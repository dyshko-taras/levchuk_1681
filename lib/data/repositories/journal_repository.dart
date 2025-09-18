// path: lib/data/repositories/journal_repository.dart
// Repository for prediction journal entries.
import 'package:FlutterApp/data/local/database/daos/journal_dao.dart';
import 'package:FlutterApp/data/models/journal_entry.dart';

class JournalRepository {
  JournalRepository(this._dao);

  final JournalDao _dao;

  Future<JournalEntry?> getEntry(DateTime date) => _dao.getForDate(date);

  Future<List<JournalEntry>> getEntries(DateTime start, DateTime end) =>
      _dao.getBetween(start, end);

  Future<void> saveEntry(DateTime date, List<String> events) async {
    final entry = JournalEntry(date: date, events: events);
    await _dao.upsert(entry);
  }

  Future<void> addEvent(DateTime date, String event) async {
    final existing = await _dao.getForDate(date);
    final events = List<String>.from(existing?.events ?? const <String>[])
      ..add(event);
    await saveEntry(date, events);
  }

  Future<void> removeEvent(DateTime date, String event) async {
    final existing = await _dao.getForDate(date);
    if (existing == null) return;
    final events = List<String>.from(existing.events)
      ..removeWhere((element) => element == event);
    if (events.isEmpty) {
      await _dao.deleteForDate(date);
    } else {
      await saveEntry(date, events);
    }
  }
}

