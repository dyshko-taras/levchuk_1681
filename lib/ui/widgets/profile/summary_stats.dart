import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SummaryStats extends StatelessWidget {
  const SummaryStats({
    required this.wins,
    required this.perfectDays,
    required this.predictions,
    super.key,
  });

  final int wins;
  final int perfectDays;
  final int predictions;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            value: wins.toString(),
            label: 'Wins',
            color: AppColors.successGreen,
          ),
        ),
        Gaps.wSm,
        Expanded(
          child: _StatCard(
            value: perfectDays.toString(),
            label: 'Perfect Day',
            color: AppColors.accentOrange,
          ),
        ),
        Gaps.wSm,
        Expanded(
          child: _StatCard(
            value: predictions.toString(),
            label: 'Predictions',
            color: AppColors.accentBlue,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.color,
  });

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    final isDarkCard = color == AppColors.cardDark;
    return Container(
      padding: Insets.allSm,
      decoration: BoxDecoration(
        color: isDarkCard ? color : color.withOpacity(0.2),
        border: isDarkCard ? null : Border.all(color: color),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: theme.headlineLarge,
          ),
          Gaps.hXs,
          Text(
            label,
            style: theme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
