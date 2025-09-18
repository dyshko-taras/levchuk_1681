// path: lib/constants/app_routes.dart
// Centralized route names and builders. Tab routes map to MainShellPage with the correct index.
import 'package:flutter/material.dart';
import '../ui/pages/main_shell_page.dart';
import '../ui/pages/match_details_page.dart';
import '../ui/pages/splash_page.dart';

final class AppRoutes {
  const AppRoutes._();

  static const String splash = '/splash';
  static const String shell = '/';
  static const String matches = '/matches';
  static const String stats = '/stats';
  static const String favorites = '/favorites';
  static const String profile = '/profile';
  static const String matchDetails = '/match';

  static Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
    splash: (_) => const SplashPage(),
    shell: (_) => const MainShellPage(),
    matches: (_) => const MainShellPage(initialIndex: 0),
    stats: (_) => const MainShellPage(initialIndex: 1),
    favorites: (_) => const MainShellPage(initialIndex: 2),
    profile: (_) => const MainShellPage(initialIndex: 3),
    matchDetails: (_) => const MatchDetailsPage(),
  };

  static String get initialRoute => splash;
}
