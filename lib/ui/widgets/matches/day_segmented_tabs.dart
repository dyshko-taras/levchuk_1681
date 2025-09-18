import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DaySegmentedTabs extends StatelessWidget {
  const DaySegmentedTabs({
    required this.index, // 0: Yesterday, 1: Today, 2: Tomorrow
    required this.onChanged,
    this.labels = const ['Yesterday', 'Today', 'Tomorrow'],
    super.key,
  });

  final int index;
  final ValueChanged<int> onChanged;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: Insets.allXs,
      decoration: const BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: AppRadius.cardLg,
      ),
      child: Row(
        children: [
          for (var i = 0; i < labels.length; i++) ...[
            Expanded(
              child: InkWell(
                borderRadius: AppRadius.cardLg,
                onTap: () => onChanged(i),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: ShapeDecoration(
                    color: i == index
                        ? AppColors.warningYellow
                        : AppColors.primaryBlack,
                    shape: const StadiumBorder(),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    labels[i],
                    style: theme.textTheme.labelMedium!.copyWith(
                      color: i == index
                          ? AppColors.primaryBlack
                          : theme.textTheme.labelMedium!.color,
                    ),
                  ),
                ),
              ),
            ),
            if (i != labels.length - 1) Gaps.wSm,
          ],
        ],
      ),
    );
  }
}
