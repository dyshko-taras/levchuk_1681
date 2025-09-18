// path: lib/ui/widgets/matches/status_chip.dart
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// A small, neutral status chip (no color-coding assumptions).
class StatusChip extends StatelessWidget {
  const StatusChip(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: const ShapeDecoration(
        color: AppColors.cardDark,
        shape: StadiumBorder(side: BorderSide(color: AppColors.borderGray)),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
