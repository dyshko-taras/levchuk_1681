import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SecondaryGreenButtonLight extends StatelessWidget {
  const SecondaryGreenButtonLight({
    required this.label,
    required this.onPressed,
    super.key,
    this.enabled = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final isEnabled = enabled && onPressed != null;
    const fg = AppColors.successGreen;

    return Opacity(
      opacity: isEnabled ? 1 : 0.5,
      child: SizedBox(
        height: AppSizes.buttonHeightMd,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.cardDark,
            borderRadius: AppRadius.btnLg,
            border: Border.all(color: fg),
          ),
          child: InkWell(
            borderRadius: AppRadius.btnLg,
            onTap: isEnabled ? onPressed : null,
            child: Center(
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: fg,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
