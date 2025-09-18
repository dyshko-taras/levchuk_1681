// path: lib/ui/widgets/matches/stat_badge.dart
// Compact KPI card showing a number and a label (Predicted / Upcoming / Completed).
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class StatBadge extends StatelessWidget {
  const StatBadge({
    required this.value,
    required this.label,
    super.key,
    this.tint,
  });

  final int value;
  final String label;
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: Insets.allMd,
      decoration: const BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: AppRadius.cardLg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value.toString(),
            style: theme.textTheme.displaySmall!.copyWith(
              // Big number; keep DS contrast. If tint provided, use it.
              color: tint ?? theme.textTheme.displaySmall!.color,
            ),
          ),
          Gaps.hSm,
          Text(label, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
