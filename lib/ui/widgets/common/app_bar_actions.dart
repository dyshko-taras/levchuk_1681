// path: lib/ui/widgets/common/app_bar_actions.dart
import 'package:FlutterApp/constants/app_icons.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Small helper for AppBar trailing actions; callbacks are optional.
class AppBarActions extends StatelessWidget {
  const AppBarActions({
    super.key,
    this.onSearch,
    this.onCalendar,
  });

  final VoidCallback? onSearch;
  final VoidCallback? onCalendar;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          tooltip: 'Search',
          onPressed: onSearch,
          icon: SvgPicture.asset(AppIcons.actionSearch),
        ),
        Gaps.wSm,
        IconButton(
          tooltip: 'Calendar',
          onPressed: onCalendar,
          icon: SvgPicture.asset(AppIcons.actionCalendar),
        ),
      ],
    );
  }
}
