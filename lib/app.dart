// path: lib/app.dart
// Root widget configuring MaterialApp with centralized theme and routing.
import 'package:FlutterApp/constants/app_routes.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/di/providers.dart';
import 'package:FlutterApp/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return buildAppProviders(
      child: MaterialApp(
        title: AppStrings.appTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark(),
        initialRoute: AppRoutes.initialRoute,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        onUnknownRoute: AppRoutes.onUnknownRoute,
      ),
    );
  }
}
