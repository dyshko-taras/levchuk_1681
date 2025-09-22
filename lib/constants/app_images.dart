// path: lib/constants/app_images.dart
/// Raster images & backgrounds path accessors (single source of truth).
/// Widgets must use AppImages.* (no raw 'assets/...' strings).
/// Inventory based on assets_list.md. :contentReference[oaicite:3]{index=3}
class AppImages {
  AppImages._();

  // Brand & common
  static const String welcomeHero = 'assets/images/welcome_hero.jpg';

  // Empty states / placeholders
  static const String emptyFavoritesStar =
      'assets/images/empty_favorites_star.webp';
  static const String emptyPredictions = 'assets/images/empty_predictions.webp';

  // Profile avatars
  static String avatar(int index) => 'assets/images/avatar_$index.webp';
  static const String avatar01 = 'assets/images/avatar_1.webp';
  static const String avatar02 = 'assets/images/avatar_2.webp';
  static const String avatar03 = 'assets/images/avatar_3.webp';
  static const String avatar04 = 'assets/images/avatar_4.webp';
  static const String avatar05 = 'assets/images/avatar_5.webp';
  static const String avatar06 = 'assets/images/avatar_6.webp';

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
