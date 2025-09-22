import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final List<BottomNavBarItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primaryBlack,
        border: Border(
          top: BorderSide(
            color: AppColors.borderGray,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: AppSizes.navBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: _BottomNavItemButton(
                    item: items[i],
                    index: i,
                    selected: i == currentIndex,
                    onTap: onTap,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavBarItem {
  const BottomNavBarItem({
    required this.label,
    required this.icon,
  });

  final String label;
  final String icon;
}

class _BottomNavItemButton extends StatelessWidget {
  const _BottomNavItemButton({
    required this.item,
    required this.index,
    required this.selected,
    required this.onTap,
  });

  final BottomNavBarItem item;
  final int index;
  final bool selected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelSmall;
    final color = selected ? AppColors.textWhite : AppColors.textGray;

    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      child: InkWell(
        onTap: () => onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              item.icon,
              width: AppSizes.navIcon,
              height: AppSizes.navIcon,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              semanticsLabel: item.label,
            ),
            Gaps.hXs,
            Text(
              item.label,
              style: labelStyle?.copyWith(
                color: color,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
