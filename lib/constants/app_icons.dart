// path: lib/constants/app_icons.dart
/// SVG icon path accessors (single source of truth).
/// Widgets must use AppIcons.* (no raw 'assets/...' strings).
abstract final class AppIcons {
  AppIcons._();

  // Navigation
  static const String navMatches = 'assets/icons/nav_matches.svg';
  static const String navStats = 'assets/icons/nav_stats.svg';
  static const String navFavorites = 'assets/icons/nav_favorites.svg';
  static const String navProfile = 'assets/icons/nav_profile.svg';

  // Actions
  static const String actionFilter = 'assets/icons/action_filter.svg';
  static const String actionTrendingUp = 'assets/icons/action_trending_up.svg';
  static const String actionOpenInNew = 'assets/icons/action_open_in_new.svg';
  static const String actionBall = 'assets/icons/action_ball.svg';
  static const String actionCalendar = 'assets/icons/action_calendar.svg';
  static const String actionBack = 'assets/icons/action_back.svg';

  static const String star = 'assets/icons/star.svg';
  static const String starFilled = 'assets/icons/star_filled.svg';
  static const String league = 'assets/icons/league.svg';
  static const String bulb = 'assets/icons/bulb.svg';

  // Achievements
  static const String badgeGoldSummary = 'assets/icons/badge_gold_summary.svg';
  static const String milestoneTargetSummary =
      'assets/icons/milestone_target.svg';
  static const String badgeGold = 'assets/icons/badge_gold.webp';
  static const String badgeSilver = 'assets/icons/badge_silver.webp';
}
