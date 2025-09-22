// path: lib/ui/widgets/achievements/achievement_tile.dart
// Individual achievement tile component for the achievements grid.
import 'package:FlutterApp/constants/app_icons.dart';
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AchievementTile extends StatelessWidget {
  const AchievementTile({
    required this.title,
    required this.subtitle,
    required this.isEarned,
    this.onTap,
    super.key,
  });

  final String title;
  final String subtitle;
  final bool isEarned;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: Insets.allSm,
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Achievement icon
              Image.asset(
                isEarned ? AppIcons.badgeGold : AppIcons.badgeSilver,
                width: 70,
                height: 70,
              ),
              Gaps.hXs,
              // Title
              Text(
                title,
                style: theme.titleMedium?.copyWith(
                  color: isEarned ? AppColors.textWhite : AppColors.textGray,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Gaps.hXs,
              // Subtitle
              Text(
                subtitle,
                style: theme.bodySmall?.copyWith(
                  color: isEarned
                      ? AppColors.warningYellow
                      : AppColors.textGray,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
