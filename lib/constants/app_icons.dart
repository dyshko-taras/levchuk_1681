// path: lib/constants/app_icons.dart
/// SVG icon path accessors (single source of truth).
/// Widgets must use AppIcons.* (no raw 'assets/...' strings).
/// Inventory based on assets_list.md. :contentReference[oaicite:1]{index=1} :contentReference[oaicite:2]{index=2}
class AppIcons {
  AppIcons._();

  // Navigation
  static const String navMatches = 'assets/icons/nav_matches.svg';
  static const String navStats = 'assets/icons/nav_stats.svg';
  static const String navFavorites = 'assets/icons/nav_favorites.svg';
  static const String navProfile = 'assets/icons/nav_profile.svg';

  // Actions
  static const String actionSearch = 'assets/icons/action_search.svg';
  static const String actionFilter = 'assets/icons/action_filter.svg';
  static const String actionCalendar = 'assets/icons/action_calendar.svg';
  static const String actionRefresh = 'assets/icons/action_refresh.svg';
  static const String actionSettings = 'assets/icons/action_settings.svg';
  static const String actionEdit = 'assets/icons/action_edit.svg';
  static const String actionSave = 'assets/icons/action_save.svg';
  static const String actionBack = 'assets/icons/action_back.svg';
  static const String actionClose = 'assets/icons/action_close.svg';

  // Favorites & domain
  static const String star = 'assets/icons/star.svg';
  static const String starFilled = 'assets/icons/star_filled.svg';
  static const String leagueBall = 'assets/icons/league_ball.svg';
  static const String team = 'assets/icons/team.svg';
  static const String match = 'assets/icons/match.svg';

  // Charts helpers
  static const String chartDonut = 'assets/icons/chart_donut.svg';
  static const String chartBar = 'assets/icons/chart_bar.svg';
  static const String chartLine = 'assets/icons/chart_line.svg';
}
