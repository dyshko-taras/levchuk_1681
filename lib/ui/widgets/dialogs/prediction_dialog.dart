// path: lib/ui/widgets/dialogs/prediction_dialog.dart
// Modal dialog for selecting a prediction outcome.
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/data/models/odds_snapshot.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:FlutterApp/ui/widgets/buttons/primary_button.dart';
import 'package:FlutterApp/ui/widgets/buttons/secondary_green_button_light.dart';
import 'package:FlutterApp/ui/widgets/match/parts/prediction_panel.dart';
import 'package:flutter/material.dart';

class PredictionDialog extends StatefulWidget {
  const PredictionDialog({
    required this.odds,
    required this.onCancel,
    required this.onConfirm,
    required this.onSelect,
    super.key,
    this.selected,
    this.title = AppStrings.matchDetailsPredictionDialogTitle,
  });

  final OddsSnapshot odds;
  final VoidCallback onCancel;
  final Future<void> Function(String) onConfirm;
  final ValueChanged<String> onSelect;
  final String? selected;
  final String title;

  @override
  State<PredictionDialog> createState() => _PredictionDialogState();
}

class _PredictionDialogState extends State<PredictionDialog> {
  String? _selection;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _selection = widget.selected;
  }

  @override
  void didUpdateWidget(covariant PredictionDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected != oldWidget.selected) {
      _selection = widget.selected;
    }
  }

  void _handleSelect(String value) {
    setState(() => _selection = value);
    widget.onSelect(value);
  }

  Future<void> _handleConfirm() async {
    final selected = _selection;
    if (selected == null || _submitting) {
      return;
    }
    setState(() => _submitting = true);
    await widget.onConfirm(selected);
    if (mounted) {
      setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: AppColors.primaryBlack,
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.cardLg),
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: AppColors.textWhite,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            Gaps.hLg,
            PredictionPanel(
              odds: widget.odds,
              selected: _selection,
              onSelect: _handleSelect,
              title: null,
            ),
            Gaps.hLg,
            Row(
              children: [
                Expanded(
                  child: SecondaryGreenButtonLight(
                    label: AppStrings.cancel,
                    onPressed: _submitting ? null : widget.onCancel,
                    enabled: !_submitting,
                  ),
                ),
                Gaps.wSm,
                Expanded(
                  child: PrimaryButton(
                    label: AppStrings.matchDetailsMakePrediction,
                    onPressed: _selection == null || _submitting
                        ? null
                        : _handleConfirm,
                    enabled: _selection != null && !_submitting,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
