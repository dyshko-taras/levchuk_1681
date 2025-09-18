// path: lib/ui/theme/app_theme.dart
import 'package:FlutterApp/constants/constants.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:FlutterApp/ui/theme/app_fonts.dart';
import 'package:flutter/material.dart';

/// Single Material 3 dark theme wired to DS tokens (colors & typography).
/// Implementation Plan requires Material 3 with dark mode and component themes.
/// :contentReference[oaicite:11]{index=11}
final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: AppColors.scheme,
  scaffoldBackgroundColor: AppColors.scaffoldBg,
  canvasColor: AppColors.surface,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: AppFonts.buildTextTheme(
    AppColors.textWhite,
    muted: AppColors.textGray,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: AppColors.primaryBlack,
    foregroundColor: AppColors.textWhite,
    centerTitle: true,
  ),
  cardTheme: const CardThemeData(
    color: AppColors.cardDark,
    elevation: 2,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)), // DS: cards 15px
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: AppColors.borderGray,
    thickness: 1,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.successGreen, // DS primary button
      foregroundColor: AppColors.onPrimary, // black text on green
      minimumSize: const Size.fromHeight(AppSizes.buttonHeightMd),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)), // DS: buttons 6px
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: AppColors.borderGray),
      foregroundColor: AppColors.textWhite,
      minimumSize: const Size.fromHeight(AppSizes.buttonHeightSm),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: AppColors.cardDark,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.borderGray),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.successGreen),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
    hintStyle: TextStyle(color: AppColors.textGray),
  ),
  iconTheme: const IconThemeData(
    color: AppColors.textWhite,
    size: AppSizes.iconMd,
  ),
);
