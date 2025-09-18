// path: lib/constants/app_strings.dart
// Centralized app strings (no hardcoded UI text elsewhere).
import 'package:flutter/foundation.dart';

@immutable
final class AppStrings {
  const AppStrings._();

  // Common
  static const String appTitle = 'Football Predictor';
  static const String retry = 'Retry';
  static const String loading = 'Loading...';
  static const String comingSoon = 'Coming soon';
  static const String notFoundTitle = 'Page not found';
  static const String backToMatches = 'Back to Matches';

  // Splash
  static const String splashEnter = 'Enter';
  static const String splashError = 'Unable to initialise the app.';

  // Welcome
  static const String welcomeTitle = 'Welcome!';
  static const String welcomeSubtitle =
      'Stay on top of fixtures, predictions, and insights.';
  static const String welcomeGetStarted = 'Get Started';

  // Navigation tabs
  static const String matchesTodayTitle = 'Matches';
  static const String statisticsTabTitle = 'Statistics';
  static const String favoritesTabTitle = 'Favorites';
  static const String profileTabTitle = 'Profile';

  // Feature titles
  static const String myPredictionsTitle = 'My Predictions';
  static const String achievementsTitle = 'Achievements';
  static const String insightsTitle = 'Insights';
  static const String journalTitle = 'Prediction Journal';
  static const String matchDetailsTitle = 'Match Details';

  // Matches Today
  static const String matchesEmpty = 'No matches found for today.';
  static const String matchesLoadHint =
      'Tap to load today\'s fixtures.\n(Requires API key & codegen)';
  static const String matchesErrorTitle = 'Couldn\'t load matches';
  static const String matchesPullToRefresh = 'Pull to refresh';
}
