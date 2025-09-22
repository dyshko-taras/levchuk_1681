// path: lib/data/local/database/app_database.dart
// Central Drift database wiring tables per Implementation Plan section 4.
import 'package:FlutterApp/data/local/database/daos/achievements_dao.dart';
import 'package:FlutterApp/data/local/database/daos/favorites_dao.dart';
import 'package:FlutterApp/data/local/database/daos/journal_dao.dart';
import 'package:FlutterApp/data/local/database/daos/matches_dao.dart';
import 'package:FlutterApp/data/local/database/daos/notes_dao.dart';
import 'package:FlutterApp/data/local/database/daos/odds_dao.dart';
import 'package:FlutterApp/data/local/database/daos/predictions_dao.dart';
import 'package:FlutterApp/data/local/database/daos/profile_dao.dart';
import 'package:FlutterApp/data/local/database/schema/achievements_table.dart';
import 'package:FlutterApp/data/local/database/schema/favorites_notes_tables.dart';
import 'package:FlutterApp/data/local/database/schema/journal_entries_table.dart';
import 'package:FlutterApp/data/local/database/schema/matches_table.dart';
import 'package:FlutterApp/data/local/database/schema/odds_table.dart';
import 'package:FlutterApp/data/local/database/schema/predictions_table.dart';
import 'package:FlutterApp/data/local/database/schema/profile_table.dart';
import 'package:drift/drift.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    MatchesTable,
    OddsTable,
    PredictionsTable,
    FavoritesTable,
    NotesTable,
    AchievementsTable,
    ProfileTable,
    JournalEntriesTable,
  ],
  daos: [
    MatchesDao,
    OddsDao,
    PredictionsDao,
    FavoritesDao,
    NotesDao,
    AchievementsDao,
    ProfileDao,
    JournalDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 1;
}
