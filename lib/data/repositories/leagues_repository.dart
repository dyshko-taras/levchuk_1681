// path: lib/data/repositories/leagues_repository.dart
// Repository for leagues, teams, standings, and team statistics with caching.
import 'package:FlutterApp/data/api/football_service.dart';
import 'package:FlutterApp/data/models/league.dart';
import 'package:FlutterApp/data/models/standing_row.dart';
import 'package:FlutterApp/data/models/team_ref.dart';

class LeaguesRepository {
  LeaguesRepository(this._api, {Duration cacheTtl = const Duration(hours: 1)})
    : _leaguesCache = <_LeaguesKey, _Timed<List<League>>>{},
      _teamsCache = <_TeamsKey, _Timed<List<TeamRef>>>{},
      _standingsCache = <_StandingsKey, _Timed<List<StandingRow>>>{},
      _ttl = cacheTtl;

  final FootballService _api;
  final Duration _ttl;

  final Map<_LeaguesKey, _Timed<List<League>>> _leaguesCache;
  final Map<_TeamsKey, _Timed<List<TeamRef>>> _teamsCache;
  final Map<_StandingsKey, _Timed<List<StandingRow>>> _standingsCache;

  Future<List<League>> getLeagues({
    String? country,
    String? type,
    int? season,
  }) async {
    final key = _LeaguesKey(country, type, season);
    final now = DateTime.now();
    final hit = _leaguesCache[key];
    if (hit != null && now.isBefore(hit.expiry)) return hit.value;

    final data = await _api.getLeagues(
      country: country,
      type: type,
      season: season,
    );
    _leaguesCache[key] = _Timed(data, now.add(_ttl));
    return data;
  }

  Future<List<TeamRef>> getTeamsById({
    required int teamId,
    int? season,
  }) async {
    final key = _TeamsKey(teamId, season);
    final now = DateTime.now();
    final hit = _teamsCache[key];
    if (hit != null && now.isBefore(hit.expiry)) return hit.value;

    final data = await _api.getTeamsById(
      teamId: teamId,
      season: season,
    );
    _teamsCache[key] = _Timed(data, now.add(_ttl));
    return data;
  }

  Future<List<StandingRow>> getStandings({
    required int leagueId,
    required int season,
  }) async {
    final key = _StandingsKey(leagueId, season);
    final now = DateTime.now();
    final hit = _standingsCache[key];
    if (hit != null && now.isBefore(hit.expiry)) return hit.value;

    final data = await _api.getStandings(leagueId: leagueId, season: season);
    _standingsCache[key] = _Timed(data, now.add(_ttl));
    return data;
  }
}

// ------------ keyed cache helpers (internal) -------------------------------

class _Timed<V> {
  _Timed(this.value, this.expiry);
  final V value;
  final DateTime expiry;
}

class _LeaguesKey {
  const _LeaguesKey(this.country, this.type, this.season);
  final String? country;
  final String? type;
  final int? season;

  @override
  bool operator ==(Object other) =>
      other is _LeaguesKey &&
      country == other.country &&
      type == other.type &&
      season == other.season;

  @override
  int get hashCode => Object.hash(country, type, season);
}

class _TeamsKey {
  const _TeamsKey(this.teamId, this.season);
  final int teamId;
  final int? season;

  @override
  bool operator ==(Object other) =>
      other is _TeamsKey &&
      teamId == other.teamId &&
      season == other.season;

  @override
  int get hashCode => Object.hash(teamId, season);
}

class _StandingsKey {
  const _StandingsKey(this.leagueId, this.season);
  final int leagueId;
  final int season;

  @override
  bool operator ==(Object other) =>
      other is _StandingsKey &&
      leagueId == other.leagueId &&
      season == other.season;

  @override
  int get hashCode => Object.hash(leagueId, season);
}

class _StatsKey {
  const _StatsKey(this.leagueId, this.season, this.teamId);
  final int leagueId;
  final int season;
  final int teamId;

  @override
  bool operator ==(Object other) =>
      other is _StatsKey &&
      leagueId == other.leagueId &&
      season == other.season &&
      teamId == other.teamId;

  @override
  int get hashCode => Object.hash(leagueId, season, teamId);
}
