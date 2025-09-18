// path: lib/providers/matches_provider.dart
// Matches feature provider: handles schedule data, derived counters, and day switching.
import 'package:FlutterApp/data/models/fixture.dart';
import 'package:FlutterApp/data/repositories/matches_repository.dart';
import 'package:flutter/foundation.dart';

@immutable
class MatchesState {
  const MatchesState({
    required this.isLoading,
    required this.error,
    required this.items,
    required this.date,
    required this.selectedDayId,
    required this.predicted,
    required this.upcoming,
    required this.completed,
  });

  final bool isLoading;
  final String? error;
  final List<Fixture> items;
  final DateTime date;
  final String selectedDayId; // "yesterday" | "today" | "tomorrow"
  final int predicted;
  final int upcoming;
  final int completed;

  MatchesState copyWith({
    bool? isLoading,
    Object? error = _sentinel,
    List<Fixture>? items,
    DateTime? date,
    String? selectedDayId,
    int? predicted,
    int? upcoming,
    int? completed,
  }) {
    return MatchesState(
      isLoading: isLoading ?? this.isLoading,
      error: identical(error, _sentinel) ? this.error : error as String?,
      items: items ?? this.items,
      date: date ?? this.date,
      selectedDayId: selectedDayId ?? this.selectedDayId,
      predicted: predicted ?? this.predicted,
      upcoming: upcoming ?? this.upcoming,
      completed: completed ?? this.completed,
    );
  }

  static const Object _sentinel = Object();
}

class MatchesProvider extends ChangeNotifier {
  MatchesProvider(this._repository)
    : _state = MatchesState(
        isLoading: false,
        error: null,
        items: const <Fixture>[],
        date: _today(),
        selectedDayId: 'today',
        predicted: 0,
        upcoming: 0,
        completed: 0,
      );

  final MatchesRepository _repository;
  MatchesState _state;

  MatchesState get state => _state;

  Future<void> load({DateTime? date, String? selectedDayId}) async {
    final at = date ?? _state.date;
    final targetDate = DateTime(at.year, at.month, at.day);
    _state = _state.copyWith(
      isLoading: true,
      error: null,
      date: targetDate,
      selectedDayId: selectedDayId ?? _state.selectedDayId,
    );
    notifyListeners();

    try {
      final fixtures = await _repository.getByDate(targetDate);
      final (predicted, upcoming, completed) = _deriveCounters(fixtures);
      _state = _state.copyWith(
        isLoading: false,
        items: fixtures,
        predicted: predicted,
        upcoming: upcoming,
        completed: completed,
      );
    } on UnimplementedError {
      _state = _state.copyWith(
        isLoading: false,
        error: 'Networking not generated yet. Run: dart run build_runner build',
      );
    } catch (e) {
      _state = _state.copyWith(isLoading: false, error: e.toString());
    }

    notifyListeners();
  }

  Future<void> setRelativeDate(int offsetDays) async {
    final base = _today();
    final target = base.add(Duration(days: offsetDays));
    final dayId = switch (offsetDays) {
      -1 => 'yesterday',
      1 => 'tomorrow',
      _ => 'today',
    };
    await load(date: target, selectedDayId: dayId);
  }

  (int predicted, int upcoming, int completed) _deriveCounters(
    List<Fixture> fixtures,
  ) {
    final completed = fixtures
        .where(
          (fixture) => fixture.goalsHome != null && fixture.goalsAway != null,
        )
        .length;
    final upcoming = fixtures.length - completed;
    // TODO(phase5): wire real predictions counter once local DB lands.
    const predicted = 0;
    return (predicted, upcoming, completed);
  }

  static DateTime _today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
}
