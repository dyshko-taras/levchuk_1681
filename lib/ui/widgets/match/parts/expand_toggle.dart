import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ExpandToggle extends StatelessWidget {
  const ExpandToggle({
    required this.expanded,
    this.onToggle,
    super.key,
  });

  final bool expanded;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    final icon = expanded ? Icons.expand_less : Icons.expand_more;
    return IconButton(
      onPressed: onToggle,
      icon: Icon(icon, color: AppColors.textWhite, size: AppSizes.iconMd),
      tooltip: expanded ? 'Collapse' : 'Expand',
    );
  }
}
