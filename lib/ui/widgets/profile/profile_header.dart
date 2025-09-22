import 'package:FlutterApp/constants/app_images.dart';
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    required this.username,
    required this.onEditProfile,
    super.key,
    this.avatarId,
  });

  final String username;
  final int? avatarId;
  final VoidCallback onEditProfile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Column(
      children: [
        Stack(
          children: [
            // Avatar
            Container(
              width: AppSizes.avatarLg,
              height: AppSizes.avatarLg,
              decoration: BoxDecoration(
                color: AppColors.cardDark,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: AppColors.errorRed.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: avatarId != null
                  ? _buildAvatar(avatarId!)
                  : _buildDefaultAvatar(),
            ),
            // Edit button
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: onEditProfile,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.successGreen,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.edit,
                    size: AppSizes.iconSm,
                    color: AppColors.primaryBlack,
                  ),
                ),
              ),
            ),
          ],
        ),
        Gaps.hMd,
        Text(
          username,
          style: theme.titleLarge?.copyWith(
            color: AppColors.textWhite,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(int avatarId) {
    return Image.asset(
      AppImages.avatar(avatarId),
      fit: BoxFit.contain,
      width: AppSizes.avatarLg,
      height: AppSizes.avatarLg,
    );
  }

  Widget _buildDefaultAvatar() {
    return const ColoredBox(
      color: AppColors.borderGray,
      child: Icon(
        Icons.person,
        size: AppSizes.iconLg,
        color: AppColors.textGray,
      ),
    );
  }
}
