// path: lib/data/local/database/daos/notes_dao.dart
// DAO for fixture notes per Implementation Plan section 4.
import 'package:FlutterApp/data/local/database/app_database.dart';
import 'package:FlutterApp/data/local/database/schema/favorites_notes_tables.dart';
import 'package:FlutterApp/data/models/note.dart';
import 'package:drift/drift.dart';

part 'notes_dao.g.dart';

@DriftAccessor(tables: [NotesTable])
class NotesDao extends DatabaseAccessor<AppDatabase> with _$NotesDaoMixin {
  NotesDao(AppDatabase db) : super(db);

  Future<void> upsert(Note note) async {
    await into(notesTable).insertOnConflictUpdate(
      NotesTableCompanion(
        id: note.id == 0 ? const Value.absent() : Value(note.id),
        fixtureId: Value(note.fixtureId),
        noteText: Value(note.text),
        updatedAt: Value(note.updatedAt),
      ),
    );
  }

  Future<int> deleteByFixture(int fixtureId) => (delete(
    notesTable,
  )..where((tbl) => tbl.fixtureId.equals(fixtureId))).go();

  Future<Note?> getByFixture(int fixtureId) async {
    final row =
        await (select(notesTable)
              ..where((tbl) => tbl.fixtureId.equals(fixtureId))
              ..limit(1))
            .getSingleOrNull();
    if (row == null) return null;
    return Note(
      id: row.id,
      fixtureId: row.fixtureId,
      text: row.noteText,
      updatedAt: row.updatedAt,
    );
  }
}

