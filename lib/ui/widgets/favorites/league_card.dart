import 'package:FlutterApp/constants/app_icons.dart';
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:FlutterApp/ui/widgets/match/parts/card_cta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeagueCard extends StatelessWidget {
  const LeagueCard({
    required this.leagueId,
    required this.name,
    required this.country,
    required this.matchesToday,
    required this.isFavorite,
    required this.onViewMatches,
    required this.onToggleFavorite,
    super.key,
  });

  final int leagueId;
  final String name;
  final String country;
  final int matchesToday;
  final bool isFavorite;
  final VoidCallback onViewMatches;
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
              Container(
                width: AppSizes.teamBadge + 15,
                height: AppSizes.teamBadge + 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.textGray,
                  border: Border.all(
                    color: AppColors.borderGray,
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppIcons.league,
                  ),
                ),
              ),
              Gaps.wSm,
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
                          '${AppStrings.favoritesCountry}: ',
                          style: theme.bodySmall?.copyWith(
                            color: AppColors.textGray,
                          ),
                        ),
                        Gaps.wXs,
                        Text(
                          country,
                          style: theme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Gaps.hSm,
                    Row(
                      children: [
                        Text(
                          '${AppStrings.favoritesMatchesToday}: ',
                          style: theme.bodySmall?.copyWith(
                            color: AppColors.textGray,
                          ),
                        ),
                        Gaps.wXs,
                        Text(
                          '$matchesToday',
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
              label: AppStrings.favoritesViewMatches,
              onPressed: onViewMatches,
              variant: CardCtaVariant.primary,
              leadingIcon: AppIcons.actionBall,
            ),
          ),
        ],
      ),
    );
  }
}
