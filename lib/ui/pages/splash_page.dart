// path: lib/ui/pages/splash_page.dart
// Splash page with minimum display time and bootstrap routing logic.
import 'dart:async';
import 'dart:developer';

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
      log('splash_shown', name: 'analytics');
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
    log('splash_routed:$nextRoute', name: 'analytics');
    _navigated = true;
    Navigator.of(context).pushReplacementNamed(nextRoute);
  }

  void _restartBootstrap() {
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
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Center(
          child: AnimatedSwitcher(
            duration: AppDurations.fast,
            child: bootstrap.error != null
                ? _ErrorContent(
                    message: bootstrap.error!,
                    onRetry: _restartBootstrap,
                  )
                : const _BrandContent(),
          ),
        ),
      ),
    );
  }
}

class _BrandContent extends StatelessWidget {
  const _BrandContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(),
        ),
        Gaps.hLg,
        Text(
          AppStrings.appTitle,
          style: theme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        Gaps.hSm,
        Text(
          AppStrings.splashTagline,
          style: theme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ErrorContent extends StatelessWidget {
  const _ErrorContent({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: Insets.allLg,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.splashError,
            style: theme.bodyMedium?.copyWith(color: colorScheme.error),
            textAlign: TextAlign.center,
          ),
          Gaps.hSm,
          Text(
            message,
            style: theme.bodySmall?.copyWith(color: colorScheme.error),
            textAlign: TextAlign.center,
          ),
          Gaps.hMd,
          FilledButton(
            onPressed: onRetry,
            child: const Text(AppStrings.retry),
          ),
        ],
      ),
    );
  }
}
