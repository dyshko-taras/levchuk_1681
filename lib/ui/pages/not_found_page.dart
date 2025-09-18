// path: lib/ui/pages/not_found_page.dart
// Simple not-found screen used by the router fallback.
import 'package:FlutterApp/constants/app_routes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key, this.message = AppStrings.notFoundTitle});

  final String message;

  @override
  Widget build(BuildContext context) {
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
                  message,
                  style: theme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                Gaps.hMd,
                FilledButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.matches,
                      (route) => false,
                    );
                  },
                  child: const Text(AppStrings.backToMatches),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
