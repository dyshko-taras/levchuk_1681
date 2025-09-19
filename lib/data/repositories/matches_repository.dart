// path: lib/data/repositories/matches_repository.dart
// Repository that orchestrates fixtures between network (Retrofit) and local DB cache.
import 'package:FlutterApp/core/env.dart';
import 'package:FlutterApp/data/api/api_client.dart';
import 'package:FlutterApp/data/local/database/daos/matches_dao.dart';
import 'package:FlutterApp/data/models/fixture.dart';
import 'package:FlutterApp/utils/date_fmt.dart';

class MatchesRepository {
  MatchesRepository({
    required MatchesDao matchesDao,
    Duration ttl = const Duration(minutes: 3),
  }) : _matchesDao = matchesDao,
       _ttl = ttl;

  final MatchesDao _matchesDao;
  final Duration _ttl;

  final Map<Object, DateTime> _lastFetched = <Object, DateTime>{};

  Future<List<Fixture>> getByDate(
    DateTime date, {
    bool forceRefresh = false,
  }) async {
    final day = DateTime(date.year, date.month, date.day);
    final cacheKey = _DateKey(day);
    final cached = await _matchesDao.getByDate(day);
    final shouldRefresh =
        forceRefresh || cached.isEmpty || _isExpired(cacheKey);
    if (!shouldRefresh) {
      return cached;
    }
    final fixtures = await _fetchFixtures(
      queryParameters: <String, dynamic>{'date': ymd(day)},
    );
    await _matchesDao.replaceForDate(day, fixtures);
    _touch(cacheKey);
    return fixtures;
  }

  Future<List<Fixture>> getByLeague({
    required int leagueId,
    required int season,
    DateTime? date,
    String? status,
    bool forceRefresh = false,
  }) async {
    final cacheKey = _LeagueKey(
      leagueId: leagueId,
      season: season,
      date: date == null ? null : DateTime(date.year, date.month, date.day),
      status: status,
    );
    final cached = await _matchesDao.getByLeague(
      leagueId: leagueId,
      season: season,
      date: date,
      status: status,
    );
    final shouldRefresh =
        forceRefresh || cached.isEmpty || _isExpired(cacheKey);
    if (!shouldRefresh) {
      return cached;
    }
    final fixtures = await _fetchFixtures(
      queryParameters: <String, dynamic>{
        'league': leagueId,
        'season': season,
        if (date != null) 'date': ymd(date),
        if (status != null) 'status': status,
      },
    );
    await _matchesDao.upsertFixtures(fixtures, season: season);
    _touch(cacheKey);
    return fixtures;
  }

  Future<List<Fixture>> getLive({bool forceRefresh = false}) async {
    const cacheKey = _LiveKey();
    if (!forceRefresh && !_isExpired(cacheKey)) {
      final cached = await _matchesDao.getLiveFixtures();
      if (cached.isNotEmpty) {
        return cached;
      }
    }
    final fixtures = await _fetchFixtures(
      queryParameters: const <String, dynamic>{'live': 'all'},
    );
    await _matchesDao.upsertFixtures(fixtures);
    _touch(cacheKey);
    return fixtures;
  }

  Future<Fixture?> getById(int id, {bool forceRefresh = false}) async {
    final cacheKey = id;
    if (!forceRefresh) {
      final cached = await _matchesDao.getById(id);
      if (cached != null && !_isExpired(cacheKey)) {
        return cached;
      }
    }
    final fixtures = await _fetchFixtures(
      queryParameters: <String, dynamic>{'id': id},
    );
    if (fixtures.isNotEmpty) {
      await _matchesDao.upsertFixtures(fixtures);
    }
    _touch(cacheKey);
    return fixtures.isEmpty ? null : fixtures.first;
  }

  Future<List<Fixture>> _fetchFixtures({
    required Map<String, dynamic> queryParameters,
  }) async {
    final response = await ApiClient.dio.get<Map<String, dynamic>>(
      '/fixtures',
      queryParameters: <String, dynamic>{
        'timezone': Env.tz,
        ...queryParameters,
      },
    );
    final data = response.data;
    if (data == null) {
      return const <Fixture>[];
    }
    final list = data['response'] as List<dynamic>? ?? const <dynamic>[];
    return list
        .map(
          (dynamic json) => Fixture.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  bool _isExpired(Object key) {
    final ts = _lastFetched[key];
    if (ts == null) return true;
    return DateTime.now().difference(ts) > _ttl;
  }

  void _touch(Object key) {
    _lastFetched[key] = DateTime.now();
  }
}

class _DateKey {
  const _DateKey(this.date);
  final DateTime date;

  @override
  bool operator ==(Object other) =>
      other is _DateKey &&
      date.year == other.date.year &&
      date.month == other.date.month &&
      date.day == other.date.day;

  @override
  int get hashCode => Object.hash(date.year, date.month, date.day);
}

class _LeagueKey {
  const _LeagueKey({
    required this.leagueId,
    required this.season,
    this.date,
    this.status,
  });

  final int leagueId;
  final int season;
  final DateTime? date;
  final String? status;

  @override
  bool operator ==(Object other) =>
      other is _LeagueKey &&
      other.leagueId == leagueId &&
      other.season == season &&
      _sameDate(other.date, date) &&
      other.status == status;

  @override
  int get hashCode => Object.hash(
    leagueId,
    season,
    date == null ? null : Object.hash(date!.year, date!.month, date!.day),
    status,
  );

  bool _sameDate(DateTime? a, DateTime? b) {
    if (a == null || b == null) return a == b;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

class _LiveKey {
  const _LiveKey();

  @override
  bool operator ==(Object other) => other is _LiveKey;

  @override
  int get hashCode => 0;
}
