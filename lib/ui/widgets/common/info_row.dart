// path: lib/ui/widgets/common/info_row.dart
// Single-line information display for key-value pairs on Match Details screen.
import 'package:flutter/material.dart';

import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    required this.label,
    required this.value,
    super.key,
    this.leading,
  });

  final String label;
  final String value;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelStyle = theme.textTheme.labelLarge?.copyWith(
      color: AppColors.textGray,
      fontWeight: FontWeight.w600,
    );
    final valueStyle = theme.textTheme.titleSmall?.copyWith(
      color: AppColors.textWhite,
      fontWeight: FontWeight.w700,
    );

    return Semantics(
      label: label,
      value: value,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: AppRadius.cardLg,
          border: Border.all(
            color: AppColors.borderGray,
            width: AppSizes.strokeThin,
          ),
        ),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              Gaps.wSm,
            ],
            Expanded(
              child: Text(
                label,
                style: labelStyle,
              ),
            ),
            Text(
              value,
              style: valueStyle,
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
