// path: lib/ui/pages/splash_page.dart
// Splash page with minimum display time and manual bypass button.
import 'dart:async';

import 'package:FlutterApp/constants/app_durations.dart';
import 'package:FlutterApp/constants/app_routes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Auto-transition after the minimum splash duration.
    _timer = Timer(AppDurations.splashMin, _goNext);
  }

  void _goNext() {
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(AppRoutes.shell);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: Insets.allLg,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.appTitle,
                  style: textTheme.headlineSmall,
                ),
                Gaps.hSm,
                FilledButton(
                  onPressed: _goNext, // Manual bypass for testing
                  child: const Text(AppStrings.splashEnter),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
