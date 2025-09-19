import 'package:flutter/material.dart';

import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';

class FavoriteStar extends StatelessWidget {
  const FavoriteStar({
    required this.isFavorite,
    this.onToggle,
    super.key,
  });

  final bool isFavorite;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    final color = isFavorite ? AppColors.warningYellow : AppColors.textGray;
    final icon = isFavorite ? Icons.star : Icons.star_border;

    return IconButton(
      onPressed: onToggle,
      icon: Icon(icon, color: color, size: AppSizes.iconMd),
      tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
    );
  }
}
