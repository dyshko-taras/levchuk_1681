// path: lib/data/repositories/odds_repository.dart
// Repository for odds snapshots backed by network and local Drift cache.
import 'package:FlutterApp/data/api/football_service.dart';
import 'package:FlutterApp/data/local/database/daos/odds_dao.dart';
import 'package:FlutterApp/data/models/odds_snapshot.dart';

class OddsRepository {
  OddsRepository({
    required FootballService api,
    required OddsDao oddsDao,
    Duration ttl = const Duration(minutes: 60),
  }) : _api = api,
       _oddsDao = oddsDao,
       _ttl = ttl;

  final FootballService _api;
  final OddsDao _oddsDao;
  final Duration _ttl;

  final Map<int, DateTime> _lastFetched = <int, DateTime>{};

  Future<OddsSnapshot?> getByFixture(
    int fixtureId, {
    bool forceRefresh = false,
  }) async {
    final cached = await _oddsDao.getByFixture(fixtureId);
    final shouldRefresh =
        forceRefresh || cached == null || _isExpired(fixtureId);
    if (!shouldRefresh) {
      return cached;
    }
    try {
      final snapshot = await _api.getOddsByFixture(fixtureId: fixtureId);
      await _oddsDao.upsert(snapshot);
      _lastFetched[fixtureId] = DateTime.now();
      return snapshot;
    } catch (_) {
      // fall back to cached value if available
      if (cached != null) {
        return cached;
      }
      rethrow;
    }
  }

  bool _isExpired(int fixtureId) {
    final ts = _lastFetched[fixtureId];
    if (ts == null) return true;
    return DateTime.now().difference(ts) > _ttl;
  }
}
