// path: lib/providers/statistics_provider.dart
// Aggregates user prediction statistics for the dashboard page.
import 'dart:collection';
import 'dart:math';

import 'package:FlutterApp/data/models/fixture.dart';
import 'package:FlutterApp/data/models/prediction.dart';
import 'package:FlutterApp/data/repositories/achievements_repository.dart';
import 'package:FlutterApp/data/repositories/matches_repository.dart';
import 'package:FlutterApp/data/repositories/predictions_repository.dart';
import 'package:flutter/foundation.dart';

@immutable
class StatisticsSummary {
  const StatisticsSummary({
    required this.total,
    required this.correct,
    required this.missed,
    required this.accuracyPct,
    required this.averageOdds,
    required this.averagePerWeek,
  });

  final int total;
  final int correct;
  final int missed;
  final double accuracyPct;
  final double averageOdds;
  final double averagePerWeek;
}

@immutable
class StatisticsState {
  const StatisticsState({
    required this.isLoading,
    required this.error,
    required this.summary,
    required this.outcomeDistribution,
    required this.weekdayCounts,
    required this.accuracyTrend,
    required this.earnedBadges,
    required this.wins,
    required this.perfectDays,
  });

  final bool isLoading;
  final String? error;
  final StatisticsSummary summary;
  final Map<String, int> outcomeDistribution;
  final Map<String, int> weekdayCounts;
  final List<double> accuracyTrend;
  final int earnedBadges;
  final int wins;
  final int perfectDays;

  StatisticsState copyWith({
    bool? isLoading,
    Object? error = _sentinel,
    StatisticsSummary? summary,
    Map<String, int>? outcomeDistribution,
    Map<String, int>? weekdayCounts,
    List<double>? accuracyTrend,
    int? earnedBadges,
    int? wins,
    int? perfectDays,
  }) {
    return StatisticsState(
      isLoading: isLoading ?? this.isLoading,
      error: identical(error, _sentinel) ? this.error : error as String?,
      summary: summary ?? this.summary,
      outcomeDistribution: outcomeDistribution ?? this.outcomeDistribution,
      weekdayCounts: weekdayCounts ?? this.weekdayCounts,
      accuracyTrend: accuracyTrend ?? this.accuracyTrend,
      earnedBadges: earnedBadges ?? this.earnedBadges,
      wins: wins ?? this.wins,
      perfectDays: perfectDays ?? this.perfectDays,
    );
  }

  static const Object _sentinel = Object();
}

class StatisticsProvider extends ChangeNotifier {
  StatisticsProvider({
    required PredictionsRepository predictionsRepository,
    required MatchesRepository matchesRepository,
    required AchievementsRepository achievementsRepository,
  }) : _predictionsRepository = predictionsRepository,
       _matchesRepository = matchesRepository,
       _achievementsRepository = achievementsRepository,
       _state = const StatisticsState(
         isLoading: false,
         error: null,
         summary: StatisticsSummary(
           total: 0,
           correct: 0,
           missed: 0,
           accuracyPct: 0,
           averageOdds: 0,
           averagePerWeek: 0,
         ),
         outcomeDistribution: <String, int>{'home': 0, 'draw': 0, 'away': 0},
         weekdayCounts: <String, int>{
           'Mon': 0,
           'Tue': 0,
           'Wed': 0,
           'Thu': 0,
           'Fri': 0,
           'Sat': 0,
           'Sun': 0,
         },
         accuracyTrend: <double>[],
         earnedBadges: 0,
         wins: 0,
         perfectDays: 0,
       );

  final PredictionsRepository _predictionsRepository;
  final MatchesRepository _matchesRepository;
  final AchievementsRepository _achievementsRepository;

  StatisticsState _state;

  StatisticsState get state => _state;

  Future<void> load() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();
    try {
      final predictions = await _predictionsRepository.getAll();
      final achievements = await _achievementsRepository.getAchievements();
      final earnedBadges = achievements.where((a) => a.earnedAt != null).length;
      final wins = _calculateWins(achievements);
      final perfectDays = _calculatePerfectDays(achievements);

      _state = _state.copyWith(
        isLoading: false,
        summary: await _buildSummaryAsync(predictions),
        outcomeDistribution: await _buildOutcomesAsync(predictions),
        weekdayCounts: _buildWeekdayCounts(predictions),
        accuracyTrend: await _buildAccuracyTrendAsync(predictions),
        earnedBadges: earnedBadges,
        wins: wins,
        perfectDays: perfectDays,
        error: null,
      );
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
    notifyListeners();
  }

  Future<StatisticsSummary> _buildSummaryAsync(
    List<Prediction> predictions,
  ) async {
    // Get all predictions with their fixtures to calculate actual results
    final graded = predictions.where((p) => p.result != null).toList();
    final correct = graded.where((p) => p.result == 'correct').length;
    final missed = graded.where((p) => p.result == 'missed').length;

    // For predictions without result, we need to calculate them
    final ungraded = predictions.where((p) => p.result == null).toList();
    var calculatedCorrect = 0;
    var calculatedMissed = 0;

    // Calculate results for ungraded predictions
    for (final prediction in ungraded) {
      final fixture = await _matchesRepository.getById(prediction.fixtureId);
      if (fixture != null && _isFixtureFinished(fixture)) {
        final result = _calculatePredictionResult(prediction, fixture);
        if (result == 'correct') {
          calculatedCorrect++;
        } else if (result == 'missed') {
          calculatedMissed++;
        }
      }
    }

    final totalCorrect = correct + calculatedCorrect;
    final totalMissed = missed + calculatedMissed;
    final totalGraded = totalCorrect + totalMissed;
    final accuracy = totalGraded == 0 ? 0 : totalCorrect / totalGraded * 100;

    final oddsValues = predictions
        .map((p) => p.odds)
        .whereType<double>()
        .toList(growable: false);
    final averageOdds = oddsValues.isEmpty
        ? 0
        : oddsValues.reduce((a, b) => a + b) / oddsValues.length;
    final averagePerWeek = _averagePerWeek(predictions);

    return StatisticsSummary(
      total: predictions.length,
      correct: totalCorrect,
      missed: totalMissed,
      accuracyPct: accuracy.toDouble(),
      averageOdds: averageOdds.toDouble(),
      averagePerWeek: averagePerWeek,
    );
  }

  Future<Map<String, int>> _buildOutcomesAsync(
    List<Prediction> predictions,
  ) async {
    final counts = <String, int>{'home': 0, 'draw': 0, 'away': 0};

    // Count actual match results for finished matches
    for (final prediction in predictions) {
      var isFinished = false;
      Fixture? fixture;

      // Check if prediction already has a result
      if (prediction.result != null) {
        isFinished = true;
        // Get fixture to determine actual result
        fixture = await _matchesRepository.getById(prediction.fixtureId);
      } else {
        // Check if match is finished by fetching fixture
        fixture = await _matchesRepository.getById(prediction.fixtureId);
        if (fixture != null && _isFixtureFinished(fixture)) {
          isFinished = true;
        }
      }

      if (isFinished && fixture != null) {
        // Determine actual match result based on score
        final homeGoals = fixture.goalsHome;
        final awayGoals = fixture.goalsAway;

        if (homeGoals != null && awayGoals != null) {
          String actualResult;
          if (homeGoals > awayGoals) {
            actualResult = 'home';
          } else if (homeGoals < awayGoals) {
            actualResult = 'away';
          } else {
            actualResult = 'draw';
          }

          if (counts.containsKey(actualResult)) {
            counts[actualResult] = (counts[actualResult] ?? 0) + 1;
          }
        }
      }
    }

    return UnmodifiableMapView(counts);
  }

  Map<String, int> _buildWeekdayCounts(List<Prediction> predictions) {
    final counts = <String, int>{
      'Mon': 0,
      'Tue': 0,
      'Wed': 0,
      'Thu': 0,
      'Fri': 0,
      'Sat': 0,
      'Sun': 0,
    };
    for (final prediction in predictions) {
      final day = _weekdayLabel(prediction.madeAt.toLocal().weekday);
      counts[day] = (counts[day] ?? 0) + 1;
    }
    return UnmodifiableMapView(counts);
  }

  Future<List<double>> _buildAccuracyTrendAsync(
    List<Prediction> predictions,
  ) async {
    // Get all finished matches (with results or calculated)
    final finishedPredictions = <Prediction>[];

    for (final prediction in predictions) {
      var isFinished = false;
      var result = prediction.result;

      // Check if prediction already has a result
      if (result != null) {
        isFinished = true;
      } else {
        // Check if match is finished by fetching fixture
        final fixture = await _matchesRepository.getById(prediction.fixtureId);
        if (fixture != null && _isFixtureFinished(fixture)) {
          isFinished = true;
          result = _calculatePredictionResult(prediction, fixture);
        }
      }

      if (isFinished && result != null) {
        // Create a copy with the calculated result
        final finishedPrediction = Prediction(
          fixtureId: prediction.fixtureId,
          pick: prediction.pick,
          odds: prediction.odds,
          madeAt: prediction.madeAt,
          result: result,
        );
        finishedPredictions.add(finishedPrediction);
      }
    }

    if (finishedPredictions.isEmpty) {
      return const <double>[];
    }

    // Group by ISO week (year-weekNumber).
    final buckets = <String, _TrendBucket>{};
    for (final prediction in finishedPredictions) {
      final madeAt = prediction.madeAt.toLocal();
      final bucketKey = _yearWeekKey(madeAt);
      buckets[bucketKey] = buckets.putIfAbsent(bucketKey, _TrendBucket.new);
      buckets[bucketKey]!.total += 1;
      if (prediction.result == 'correct') {
        buckets[bucketKey]!.correct += 1;
      }
    }

    // Get current week and 3 previous weeks (total 4 weeks)
    final allWeeks = <String>[];

    // Generate last 4 weeks including current
    for (var i = 3; i >= 0; i--) {
      final weekDate = DateTime.now().subtract(Duration(days: i * 7));
      allWeeks.add(_yearWeekKey(weekDate));
    }

    final trend = <double>[];

    // Always show 4 weeks: current + 3 previous
    for (final weekKey in allWeeks) {
      if (buckets.containsKey(weekKey)) {
        final bucket = buckets[weekKey]!;
        final accuracy = bucket.total == 0
            ? 0
            : bucket.correct / bucket.total * 100;
        trend.add(double.parse(accuracy.toStringAsFixed(1)));
      } else {
        // No data for this week
        trend.add(0);
      }
    }

    return trend;
  }

  double _averagePerWeek(List<Prediction> predictions) {
    if (predictions.isEmpty) return 0;
    final sorted = List<Prediction>.from(predictions)
      ..sort((a, b) => a.madeAt.compareTo(b.madeAt));
    final first = sorted.first.madeAt;
    final last = sorted.last.madeAt;
    final weeks = (last.difference(first).inDays.abs() / 7).ceil() + 1;
    return predictions.length / max(weeks, 1);
  }

  String _weekdayLabel(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
      default:
        return 'Sun';
    }
  }

  String _yearWeekKey(DateTime date) {
    final firstDayOfYear = DateTime(date.year);
    final dayOfYear = date.difference(firstDayOfYear).inDays + 1;
    final week = ((dayOfYear - date.weekday + 10) / 7).floor();
    return '${date.year}-$week';
  }

  bool _isFixtureFinished(Fixture fixture) {
    const finishedStatuses = {'FT', 'AET', 'PEN'};
    return finishedStatuses.contains(fixture.status.toUpperCase());
  }

  String? _calculatePredictionResult(Prediction prediction, Fixture fixture) {
    final homeGoals = fixture.goalsHome;
    final awayGoals = fixture.goalsAway;

    if (homeGoals == null || awayGoals == null) return null;

    final actualWinner = homeGoals > awayGoals
        ? 'home'
        : homeGoals < awayGoals
        ? 'away'
        : 'draw';

    final predictionPick = prediction.pick.toLowerCase();
    return predictionPick == actualWinner ? 'correct' : 'missed';
  }

  int _calculateWins(List<dynamic> achievements) {
    // Count achievements related to wins (correct predictions)
    return achievements.where((a) => a.earnedAt != null).length;
  }

  int _calculatePerfectDays(List<dynamic> achievements) {
    // Count achievements related to perfect days
    return achievements.where((a) => a.earnedAt != null).length ~/ 3;
  }
}

class _TrendBucket {
  int total = 0;
  int correct = 0;
}
