// path: lib/ui/theme/app_theme.dart
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:FlutterApp/ui/theme/app_fonts.dart';
import 'package:flutter/material.dart';

/// Centralized Material 3 dark theme built from tokens.
@immutable
final class AppTheme {
  const AppTheme._();

  static ThemeData dark() {
    const scheme = ColorScheme.dark(
      primary: AppColors.successGreen,
      secondary: AppColors.accentBlue,
      error: AppColors.errorRed,
      surface: AppColors.primaryBlack,
      outline: AppColors.borderGray,
      surfaceContainerHighest: AppColors.cardDark,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.primaryBlack,
      cardTheme: const CardThemeData(
        color: AppColors.cardDark,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.cardLg),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.borderGray),
      textTheme: AppFonts.textTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryBlack,
        foregroundColor: AppColors.textWhite,
        elevation: 0,
        centerTitle: false,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all<Size>(const Size(64, 44)),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) => states.contains(WidgetState.disabled)
                ? AppColors.borderGray
                : AppColors.successGreen,
          ),
          foregroundColor: WidgetStateProperty.all<Color>(
            AppColors.primaryBlack,
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(borderRadius: AppRadius.btnLg),
          ),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardDark,
        border: OutlineInputBorder(
          borderRadius: AppRadius.cardLg,
          borderSide: BorderSide(color: AppColors.borderGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.cardLg,
          borderSide: BorderSide(color: AppColors.borderGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.cardLg,
          borderSide: BorderSide(color: AppColors.successGreen, width: 1.5),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.cardDark,
        contentTextStyle: TextStyle(color: AppColors.textWhite),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.cardLg),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.successGreen,
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: AppColors.textGray,
        textColor: AppColors.textWhite,
      ),
      iconTheme: const IconThemeData(color: AppColors.textGray),
      tabBarTheme: const TabBarThemeData(
        labelColor: AppColors.textWhite,
        unselectedLabelColor: AppColors.textGray,
        indicatorColor: AppColors.successGreen,
      ),
      dialogTheme: const DialogThemeData(backgroundColor: AppColors.cardDark),
    );
  }
}
