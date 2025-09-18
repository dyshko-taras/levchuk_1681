// path: lib/ui/pages/main_shell_page.dart
// Main shell with IndexedStack tabs and NavigationBar icons from AppIcons.
import 'package:FlutterApp/constants/app_icons.dart';
import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/providers/bottom_nav_provider.dart';
import 'package:FlutterApp/ui/pages/favorites_page.dart';
import 'package:FlutterApp/ui/pages/match_schedule_page.dart';
import 'package:FlutterApp/ui/pages/statistics_page.dart';
import 'package:FlutterApp/ui/pages/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MainShellPage extends StatefulWidget {
  const MainShellPage({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<MainShellPage> createState() => _MainShellPageState();
}

class _MainShellPageState extends State<MainShellPage> {
  static const _titles = <String>[
    AppStrings.matchesTodayTitle,
    AppStrings.statisticsTabTitle,
    AppStrings.favoritesTabTitle,
    AppStrings.profileTabTitle,
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
        appBar: AppBar(title: Text(_titles[index])),
        body: IndexedStack(
          index: index,
          children: const [
            MatchSchedulePage(),
            StatisticsPage(),
            FavoritesPage(),
            UserProfilePage(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (value) =>
              context.read<BottomNavProvider>().setIndex(value),
          destinations: [
            _NavDestination(
              asset: AppIcons.navMatches,
              label: AppStrings.matchesTodayTitle,
            ),
            _NavDestination(
              asset: AppIcons.navStats,
              label: AppStrings.statisticsTabTitle,
            ),
            _NavDestination(
              asset: AppIcons.navFavorites,
              label: AppStrings.favoritesTabTitle,
            ),
            _NavDestination(
              asset: AppIcons.navProfile,
              label: AppStrings.profileTabTitle,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavDestination extends NavigationDestination {
  _NavDestination({required super.label, required String asset})
    : super(
        icon: _NavIcon(asset: asset, label: label, size: AppSizes.iconSm),
        selectedIcon: _NavIcon(
          asset: asset,
          label: label,
          size: AppSizes.iconMd,
        ),
      );
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({
    required this.asset,
    required this.label,
    required this.size,
  });

  final String asset;
  final String label;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      width: size,
      height: size,
      semanticsLabel: label,
    );
  }
}
