// path: lib/ui/pages/insights_page.dart
// Placeholder insights page for navigation scaffolding.
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:flutter/material.dart';

class InsightsPage extends StatelessWidget {
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.insightsTitle)),
      body: Center(
        child: Padding(
          padding: Insets.allLg,
          child: Text(
            AppStrings.comingSoon,
            style: theme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
