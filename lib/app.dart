// path: lib/app.dart
import 'package:FlutterApp/constants/constants.dart';
import 'package:FlutterApp/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Root widget configuring MaterialApp with centralized theme and routing.
/// No inline theme; uses DS-driven `appTheme`.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const _BootstrapProbe(),
      routes: AppRoutes.routes,
    );
  }
}

/// Temporary, minimal visible surface so the app boots cleanly this phase.
/// Will be removed once Splash/Welcome pages are implemented per PRD.
class _BootstrapProbe extends StatelessWidget {
  const _BootstrapProbe();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Boot OK')),
      body: Column(
        children: [
          Text('Boot OK', style: Theme.of(context).textTheme.bodyLarge),
          Text(
            'Phase 1 — App theme applied',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            'Phase 2 — DS theme applied',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
