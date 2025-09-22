import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TeamBadge extends StatelessWidget {
  const TeamBadge({
    required this.logoUrl,
    this.size = AppSizes.teamBadge,
    super.key,
  });

  final String? logoUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.onSurface,
        border: Border.all(
          color: AppColors.borderGray,
        ),
      ),
      child: Icon(Icons.shield, size: size * 0.45, color: AppColors.textGray),
    );

    if (logoUrl == null || logoUrl!.isEmpty) {
      return placeholder;
    }

    return Container(
      width: size + 15,
      height: size + 15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.textGray,
        border: Border.all(
          color: AppColors.borderGray,
        ),
      ),
      child: Center(
        child: Image.network(
          logoUrl!,
          width: AppSizes.teamBadge,
          height: AppSizes.teamBadge,
          fit: BoxFit.contain,
          errorBuilder: (_, _, _) => placeholder,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return placeholder;
          },
        ),
      ),
    );
  }
}
