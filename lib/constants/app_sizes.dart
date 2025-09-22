import 'package:FlutterApp/constants/app_spacing.dart';

/// Sizing tokens for controls, icons, and layout primitives.
/// All UI code must consume these constants instead of inline numbers.
abstract final class AppSizes {
  AppSizes._();

  // Icon sizes
  static const double iconXs = 14;
  static const double iconSm = 18;
  static const double iconMd = 24;
  static const double iconLg = 32;
  static const double iconXl = 40;
  static const double navIcon = iconMd;

  // Tap targets / controls
  static const double minTap = 44;
  static const double touchMin44 = 44;

  // Buttons & CTAs
  static const double buttonHeightSm = 36;
  static const double buttonHeightMd = 44;
  static const double buttonHeightLg = 52;
  static const double ctaHeight = buttonHeightMd;

  // Segmented tabs
  static const double segmentedTabSm = 36;
  static const double segmentedTabMd = 44;
  static const double segmentedTabLg = 52;

  // Chips & pills
  static const double chipHeight = 32;

  // App bars & navigation
  static const double appBarHeight = 56;
  static const double navBarHeight = 64;
  static const double navBarElevation = 2;

  // Cards / list items
  static const double listItemHeight = 56;
  static const double teamBadge = 40;

  //Image
  static const double imageLg = 80;

  // Avatars / badges
  static const double avatarSm = 24;
  static const double avatarMd = 32;
  static const double avatarLg = 100;

  // Stroke widths
  static const double strokeThin = 1;
  static const double strokeThick = 2;

  // Misc
  static const double segmentedTabHeaderHeight = 60;
}

/// Semantic padding buckets for MatchCard densities.
abstract final class AppCardPadding {
  AppCardPadding._();

  static const double compact = AppSpacing.sm;
  static const double regular = AppSpacing.md;
  static const double expanded = AppSpacing.lg;
}
