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

  // Splash
  static const String splashEnter = 'Enter';

  // Matches Today
  static const String matchesTodayTitle = 'Matches';
  static const String matchesEmpty = 'No matches found for today.';
  static const String matchesLoadHint =
      'Tap to load today’s fixtures.\n(Requires API key & codegen)';
  static const String matchesErrorTitle = 'Couldn’t load matches';
  static const String matchesPullToRefresh = 'Pull to refresh';
}
