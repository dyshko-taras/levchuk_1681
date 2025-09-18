// path: lib/data/repositories/notes_repository.dart
// Repository for fixture notes stored locally.
import 'package:FlutterApp/data/local/database/daos/notes_dao.dart';
import 'package:FlutterApp/data/models/note.dart';

class NotesRepository {
  NotesRepository(this._dao);

  final NotesDao _dao;

  Future<void> saveNote(Note note) => _dao.upsert(note);

  Future<Note?> getNote(int fixtureId) => _dao.getByFixture(fixtureId);

  Future<void> deleteNote(int fixtureId) => _dao.deleteByFixture(fixtureId);
}
