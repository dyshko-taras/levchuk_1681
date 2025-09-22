// path: lib/ui/widgets/stats/detailed_stats.dart
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DetailedStats extends StatelessWidget {
  const DetailedStats({
    required this.total,
    required this.accuracy,
    required this.correct,
    required this.missed,
    required this.avgOdds,
    required this.predictionsPerWeek,
    super.key,
  });

  final int total;
  final double accuracy;
  final int correct;
  final int missed;
  final double avgOdds;
  final double predictionsPerWeek;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ---- перший ряд: 4 елементи ----
        Row(
          children: [
            Expanded(
              child: _MetricTile(
                label: 'Total Preds',
                value: total.toString(),
                theme: theme,
              ),
            ),
            Gaps.wSm,
            Expanded(
              child: _MetricTile(
                label: 'Accuracy',
                value: '${accuracy.toInt()}%',
                theme: theme,
              ),
            ),
            Gaps.wSm,
            Expanded(
              child: _MetricTile(
                label: 'Correct',
                value: correct.toString(),
                theme: theme,
              ),
            ),
            Gaps.wSm,
            Expanded(
              child: _MetricTile(
                label: 'Missed',
                value: missed.toString(),
                theme: theme,
              ),
            ),
          ],
        ),
        Gaps.hSm,
        Row(
          children: [
            Expanded(
              child: _MetricTileWide(
                label: 'Avg Odds Picked',
                value: avgOdds.toStringAsFixed(1),
                theme: theme,
              ),
            ),
            Gaps.wSm,
            Expanded(
              child: _MetricTileWide(
                label: 'Predictions/Week',
                value: predictionsPerWeek.toStringAsFixed(1),
                theme: theme,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Компактний тайл (для першого ряду)
class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.label,
    required this.value,
    required this.theme,
  });

  final String label;
  final String value;
  final TextTheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: Insets.allSm,
      decoration: const BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: AppRadius.cardLg,
      ),
      child: Column(
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.bodySmall?.copyWith(color: AppColors.textGray),
          ),
          const Spacer(),
          Text(
            value,
            style: theme.titleLarge?.copyWith(
              color: AppColors.textWhite,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

// Широкий тайл (на всю ширину, один в рядку)
class _MetricTileWide extends StatelessWidget {
  const _MetricTileWide({
    required this.label,
    required this.value,
    required this.theme,
  });

  final String label;
  final String value;
  final TextTheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: Insets.allSm,
      decoration: const BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: AppRadius.cardLg,
      ),
      child: Column(
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.bodySmall?.copyWith(color: AppColors.textGray),
          ),
          const Spacer(),
          Text(
            value,
            style: theme.titleLarge?.copyWith(
              color: AppColors.textWhite,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
