// path: lib/ui/widgets/profile/recent_predictions.dart
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/providers/user_profile_provider.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:FlutterApp/ui/widgets/predictions/prediction_card.dart';
import 'package:flutter/material.dart';

class RecentPredictions extends StatelessWidget {
  const RecentPredictions({
    required this.predictions,
    super.key,
  });

  final List<RecentPredictionInfo> predictions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent predictions',
          style: theme.titleLarge?.copyWith(
            color: AppColors.textWhite,
            fontWeight: FontWeight.w600,
          ),
        ),
        Gaps.hMd,
        ...predictions.map(
          (info) => PredictionCard(
            prediction: info.prediction,
            fixture: info.fixture,
          ),
        ),
      ],
    );
  }
}
