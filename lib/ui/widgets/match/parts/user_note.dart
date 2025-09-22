// path: lib/ui/widgets/common/user_note.dart
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class UserNote extends StatelessWidget {
  const UserNote({
    this.text,
    super.key,
  });

  final String? text;

  @override
  Widget build(BuildContext context) {
    if (text == null || text!.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: Insets.allMd,
      decoration: const BoxDecoration(
        color: AppColors.textGray,
        borderRadius: AppRadius.noteRadius,
      ),
      child: Text(
        text!,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.textWhite,
        ),
      ),
    );
  }
}
