// path: lib/constants/app_routes.dart
// Centralized route names, generators, and helpers for navigation.
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/ui/pages/achievements_page.dart';
import 'package:FlutterApp/ui/pages/insights_page.dart';
import 'package:FlutterApp/ui/pages/main_shell_page.dart';
import 'package:FlutterApp/ui/pages/match_details_page.dart';
import 'package:FlutterApp/ui/pages/my_predictions_page.dart';
import 'package:FlutterApp/ui/pages/not_found_page.dart';
import 'package:FlutterApp/ui/pages/prediction_journal_page.dart';
import 'package:FlutterApp/ui/pages/splash_page.dart';
import 'package:FlutterApp/ui/pages/welcome_page.dart';
import 'package:flutter/material.dart';

final class AppRoutes {
  const AppRoutes._();

  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String shell = '/';
  static const String matches = '/matches';
  static const String stats = '/stats';
  static const String favorites = '/favorites';
  static const String profile = '/profile';
  static const String myPredictions = '/predictions';
  static const String achievements = '/achievements';
  static const String insights = '/insights';
  static const String journal = '/journal';
  static const String _matchDetailsBase = '/match';

  static String matchDetails(int fixtureId) => '$_matchDetailsBase/$fixtureId';

  static String get initialRoute => splash;

  static Map<String, WidgetBuilder> get _staticRoutes =>
      <String, WidgetBuilder>{
        splash: (_) => const SplashPage(),
        welcome: (_) => const WelcomePage(),
        shell: (_) => const MainShellPage(),
        matches: (_) => const MainShellPage(initialIndex: 0),
        stats: (_) => const MainShellPage(initialIndex: 1),
        favorites: (_) => const MainShellPage(initialIndex: 2),
        profile: (_) => const MainShellPage(initialIndex: 3),
        myPredictions: (_) => const MyPredictionsPage(),
        achievements: (_) => const AchievementsPage(),
        insights: (_) => const InsightsPage(),
        journal: (_) => const PredictionJournalPage(),
      };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final name = settings.name;
    if (name == null) {
      return _buildRoute(const NotFoundPage(), settings);
    }

    final builder = _staticRoutes[name];
    if (builder != null) {
      return MaterialPageRoute<void>(
        builder: builder,
        settings: settings,
      );
    }

    if (name.startsWith('$_matchDetailsBase/')) {
      final idPart = name.substring(_matchDetailsBase.length + 1);
      final id = int.tryParse(idPart);
      if (id != null) {
        return _buildRoute(MatchDetailsPage(fixtureId: id), settings);
      }
    }

    return _buildRoute(
      const NotFoundPage(message: AppStrings.notFoundTitle),
      settings,
    );
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) =>
      _buildRoute(const NotFoundPage(), settings);

  static MaterialPageRoute<void> _buildRoute(
    Widget child,
    RouteSettings settings,
  ) {
    return MaterialPageRoute<void>(
      builder: (_) => child,
      settings: settings,
    );
  }
}
