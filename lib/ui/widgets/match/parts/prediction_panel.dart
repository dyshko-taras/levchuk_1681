// path: lib/ui/widgets/match/parts/prediction_panel.dart
// Displays selectable odds options (Home/Draw/Away) with styling per PRD.
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/data/models/odds_snapshot.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PredictionPanel extends StatelessWidget {
  const PredictionPanel({
    required this.odds,
    required this.onSelect,
    super.key,
    this.selected,
    this.title = AppStrings.matchDetailsPredictionPanelTitle,
  });

  final OddsSnapshot odds;
  final ValueChanged<String> onSelect;
  final String? selected;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entries = <_PredictionEntry>[
      _PredictionEntry(
        id: 'home',
        label: AppStrings.matchDetailsPredictionOptionHome,
        value: odds.home,
      ),
      _PredictionEntry(
        id: 'draw',
        label: AppStrings.matchDetailsPredictionOptionDraw,
        value: odds.draw,
      ),
      _PredictionEntry(
        id: 'away',
        label: AppStrings.matchDetailsPredictionOptionAway,
        value: odds.away,
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: AppRadius.cardLg,
        border: Border.all(
          color: AppColors.borderGray,
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: theme.textTheme.titleSmall?.copyWith(
                color: AppColors.textWhite,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            Gaps.hSm,
          ],
          Row(
            children: [
              for (var i = 0; i < entries.length; i++) ...[
                Expanded(
                  child: _PredictionOption(
                    entry: entries[i],
                    selected: selected == entries[i].id,
                    onTap: () => onSelect(entries[i].id),
                  ),
                ),
                if (i != entries.length - 1) Gaps.wSm,
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _PredictionEntry {
  const _PredictionEntry({
    required this.id,
    required this.label,
    required this.value,
  });

  final String id;
  final String label;
  final double value;
}

class _PredictionOption extends StatelessWidget {
  const _PredictionOption({
    required this.entry,
    required this.selected,
    required this.onTap,
  });

  final _PredictionEntry entry;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final outlineColor = selected
        ? AppColors.warningYellow
        : AppColors.borderGray;
    final background = selected ? AppColors.primaryBlack : Colors.transparent;

    return Semantics(
      button: true,
      selected: selected,
      label: '${entry.label} ${_formatOdd(entry.value)}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppRadius.btnLg,
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: ShapeDecoration(
              color: background,
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.btnLg,
                side: BorderSide(
                  color: outlineColor,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  entry.label,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: AppColors.textWhite,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gaps.hXs,
                Text(
                  _formatOdd(entry.value),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.successGreen,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String _formatOdd(double value) => value.toStringAsFixed(2);
