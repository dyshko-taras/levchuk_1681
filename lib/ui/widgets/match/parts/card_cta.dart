import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum CardCtaVariant { primary, secondary }

class CardCTA extends StatelessWidget {
  const CardCTA({
    required this.label,
    required this.variant,
    required this.leadingIcon,
    super.key,
    this.onPressed,
    this.enabled = true,
  });

  final String label;
  final CardCtaVariant variant;
  final String leadingIcon;
  final VoidCallback? onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final isEnabled = enabled && onPressed != null;
    final (bg, fg) = switch (variant) {
      CardCtaVariant.primary => (
        AppColors.successGreen,
        AppColors.primaryBlack,
      ),
      CardCtaVariant.secondary => (AppColors.cardDark, AppColors.textWhite),
    };

    return Opacity(
      opacity: isEnabled ? 1 : 0.5,
      child: SizedBox(
        height: AppSizes.ctaHeight,
        child: Material(
          color: bg,
          borderRadius: AppRadius.btnLg,
          child: InkWell(
            borderRadius: AppRadius.btnLg,
            onTap: isEnabled ? onPressed : null,
            child: Padding(
              padding: Insets.hMd,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    leadingIcon,
                    width: AppSizes.iconSm,
                    height: AppSizes.iconSm,
                    colorFilter: ColorFilter.mode(fg, BlendMode.srcIn),
                  ),
                  Gaps.wSm,
                  Text(
                    label,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: fg,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
