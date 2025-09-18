// path: lib/ui/pages/main_shell_page.dart
// Main shell with IndexedStack tabs and NavigationBar icons from AppIcons.
import 'package:FlutterApp/constants/app_icons.dart';
import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/ui/pages/match_schedule_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainShellPage extends StatefulWidget {
  const MainShellPage({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<MainShellPage> createState() => _MainShellPageState();
}

class _MainShellPageState extends State<MainShellPage> {
  late int _index;

  static const _tabTitles = <String>[
    AppStrings.matchesTodayTitle,
    'Statistics',
    'Favorites',
    'Profile',
  ];

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
  }

  NavigationDestination _dest(String asset, String label) {
    return NavigationDestination(
      icon: SvgPicture.asset(
        asset,
        width: AppSizes.iconSm,
        height: AppSizes.iconSm,
        semanticsLabel: label,
      ),
      selectedIcon: SvgPicture.asset(
        asset,
        width: AppSizes.iconMd,
        height: AppSizes.iconMd,
        semanticsLabel: label,
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_tabTitles[_index])),
      body: IndexedStack(
        index: _index,
        children: const [
          MatchSchedulePage(),
          _TabPlaceholder(title: 'Statistics'),
          _TabPlaceholder(title: 'Favorites'),
          _TabPlaceholder(title: 'Profile'),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (index) => setState(() => _index = index),
        destinations: [
          _dest(AppIcons.navMatches, AppStrings.matchesTodayTitle),
          _dest(AppIcons.navStats, 'Statistics'),
          _dest(AppIcons.navFavorites, 'Favorites'),
          _dest(AppIcons.navProfile, 'Profile'),
        ],
      ),
    );
  }
}

class _TabPlaceholder extends StatelessWidget {
  const _TabPlaceholder({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$title - coming next',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
