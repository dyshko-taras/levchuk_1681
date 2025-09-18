// path: lib/ui/pages/splash_page.dart
// Splash page with minimum display time and bootstrap routing logic.
import 'dart:async';

import 'package:FlutterApp/constants/app_durations.dart';
import 'package:FlutterApp/constants/app_routes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/providers/app_bootstrap_provider.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;
  late AppBootstrapProvider _bootstrap;
  bool _timerElapsed = false;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _bootstrap = context.read<AppBootstrapProvider>()
      ..addListener(_maybeNavigate);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _bootstrap.ensureInitialized();
    });
    _timer = Timer(AppDurations.splashMin, () {
      _timerElapsed = true;
      _maybeNavigate();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _bootstrap.removeListener(_maybeNavigate);
    super.dispose();
  }

  void _maybeNavigate() {
    if (!mounted || _navigated) return;
    if (!_timerElapsed) return;
    if (!_bootstrap.isInitialized || _bootstrap.error != null) {
      return;
    }
    final nextRoute = _bootstrap.isFirstRun
        ? AppRoutes.welcome
        : AppRoutes.matches;
    _navigated = true;
    Navigator.of(context).pushReplacementNamed(nextRoute);
  }

  void _onRetry() {
    if (_bootstrap.isLoading) return;
    _timerElapsed = false;
    _timer?.cancel();
    _timer = Timer(AppDurations.splashMin, () {
      _timerElapsed = true;
      _maybeNavigate();
    });
    _bootstrap.reload();
  }

  @override
  Widget build(BuildContext context) {
    final bootstrap = context.watch<AppBootstrapProvider>();
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
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
                  textAlign: TextAlign.center,
                ),
                Gaps.hSm,
                if (bootstrap.error != null) ...[
                  Text(
                    AppStrings.splashError,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gaps.hSm,
                  Text(
                    bootstrap.error!,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gaps.hMd,
                  FilledButton(
                    onPressed: _onRetry,
                    child: const Text(AppStrings.retry),
                  ),
                ] else ...[
                  if (bootstrap.isLoading)
                    const CircularProgressIndicator()
                  else
                    Text(
                      AppStrings.loading,
                      style: textTheme.bodyMedium,
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
