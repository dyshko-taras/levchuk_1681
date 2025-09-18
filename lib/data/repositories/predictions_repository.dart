// path: lib/data/repositories/predictions_repository.dart
// Repository for user predictions. Handles CRUD and grading against fixtures.
import 'package:FlutterApp/data/local/database/daos/matches_dao.dart';
import 'package:FlutterApp/data/local/database/daos/predictions_dao.dart';
import 'package:FlutterApp/data/models/fixture.dart';
import 'package:FlutterApp/data/models/prediction.dart';

class PredictionsRepository {
  PredictionsRepository({
    required PredictionsDao predictionsDao,
    required MatchesDao matchesDao,
  }) : _predictionsDao = predictionsDao,
       _matchesDao = matchesDao;

  final PredictionsDao _predictionsDao;
  final MatchesDao _matchesDao;

  Future<List<Prediction>> getAll() => _predictionsDao.getAllOrdered();

  Future<Prediction?> getByFixture(int fixtureId) =>
      _predictionsDao.getByFixture(fixtureId);

  Future<void> savePrediction(Prediction prediction) =>
      _predictionsDao.upsertPrediction(prediction);

  Future<void> deletePrediction(int fixtureId) =>
      _predictionsDao.deleteByFixture(fixtureId);

  Future<void> markOpenedDetails(int fixtureId, bool opened) =>
      _predictionsDao.setOpenedDetails(fixtureId, opened);

  Future<void> lockPrediction(int fixtureId, DateTime lockedAt) =>
      _predictionsDao.setLockedAt(fixtureId, lockedAt);

  Future<Prediction?> gradePrediction(int fixtureId) async {
    final prediction = await _predictionsDao.getByFixture(fixtureId);
    if (prediction == null) return null;

    final fixture = await _matchesDao.getById(fixtureId);
    if (fixture == null || !_isFixtureFinished(fixture)) {
      return prediction;
    }

    final winner = _resolveWinner(fixture);
    if (winner == null) {
      return prediction;
    }

    final result = prediction.pick == winner ? 'correct' : 'missed';
    await _predictionsDao.markResult(
      fixtureId,
      result: result,
      gradedAt: DateTime.now(),
    );
    return _predictionsDao.getByFixture(fixtureId);
  }

  bool _isFixtureFinished(Fixture fixture) {
    const finishedStatuses = <String>{'FT', 'AET', 'PEN'};
    return finishedStatuses.contains(fixture.status.toUpperCase());
  }

  String? _resolveWinner(Fixture fixture) {
    final home = fixture.goalsHome;
    final away = fixture.goalsAway;
    if (home == null || away == null) return null;
    if (home > away) return 'home';
    if (home < away) return 'away';
    return 'draw';
  }
}
