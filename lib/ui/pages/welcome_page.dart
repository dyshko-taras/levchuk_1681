// path: lib/ui/pages/welcome_page.dart
// Welcome/onboarding screen that clears first-run flag before entering the shell.
import 'package:FlutterApp/constants/app_images.dart';
import 'package:FlutterApp/constants/app_routes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/providers/bottom_nav_provider.dart';
import 'package:FlutterApp/providers/welcome_provider.dart';
import 'package:FlutterApp/ui/theme/app_decorations.dart';
import 'package:FlutterApp/ui/widgets/common/primary_cta_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await context.read<WelcomeProvider>().readFirstRunFlag();
    });
  }

  Future<void> _onGetStarted() async {
    final provider = context.read<WelcomeProvider>();
    final success = await provider.completeOnboarding();
    if (!mounted || !success) return;
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
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppImages.welcomeHero,
            fit: BoxFit.cover,
          ),
          const DecoratedBox(decoration: AppDecorations.heroDimOverlay),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: Insets.allXl,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Gaps.hXl,
                    Expanded(
                      child: Center(
                        child: Text(
                          AppStrings.welcomeTitle,
                          style: theme.displayLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Gaps.hXl,
                    Text(
                      AppStrings.welcomeSubtitle,
                      style: theme.bodyLarge,
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
                    Gaps.hXl,
                    PrimaryCtaButton(
                      label: AppStrings.welcomeGetStarted,
                      onPressed: _onGetStarted,
                      isLoading: provider.isSubmitting,
                      isEnabled: !provider.isSubmitting,
                    ),
                    Gaps.hXl,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
