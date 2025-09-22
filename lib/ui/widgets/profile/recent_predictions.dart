// path: lib/ui/widgets/profile/recent_predictions.dart
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/data/models/fixture.dart';
import 'package:FlutterApp/data/models/prediction.dart';
import 'package:FlutterApp/providers/user_profile_provider.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:FlutterApp/ui/widgets/match/parts/status_chip.dart';
import 'package:FlutterApp/ui/widgets/match/parts/teams_row.dart' show TeamsRow;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
          (info) => _PredictionCard(
            prediction: info.prediction,
            fixture: info.fixture,
          ),
        ),
      ],
    );
  }
}

class _PredictionCard extends StatelessWidget {
  const _PredictionCard({
    required this.prediction,
    required this.fixture,
  });

  final Prediction prediction;
  final Fixture? fixture;

  @override
  Widget build(BuildContext context) {
    // Якщо немає даних по матчу — нічого не показуємо (або можна відрендерити плейсхолдер)
    if (fixture == null) return const SizedBox.shrink();

    final theme = Theme.of(context).textTheme;
    final dateStr = DateFormat('MMM d').format(fixture!.dateUtc);

    final (variant, label) = _statusFor(prediction);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: Insets.allMd,
      decoration: const BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: AppRadius.cardLg,
      ),
      child: Column(
        children: [
          TeamsRow(home: fixture!.homeTeam, away: fixture!.awayTeam),
          Gaps.hSm,
          Text(
            dateStr,
            style: theme.bodyMedium?.copyWith(
              color: AppColors.textGray,
            ),
          ),
          Gaps.hSm,
          StatusChip(variant: variant, label: label),
        ],
      ),
    );
  }

  // Мапінг статусу у варіант/лейбл для чіпа
  (StatusChipVariant, String) _statusFor(Prediction p) {
    // Якщо є результат в базі даних, використовуємо його
    if (p.result == 'correct') {
      return (StatusChipVariant.completedCorrect, 'Completed (Correct)');
    }
    if (p.result == 'missed') {
      return (StatusChipVariant.completedMissed, 'Completed (Missed)');
    }

    // Якщо результату немає, але матч закінчився, обчислюємо результат
    if (fixture != null && _isFixtureFinished(fixture!)) {
      final calculatedResult = _calculatePredictionResult(p, fixture!);
      if (calculatedResult == 'correct') {
        return (StatusChipVariant.completedCorrect, 'Completed (Correct)');
      } else if (calculatedResult == 'missed') {
        return (StatusChipVariant.completedMissed, 'Completed (Missed)');
      }
    }

    // Якщо матч ще не закінчився або немає даних
    return (StatusChipVariant.predicted, 'Predicted');
  }

  bool _isFixtureFinished(Fixture fixture) {
    const finishedStatuses = {'FT', 'AET', 'PEN'};
    return finishedStatuses.contains(fixture.status.toUpperCase());
  }

  String? _calculatePredictionResult(Prediction prediction, Fixture fixture) {
    final homeGoals = fixture.goalsHome;
    final awayGoals = fixture.goalsAway;

    if (homeGoals == null || awayGoals == null) return null;

    final actualWinner = homeGoals > awayGoals
        ? 'home'
        : homeGoals < awayGoals
        ? 'away'
        : 'draw';

    final predictionPick = prediction.pick.toLowerCase();
    return predictionPick == actualWinner ? 'correct' : 'missed';
  }
}
