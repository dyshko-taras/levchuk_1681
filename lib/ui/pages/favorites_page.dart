// path: lib/ui/pages/favorites_page.dart
// Placeholder favorites page until dedicated implementation.
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: Insets.allLg,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppStrings.favoritesTabTitle,
              style: theme.titleLarge,
            ),
            Gaps.hSm,
            Text(
              AppStrings.comingSoon,
              style: theme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
