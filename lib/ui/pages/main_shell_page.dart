// path: lib/ui/pages/main_shell_page.dart
// Main shell with IndexedStack tabs and custom BottomNavBar per PRD.
import 'package:FlutterApp/constants/app_icons.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/providers/bottom_nav_provider.dart';
import 'package:FlutterApp/ui/pages/favorites_page.dart';
import 'package:FlutterApp/ui/pages/match_schedule_page.dart';
import 'package:FlutterApp/ui/pages/statistics_page.dart';
import 'package:FlutterApp/ui/pages/user_profile_page.dart';
import 'package:FlutterApp/ui/widgets/navigation/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainShellPage extends StatefulWidget {
  const MainShellPage({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<MainShellPage> createState() => _MainShellPageState();
}

class _MainShellPageState extends State<MainShellPage> {
  static const _pages = <Widget>[
    MatchSchedulePage(),
    StatisticsPage(),
    FavoritesPage(),
    UserProfilePage(),
  ];

  static const _items = <BottomNavBarItem>[
    BottomNavBarItem(
      label: AppStrings.matchesTodayTitle,
      icon: AppIcons.navMatches,
    ),
    BottomNavBarItem(
      label: AppStrings.statisticsTabTitle,
      icon: AppIcons.navStats,
    ),
    BottomNavBarItem(
      label: AppStrings.favoritesTabTitle,
      icon: AppIcons.navFavorites,
    ),
    BottomNavBarItem(
      label: AppStrings.profileTabTitle,
      icon: AppIcons.navProfile,
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<BottomNavProvider>().resetTo(widget.initialIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<BottomNavProvider>();
    final index = nav.currentIndex;

    return WillPopScope(
      onWillPop: () async => !context.read<BottomNavProvider>().handleBack(),
      child: Scaffold(
        body: IndexedStack(index: index, children: _pages),
        bottomNavigationBar: BottomNavBar(
          items: _items,
          currentIndex: index,
          onTap: (value) => context.read<BottomNavProvider>().setIndex(value),
        ),
      ),
    );
  }
}
