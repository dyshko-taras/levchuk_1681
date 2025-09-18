// path: lib/providers/matches_provider.dart
// Matches feature provider: handles schedule data, filters, counters, and odds access.
import 'dart:collection';

import 'package:FlutterApp/data/models/favorite.dart';
import 'package:FlutterApp/data/models/fixture.dart';
import 'package:FlutterApp/data/models/odds_snapshot.dart';
import 'package:FlutterApp/data/models/prediction.dart';
import 'package:FlutterApp/data/repositories/favorites_repository.dart';
import 'package:FlutterApp/data/repositories/matches_repository.dart';
import 'package:FlutterApp/data/repositories/notes_repository.dart';
import 'package:FlutterApp/data/repositories/odds_repository.dart';
import 'package:FlutterApp/data/repositories/predictions_repository.dart';
import 'package:flutter/foundation.dart';

@immutable
class MatchesFilters {
  const MatchesFilters({
    this.leagueIds = const <int>{},
    this.countries = const <String>{},
    this.statuses = const <String>{},
    this.favoritesOnly = false,
  });

  final Set<int> leagueIds;
  final Set<String> countries;
  final Set<String> statuses;
  final bool favoritesOnly;

  bool get isEmpty =>
      leagueIds.isEmpty &&
      countries.isEmpty &&
      statuses.isEmpty &&
      !favoritesOnly;

  MatchesFilters copyWith({
    Set<int>? leagueIds,
    Set<String>? countries,
    Set<String>? statuses,
    bool? favoritesOnly,
  }) {
    return MatchesFilters(
      leagueIds: leagueIds ?? this.leagueIds,
      countries: countries ?? this.countries,
      statuses: statuses ?? this.statuses,
      favoritesOnly: favoritesOnly ?? this.favoritesOnly,
    );
  }

  MatchesFilters cleared() => const MatchesFilters();
}

@immutable
class MatchesCounters {
  const MatchesCounters({
    required this.predicted,
    required this.upcoming,
    required this.completed,
  });

  final int predicted;
  final int upcoming;
  final int completed;
}

@immutable
class MatchesState {
  const MatchesState({
    required this.isLoading,
    required this.error,
    required this.selectedDate,
    required this.selectedDayId,
    required this.filters,
    required this.fixtures,
    required this.counters,
  });

  final bool isLoading;
  final String? error;
  final DateTime selectedDate;
  final String selectedDayId; // yesterday|today|tomorrow|custom
  final MatchesFilters filters;
  final List<Fixture> fixtures;
  final MatchesCounters counters;

  List<Fixture> get items => fixtures;
  int get predicted => counters.predicted;
  int get upcoming => counters.upcoming;
  int get completed => counters.completed;

  MatchesState copyWith({
    bool? isLoading,
    Object? error = _sentinel,
    DateTime? selectedDate,
    String? selectedDayId,
    MatchesFilters? filters,
    List<Fixture>? fixtures,
    MatchesCounters? counters,
  }) {
    return MatchesState(
      isLoading: isLoading ?? this.isLoading,
      error: identical(error, _sentinel) ? this.error : error as String?,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedDayId: selectedDayId ?? this.selectedDayId,
      filters: filters ?? this.filters,
      fixtures: fixtures ?? this.fixtures,
      counters: counters ?? this.counters,
    );
  }

  static const Object _sentinel = Object();
}

class MatchesProvider extends ChangeNotifier {
  MatchesProvider(MatchesRepository read, {
    required MatchesRepository matchesRepository,
    required PredictionsRepository predictionsRepository,
    required FavoritesRepository favoritesRepository,
    required NotesRepository notesRepository,
    required OddsRepository oddsRepository,
  }) : _matchesRepository = matchesRepository,
       _predictionsRepository = predictionsRepository,
       _favoritesRepository = favoritesRepository,
       _notesRepository = notesRepository,
       _oddsRepository = oddsRepository,
       _state = MatchesState(
         isLoading: false,
         error: null,
         selectedDate: _today(),
         selectedDayId: _dayIdForDate(_today()),
         filters: const MatchesFilters(),
         fixtures: const <Fixture>[],
         counters: const MatchesCounters(
           predicted: 0,
           upcoming: 0,
           completed: 0,
         ),
       );

  final MatchesRepository _matchesRepository;
  final PredictionsRepository _predictionsRepository;
  final FavoritesRepository _favoritesRepository;
  final NotesRepository _notesRepository;
  final OddsRepository _oddsRepository;

  MatchesState _state;
  List<Fixture> _allFixtures = const <Fixture>[];
  final Map<int, Prediction> _predictionsByFixture = <int, Prediction>{};
  Set<int> _favoriteMatchIds = <int>{};
  final Map<int, bool> _notesPresence = <int, bool>{};

  MatchesState get state => _state;
  MatchesFilters get filters => _state.filters;

  Future<void> load({DateTime? date, bool forceRefresh = false}) async {
    final targetDate = _normalizeDate(date ?? _state.selectedDate);
    _state = _state.copyWith(
      isLoading: true,
      error: MatchesState._sentinel,
      selectedDate: targetDate,
      selectedDayId: _dayIdForDate(targetDate),
    );
    notifyListeners();

    try {
      final fixtures = await _matchesRepository.getByDate(
        targetDate,
        forceRefresh: forceRefresh,
      );
      _allFixtures = fixtures;
      await _hydrateContext(fixtures);
      _applyFiltersAndUpdate();
      _state = _state.copyWith(isLoading: false, error: null);
    } catch (e) {
      _state = _state.copyWith(isLoading: false, error: e.toString());
    }
    notifyListeners();
  }

  Future<void> refresh() async => load(forceRefresh: true);

  Future<void> setRelativeDate(int offsetDays) async {
    final target = _state.selectedDate.add(Duration(days: offsetDays));
    await load(date: target);
  }

  Future<void> selectDay(String dayId) async {
    final offset = switch (dayId) {
      'yesterday' => -1,
      'tomorrow' => 1,
      _ => 0,
    };
    final target = _normalizeDate(_today().add(Duration(days: offset)));
    await load(date: target);
  }

  void updateFilters(MatchesFilters filters) {
    _state = _state.copyWith(filters: filters);
    _applyFiltersAndUpdate();
    notifyListeners();
  }

  void clearFilters() {
    updateFilters(const MatchesFilters());
  }

  Future<bool> toggleFavorite(int fixtureId) async {
    final toggled = await _favoritesRepository.toggleFavorite(
      FavoriteType.match,
      fixtureId,
    );
    if (toggled) {
      _favoriteMatchIds.add(fixtureId);
    } else {
      _favoriteMatchIds.remove(fixtureId);
    }
    _applyFiltersAndUpdate();
    notifyListeners();
    return toggled;
  }

  bool isFavorite(int fixtureId) => _favoriteMatchIds.contains(fixtureId);

  Prediction? predictionForFixture(int fixtureId) =>
      _predictionsByFixture[fixtureId];

  Future<OddsSnapshot?> loadOdds(int fixtureId) =>
      _oddsRepository.getByFixture(fixtureId);

  Future<bool> hasNote(int fixtureId) async {
    if (_notesPresence.containsKey(fixtureId)) {
      return _notesPresence[fixtureId] ?? false;
    }
    final note = await _notesRepository.getNote(fixtureId);
    final exists = note != null;
    _notesPresence[fixtureId] = exists;
    return exists;
  }

  void _applyFiltersAndUpdate() {
    final filtered = _applyFilters(_allFixtures);
    final counters = _buildCounters(filtered);
    _state = _state.copyWith(
      fixtures: filtered,
      counters: counters,
    );
  }

  Future<void> _hydrateContext(List<Fixture> fixtures) async {
    final predictionList = await _predictionsRepository.getAll();
    _predictionsByFixture
      ..clear()
      ..addEntries(
        predictionList.map(
          (prediction) => MapEntry(prediction.fixtureId, prediction),
        ),
      );

    final favorites = await _favoritesRepository.getFavorites(
      type: FavoriteType.match,
    );
    _favoriteMatchIds = favorites.map((fav) => fav.refId).toSet();

    // Clear notes presence cache for fixtures no longer visible.
    final validIds = fixtures.map((fixture) => fixture.fixtureId).toSet();
    _notesPresence.removeWhere((key, _) => !validIds.contains(key));
  }

  List<Fixture> _applyFilters(List<Fixture> fixtures) {
    Iterable<Fixture> current = fixtures;
    final filter = _state.filters;
    if (filter.leagueIds.isNotEmpty) {
      current = current.where(
        (fixture) => filter.leagueIds.contains(
          fixture.leagueId,
        ),
      );
    }
    if (filter.countries.isNotEmpty) {
      current = current.where(
        (fixture) =>
            fixture.country != null &&
            filter.countries.contains(fixture.country),
      );
    }
    if (filter.statuses.isNotEmpty) {
      final normalized = filter.statuses
          .map((status) => status.toUpperCase())
          .toSet();
      current = current.where(
        (fixture) => normalized.contains(fixture.status.toUpperCase()),
      );
    }
    if (filter.favoritesOnly) {
      current = current.where(
        (fixture) => _favoriteMatchIds.contains(fixture.fixtureId),
      );
    }
    return List<Fixture>.unmodifiable(current);
  }

  MatchesCounters _buildCounters(List<Fixture> fixtures) {
    final fixtureIds = fixtures.map((fixture) => fixture.fixtureId).toSet();
    final predicted = fixtureIds
        .where((id) => _predictionsByFixture.containsKey(id))
        .length;
    final completed = fixtures.where(_isFinished).length;
    final upcoming = fixtures.length - completed;
    return MatchesCounters(
      predicted: predicted,
      upcoming: upcoming,
      completed: completed,
    );
  }

  static bool _isFinished(Fixture fixture) {
    const finished = {'FT', 'AET', 'PEN'};
    if (finished.contains(fixture.status.toUpperCase())) {
      return true;
    }
    return fixture.goalsHome != null && fixture.goalsAway != null;
  }

  static DateTime _normalizeDate(DateTime value) =>
      DateTime(value.year, value.month, value.day);

  static DateTime _today() => _normalizeDate(DateTime.now());

  static String _dayIdForDate(DateTime date) {
    final today = _today();
    if (date.isAtSameMomentAs(today.subtract(const Duration(days: 1)))) {
      return 'yesterday';
    }
    if (date.isAtSameMomentAs(today.add(const Duration(days: 1)))) {
      return 'tomorrow';
    }
    if (date.isAtSameMomentAs(today)) {
      return 'today';
    }
    return 'custom';
  }
}
