import 'package:FlutterApp/constants/app_icons.dart';
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:FlutterApp/ui/widgets/match/match_card_config.dart';
import 'package:FlutterApp/ui/widgets/match/parts/actions_row.dart';
import 'package:FlutterApp/ui/widgets/match/parts/card_cta.dart';
import 'package:FlutterApp/ui/widgets/match/parts/center_block.dart';
import 'package:FlutterApp/ui/widgets/match/parts/favorite_star.dart';
import 'package:FlutterApp/ui/widgets/match/parts/league_header.dart';
import 'package:FlutterApp/ui/widgets/match/parts/status_chip.dart';
import 'package:FlutterApp/ui/widgets/match/parts/sub_info.dart';
import 'package:FlutterApp/ui/widgets/match/parts/teams_row.dart';
import 'package:FlutterApp/ui/widgets/match/parts/user_note.dart';
import 'package:flutter/material.dart';

class MatchCard extends StatelessWidget {
  const MatchCard({
    required this.config,
    super.key,
    this.onOpenMatch,
    this.onMakePrediction,
    this.onToggleFavorite,
    this.onExpandToggle,
  });

  final MatchCardConfig config;
  final VoidCallback? onOpenMatch;
  final VoidCallback? onMakePrediction;
  final VoidCallback? onToggleFavorite;
  final VoidCallback? onExpandToggle;

  @override
  Widget build(BuildContext context) {
    final match = config.match;

    final centerBlock = switch (config.state) {
      MatchCardState.upcoming ||
      MatchCardState.live => _buildKickoffBlock(match.dateUtc),
      MatchCardState.finished => _buildScoreBlock(
        match.goalsHome,
        match.goalsAway,
        match.status,
      ),
    };

    final subInfo = _buildSubInfo();
    final statusChip = _buildStatusChip();
    final actions = _buildActions();
    final showActions = actions.isNotEmpty;

    final expandedContent = config.isExpanded
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.hMd,
              UserNote(text: config.userNote),
            ],
          )
        : const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(_paddingForDensity()),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: AppRadius.cardLg,
        gradient: LinearGradient(
          colors: [
            AppColors.cardDark,
            AppColors.cardDark.withOpacity(0.92),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        spacing: 2,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: LeagueHeader(
                  leagueName: match.leagueName,
                  countryName: match.country,
                ),
              ),
              FavoriteStar(
                isFavorite: config.isFavorite,
                onToggle: onToggleFavorite,
              ),
            ],
          ),
          TeamsRow(home: match.homeTeam, away: match.awayTeam),
          Center(child: centerBlock),
          subInfo,
          statusChip,
          expandedContent,
          if (showActions) ...[
            Gaps.hSm,
            ActionsRow(actions: actions),
          ],
          if (_shouldShowExpandToggle())
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onExpandToggle,
                icon: Icon(
                  config.isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: AppColors.textWhite,
                ),
                label: Text(
                  config.isExpanded ? 'Hide details' : 'Show details',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildKickoffBlock(DateTime dateUtc) {
    final local = dateUtc.toLocal();
    final time = _formatTime(local);
    final date = _formatDate(local);
    return CenterBlock.kickoff(timeText: time, dateText: date);
  }

  Widget _buildScoreBlock(int? homeGoals, int? awayGoals, String status) {
    final home = homeGoals?.toString() ?? '-';
    final away = awayGoals?.toString() ?? '-';
    final score = '$home - $away';
    final statusText = status.toUpperCase();
    return CenterBlock.score(scoreText: score, statusText: statusText);
  }

  Widget _buildSubInfo() {
    switch (config.state) {
      case MatchCardState.upcoming:
      case MatchCardState.live:
        if (config.prediction != null) {
          final odds = config.prediction?.odds;
          return SubInfo.predictionSummary(
            pick: _formatPick(config.prediction!.pick),
            odds: odds,
          );
        }
        final odds = config.odds;
        if (odds == null) {
          return const SizedBox.shrink();
        }
        return SubInfo.odds(
          home: odds.home,
          draw: odds.draw,
          away: odds.away,
        );
      case MatchCardState.finished:
        if (config.prediction != null) {
          final odds = config.prediction?.odds;
          return SubInfo.predictionSummary(
            pick: _formatPick(config.prediction!.pick),
            odds: odds,
          );
        }
        return const SubInfo.finished();
    }
  }

  StatusChip _buildStatusChip() {
    // For finished matches, check the actual result
    if (config.state == MatchCardState.finished) {
      if (config.prediction != null) {
        final result = config.prediction!.result;
        if (result == 'correct') {
          return const StatusChip(
            variant: StatusChipVariant.completedCorrect,
            label: 'Completed (Correct)',
          );
        } else if (result == 'missed') {
          return const StatusChip(
            variant: StatusChipVariant.completedMissed,
            label: 'Completed (Missed)',
          );
        } else {
          final calculatedResult = _calculatePredictionResult();
          if (calculatedResult == 'correct') {
            return const StatusChip(
              variant: StatusChipVariant.completedCorrect,
              label: 'Completed (Correct)',
            );
          } else if (calculatedResult == 'missed') {
            return const StatusChip(
              variant: StatusChipVariant.completedMissed,
              label: 'Completed (Missed)',
            );
          } else {
            return const StatusChip(
              variant: StatusChipVariant.completedCorrect,
              label: 'Completed',
            );
          }
        }
      } else {
        // No prediction for finished match
        return const StatusChip(
          variant: StatusChipVariant.completedCorrect,
          label: 'Completed',
        );
      }
    }

    // For upcoming/live matches, use userPick
    switch (config.userPick) {
      case MatchCardUserPick.correct:
        return const StatusChip(
          variant: StatusChipVariant.completedCorrect,
          label: 'Completed (Correct)',
        );
      case MatchCardUserPick.missed:
        return const StatusChip(
          variant: StatusChipVariant.completedMissed,
          label: 'Completed (Missed)',
        );
      case MatchCardUserPick.predicted:
        return const StatusChip(
          variant: StatusChipVariant.predicted,
          label: 'Prediction made',
        );
      case MatchCardUserPick.finished:
        return const StatusChip(
          variant: StatusChipVariant.completedCorrect,
          label: 'Completed',
        );
      case MatchCardUserPick.none:
        return StatusChip(
          variant: StatusChipVariant.upcoming,
          label: config.state == MatchCardState.live ? 'Live' : 'Upcoming',
        );
    }
  }

  String? _calculatePredictionResult() {
    if (config.prediction == null) return null;

    final match = config.match;
    final homeGoals = match.goalsHome;
    final awayGoals = match.goalsAway;

    if (homeGoals == null || awayGoals == null) return null;

    final actualWinner = homeGoals > awayGoals
        ? 'home'
        : homeGoals < awayGoals
        ? 'away'
        : 'draw';

    final prediction = config.prediction!.pick.toLowerCase();
    return prediction == actualWinner ? 'correct' : 'missed';
  }

  List<CardAction> _buildActions() {
    final actions = <CardAction>[];
    switch (config.state) {
      case MatchCardState.upcoming:
      case MatchCardState.live:
        if (config.userPick == MatchCardUserPick.none) {
          actions.add(
            CardAction(
              label: 'Make Prediction',
              variant: CardCtaVariant.primary,
              onPressed: onMakePrediction,
              enabled: onMakePrediction != null,
              icon: AppIcons.actionTrendingUp,
            ),
          );
        } else {
          actions.add(
            CardAction(
              label: 'Open Match',
              variant: CardCtaVariant.primary,
              onPressed: onOpenMatch,
              enabled: onOpenMatch != null,
              icon: AppIcons.actionOpenInNew,
            ),
          );
        }
      case MatchCardState.finished:
        actions.add(
          CardAction(
            label: 'Open Match',
            variant: CardCtaVariant.primary,
            onPressed: onOpenMatch,
            enabled: onOpenMatch != null,
            icon: AppIcons.actionOpenInNew,
          ),
        );
    }
    return actions;
  }

  double _paddingForDensity() {
    switch (config.density) {
      case MatchCardDensity.compact:
        return AppSpacing.sm;
      case MatchCardDensity.regular:
        return AppSpacing.md;
      case MatchCardDensity.expanded:
        return AppSpacing.lg;
    }
  }

  bool _shouldShowExpandToggle() =>
      config.density == MatchCardDensity.expanded && onExpandToggle != null;
}

String _formatPick(String pick) {
  switch (pick.toLowerCase()) {
    case 'home':
      return 'Home Win';
    case 'draw':
      return 'Draw';
    case 'away':
      return 'Away Win';
    default:
      return pick;
  }
}

String _formatTime(DateTime dateTime) =>
    '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

String _formatDate(DateTime dateTime) {
  const monthNames = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  final month = monthNames[dateTime.month - 1];
  return '$month ${dateTime.day.toString().padLeft(2, '0')}';
}
