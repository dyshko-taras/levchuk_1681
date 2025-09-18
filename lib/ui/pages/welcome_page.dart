// path: lib/ui/pages/welcome_page.dart
// Welcome/onboarding screen that clears first-run flag before entering the shell.
import 'package:FlutterApp/constants/app_routes.dart';
import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/providers/bottom_nav_provider.dart';
import 'package:FlutterApp/providers/welcome_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Future<void> _onGetStarted() async {
    final welcome = context.read<WelcomeProvider>();
    final success = await welcome.completeOnboarding();
    if (!mounted || !success) {
      return;
    }
    context.read<BottomNavProvider>().resetTo(0);
    if (!mounted) return;
    await Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.matches,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WelcomeProvider>();
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: Insets.allLg,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppStrings.welcomeTitle,
                  style: theme.displaySmall,
                  textAlign: TextAlign.center,
                ),
                Gaps.hSm,
                Text(
                  AppStrings.welcomeSubtitle,
                  style: theme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                if (provider.error != null) ...[
                  Gaps.hMd,
                  Text(
                    provider.error!,
                    style: theme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                Gaps.hLg,
                FilledButton(
                  onPressed: provider.isSubmitting ? null : _onGetStarted,
                  child: provider.isSubmitting
                      ? const SizedBox.square(
                          dimension: AppSizes.iconMd,
                          child: CircularProgressIndicator(
                            strokeWidth: AppSizes.strokeThick,
                          ),
                        )
                      : const Text(AppStrings.welcomeGetStarted),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
