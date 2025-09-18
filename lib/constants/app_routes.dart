import 'package:flutter/material.dart';

class AppRoutes {
  // Shell & entry
  static const String root = '/';
  static const String splash = '/splash';
  static const String welcome = '/welcome';

  // Tabs (hosted by MainShellPage via IndexedStack)
  static const String matches = '/matches';
  static const String stats = '/stats';
  static const String favorites = '/favorites';
  static const String profile = '/profile';

  // Non-tab details & flows
  static const String predictions = '/predictions';
  static const String achievements = '/achievements';
  static const String insights = '/insights';
  static const String journal = '/journal';

  /// Route pattern for match details (PRD: /match/:id).
  static const String matchDetailsPattern = '/match/:id';

  /// Helper to build a concrete path for a given match [id].
  static String matchDetails(String id) => '/match/$id';

  /// Centralized WidgetBuilder map.
  ///
  /// NOTE: Page classes are registered in later phases to respect the
  /// “create files in exact order” rule. Using empty builders here is valid;
  /// all navigation MUST reference these names.
  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    // Will be populated in subsequent phases when pages are introduced.
    // This map exists now to ensure all modules import from a single source.
  };
}
