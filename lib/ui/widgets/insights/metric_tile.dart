// path: lib/ui/widgets/insights/metric_tile.dart
// Metric tile component for the Your Trends section.
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MetricTile extends StatelessWidget {
  const MetricTile({
    required this.title,
    required this.value,
    super.key,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      padding: Insets.allSm,
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title
          Text(
            title,
            style: theme.bodySmall?.copyWith(
              color: AppColors.textGray,
            ),
            textAlign: TextAlign.center,
          ),
          Gaps.hXs,
          // Value
          Text(
            value,
            style: theme.titleMedium?.copyWith(
              color: AppColors.textWhite,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
