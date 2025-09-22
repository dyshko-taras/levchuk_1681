import 'package:FlutterApp/constants/app_icons.dart';
import 'package:FlutterApp/constants/app_images.dart';
import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:FlutterApp/ui/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoritesEmptyState extends StatelessWidget {
  const FavoritesEmptyState({
    required this.onGoToMatches,
    super.key,
  });

  final VoidCallback onGoToMatches;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: Insets.allLg,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppImages.emptyFavoritesStar,
            width: AppSizes.imageLg,
            height: AppSizes.imageLg,
          ),
          Gaps.hMd,
          Text(
            AppStrings.favoritesEmptyTitle,
            style: theme.bodyLarge?.copyWith(
              color: AppColors.textWhite,
            ),
            textAlign: TextAlign.center,
          ),
          Gaps.hLg,
          PrimaryButton(
            label: AppStrings.favoritesGoToMatches,
            onPressed: onGoToMatches,
          ),
        ],
      ),
    );
  }
}
