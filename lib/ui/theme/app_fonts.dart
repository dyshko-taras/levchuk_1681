// path: lib/ui/theme/app_fonts.dart
import 'package:flutter/material.dart';

/// Inter typography roles and Material TextTheme mapping.
/// DS: Inter weights 400–900; role sizes Hero→Micro per visual_style.md.
/// :contentReference[oaicite:9]{index=9} :contentReference[oaicite:10]{index=10}
class AppFonts {
  AppFonts._();

  static const String family =
      'Inter'; // registered in Phase 3 (fonts) per plan.

  // Role styles (sizes from DS; weights mapped as comments)
  static const TextStyle hero = TextStyle(
    fontFamily: family,
    fontSize: 27,
    fontWeight: FontWeight.w900,
  ); // Black 900
  static const TextStyle title = TextStyle(
    fontFamily: family,
    fontSize: 18,
    fontWeight: FontWeight.w800,
  ); // ExtraBold 800
  static const TextStyle heading = TextStyle(
    fontFamily: family,
    fontSize: 16.5,
    fontWeight: FontWeight.w700,
  ); // Bold 700
  static const TextStyle subheading = TextStyle(
    fontFamily: family,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  ); // SemiBold 600
  static const TextStyle body = TextStyle(
    fontFamily: family,
    fontSize: 13.5,
    fontWeight: FontWeight.w400,
  ); // Regular 400
  static const TextStyle caption = TextStyle(
    fontFamily: family,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  ); // Medium 500
  static const TextStyle small = TextStyle(
    fontFamily: family,
    fontSize: 10.5,
    fontWeight: FontWeight.w500,
  ); // Medium 500
  static const TextStyle micro = TextStyle(
    fontFamily: family,
    fontSize: 9,
    fontWeight: FontWeight.w500,
  ); // Medium 500

  /// Map DS roles to Material 3 `TextTheme` slots.
  static TextTheme buildTextTheme(Color color, {Color? muted}) {
    final on = color;
    final dim = muted ?? color.withOpacity(0.8);
    return TextTheme(
      displaySmall: hero.copyWith(color: on),
      titleLarge: title.copyWith(color: on),
      titleMedium: heading.copyWith(color: on),
      titleSmall: subheading.copyWith(color: on),
      bodyLarge: body.copyWith(color: on),
      bodyMedium: body.copyWith(color: on),
      bodySmall: caption.copyWith(color: dim),
      labelLarge: subheading.copyWith(color: on),
      labelMedium: small.copyWith(color: dim),
      labelSmall: micro.copyWith(color: dim),
    );
  }
}
