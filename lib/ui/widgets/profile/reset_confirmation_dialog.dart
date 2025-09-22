import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:FlutterApp/ui/widgets/buttons/danger_red_button.dart';
import 'package:FlutterApp/ui/widgets/buttons/translucent_tinted_button.dart';
import 'package:flutter/material.dart';

class ResetConfirmationDialog extends StatelessWidget {
  const ResetConfirmationDialog({
    required this.onStatsOnly,
    required this.onAllData,
    required this.onCancel,
    super.key,
  });

  final VoidCallback onStatsOnly;
  final VoidCallback onAllData;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Dialog(
      backgroundColor: AppColors.primaryBlack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: AppColors.borderGray,
        ),
      ),
      child: Padding(
        padding: Insets.allLg,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: onCancel,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.borderGray.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.close,
                      size: AppSizes.iconSm,
                      color: AppColors.textWhite,
                    ),
                  ),
                ),
              ],
            ),

            Gaps.hMd,

            // Message
            Text(
              AppStrings.profileResetConfirmMessage,
              style: theme.bodyLarge?.copyWith(
                color: AppColors.textWhite,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),

            Gaps.hLg,

            // Buttons
            Row(
              children: [
                Expanded(
                  child: TranslucentTintedButton(
                    label: AppStrings.profileResetStatsOnly,
                    onPressed: onStatsOnly,
                    color: AppColors.errorRed,
                  ),
                ),

                Gaps.wSm,

                Expanded(
                  child: DangerRedButton(
                    label: AppStrings.profileResetAllData,
                    onPressed: onAllData,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
