// path: lib/data/local/database/schema/journal_entries_table.dart
// Drift table for storing daily journal entries.
import 'package:drift/drift.dart';

class JournalEntriesTable extends Table {
  TextColumn get dateYmd => text().named('date_ymd')();
  TextColumn get eventsJson =>
      text().named('events_json').withDefault(const Constant('[]'))();
  DateTimeColumn get updatedAt =>
      dateTime().named('updated_at').withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {dateYmd};
}
