// path: lib/ui/widgets/insights/focus_point_card.dart
// Focus point card component for Strengths and Weaknesses sections.
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/providers/insights_provider.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FocusPointCard extends StatelessWidget {
  const FocusPointCard({
    required this.title,
    required this.items,
    required this.isStrengths,
    super.key,
  });

  final String title;
  final List<InsightEntry> items;
  final bool isStrengths;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final cardColor = isStrengths ? AppColors.successGreen : AppColors.errorRed;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: cardColor.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: Insets.allMd,
            decoration: BoxDecoration(
              color: cardColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppRadius.lg),
                topRight: Radius.circular(AppRadius.lg),
              ),
            ),
            child: Text(
              title,
              style: theme.titleMedium?.copyWith(
                color: AppColors.textWhite,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Items
          Padding(
            padding: Insets.allMd,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Row(
                        children: [
                          Text(
                            '${item.label}: ',
                            style: theme.bodyMedium?.copyWith(
                              color: AppColors.textWhite,
                            ),
                          ),
                          Text(
                            item.value,
                            style: theme.bodyMedium?.copyWith(
                              color: cardColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
