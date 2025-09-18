// path: lib/data/local/database/daos/journal_dao.dart
// DAO for prediction journal entries.
import 'dart:convert';

import 'package:FlutterApp/data/local/database/app_database.dart';
import 'package:FlutterApp/data/local/database/schema/journal_entries_table.dart';
import 'package:FlutterApp/data/models/journal_entry.dart';
import 'package:drift/drift.dart';

part 'journal_dao.g.dart';

@DriftAccessor(tables: [JournalEntriesTable])
class JournalDao extends DatabaseAccessor<AppDatabase> with _$JournalDaoMixin {
  JournalDao(AppDatabase db) : super(db);

  Future<JournalEntry?> getForDate(DateTime date) async {
    final key = _formatDate(date);
    final row =
        await (select(journalEntriesTable)
              ..where((tbl) => tbl.dateYmd.equals(key))
              ..limit(1))
            .getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<List<JournalEntry>> getBetween(DateTime start, DateTime end) async {
    final startKey = _formatDate(start);
    final endKey = _formatDate(end);
    final rows =
        await (select(journalEntriesTable)..where(
              (tbl) => tbl.dateYmd.isBetweenValues(startKey, endKey),
            ))
            .get();
    return rows.map(_toModel).toList(growable: false);
  }

  Future<void> upsert(JournalEntry entry) async {
    await into(journalEntriesTable).insertOnConflictUpdate(
      JournalEntriesTableCompanion(
        dateYmd: Value(_formatDate(entry.date)),
        eventsJson: Value(jsonEncode(entry.events)),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteForDate(DateTime date) async {
    await (delete(
      journalEntriesTable,
    )..where((tbl) => tbl.dateYmd.equals(_formatDate(date)))).go();
  }

  JournalEntry _toModel(JournalEntriesTableData data) {
    final events = (jsonDecode(data.eventsJson) as List<dynamic>)
        .map((dynamic e) => e.toString())
        .toList();
    return JournalEntry(
      date: DateTime.parse('${data.dateYmd}T00:00:00Z').toLocal(),
      events: events,
    );
  }

  String _formatDate(DateTime date) {
    final local = DateTime(date.year, date.month, date.day);
    final y = local.year.toString().padLeft(4, '0');
    final m = local.month.toString().padLeft(2, '0');
    final d = local.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }
}
