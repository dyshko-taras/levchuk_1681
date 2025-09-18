// path: lib/ui/widgets/common/segmented_tabs.dart
// Enhancement: optional semanticsPrefix for better accessibility.
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Minimal segmented control (index-based).
class SegmentedTabs extends StatelessWidget {
  const SegmentedTabs({
    required this.segments,
    required this.currentIndex,
    required this.onChanged,
    super.key,
    this.semanticsPrefix,
  });

  final List<String> segments;
  final int currentIndex;
  final ValueChanged<int> onChanged;
  final String? semanticsPrefix;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: const BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: AppRadius.cardLg,
      ),
      child: Row(
        children: [
          for (var i = 0; i < segments.length; i++) ...[
            Expanded(
              child: _Segment(
                text: segments[i],
                selected: i == currentIndex,
                onTap: () => onChanged(i),
                semanticsLabel: semanticsPrefix == null
                    ? segments[i]
                    : '$semanticsPrefix: ${segments[i]}',
              ),
            ),
            if (i != segments.length - 1) Gaps.wSm,
          ],
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.text,
    required this.selected,
    required this.onTap,
    required this.semanticsLabel,
  });

  final String text;
  final bool selected;
  final VoidCallback onTap;
  final String semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      button: true,
      selected: selected,
      label: semanticsLabel,
      child: InkWell(
        borderRadius: AppRadius.cardLg,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: ShapeDecoration(
            color: selected
                ? theme.colorScheme.primary
                : AppColors.primaryBlack,
            shape: const StadiumBorder(
              side: BorderSide(color: AppColors.borderGray),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: selected
                ? theme.textTheme.labelMedium!.copyWith(
                    color: AppColors.primaryBlack,
                  )
                : theme.textTheme.labelMedium,
          ),
        ),
      ),
    );
  }
}
