// path: lib/data/local/database/schema/predictions_table.dart
// Drift table for user predictions (Implementation Plan section 4).
import 'package:drift/drift.dart';

import 'matches_table.dart';

class PredictionsTable extends Table {
  IntColumn get id => integer().named('id').autoIncrement()();
  IntColumn get fixtureId => integer()
      .named('fixture_id')
      .references(MatchesTable, #fixtureId, onDelete: KeyAction.cascade)();
  TextColumn get pick => text().named('pick')();
  RealColumn get odds => real().named('odds').nullable()();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get lockedAt => dateTime().named('locked_at').nullable()();
  DateTimeColumn get gradedAt => dateTime().named('graded_at').nullable()();
  TextColumn get result => text().named('result').nullable()();
  BoolColumn get openedDetails =>
      boolean().named('opened_details').withDefault(const Constant(false))();

  @override
  List<Index> get indexes => [
        Index('idx_predictions_fixture', 'fixture_id'),
        Index('idx_predictions_created_at', 'created_at'),
      ];
}
