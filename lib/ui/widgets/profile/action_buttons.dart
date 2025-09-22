import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:FlutterApp/ui/widgets/buttons/primary_button.dart';
import 'package:FlutterApp/ui/widgets/buttons/translucent_tinted_button.dart';
import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    required this.onViewStatistics,
    required this.onViewPredictions,
    required this.onViewFavorites,
    required this.onOpenJournal,
    required this.onOpenInsights,
    required this.onResetStats,
    super.key,
  });

  final VoidCallback onViewStatistics;
  final VoidCallback onViewPredictions;
  final VoidCallback onViewFavorites;
  final VoidCallback onOpenJournal;
  final VoidCallback onOpenInsights;
  final VoidCallback onResetStats;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TranslucentTintedButton(
          label: AppStrings.profileViewStatistics,
          color: AppColors.successGreen,
          onPressed: onViewStatistics,
        ),
        Gaps.hSm,
        TranslucentTintedButton(
          label: AppStrings.profileViewMyPredictions,
          color: AppColors.accentBlue,
          onPressed: onViewPredictions,
        ),
        Gaps.hSm,
        TranslucentTintedButton(
          label: AppStrings.profileViewFavorites,
          color: AppColors.warningYellow,
          onPressed: onViewFavorites,
        ),
        Gaps.hSm,
        TranslucentTintedButton(
          label: AppStrings.profileOpenJournal,
          color: AppColors.errorRed,
          onPressed: onOpenJournal,
        ),
        Gaps.hSm,
        TranslucentTintedButton(
          label: AppStrings.profileOpenInsights,
          color: AppColors.accentBlue,
          onPressed: onOpenInsights,
        ),
        Gaps.hLg,
        PrimaryButton(
          label: AppStrings.profileResetStats,
          onPressed: onResetStats,
        ),
      ],
    );
  }
}
