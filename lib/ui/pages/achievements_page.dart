// path: lib/ui/pages/achievements_page.dart
// Placeholder achievements page until dedicated implementation.
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:flutter/material.dart';

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.achievementsTitle)),
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
