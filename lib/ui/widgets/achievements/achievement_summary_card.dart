// path: lib/ui/widgets/achievements/achievement_summary_card.dart
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AchievementSummaryCard extends StatelessWidget {
  const AchievementSummaryCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.subtitle,
    super.key,
  });

  final String icon;
  final String value;
  final String label;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      padding: Insets.allMd,
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Row(
        children: [
          // Icon
          SvgPicture.asset(
            icon,
            width: AppSizes.iconXl,
            height: AppSizes.iconXl,
          ),
          Gaps.wMd,
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Value
                Text(
                  value,
                  style: theme.displaySmall?.copyWith(
                    color: AppColors.textWhite,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Gaps.hXs,
                // Label
                Text(
                  label,
                  style: theme.titleMedium?.copyWith(
                    color: AppColors.textWhite,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gaps.hXs,
                // Subtitle
                Text(
                  subtitle,
                  style: theme.bodyMedium?.copyWith(
                    color: AppColors.textGray,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
