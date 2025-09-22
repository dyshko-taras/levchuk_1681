// path: lib/ui/widgets/insights/advice_row.dart
// Advice row component for the advice list.
import 'package:FlutterApp/constants/app_icons.dart';
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdviceRow extends StatelessWidget {
  const AdviceRow({
    required this.text,
    super.key,
  });

  final String text;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bulb icon
          SvgPicture.asset(
            AppIcons.bulb,
            width: AppSizes.iconSm,
            height: AppSizes.iconSm,
            colorFilter: const ColorFilter.mode(
              AppColors.warningYellow,
              BlendMode.srcIn,
            ),
          ),
          Gaps.wSm,
          // Advice text
          Expanded(
            child: Text(
              text,
              style: theme.bodyMedium?.copyWith(
                color: AppColors.textWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
