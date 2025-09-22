// path: lib/providers/prediction_journal_provider.dart
// Coordinates the prediction journal calendar and daily timeline.
import 'package:FlutterApp/data/models/fixture.dart';
import 'package:FlutterApp/data/models/prediction.dart';
import 'package:FlutterApp/data/repositories/journal_repository.dart';
import 'package:FlutterApp/data/repositories/matches_repository.dart';
import 'package:FlutterApp/data/repositories/predictions_repository.dart';
import 'package:flutter/foundation.dart';

@immutable
class JournalSummary {
  const JournalSummary({
    required this.total,
    required this.correct,
    required this.missed,
    required this.averageOdds,
  });

  final int total;
  final int correct;
  final int missed;
  final double averageOdds;
}

@immutable
class PredictionTimelineItem {
  const PredictionTimelineItem({
    required this.prediction,
    required this.fixture,
  });

  final Prediction prediction;
  final Fixture? fixture;
}

@immutable
class PredictionJournalState {
  const PredictionJournalState({
    required this.isLoading,
    required this.error,
    required this.selectedDate,
    required this.timeline,
    required this.summary,
    required this.events,
    required this.predictionHeatmap,
    required this.isSaving,
  });

  final bool isLoading;
  final String? error;
  final DateTime selectedDate;
  final List<PredictionTimelineItem> timeline;
  final JournalSummary summary;
  final List<String> events;
  final Map<DateTime, int> predictionHeatmap;
  final bool isSaving;

  PredictionJournalState copyWith({
    bool? isLoading,
    Object? error = _sentinel,
    DateTime? selectedDate,
    List<PredictionTimelineItem>? timeline,
    JournalSummary? summary,
    List<String>? events,
    Map<DateTime, int>? predictionHeatmap,
    bool? isSaving,
  }) {
    return PredictionJournalState(
      isLoading: isLoading ?? this.isLoading,
      error: identical(error, _sentinel) ? this.error : error as String?,
      selectedDate: selectedDate ?? this.selectedDate,
      timeline: timeline ?? this.timeline,
      summary: summary ?? this.summary,
      events: events ?? this.events,
      predictionHeatmap: predictionHeatmap ?? this.predictionHeatmap,
      isSaving: isSaving ?? this.isSaving,
    );
  }

  static const Object _sentinel = Object();
}

class PredictionJournalProvider extends ChangeNotifier {
  PredictionJournalProvider({
    required PredictionsRepository predictionsRepository,
    required MatchesRepository matchesRepository,
    required JournalRepository journalRepository,
  }) : _predictionsRepository = predictionsRepository,
       _matchesRepository = matchesRepository,
       _journalRepository = journalRepository,
       _state = PredictionJournalState(
         isLoading: false,
         error: null,
         selectedDate: _today(),
         timeline: const <PredictionTimelineItem>[],
         summary: const JournalSummary(
           total: 0,
           correct: 0,
           missed: 0,
           averageOdds: 0,
         ),
         events: const <String>[],
         predictionHeatmap: const <DateTime, int>{},
         isSaving: false,
       );

  final PredictionsRepository _predictionsRepository;
  final MatchesRepository _matchesRepository;
  final JournalRepository _journalRepository;

  PredictionJournalState _state;

  PredictionJournalState get state => _state;

  Future<void> loadForDate(DateTime date) async {
    final target = _normalizeDate(date);
    _state = _state.copyWith(
      isLoading: true,
      selectedDate: target,
    );
    notifyListeners();
    try {
      final predictions = await _predictionsRepository.getAll();
      final heatmap = _buildHeatmap(predictions);
      final dailyPredictions = predictions
          .where((prediction) => _isSameDay(prediction.madeAt, target))
          .toList();
      final timeline = await _buildTimeline(dailyPredictions);
      final summary = await _buildSummary(dailyPredictions);
      final entry = await _journalRepository.getEntry(target);
      _state = _state.copyWith(
        isLoading: false,
        error: null,
        selectedDate: target,
        timeline: timeline,
        summary: summary,
        events: entry?.events ?? const <String>[],
        predictionHeatmap: heatmap,
      );
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
    notifyListeners();
  }

  Future<void> nextDay() async {
    await loadForDate(state.selectedDate.add(const Duration(days: 1)));
  }

  Future<void> previousDay() async {
    await loadForDate(state.selectedDate.subtract(const Duration(days: 1)));
  }

  Future<void> addEvent(String event) async {
    final normalized = _normalizeDate(state.selectedDate);
    _state = _state.copyWith(isSaving: true);
    notifyListeners();
    try {
      await _journalRepository.addEvent(normalized, event);
      await loadForDate(normalized);
    } finally {
      _state = _state.copyWith(isSaving: false);
      notifyListeners();
    }
  }

  Future<void> removeEvent(String event) async {
    final normalized = _normalizeDate(state.selectedDate);
    _state = _state.copyWith(isSaving: true);
    notifyListeners();
    try {
      await _journalRepository.removeEvent(normalized, event);
      await loadForDate(normalized);
    } finally {
      _state = _state.copyWith(isSaving: false);
      notifyListeners();
    }
  }

  Map<DateTime, int> _buildHeatmap(List<Prediction> predictions) {
    final map = <DateTime, int>{};
    for (final prediction in predictions) {
      final key = _normalizeDate(prediction.madeAt);
      map[key] = (map[key] ?? 0) + 1;
    }
    return map;
  }

  Future<List<PredictionTimelineItem>> _buildTimeline(
    List<Prediction> predictions,
  ) async {
    final futures = predictions.map((prediction) async {
      final fixture = await _matchesRepository.getById(prediction.fixtureId);
      return PredictionTimelineItem(
        prediction: prediction,
        fixture: fixture,
      );
    });
    final list = await Future.wait(futures);
    list.sort((a, b) => a.prediction.madeAt.compareTo(b.prediction.madeAt));
    return list;
  }

  Future<JournalSummary> _buildSummary(List<Prediction> predictions) async {
    final total = predictions.length;

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

    final oddsValues = predictions
        .map((prediction) => prediction.odds)
        .whereType<double>()
        .toList();
    final averageOdds = oddsValues.isEmpty
        ? 0
        : oddsValues.reduce((value, element) => value + element) /
              oddsValues.length;

    return JournalSummary(
      total: total,
      correct: totalCorrect,
      missed: totalMissed,
      averageOdds: averageOdds.toDouble(),
    );
  }

  static DateTime _normalizeDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  static bool _isSameDay(DateTime a, DateTime b) {
    final na = _normalizeDate(a);
    final nb = _normalizeDate(b);
    return na.isAtSameMomentAs(nb);
  }

  static DateTime _today() => _normalizeDate(DateTime.now());

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
}
