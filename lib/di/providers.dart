// path: lib/di/providers.dart
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
import 'package:FlutterApp/providers/achievements_provider.dart';
import 'package:FlutterApp/providers/app_bootstrap_provider.dart';
import 'package:FlutterApp/providers/bottom_nav_provider.dart';
import 'package:FlutterApp/providers/favorites_provider.dart';
import 'package:FlutterApp/providers/insights_provider.dart';
import 'package:FlutterApp/providers/matches_provider.dart';
import 'package:FlutterApp/providers/my_predictions_provider.dart';
import 'package:FlutterApp/providers/prediction_journal_provider.dart';
import 'package:FlutterApp/providers/statistics_provider.dart';
import 'package:FlutterApp/providers/user_profile_provider.dart';
import 'package:FlutterApp/providers/welcome_provider.dart';
import 'package:drift/drift.dart' show LazyDatabase;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

Widget buildAppProviders({required Widget child}) =>
    _AppProviders(child: child);

class _AppProviders extends StatefulWidget {
  const _AppProviders({required this.child});

  final Widget child;

  @override
  State<_AppProviders> createState() => _AppProvidersState();
}

class _AppProvidersState extends State<_AppProviders> {
  late Future<PrefsStore> _prefsFuture;

  @override
  void initState() {
    super.initState();
    _prefsFuture = PrefsStore.create();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PrefsStore>(
      future: _prefsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Directionality(
            textDirection: TextDirection.ltr,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return const Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: Text('Failed to initialise preferences'),
            ),
          );
        }

        final prefs = snapshot.requireData;
        return MultiProvider(
          providers: _buildProviders(prefs),
          child: widget.child,
        );
      },
    );
  }

  List<SingleChildWidget> _buildProviders(PrefsStore prefs) =>
      <SingleChildWidget>[
        Provider<PrefsStore>.value(value: prefs),
        Provider<FootballService>(
          create: (_) => createFootballService(),
        ),
        Provider<AppDatabase>(
          create: (_) => AppDatabase(_openConnection()),
          dispose: (_, db) => db.close(),
        ),
        ProxyProvider<AppDatabase, MatchesRepository>(
          update: (_, db, previous) =>
              previous ??
              MatchesRepository(
                matchesDao: db.matchesDao,
              ),
        ),
        ProxyProvider2<FootballService, AppDatabase, OddsRepository>(
          update: (_, api, db, previous) =>
              previous ??
              OddsRepository(
                api: api,
                oddsDao: db.oddsDao,
              ),
        ),
        ProxyProvider<FootballService, LeaguesRepository>(
          update: (_, api, previous) => previous ?? LeaguesRepository(api),
        ),
        ProxyProvider<AppDatabase, FavoritesRepository>(
          update: (_, db, previous) =>
              previous ?? FavoritesRepository(db.favoritesDao),
        ),
        ProxyProvider<AppDatabase, NotesRepository>(
          update: (_, db, previous) => previous ?? NotesRepository(db.notesDao),
        ),
        ProxyProvider<AppDatabase, PredictionsRepository>(
          update: (_, db, previous) =>
              previous ??
              PredictionsRepository(
                predictionsDao: db.predictionsDao,
                matchesDao: db.matchesDao,
              ),
        ),
        ProxyProvider<AppDatabase, ProfileRepository>(
          update: (_, db, previous) =>
              previous ?? ProfileRepository(db.profileDao),
        ),
        ProxyProvider<AppDatabase, AchievementsRepository>(
          update: (_, db, previous) =>
              previous ??
              AchievementsRepository(
                achievementsDao: db.achievementsDao,
                predictionsDao: db.predictionsDao,
                matchesDao: db.matchesDao,
              ),
        ),
        ProxyProvider<AppDatabase, JournalRepository>(
          update: (_, db, previous) =>
              previous ?? JournalRepository(db.journalDao),
        ),
        ChangeNotifierProvider<AppBootstrapProvider>(
          create: (_) => AppBootstrapProvider(prefs),
        ),
        ChangeNotifierProvider<WelcomeProvider>(
          create: (_) => WelcomeProvider(prefs),
        ),
        ChangeNotifierProvider<BottomNavProvider>(
          create: (_) => BottomNavProvider(),
        ),
        ChangeNotifierProvider<MatchesProvider>(
          lazy: false,
          create: (context) => MatchesProvider(
            matchesRepository: context.read<MatchesRepository>(),
            predictionsRepository: context.read<PredictionsRepository>(),
            favoritesRepository: context.read<FavoritesRepository>(),
            notesRepository: context.read<NotesRepository>(),
            oddsRepository: context.read<OddsRepository>(),
          )..load(),
        ),
        ChangeNotifierProvider<StatisticsProvider>(
          create: (context) => StatisticsProvider(
            predictionsRepository: context.read<PredictionsRepository>(),
            matchesRepository: context.read<MatchesRepository>(),
            achievementsRepository: context.read<AchievementsRepository>(),
          ),
        ),
        ChangeNotifierProvider<FavoritesProvider>(
          create: (context) => FavoritesProvider(
            favoritesRepository: context.read<FavoritesRepository>(),
            matchesRepository: context.read<MatchesRepository>(),
            leaguesRepository: context.read<LeaguesRepository>(),
          ),
        ),
        ChangeNotifierProvider<UserProfileProvider>(
          create: (context) => UserProfileProvider(
            profileRepository: context.read<ProfileRepository>(),
            predictionsRepository: context.read<PredictionsRepository>(),
            matchesRepository: context.read<MatchesRepository>(),
            achievementsRepository: context.read<AchievementsRepository>(),
          ),
        ),
        ChangeNotifierProvider<MyPredictionsProvider>(
          create: (context) => MyPredictionsProvider(
            predictionsRepository: context.read<PredictionsRepository>(),
            matchesRepository: context.read<MatchesRepository>(),
            favoritesRepository: context.read<FavoritesRepository>(),
          ),
        ),
        ChangeNotifierProvider<AchievementsProvider>(
          create: (context) => AchievementsProvider(
            context.read<AchievementsRepository>(),
          ),
        ),
        ChangeNotifierProvider<InsightsProvider>(
          create: (context) => InsightsProvider(
            predictionsRepository: context.read<PredictionsRepository>(),
            matchesRepository: context.read<MatchesRepository>(),
          ),
        ),
        ChangeNotifierProvider<PredictionJournalProvider>(
          create: (context) => PredictionJournalProvider(
            predictionsRepository: context.read<PredictionsRepository>(),
            matchesRepository: context.read<MatchesRepository>(),
            journalRepository: context.read<JournalRepository>(),
          ),
        ),
      ];
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'football_predictor.db'));
    return NativeDatabase(file);
  });
}
