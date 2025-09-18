
// path: lib/data/local/database/schema/favorites_notes_tables.dart
// Drift tables for favorites and notes (Implementation Plan section 4).
import 'package:drift/drift.dart';

import 'matches_table.dart';

class FavoritesTable extends Table {
  IntColumn get id => integer().named('id').autoIncrement()();
  TextColumn get type => text().named('type')();
  IntColumn get refId => integer().named('ref_id')();
  DateTimeColumn get createdAt => dateTime().named('created_at')();

  @override
  List<Set<Column>> get uniqueKeys => [
        {type, refId},
      ];
}
class NotesTable extends Table {
  IntColumn get id => integer().named('id').autoIncrement()();
  IntColumn get fixtureId => integer()
      .named('fixture_id')
      .references(MatchesTable, #fixtureId, onDelete: KeyAction.cascade)();
  TextColumn get noteText => text().named('text')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  @override
  List<Index> get indexes => [
        Index('idx_notes_fixture', 'fixture_id'),
      ];

  @override
  List<Set<Column>> get uniqueKeys => [
        {fixtureId},
      ];
}

