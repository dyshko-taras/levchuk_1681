// path: lib/constants/app_images.dart
/// Raster images & backgrounds path accessors (single source of truth).
/// Widgets must use AppImages.* (no raw 'assets/...' strings).
/// Inventory based on assets_list.md. :contentReference[oaicite:3]{index=3}
class AppImages {
  AppImages._();

  // Brand & common
  static const String welcomeHero = 'assets/images/welcome_hero.jpg';

  // Empty states / placeholders
  static const String emptyMatches = 'assets/images/empty_matches.jpg';
  static const String emptyFavoritesStar =
      'assets/images/empty_favorites_star.webp';
  static const String emptyPredictions = 'assets/images/empty_predictions.webp';
  static const String emptyStats = 'assets/images/empty_stats.webp';
  static const String emptyJournal = 'assets/images/empty_journal.webp';

  // Profile avatars
  static const String avatar01 = 'assets/images/avatars/avatar_01.png';
  static const String avatar02 = 'assets/images/avatars/avatar_02.png';
  static const String avatar03 = 'assets/images/avatars/avatar_03.png';
  static const String avatar04 = 'assets/images/avatars/avatar_04.png';
  static const String avatar05 = 'assets/images/avatars/avatar_05.png';
  static const String avatar06 = 'assets/images/avatars/avatar_06.png';

  /// Helper list requested by PRD for avatar picker bindings.
  /// Usage example (PRD binding sketch): `profileAvatars6` as a data source. :contentReference[oaicite:4]{index=4}
  static const List<String> profileAvatars6 = <String>[
    avatar01,
    avatar02,
    avatar03,
    avatar04,
    avatar05,
    avatar06,
  ];
}
