// path: lib/data/local/database/daos/odds_dao.dart
// DAO for persisting odds snapshots locally (Implementation Plan section 4).
import 'package:FlutterApp/data/local/database/app_database.dart';
import 'package:FlutterApp/data/local/database/schema/odds_table.dart';
import 'package:FlutterApp/data/models/odds_snapshot.dart';
import 'package:drift/drift.dart';

part 'odds_dao.g.dart';

@DriftAccessor(tables: [OddsTable])
class OddsDao extends DatabaseAccessor<AppDatabase> with _$OddsDaoMixin {
  OddsDao(super.db);

  Future<void> upsert(OddsSnapshot snapshot) async {
    await into(oddsTable).insertOnConflictUpdate(
      OddsTableCompanion(
        fixtureId: Value(snapshot.fixtureId),
        homeOdd: Value(snapshot.home),
        drawOdd: Value(snapshot.draw),
        awayOdd: Value(snapshot.away),
        provider: const Value(null),
        takenAt: Value(snapshot.ts),
      ),
    );
  }

  Future<OddsSnapshot?> getByFixture(int fixtureId) async {
    final row =
        await (select(oddsTable)
              ..where((tbl) => tbl.fixtureId.equals(fixtureId))
              ..limit(1))
            .getSingleOrNull();
    if (row == null) return null;
    return OddsSnapshot(
      fixtureId: row.fixtureId,
      home: row.homeOdd,
      draw: row.drawOdd,
      away: row.awayOdd,
      ts: row.takenAt,
    );
  }
}
