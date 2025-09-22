import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum StatusChipVariant {
  upcoming,
  predicted,
  completedCorrect,
  completedMissed,
  completed,
}

class StatusChip extends StatelessWidget {
  const StatusChip({
    required this.variant,
    required this.label,
    super.key,
  });

  final StatusChipVariant variant;
  final String label;

  @override
  Widget build(BuildContext context) {
    final (bg, fg, icon) = switch (variant) {
      StatusChipVariant.upcoming => (
        AppColors.cardDark,
        AppColors.warningYellow,
        Icons.rocket_launch,
      ),
      StatusChipVariant.predicted => (
        AppColors.cardDark,
        AppColors.accentBlue,
        Icons.bar_chart,
      ),
      StatusChipVariant.completedCorrect => (
        AppColors.cardDark,
        AppColors.successGreen,
        Icons.check_circle_outline,
      ),
      StatusChipVariant.completedMissed => (
        AppColors.cardDark,
        AppColors.errorRed,
        Icons.cancel_outlined,
      ),
      StatusChipVariant.completed => (
        AppColors.cardDark,
        AppColors.successGreen,
        Icons.check_circle_outline,
      ),
    };

    return Container(
      height: AppSizes.chipHeight,
      padding: Insets.hMd,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppRadius.chipRadius,
        border: Border.all(
          color: fg.withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppSizes.iconSm, color: fg),
          Gaps.wSm,
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: fg,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
