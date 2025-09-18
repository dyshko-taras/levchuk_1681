// path: lib/providers/insights_provider.dart
// Derives personal insights from prediction history.
import 'package:FlutterApp/data/models/prediction.dart';
import 'package:FlutterApp/data/repositories/predictions_repository.dart';
import 'package:flutter/foundation.dart';

@immutable
class InsightEntry {
  const InsightEntry({required this.label, required this.value});

  final String label;
  final String value;
}

@immutable
class InsightsState {
  const InsightsState({
    required this.isLoading,
    required this.error,
    required this.pickAccuracy,
    required this.averageOdds,
    required this.mostActiveDay,
    required this.strengths,
    required this.weaknesses,
    required this.advice,
  });

  final bool isLoading;
  final String? error;
  final Map<String, double> pickAccuracy;
  final double averageOdds;
  final String mostActiveDay;
  final List<InsightEntry> strengths;
  final List<InsightEntry> weaknesses;
  final List<String> advice;

  InsightsState copyWith({
    bool? isLoading,
    Object? error = _sentinel,
    Map<String, double>? pickAccuracy,
    double? averageOdds,
    String? mostActiveDay,
    List<InsightEntry>? strengths,
    List<InsightEntry>? weaknesses,
    List<String>? advice,
  }) {
    return InsightsState(
      isLoading: isLoading ?? this.isLoading,
      error: identical(error, _sentinel) ? this.error : error as String?,
      pickAccuracy: pickAccuracy ?? this.pickAccuracy,
      averageOdds: averageOdds ?? this.averageOdds,
      mostActiveDay: mostActiveDay ?? this.mostActiveDay,
      strengths: strengths ?? this.strengths,
      weaknesses: weaknesses ?? this.weaknesses,
      advice: advice ?? this.advice,
    );
  }

  static const Object _sentinel = Object();
}

class InsightsProvider extends ChangeNotifier {
  InsightsProvider(this._predictionsRepository)
    : _state = const InsightsState(
        isLoading: false,
        error: null,
        pickAccuracy: <String, double>{'home': 0, 'draw': 0, 'away': 0},
        averageOdds: 0,
        mostActiveDay: 'Unknown',
        strengths: <InsightEntry>[],
        weaknesses: <InsightEntry>[],
        advice: <String>[],
      );

  final PredictionsRepository _predictionsRepository;

  InsightsState _state;

  InsightsState get state => _state;

  Future<void> loadAndComputeInsights() async {
    _state = _state.copyWith(
      isLoading: true,
      error: InsightsState._sentinel,
    );
    notifyListeners();
    try {
      final predictions = await _predictionsRepository.getAll();
      final graded = predictions.where((p) => p.result != null).toList();
      final pickAccuracy = _calculatePickAccuracy(graded);
      final averageOdds = _calculateAverageOdds(predictions);
      final mostActiveDay = _mostActiveDay(predictions);
      final strengths = _buildStrengths(pickAccuracy);
      final weaknesses = _buildWeaknesses(pickAccuracy);
      final advice = _buildAdvice(strengths, weaknesses, averageOdds);
      _state = _state.copyWith(
        isLoading: false,
        pickAccuracy: pickAccuracy,
        averageOdds: averageOdds,
        mostActiveDay: mostActiveDay,
        strengths: strengths,
        weaknesses: weaknesses,
        advice: advice,
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

  Map<String, double> _calculatePickAccuracy(List<Prediction> predictions) {
    final totals = <String, _AccuracyBucket>{
      'home': _AccuracyBucket(),
      'draw': _AccuracyBucket(),
      'away': _AccuracyBucket(),
    };
    for (final prediction in predictions) {
      final pick = prediction.pick.toLowerCase();
      final bucket = totals[pick];
      if (bucket == null) continue;
      bucket.total += 1;
      if (prediction.result == 'correct') {
        bucket.correct += 1;
      }
    }
    return totals.map(
      (key, value) => MapEntry(
        key,
        value.total == 0 ? 0 : value.correct / value.total * 100,
      ),
    );
  }

  double _calculateAverageOdds(List<Prediction> predictions) {
    final values = predictions.map((p) => p.odds).whereType<double>();
    if (values.isEmpty) return 0;
    final total = values.fold<double>(0, (prev, odd) => prev + odd);
    return total / values.length;
  }

  String _mostActiveDay(List<Prediction> predictions) {
    if (predictions.isEmpty) return 'Unknown';
    final counts = <int, int>{};
    for (final prediction in predictions) {
      final weekday = prediction.madeAt.toLocal().weekday;
      counts[weekday] = (counts[weekday] ?? 0) + 1;
    }
    final most = counts.entries.reduce(
      (a, b) => a.value >= b.value ? a : b,
    );
    return _weekdayLabel(most.key);
  }

  List<InsightEntry> _buildStrengths(Map<String, double> accuracy) {
    final entries = accuracy.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries
        .where((entry) => entry.value >= 50)
        .take(2)
        .map((entry) => InsightEntry(
              label: _pickLabel(entry.key),
              value: '${entry.value.toStringAsFixed(1)}% accuracy',
            ))
        .toList();
  }

  List<InsightEntry> _buildWeaknesses(Map<String, double> accuracy) {
    final entries = accuracy.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    return entries
        .where((entry) => entry.value < 50)
        .take(2)
        .map((entry) => InsightEntry(
              label: _pickLabel(entry.key),
              value: '${entry.value.toStringAsFixed(1)}% accuracy',
            ))
        .toList();
  }

  List<String> _buildAdvice(
    List<InsightEntry> strengths,
    List<InsightEntry> weaknesses,
    double averageOdds,
  ) {
    final advice = <String>[];
    if (weaknesses.isNotEmpty) {
      advice.add(
        'Review your ${weaknesses.first.label.toLowerCase()} picks — accuracy is only ${weaknesses.first.value}.',
      );
    }
    if (strengths.isNotEmpty) {
      advice.add(
        'Lean into ${strengths.first.label.toLowerCase()} selections where you perform well (${strengths.first.value}).',
      );
    }
    if (averageOdds > 3) {
      advice.add('Consider balancing risk: average odds ${averageOdds.toStringAsFixed(2)}.');
    } else if (averageOdds < 1.8) {
      advice.add('Average odds ${averageOdds.toStringAsFixed(2)} suggest you may prefer favorites; diversify when possible.');
    }
    return advice;
  }

  String _weekdayLabel(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
      default:
        return 'Sunday';
    }
  }

  String _pickLabel(String pick) {
    switch (pick.toLowerCase()) {
      case 'home':
        return 'Home wins';
      case 'draw':
        return 'Draws';
      case 'away':
        return 'Away wins';
      default:
        return pick;
    }
  }
}

class _AccuracyBucket {
  int total = 0;
  int correct = 0;
}

