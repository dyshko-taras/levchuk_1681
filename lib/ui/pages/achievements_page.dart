// path: lib/ui/pages/achievements_page.dart
// Achievements page showing earned/locked achievements with progress summary.
import 'package:FlutterApp/constants/app_icons.dart';
import 'package:FlutterApp/constants/app_routes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/providers/achievements_provider.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:FlutterApp/ui/widgets/achievements/achievement_summary_card.dart';
import 'package:FlutterApp/ui/widgets/achievements/achievement_tile.dart';
import 'package:FlutterApp/ui/widgets/common/app_bar_actions.dart';
import 'package:FlutterApp/ui/widgets/common/empty_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({super.key});

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<AchievementsProvider>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AchievementsProvider>(
        builder: (context, provider, child) {
          final state = provider.state;

          final slivers = <Widget>[];

          if (state.isLoading) {
            slivers.add(
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.successGreen,
                  ),
                ),
              ),
            );
          } else if (state.error != null) {
            slivers.add(
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error loading achievements',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Gaps.hMd,
                      ElevatedButton(
                        onPressed: () => provider.load(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            // Header
            slivers
              ..add(
                SliverToBoxAdapter(
                  child: Padding(
                    padding: Insets.allMd,
                    child: AppBarActions(
                      title: AppStrings.achievementsTitle,
                      showRight: false,
                      leftIcon: AppIcons.actionBack,
                      onLeft: () =>
                          Navigator.of(context).pushNamed(AppRoutes.stats),
                    ),
                  ),
                ),
              )
              // Content
              ..add(
                SliverToBoxAdapter(
                  child: Padding(
                    padding: Insets.hMd,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Summary section title
                        Text(
                          'Summary section',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: AppColors.textWhite,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Gaps.hMd,

                        // Summary cards
                        Column(
                          children: [
                            // Total badges earned
                            AchievementSummaryCard(
                              icon: AppIcons.badgeGoldSummary,
                              value: state.earnedCount.toString(),
                              label: 'Total badges earned',
                              subtitle: '',
                            ),
                            Gaps.hSm,
                            // Next milestone
                            AchievementSummaryCard(
                              icon: AppIcons.milestoneTargetSummary,
                              value: _getNextMilestoneValue(state),
                              label: _getNextMilestoneLabel(state),
                              subtitle: 'Next milestone',
                            ),
                          ],
                        ),

                        Gaps.hLg,

                        // Achievements list title
                        Text(
                          'Achievements list',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: AppColors.textWhite,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Gaps.hMd,

                        // Achievements grid
                        if (state.achievements.isEmpty)
                          const EmptyView(
                            title: 'No achievements available',
                            subtitle:
                                'Achievements will appear here as you progress.',
                          )
                        else
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: AppSpacing.md,
                                  mainAxisSpacing: AppSpacing.md,
                                  childAspectRatio: 0.85,
                                ),
                            itemCount: state.achievements.length,
                            itemBuilder: (context, index) {
                              final achievement = state.achievements[index];
                              final isEarned = achievement.earnedAt != null;

                              return AchievementTile(
                                title: achievement.title,
                                subtitle: provider.getSubtitleForAchievement(
                                  achievement,
                                ),
                                isEarned: isEarned,
                                onTap: () => provider.onTileTap(achievement),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              )
              // Bottom spacing
              ..add(
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.lg),
                ),
              );
          }

          return SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: slivers,
            ),
          );
        },
      ),
    );
  }

  String _getNextMilestoneValue(AchievementsState state) {
    final nextMilestone = state.nextMilestone;
    if (nextMilestone == null) return '100';

    // Extract number from milestone titles
    if (nextMilestone.title.contains('25')) return '25';
    if (nextMilestone.title.contains('75')) return '75';
    if (nextMilestone.title.contains('100')) return '100';
    if (nextMilestone.title.contains('300')) return '300';

    return '100';
  }

  String _getNextMilestoneLabel(AchievementsState state) {
    final nextMilestone = state.nextMilestone;
    if (nextMilestone == null) return '100 Predictions Total';

    return nextMilestone.title;
  }
}
