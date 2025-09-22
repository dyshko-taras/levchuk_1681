import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AchievementChip extends StatelessWidget {
  const AchievementChip({
    required this.value,
    required this.label,
    super.key,
  });

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      padding: Insets.allSm,
      decoration: BoxDecoration(
        color: AppColors.accentOrange.withOpacity(0.12),
        border: Border.all(color: AppColors.accentOrange),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value.toString(),
            style: theme.titleLarge?.copyWith(
              color: AppColors.textWhite,
              fontWeight: FontWeight.w900,
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
