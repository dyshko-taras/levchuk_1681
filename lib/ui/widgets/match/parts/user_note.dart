import 'package:flutter/material.dart';

import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';

class UserNote extends StatelessWidget {
  const UserNote({
    this.text,
    super.key,
  });

  final String? text;

  @override
  Widget build(BuildContext context) {
    final display = (text == null || text!.isEmpty) ? '-' : text!;
    return Container(
      width: double.infinity,
      padding: Insets.allMd,
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: AppRadius.noteRadius,
      ),
      child: Text(
        display,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.textWhite,
        ),
      ),
    );
  }
}
