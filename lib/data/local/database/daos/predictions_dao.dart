// path: lib/data/local/database/daos/predictions_dao.dart
// DAO for managing user predictions (Implementation Plan section 4).
import 'package:FlutterApp/data/local/database/app_database.dart';
import 'package:FlutterApp/data/local/database/schema/predictions_table.dart';
import 'package:FlutterApp/data/models/prediction.dart';
import 'package:drift/drift.dart';

part 'predictions_dao.g.dart';

@DriftAccessor(tables: [PredictionsTable])
class PredictionsDao extends DatabaseAccessor<AppDatabase>
    with _$PredictionsDaoMixin {
  PredictionsDao(super.db);

  Future<int> upsertPrediction(Prediction prediction) => into(
    predictionsTable,
  ).insertOnConflictUpdate(_toCompanion(prediction));

  Future<void> deleteByFixture(int fixtureId) async {
    await (delete(
      predictionsTable,
    )..where((tbl) => tbl.fixtureId.equals(fixtureId))).go();
  }

  Future<Prediction?> getByFixture(int fixtureId) async {
    final row =
        await (select(predictionsTable)
              ..where((tbl) => tbl.fixtureId.equals(fixtureId))
              ..limit(1))
            .getSingleOrNull();
    if (row == null) return null;
    return _fromData(row);
  }

  Future<List<Prediction>> getAllOrdered() async {
    final rows = await (select(
      predictionsTable,
    )..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)])).get();
    return rows.map(_fromData).toList();
  }

  Future<void> markResult(
    int fixtureId, {
    required String result,
    DateTime? gradedAt,
  }) async {
    await (update(
      predictionsTable,
    )..where((tbl) => tbl.fixtureId.equals(fixtureId))).write(
      PredictionsTableCompanion(
        result: Value(result),
        gradedAt: gradedAt == null
            ? const Value(null)
            : Value(gradedAt.toUtc()),
      ),
    );
  }

  Future<void> setLockedAt(int fixtureId, DateTime lockedAt) async {
    await (update(
      predictionsTable,
    )..where((tbl) => tbl.fixtureId.equals(fixtureId))).write(
      PredictionsTableCompanion(
        lockedAt: Value(lockedAt.toUtc()),
      ),
    );
  }

  Future<void> setOpenedDetails(int fixtureId, bool opened) async {
    await (update(
      predictionsTable,
    )..where((tbl) => tbl.fixtureId.equals(fixtureId))).write(
      PredictionsTableCompanion(
        openedDetails: Value(opened),
      ),
    );
  }

  PredictionsTableCompanion _toCompanion(Prediction prediction) =>
      PredictionsTableCompanion(
        fixtureId: Value(prediction.fixtureId),
        pick: Value(prediction.pick),
        odds: Value(prediction.odds),
        createdAt: Value(prediction.madeAt.toUtc()),
        lockedAt: prediction.lockedAt == null
            ? const Value(null)
            : Value(prediction.lockedAt!.toUtc()),
        gradedAt: prediction.gradedAt == null
            ? const Value(null)
            : Value(prediction.gradedAt!.toUtc()),
        result: prediction.result == null
            ? const Value(null)
            : Value(prediction.result),
        openedDetails: Value(prediction.openedDetails),
      );

  Prediction _fromData(PredictionsTableData data) => Prediction(
    fixtureId: data.fixtureId,
    pick: data.pick,
    odds: data.odds,
    madeAt: data.createdAt.toLocal(),
    lockedAt: data.lockedAt?.toLocal(),
    gradedAt: data.gradedAt?.toLocal(),
    result: data.result,
    openedDetails: data.openedDetails,
  );
}

