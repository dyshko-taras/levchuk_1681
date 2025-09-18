// path: lib/data/local/database/schema/odds_table.dart
// Drift table storing per-fixture odds snapshots
import 'package:FlutterApp/data/local/database/schema/matches_table.dart';
import 'package:drift/drift.dart';

class OddsTable extends Table {
  IntColumn get fixtureId => integer()
      .named('fixture_id')
      .references(MatchesTable, #fixtureId, onDelete: KeyAction.cascade)();
  RealColumn get homeOdd => real().named('home_odd')();
  RealColumn get drawOdd => real().named('draw_odd')();
  RealColumn get awayOdd => real().named('away_odd')();
  TextColumn get provider => text().named('provider').nullable()();
  DateTimeColumn get takenAt => dateTime().named('taken_at')();

  @override
  Set<Column> get primaryKey => {fixtureId};

  List<Index> get indexes => [
    Index('idx_odds_fixture', 'fixture_id'),
  ];
}
