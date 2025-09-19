import 'package:flutter/material.dart';

import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';

class CenterBlock extends StatelessWidget {
  const CenterBlock.kickoff({
    required String timeText,
    required String dateText,
    super.key,
  }) : _primaryText = timeText,
       _secondaryText = dateText;

  const CenterBlock.score({
    required String scoreText,
    String? statusText,
    super.key,
  }) : _primaryText = scoreText,
       _secondaryText = statusText;

  final String _primaryText;
  final String? _secondaryText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w700,
      color: AppColors.textWhite,
    );
    final subtitleStyle = theme.textTheme.labelSmall?.copyWith(
      color: AppColors.textGray,
      fontWeight: FontWeight.w500,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(_primaryText, style: titleStyle, textAlign: TextAlign.center),
        if (_secondaryText case final text? when text.isNotEmpty) ...[
          Gaps.hXs,
          Text(
            text,
            style: subtitleStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
