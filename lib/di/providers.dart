// path: lib/di/providers.dart
// Provider graph: service + repositories (created once).
import 'dart:io';

import 'package:FlutterApp/data/api/football_service.dart';
import 'package:FlutterApp/data/local/database/app_database.dart';
import 'package:FlutterApp/data/local/prefs_store.dart';
import 'package:FlutterApp/data/repositories/achievements_repository.dart';
import 'package:FlutterApp/data/repositories/favorites_repository.dart';
import 'package:FlutterApp/data/repositories/journal_repository.dart';
import 'package:FlutterApp/data/repositories/leagues_repository.dart';
import 'package:FlutterApp/data/repositories/matches_repository.dart';
import 'package:FlutterApp/data/repositories/notes_repository.dart';
import 'package:FlutterApp/data/repositories/odds_repository.dart';
import 'package:FlutterApp/data/repositories/predictions_repository.dart';
import 'package:FlutterApp/data/repositories/profile_repository.dart';
import 'package:drift/drift.dart' show LazyDatabase;
import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

final Future<PrefsStore> _prefsStoreFuture = PrefsStore.create();

Widget buildAppProviders({required Widget child}) {
  return FutureBuilder<PrefsStore>(
    future: _prefsStoreFuture,
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const SizedBox.shrink();
      }
      final prefs = snapshot.data!;
      return MultiProvider(
        providers: [
          Provider<PrefsStore>.value(value: prefs),
          Provider<FootballService>(
            create: (_) => createFootballService(),
          ),
          Provider<AppDatabase>(
            create: (_) => AppDatabase(_openConnection()),
            dispose: (_, db) => db.close(),
          ),
          ProxyProvider2<FootballService, AppDatabase, MatchesRepository>(
            update: (_, api, db, __) => MatchesRepository(
              api: api,
              matchesDao: db.matchesDao,
            ),
          ),
          ProxyProvider2<FootballService, AppDatabase, OddsRepository>(
            update: (_, api, db, __) => OddsRepository(
              api: api,
              oddsDao: db.oddsDao,
            ),
          ),
          ProxyProvider<FootballService, LeaguesRepository>(
            update: (_, api, __) => LeaguesRepository(api),
          ),
          ProxyProvider<AppDatabase, FavoritesRepository>(
            update: (_, db, __) => FavoritesRepository(db.favoritesDao),
          ),
          ProxyProvider<AppDatabase, NotesRepository>(
            update: (_, db, __) => NotesRepository(db.notesDao),
          ),
          ProxyProvider<AppDatabase, PredictionsRepository>(
            update: (_, db, __) => PredictionsRepository(
              predictionsDao: db.predictionsDao,
              matchesDao: db.matchesDao,
            ),
          ),
          ProxyProvider<AppDatabase, ProfileRepository>(
            update: (_, db, __) => ProfileRepository(db.profileDao),
          ),
          ProxyProvider<AppDatabase, AchievementsRepository>(
            update: (_, db, __) => AchievementsRepository(
              achievementsDao: db.achievementsDao,
              predictionsDao: db.predictionsDao,
              matchesDao: db.matchesDao,
            ),
          ),
          ProxyProvider<AppDatabase, JournalRepository>(
            update: (_, db, __) => JournalRepository(db.journalDao),
          ),
        ],
        child: child,
      );
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'football_predictor.db'));
    return NativeDatabase(file);
  });
}

