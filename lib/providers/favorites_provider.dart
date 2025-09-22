// path: lib/providers/favorites_provider.dart
// Manages user favorites grouped by leagues, teams, and matches.
import 'package:FlutterApp/data/models/favorite.dart';
import 'package:FlutterApp/data/models/fixture.dart';
import 'package:FlutterApp/data/models/league.dart';
import 'package:FlutterApp/data/models/prediction.dart';
import 'package:FlutterApp/data/models/team_ref.dart';
import 'package:FlutterApp/data/repositories/favorites_repository.dart';
import 'package:FlutterApp/data/repositories/leagues_repository.dart';
import 'package:FlutterApp/data/repositories/matches_repository.dart';
import 'package:flutter/foundation.dart';

@immutable
class FavoritesState {
  const FavoritesState({
    required this.isLoading,
    required this.error,
    required this.activeTab,
    required this.favorites,
  });

  final bool isLoading;
  final String? error;
  final FavoriteType activeTab;
  final Map<FavoriteType, List<Favorite>> favorites;

  FavoritesState copyWith({
    bool? isLoading,
    Object? error = _sentinel,
    FavoriteType? activeTab,
    Map<FavoriteType, List<Favorite>>? favorites,
  }) {
    return FavoritesState(
      isLoading: isLoading ?? this.isLoading,
      error: identical(error, _sentinel) ? this.error : error as String?,
      activeTab: activeTab ?? this.activeTab,
      favorites: favorites ?? this.favorites,
    );
  }

  static const Object _sentinel = Object();
}

class FavoritesProvider extends ChangeNotifier {
  FavoritesProvider({
    required FavoritesRepository favoritesRepository,
    required MatchesRepository matchesRepository,
    required LeaguesRepository leaguesRepository,
  }) : _favoritesRepository = favoritesRepository,
       _matchesRepository = matchesRepository,
       _leaguesRepository = leaguesRepository,
       _state = const FavoritesState(
         isLoading: false,
         error: null,
         activeTab: FavoriteType.leagues,
         favorites: {
           FavoriteType.matches: <Favorite>[],
           FavoriteType.teams: <Favorite>[],
           FavoriteType.leagues: <Favorite>[],
         },
       );

  final FavoritesRepository _favoritesRepository;
  final MatchesRepository _matchesRepository;
  final LeaguesRepository _leaguesRepository;

  FavoritesState _state;

  FavoritesState get state => _state;

  List<Favorite> get items => List<Favorite>.unmodifiable(
    _state.favorites[_state.activeTab] ?? const [],
  );

  Future<void> load() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();
    try {
      final leagues = await _favoritesRepository.getFavorites(
        type: FavoriteType.leagues,
      );
      final teams = await _favoritesRepository.getFavorites(
        type: FavoriteType.teams,
      );
      final matches = await _favoritesRepository.getFavorites(
        type: FavoriteType.matches,
      );
      _state = _state.copyWith(
        isLoading: false,
        favorites: {
          FavoriteType.leagues: leagues,
          FavoriteType.teams: teams,
          FavoriteType.matches: matches,
        },
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

  void selectTab(FavoriteType type) {
    if (_state.activeTab == type) return;
    _state = _state.copyWith(activeTab: type);
    notifyListeners();
  }

  Future<bool> toggleFavorite(FavoriteType type, int refId) async {
    final toggled = await _favoritesRepository.toggleFavorite(type, refId);
    final updated = Map<FavoriteType, List<Favorite>>.from(_state.favorites);
    final list = List<Favorite>.from(updated[type] ?? const []);
    if (toggled) {
      list.add(
        Favorite(
          id: 0,
          type: type,
          refId: refId,
          createdAt: DateTime.now(),
        ),
      );
    } else {
      list.removeWhere((favorite) => favorite.refId == refId);
    }
    updated[type] = list;
    _state = _state.copyWith(favorites: updated);
    notifyListeners();
    return toggled;
  }

  Future<Fixture?> loadMatch(int fixtureId) =>
      _matchesRepository.getById(fixtureId);

  Future<League?> loadLeague(int leagueId) async {
    final leagues = await _leaguesRepository.getLeagues();
    return leagues.firstWhereOrNull((league) => league.id == leagueId);
  }

  Future<TeamRef?> loadTeam({required int teamId}) async {
    final teams = await _leaguesRepository.getTeamsById(
      teamId: teamId,
    );
    return teams.firstWhereOrNull((team) => team.id == teamId);
  }

  Prediction? predictionForFixture(int fixtureId) => null;

  Future<int> matchesToday(int leagueId) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final fixtures = await _matchesRepository.getByDate(today);
    return fixtures.where((f) => f.leagueId == leagueId).length;
  }

  Future<int?> firstMatchIdTodayForLeague(int leagueId) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final fixtures = await _matchesRepository.getByDate(today);
    final m = fixtures.firstWhereOrNull((f) => f.leagueId == leagueId);
    return m?.fixtureId;
  }

  Future<Fixture?> lastMatchForTeam(int teamId) async {
    final d = DateTime.now();
    for (var i = 0; i <= 7; i++) {
      final day = DateTime(d.year, d.month, d.day).subtract(Duration(days: i));
      final fixtures = await _matchesRepository.getByDate(day);
      for (final f in fixtures) {
        try {
          final homeId = f.homeTeam.id;
          final awayId = f.awayTeam.id;
          if (homeId == teamId || awayId == teamId) {
            return f;
          }
        } catch (_) {
        }
      }
    }
    return null;
  }
}

extension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
