// path: lib/ui/pages/my_predictions_page.dart
// Placeholder predictions list page for navigation scaffolding.
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:flutter/material.dart';

class MyPredictionsPage extends StatelessWidget {
  const MyPredictionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.myPredictionsTitle)),
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
