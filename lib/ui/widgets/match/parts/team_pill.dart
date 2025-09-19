import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TeamPill extends StatelessWidget {
  const TeamPill({
    required this.name,
    this.alignment = Alignment.centerLeft,
    super.key,
  });

  final String name;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Insets.vSm.add(Insets.hMd),
      decoration: const BoxDecoration(
        color: AppColors.textGray,
        borderRadius: AppRadius.chipRadius,
      ),
      alignment: alignment,
      child: Text(
        name,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
