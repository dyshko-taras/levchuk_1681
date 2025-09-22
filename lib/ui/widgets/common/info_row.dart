// path: lib/ui/widgets/common/info_row.dart
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

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
          border: Border.all(color: AppColors.borderGray),
        ),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              Gaps.wSm,
            ],
            // Label — take remaining space, ellipsize if long
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: labelStyle,
              ),
            ),
            Gaps.wSm,
            // Value — keep in bounds, right-aligned, ellipsize if long
            Flexible(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  textAlign: TextAlign.right,
                  style: valueStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
