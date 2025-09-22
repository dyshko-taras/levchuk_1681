// path: lib/ui/theme/app_colors.dart
import 'package:flutter/material.dart';

/// Design System palette & role colors (dark theme).
class AppColors {
  AppColors._();

  // Base palette
  static const Color primaryBlack = Color(0xFF000000);
  static const Color successGreen = Color(0xFF00DD70);
  static const Color warningYellow = Color(0xFFFAD749);
  static const Color errorRed = Color(0xFFFF5555);
  static const Color cardDark = Color(0xFF161616);
  static const Color borderGray = Color(0xFF323232);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textGray = Color(0xFF727272);
  static const Color accentBlue = Color(0xFF38B6FF);
  static const Color accentOrange = Color(0xFFFF8438);

  // Derived roles
  static const Color scaffoldBg = primaryBlack;
  static const Color surface = cardDark;
  static const Color onSurface = textWhite;
  static const Color onSurfaceMuted = textGray;

  static const Color onPrimary = primaryBlack;

  /// Build a dark ColorScheme binding DS tokens.
  static const ColorScheme scheme = ColorScheme(
    brightness: Brightness.dark,
    primary: successGreen,
    onPrimary: onPrimary,
    secondary: accentBlue,
    onSecondary: textWhite,
    error: errorRed,
    onError: textWhite,
    surface: surface,
    onSurface: onSurface,
    surfaceTint: successGreen,
    outline: borderGray,
    tertiary: accentOrange,
    onTertiary: textWhite,
    primaryContainer: Color(0xFF0A3F2B),
    onPrimaryContainer: textWhite,
    secondaryContainer: Color(0xFF0F2C3A),
    onSecondaryContainer: textWhite,
    tertiaryContainer: Color(0xFF40210A),
    onTertiaryContainer: textWhite,
  );
}
