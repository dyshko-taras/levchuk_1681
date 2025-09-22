import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum CounterAccent { blue, yellow, green }

/// Counter card used in schedule stats (Predicted / Upcoming / Completed).
class CounterCard extends StatelessWidget {
  const CounterCard({
    required this.label,
    required this.value,
    this.accent = CounterAccent.green,
    this.onTap,
    super.key,
  });

  final String label;
  final int value;
  final CounterAccent accent;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = switch (accent) {
      CounterAccent.blue => AppColors.accentBlue,
      CounterAccent.green => AppColors.successGreen,
      CounterAccent.yellow => AppColors.warningYellow,
    };

    final card = Container(
      padding: Insets.allSm,
      decoration: const BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: AppRadius.cardLg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value.toString(),
            style: theme.textTheme.displaySmall?.copyWith(
              color: accentColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          Gaps.hSm,
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textWhite,
            ),
          ),
        ],
      ),
    );

    if (onTap == null) {
      return card;
    }

    return Semantics(
      button: true,
      label: label,
      value: value.toString(),
      child: InkWell(
        borderRadius: AppRadius.cardLg,
        onTap: onTap,
        child: card,
      ),
    );
  }
}
