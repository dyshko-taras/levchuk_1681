// path: lib/providers/statistics_provider.dart
// Aggregates user prediction statistics for the dashboard page.
import 'dart:collection';
import 'dart:math';

import 'package:FlutterApp/data/models/prediction.dart';
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
  });

  final bool isLoading;
  final String? error;
  final StatisticsSummary summary;
  final Map<String, int> outcomeDistribution;
  final Map<String, int> weekdayCounts;
  final List<double> accuracyTrend;

  StatisticsState copyWith({
    bool? isLoading,
    Object? error = _sentinel,
    StatisticsSummary? summary,
    Map<String, int>? outcomeDistribution,
    Map<String, int>? weekdayCounts,
    List<double>? accuracyTrend,
  }) {
    return StatisticsState(
      isLoading: isLoading ?? this.isLoading,
      error: identical(error, _sentinel) ? this.error : error as String?,
      summary: summary ?? this.summary,
      outcomeDistribution: outcomeDistribution ?? this.outcomeDistribution,
      weekdayCounts: weekdayCounts ?? this.weekdayCounts,
      accuracyTrend: accuracyTrend ?? this.accuracyTrend,
    );
  }

  static const Object _sentinel = Object();
}

class StatisticsProvider extends ChangeNotifier {
  StatisticsProvider({
    required PredictionsRepository predictionsRepository,
    required MatchesRepository matchesRepository,
  })  : _predictionsRepository = predictionsRepository,
        _matchesRepository = matchesRepository,
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
        );

  final PredictionsRepository _predictionsRepository;
  final MatchesRepository _matchesRepository; // reserved for future FT validations

  StatisticsState _state;

  StatisticsState get state => _state;

  Future<void> load() async {
    _state = _state.copyWith(isLoading: true, error: StatisticsState._sentinel);
    notifyListeners();
    try {
      final predictions = await _predictionsRepository.getAll();
      _state = _state.copyWith(
        isLoading: false,
        summary: _buildSummary(predictions),
        outcomeDistribution: _buildOutcomes(predictions),
        weekdayCounts: _buildWeekdayCounts(predictions),
        accuracyTrend: _buildAccuracyTrend(predictions),
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

  StatisticsSummary _buildSummary(List<Prediction> predictions) {
    final graded = predictions.where((p) => p.result != null).toList();
    final correct = graded.where((p) => p.result == 'correct').length;
    final missed = graded.where((p) => p.result == 'missed').length;
    final accuracy = graded.isEmpty ? 0 : correct / graded.length * 100;
    final oddsValues = predictions
        .map((p) => p.odds)
        .whereType<double>()
        .toList(growable: false);
    final averageOdds =
        oddsValues.isEmpty ? 0 : oddsValues.reduce((a, b) => a + b) / oddsValues.length;
    final averagePerWeek = _averagePerWeek(predictions);
    return StatisticsSummary(
      total: predictions.length,
      correct: correct,
      missed: missed,
      accuracyPct: accuracy.toDouble(),
      averageOdds: averageOdds.toDouble(),
      averagePerWeek: averagePerWeek,
    );
  }

  Map<String, int> _buildOutcomes(List<Prediction> predictions) {
    final counts = <String, int>{'home': 0, 'draw': 0, 'away': 0};
    for (final prediction in predictions) {
      final pick = prediction.pick.toLowerCase();
      if (counts.containsKey(pick)) {
        counts[pick] = (counts[pick] ?? 0) + 1;
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

  List<double> _buildAccuracyTrend(List<Prediction> predictions) {
    if (predictions.isEmpty) return const <double>[];
    final graded = predictions
        .where((prediction) => prediction.result != null)
        .toList(growable: false);
    if (graded.isEmpty) return const <double>[];

    // Group by ISO week (year-weekNumber).
    final buckets = <String, _TrendBucket>{};
    for (final prediction in graded) {
      final madeAt = prediction.madeAt.toLocal();
      final bucketKey = _yearWeekKey(madeAt);
      buckets[bucketKey] = buckets.putIfAbsent(bucketKey, _TrendBucket.new);
      buckets[bucketKey]!.total += 1;
      if (prediction.result == 'correct') {
        buckets[bucketKey]!.correct += 1;
      }
    }
    final sortedKeys = buckets.keys.toList()
      ..sort();
    final recentKeys = sortedKeys.takeLast(4).toList();
    final trend = <double>[];
    for (final key in recentKeys) {
      final bucket = buckets[key]!;
      final accuracy = bucket.total == 0
          ? 0
          : bucket.correct / bucket.total * 100;
      trend.add(double.parse(accuracy.toStringAsFixed(1)));
    }
    return trend;
  }

  double _averagePerWeek(List<Prediction> predictions) {
    if (predictions.isEmpty) return 0;
    final sorted = List<Prediction>.from(predictions)
      ..sort((a, b) => a.madeAt.compareTo(b.madeAt));
    final first = sorted.first.madeAt;
    final last = sorted.last.madeAt;
    final weeks = ((last.difference(first).inDays).abs() / 7).ceil() + 1;
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
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final dayOfYear = date.difference(firstDayOfYear).inDays + 1;
    final week = ((dayOfYear - date.weekday + 10) / 7).floor();
    return '${date.year}-$week';
  }
}

class _TrendBucket {
  int total = 0;
  int correct = 0;
}

extension<T> on List<T> {
  Iterable<T> takeLast(int count) {
    if (length <= count) return this;
    return sublist(length - count);
  }
}

