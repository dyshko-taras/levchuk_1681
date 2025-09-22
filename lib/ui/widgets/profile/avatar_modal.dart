import 'package:FlutterApp/constants/app_images.dart';
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AvatarModal extends StatefulWidget {
  const AvatarModal({
    required this.currentAvatarId,
    required this.currentName,
    required this.onSave,
    required this.onCancel,
    super.key,
  });

  final int? currentAvatarId;
  final String currentName;
  final void Function(String name, int avatarId) onSave;
  final VoidCallback onCancel;

  @override
  State<AvatarModal> createState() => _AvatarModalState();
}

class _AvatarModalState extends State<AvatarModal> {
  late int selectedAvatarId;
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    selectedAvatarId = widget.currentAvatarId ?? 1;
    nameController = TextEditingController(text: widget.currentName);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Dialog(
      backgroundColor: AppColors.primaryBlack,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.borderGray, width: 2),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Padding(
        padding: Insets.allLg,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.profileAvatar,
              style: theme.titleLarge?.copyWith(
                color: AppColors.textWhite,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gaps.hLg,
            // Avatar grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                final avatarId = index + 1;
                final isSelected = selectedAvatarId == avatarId;

                return GestureDetector(
                  onTap: () => setState(() => selectedAvatarId = avatarId),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.cardDark,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.warningYellow
                            : AppColors.borderGray,
                        width: 2,
                      ),
                    ),
                    child: _buildAvatar(avatarId),
                  ),
                );
              },
            ),
            Gaps.hLg,
            // Name input
            TextField(
              controller: nameController,
              style: theme.bodyMedium?.copyWith(color: AppColors.textWhite),
              decoration: InputDecoration(
                labelText: AppStrings.profileName,
                hintText: AppStrings.profileEnterName,
                labelStyle: const TextStyle(color: AppColors.textGray),
                hintStyle: const TextStyle(color: AppColors.textGray),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  borderSide: const BorderSide(color: AppColors.borderGray),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  borderSide: const BorderSide(color: AppColors.accentBlue),
                ),
              ),
            ),
            Gaps.hLg,
            // Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.onCancel,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.cardDark,
                      foregroundColor: AppColors.textWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                    ),
                    child: const Text(AppStrings.profileCancel),
                  ),
                ),
                Gaps.wMd,
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => widget.onSave(
                      nameController.text,
                      selectedAvatarId,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.successGreen,
                      foregroundColor: AppColors.textWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                    ),
                    child: const Text(AppStrings.profileSave),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
}
