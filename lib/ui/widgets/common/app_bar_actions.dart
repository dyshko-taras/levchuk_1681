import 'package:FlutterApp/constants/app_icons.dart';
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarActions extends StatelessWidget {
  const AppBarActions({
    required this.title,
    super.key,
    this.leftIcon,
    this.rightIcon,
    this.onLeft,
    this.onRight,
    this.showLeft = true,
    this.showRight = true,
    this.hideLeftOnRootTabs = true,
    this.isRootTab = false,
  });

  final String title;
  final String? leftIcon;
  final String? rightIcon;
  final VoidCallback? onLeft;
  final VoidCallback? onRight;
  final bool showLeft;
  final bool showRight;
  final bool hideLeftOnRootTabs;
  final bool isRootTab;

  bool get _shouldShowLeft => showLeft && !(hideLeftOnRootTabs && isRootTab);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveLeftIcon = leftIcon ?? AppIcons.actionBack;
    final effectiveRightIcon = rightIcon ?? AppIcons.actionBack;

    return Container(
      height: AppSizes.appBarHeight,
      padding: Insets.hMd,
      decoration: const BoxDecoration(
        color: AppColors.primaryBlack,
      ),
      child: Row(
        children: [
          if (_shouldShowLeft)
            _AppBarIconButton(
              asset: effectiveLeftIcon,
              tooltip: AppStrings.appBarBackTooltip,
              onPressed: onLeft,
            ),
          Gaps.wSm,
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
                color: AppColors.textWhite,
              ),
            ),
          ),
          Gaps.wSm,
          if (showRight)
            _AppBarIconButton(
              asset: effectiveRightIcon,
              tooltip: AppStrings.appBarActionTooltip,
              onPressed: onRight,
            )
          else
            const SizedBox(width: AppSizes.iconMd + AppSpacing.sm),
        ],
      ),
    );
  }
}

class _AppBarIconButton extends StatelessWidget {
  const _AppBarIconButton({
    required this.asset,
    required this.tooltip,
    this.onPressed,
  });

  final String asset;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: tooltip,
      child: InkWell(
        borderRadius: AppRadius.segmented,
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xs),
          child: SvgPicture.asset(
            asset,
            width: AppSizes.iconMd,
            height: AppSizes.iconMd,
            colorFilter: const ColorFilter.mode(
              AppColors.textWhite,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
