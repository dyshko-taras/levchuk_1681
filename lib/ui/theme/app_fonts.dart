// path: lib/ui/theme/app_fonts.dart
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Inter font family setup & role-based text styles.
/// Sizes per Visual Style; weights per usage guidance.
@immutable
final class AppFonts {
  const AppFonts._();

  static const String family = 'Inter';

  // Role sizes (dp)
  static const double hero = 35;
  static const double title = 18;
  static const double heading = 16.5;
  static const double subheading = 15;
  static const double body = 13.5;
  static const double caption = 12;
  static const double small = 10.5;
  static const double micro = 9;

  // Role styles (weights mapped to typical usage)
  static TextStyle _base(double size, FontWeight weight) => TextStyle(
    fontFamily: family,
    fontSize: size,
    fontWeight: weight,
    height: 1.25,
    color: AppColors.textWhite,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static TextStyle heroBold() => _base(hero, FontWeight.w800);
  static TextStyle titleBold() => _base(title, FontWeight.w700);
  static TextStyle headingSemi() => _base(heading, FontWeight.w600);
  static TextStyle subheadingMedium() => _base(subheading, FontWeight.w500);
  static TextStyle bodyRegular() => _base(body, FontWeight.w400);
  static TextStyle captionRegular() => _base(caption, FontWeight.w400);
  static TextStyle smallMedium() => _base(small, FontWeight.w500);
  static TextStyle microMedium() => _base(micro, FontWeight.w500);

  /// Builds a Material TextTheme mapping roles → M3 slots.
  static TextTheme textTheme() {
    return TextTheme(
      displayLarge: heroBold(), // prominent hero/metrics
      headlineSmall: titleBold(),
      titleMedium: headingSemi(),
      titleSmall: subheadingMedium(),
      bodyMedium: bodyRegular(),
      bodySmall: captionRegular(),
      labelMedium: smallMedium(),
      labelSmall: microMedium(),
    ).apply(
      bodyColor: AppColors.textWhite,
      displayColor: AppColors.textWhite,
    );
  }
}
