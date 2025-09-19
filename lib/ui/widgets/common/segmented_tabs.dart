import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SegmentedTabs extends StatelessWidget {
  const SegmentedTabs({
    required this.items,
    required this.selectedId,
    required this.onChange,
    super.key,
    this.size = SegmentedTabsSize.lg,
    this.emphasis = SegmentedTabsEmphasis.primary,
    this.scrollable = false,
    this.equalWidth = true,
    this.hideBadgesWhenZero = true,
    this.semanticLabel = 'Tabs',
  });

  final List<SegmentedTabItem> items;
  final String selectedId;
  final ValueChanged<String> onChange;
  final SegmentedTabsSize size;
  final SegmentedTabsEmphasis emphasis;
  final bool scrollable;
  final bool equalWidth;
  final bool hideBadgesWhenZero;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final height = switch (size) {
      SegmentedTabsSize.sm => AppSizes.segmentedTabSm,
      SegmentedTabsSize.md => AppSizes.segmentedTabMd,
      SegmentedTabsSize.lg => AppSizes.segmentedTabLg,
    };

    final textStyle = switch (size) {
      SegmentedTabsSize.sm => Theme.of(context).textTheme.bodySmall,
      SegmentedTabsSize.md => Theme.of(context).textTheme.bodyMedium,
      SegmentedTabsSize.lg => Theme.of(context).textTheme.titleSmall,
    };

    final colors = _SegmentColors.fromEmphasis(emphasis);

    final segments = items
        .map(
          (item) => _SegmentButton(
            item: item,
            selected: item.id == selectedId,
            onTap: () => onChange(item.id),
            height: height,
            textStyle: textStyle,
            colors: colors,
            hideBadgeWhenZero: hideBadgesWhenZero,
          ),
        )
        .toList(growable: false);

    Widget child;
    if (scrollable) {
      child = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var i = 0; i < segments.length; i++) ...[
              segments[i],
              if (i != segments.length - 1) Gaps.wSm,
            ],
          ],
        ),
      );
    } else if (equalWidth) {
      child = Row(
        children: [
          for (var i = 0; i < segments.length; i++) ...[
            Expanded(child: segments[i]),
            if (i != segments.length - 1) Gaps.wSm,
          ],
        ],
      );
    } else {
      child = Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: segments,
      );
    }

    return Semantics(
      container: true,
      label: semanticLabel,
      child: Container(
        padding: Insets.allSm,
        decoration: const BoxDecoration(
          color: AppColors.warningYellow,
          borderRadius: AppRadius.segmented,
        ),
        child: child,
      ),
    );
  }
}

class SegmentedTabItem {
  const SegmentedTabItem({
    required this.id,
    required this.label,
    this.badge,
    this.icon,
  });

  final String id;
  final String label;
  final int? badge;
  final IconData? icon;
}

enum SegmentedTabsSize { sm, md, lg }

enum SegmentedTabsEmphasis { primary, neutral }

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.item,
    required this.selected,
    required this.onTap,
    required this.height,
    required this.textStyle,
    required this.colors,
    required this.hideBadgeWhenZero,
  });

  final SegmentedTabItem item;
  final bool selected;
  final VoidCallback onTap;
  final double height;
  final TextStyle? textStyle;
  final _SegmentColors colors;
  final bool hideBadgeWhenZero;

  @override
  Widget build(BuildContext context) {
    final fg = selected ? colors.fgSelected : colors.fgUnselected;
    final bg = selected ? colors.bgSelected : colors.bgUnselected;
    final showBadge =
        item.badge != null && (!hideBadgeWhenZero || (item.badge ?? 0) > 0);

    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppRadius.segmented,
          onTap: onTap,
          child: Container(
            height: height,
            padding: Insets.hMd,
            decoration: ShapeDecoration(
              color: bg,
              shape: const StadiumBorder(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (item.icon != null) ...[
                  Icon(item.icon, size: AppSizes.iconSm, color: fg),
                  Gaps.wSm,
                ],
                Text(
                  item.label,
                  style: textStyle?.copyWith(
                    color: fg,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (showBadge) ...[
                  Gaps.wSm,
                  _Badge(value: item.badge!, colors: colors),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.value, required this.colors});

  final int value;
  final _SegmentColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.chipHeight / 1.6,
      constraints: const BoxConstraints(minWidth: AppSizes.chipHeight / 1.6),
      padding: Insets.hXs,
      decoration: BoxDecoration(
        color: colors.badgeBg,
        borderRadius: AppRadius.chipRadius,
      ),
      alignment: Alignment.center,
      child: Text(
        value.toString(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: AppColors.textWhite,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _SegmentColors {
  const _SegmentColors({
    required this.bgUnselected,
    required this.fgUnselected,
    required this.bgSelected,
    required this.fgSelected,
    required this.badgeBg,
  });

  factory _SegmentColors.fromEmphasis(SegmentedTabsEmphasis emphasis) {
    return switch (emphasis) {
      SegmentedTabsEmphasis.primary => const _SegmentColors(
        bgUnselected: AppColors.warningYellow,
        fgUnselected: AppColors.primaryBlack,
        bgSelected: AppColors.primaryBlack,
        fgSelected: AppColors.textWhite,
        badgeBg: AppColors.accentBlue,
      ),
      SegmentedTabsEmphasis.neutral => const _SegmentColors(
        bgUnselected: AppColors.cardDark,
        fgUnselected: AppColors.textWhite,
        bgSelected: AppColors.surface,
        fgSelected: AppColors.textWhite,
        badgeBg: AppColors.borderGray,
      ),
    };
  }

  final Color bgUnselected;
  final Color fgUnselected;
  final Color bgSelected;
  final Color fgSelected;
  final Color badgeBg;
}
