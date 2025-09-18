class AppSizes {
  AppSizes._();

  // Icon sizes
  static const double iconXs = 14;
  static const double iconSm = 18;
  static const double iconMd = 24; // Material default
  static const double iconLg = 32;
  static const double iconXl = 40;

  // Hit target / controls
  static const double minTap = 44; // iOS/Material recommended min tap area

  // Buttons
  static const double buttonHeightSm = 36;
  static const double buttonHeightMd = 44;
  static const double buttonHeightLg = 52;

  // AppBar / top bars
  static const double appBarHeight = 56;

  // Cards / list rows
  static const double listItemHeight = 56;

  // Avatars / badges
  static const double avatarSm = 24;
  static const double avatarMd = 32;
  static const double avatarLg = 48;

  // Strokes / borders
  static const double strokeThin = 1;
  static const double strokeThick = 2;

  // Elevation steps (kept here to avoid hardcoding if using Material3 shadows elsewhere)
  static const double elevationLow = 1;
  static const double elevationMd = 3;
  static const double elevationHigh = 6;
}
