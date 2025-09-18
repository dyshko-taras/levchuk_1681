// path: lib/ui/widgets/matches/match_card.dart
// Upgraded visuals to align with MatchCard PRD variants.
import 'package:FlutterApp/constants/app_icons.dart';
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/data/models/fixture.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MatchCard extends StatefulWidget {
  const MatchCard({
    required this.fixture,
    super.key,
    this.onTap,
  });

  final Fixture fixture;
  final VoidCallback? onTap;

  @override
  State<MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {
  bool _fav = false;

  @override
  Widget build(BuildContext context) {
    final fx = widget.fixture;
    final theme = Theme.of(context);
    final isFinished = fx.goalsHome != null && fx.goalsAway != null;
    final kickoff = fx.dateUtc.toLocal();
    final kickoffTime =
        '${kickoff.hour.toString().padLeft(2, '0')}:${kickoff.minute.toString().padLeft(2, '0')}';
    final kickoffDate = _monDay(kickoff);
    final score = '${fx.goalsHome ?? '-'}-${fx.goalsAway ?? '-'}';

    return Material(
      color: AppColors.cardDark,
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.cardLg),
      child: InkWell(
        borderRadius: AppRadius.cardLg,
        onTap: widget.onTap,
        child: Padding(
          padding: Insets.allMd,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.leagueBall,
                    width: AppSizes.iconSm,
                    height: AppSizes.iconSm,
                  ),
                  Gaps.wSm,
                  Expanded(
                    child: Text(
                      fx.leagueName,
                      style: theme.textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Favorite',
                    onPressed: () => setState(() => _fav = !_fav),
                    icon: SvgPicture.asset(
                      _fav ? AppIcons.starFilled : AppIcons.star,
                    ),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
              Gaps.hSm,
              Row(
                children: [
                  Expanded(child: _TeamPill(name: fx.homeTeam.name)),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                    ),
                    child: Column(
                      children: [
                        Text(
                          isFinished ? score : kickoffTime,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleSmall,
                        ),
                        if (!isFinished)
                          Text(
                            kickoffDate,
                            style: theme.textTheme.bodySmall,
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: _TeamPill(name: fx.awayTeam.name, alignEnd: true),
                  ),
                ],
              ),
              Gaps.hSm,
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _OddsText(label: 'Home Win', value: '--'),
                  _OddsText(label: 'Draw', value: '--'),
                  _OddsText(label: 'Away Win', value: '--'),
                ],
              ),
              Gaps.hSm,
              _CtaBar(
                text: isFinished ? 'Completed' : 'Prediction made',
                type: isFinished
                    ? _CtaType.finishedNeutral
                    : _CtaType.predictionMade,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _monDay(DateTime d) {
    const months = [
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
    return '${months[d.month - 1]} ${d.day}';
  }
}

class _TeamPill extends StatelessWidget {
  const _TeamPill({required this.name, this.alignEnd = false});
  final String name;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: const ShapeDecoration(
        color: AppColors.primaryBlack,
        shape: StadiumBorder(),
      ),
      alignment: alignEnd ? Alignment.centerRight : Alignment.centerLeft,
      child: Text(
        name,
        style: theme.textTheme.titleSmall,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _OddsText extends StatelessWidget {
  const _OddsText({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RichText(
      text: TextSpan(
        text: '$label: ',
        style: theme.textTheme.bodySmall,
        children: [
          TextSpan(
            text: value,
            style: theme.textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

enum _CtaType { predictionMade, finishedNeutral }

class _CtaBar extends StatelessWidget {
  const _CtaBar({required this.text, required this.type});
  final String text;
  final _CtaType type;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = type == _CtaType.predictionMade
        ? AppColors.successGreen.withValues(alpha: 0.18)
        : AppColors.textGray.withValues(alpha: 0.18);
    final fg = type == _CtaType.predictionMade
        ? AppColors.successGreen
        : AppColors.textWhite;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppRadius.cardLg,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: theme.textTheme.labelMedium!.copyWith(color: fg),
      ),
    );
  }
}
