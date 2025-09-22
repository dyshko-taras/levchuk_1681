import 'package:FlutterApp/constants/app_icons.dart';
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:FlutterApp/ui/widgets/match/parts/card_cta.dart';
import 'package:FlutterApp/ui/widgets/match/parts/team_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TeamCard extends StatelessWidget {
  const TeamCard({
    required this.teamId,
    required this.name,
    required this.subtitle1,
    required this.subtitle2,
    required this.isFavorite,
    required this.action,
    required this.onToggleFavorite,
    super.key,
    this.logoAssetConst,
  });

  final int teamId;
  final String name;
  final String subtitle1;
  final String subtitle2;
  final String? logoAssetConst;
  final bool isFavorite;
  final TeamCardAction action;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      padding: Insets.allMd,
      decoration: const BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: AppRadius.cardLg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TeamBadge(
                logoUrl: logoAssetConst,
              ),
              Gaps.wMd,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: theme.titleMedium?.copyWith(
                        color: AppColors.textWhite,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gaps.hXs,
                    Row(
                      children: [
                        Text(
                          'League: ',
                          style: theme.bodySmall?.copyWith(
                            color: AppColors.textGray,
                          ),
                        ),
                        Gaps.wXs,
                        Text(
                          subtitle1,
                          style: theme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Gaps.hXs,
                    Row(
                      children: [
                        Text(
                          'Next match: ',
                          style: theme.bodySmall?.copyWith(
                            color: AppColors.textGray,
                          ),
                        ),
                        Gaps.wXs,
                        Text(
                          subtitle2,
                          style: theme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onToggleFavorite,
                icon: SvgPicture.asset(
                  isFavorite ? AppIcons.starFilled : AppIcons.star,
                  width: AppSizes.iconSm,
                  height: AppSizes.iconSm,
                  colorFilter: ColorFilter.mode(
                    isFavorite ? AppColors.warningYellow : AppColors.textGray,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
          Gaps.hMd,
          SizedBox(
            width: double.infinity,
            child: CardCTA(
              label: action.label,
              onPressed: action.onPressed,
              variant: CardCtaVariant.primary,
              leadingIcon: AppIcons.actionOpenInNew,
            ),
          ),
        ],
      ),
    );
  }
}

class TeamCardAction {
  const TeamCardAction({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;
}
