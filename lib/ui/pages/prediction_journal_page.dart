// path: lib/ui/pages/prediction_journal_page.dart
// Placeholder prediction journal page for navigation scaffolding.
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:flutter/material.dart';

class PredictionJournalPage extends StatelessWidget {
  const PredictionJournalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.journalTitle)),
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
