// path: lib/ui/widgets/journal/journal_summary_grid.dart
// Daily summary grid component for prediction journal.
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/providers/prediction_journal_provider.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class JournalSummaryGrid extends StatelessWidget {
  const JournalSummaryGrid({
    required this.summary,
    super.key,
  });

  final JournalSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daily summary',
          style: theme.titleLarge?.copyWith(
            color: AppColors.textWhite,
            fontWeight: FontWeight.w600,
          ),
        ),
        Gaps.hMd,
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
          childAspectRatio: 1.5,
          children: [
            _SummaryCard(
              label: 'Total',
              value: summary.total.toString(),
            ),
            _SummaryCard(
              label: 'Correct',
              value: summary.correct.toString(),
            ),
            _SummaryCard(
              label: 'Missed',
              value: summary.missed.toString(),
            ),
            _SummaryCard(
              label: 'Avg odds',
              value: summary.averageOdds.toStringAsFixed(2),
            ),
          ],
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      padding: Insets.allMd,
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: theme.titleLarge?.copyWith(
              color: AppColors.textWhite,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gaps.hXs,
          Text(
            label,
            style: theme.bodySmall?.copyWith(
              color: AppColors.textGray,
            ),
          ),
        ],
      ),
    );
  }
}
