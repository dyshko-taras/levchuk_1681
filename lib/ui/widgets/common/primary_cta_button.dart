// path: lib/ui/widgets/common/primary_cta_button.dart
// Primary CTA button molecule per Component Catalog.
import 'package:FlutterApp/constants/app_durations.dart';
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PrimaryCtaButton extends StatefulWidget {
  const PrimaryCtaButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;

  @override
  State<PrimaryCtaButton> createState() => _PrimaryCtaButtonState();
}

class _PrimaryCtaButtonState extends State<PrimaryCtaButton> {
  bool _highlighted = false;

  bool get _isInteractive => widget.isEnabled && !widget.isLoading;

  void _handleHighlightChanged(bool value) {
    if (_highlighted == value) return;
    if (!_isInteractive) return;
    setState(() => _highlighted = value);
  }

  @override
  Widget build(BuildContext context) {
    final scale = _highlighted ? 0.95 : 1.0;
    final opacity = !_isInteractive
        ? 0.5
        : _highlighted
        ? 0.8
        : 1.0;

    return AnimatedOpacity(
      duration: AppDurations.fast,
      opacity: opacity,
      child: AnimatedScale(
        duration: AppDurations.fast,
        scale: scale,
        child: SizedBox(
          width: double.infinity,
          height: AppSizes.buttonHeightLg,
          child: Material(
            color: AppColors.successGreen,
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              onTap: _isInteractive ? widget.onPressed : null,
              onHighlightChanged: _handleHighlightChanged,
              child: Padding(
                padding: Insets.hLg,
                child: Center(
                  child: widget.isLoading
                      ? const SizedBox.square(
                          dimension: AppSizes.iconSm,
                          child: CircularProgressIndicator(
                            strokeWidth: AppSizes.strokeThick,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.onPrimary,
                            ),
                          ),
                        )
                      : Text(
                          widget.label,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: AppColors.onPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
