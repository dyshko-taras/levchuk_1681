import 'package:FlutterApp/constants/app_images.dart';
import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:FlutterApp/ui/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';

class PredictionsEmptyState extends StatelessWidget {
  const PredictionsEmptyState({
    required this.onGoToMatches,
    super.key,
  });

  final VoidCallback onGoToMatches;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: Insets.allLg,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.emptyPredictions,
              width: AppSizes.imageLg,
              height: AppSizes.imageLg,
            ),
            Gaps.hMd,
            Text(
              AppStrings.myPredictionsEmptyTitle,
              style: theme.bodyLarge?.copyWith(
                color: AppColors.textWhite,
              ),
              textAlign: TextAlign.center,
            ),
            Gaps.hLg,
            PrimaryButton(
              label: AppStrings.myPredictionsGoToMatches,
              onPressed: onGoToMatches,
            ),
          ],
        ),
      ),
    );
  }
}
