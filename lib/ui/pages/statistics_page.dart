// path: lib/ui/pages/statistics_page.dart
// Statistics page with summary metrics, charts, and achievements per PRD.
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_routes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/providers/statistics_provider.dart';
import 'package:FlutterApp/providers/user_profile_provider.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:FlutterApp/ui/widgets/buttons/danger_red_button.dart';
import 'package:FlutterApp/ui/widgets/buttons/translucent_tinted_button.dart';
import 'package:FlutterApp/ui/widgets/common/app_bar_actions.dart';
import 'package:FlutterApp/ui/widgets/profile/detailed_stats.dart';
import 'package:FlutterApp/ui/widgets/profile/reset_confirmation_dialog.dart';
import 'package:FlutterApp/ui/widgets/profile/summary_stats.dart';
import 'package:FlutterApp/ui/widgets/stats/bar_chart.dart';
import 'package:FlutterApp/ui/widgets/stats/donut_chart.dart';
import 'package:FlutterApp/ui/widgets/stats/line_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<StatisticsProvider>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Consumer<StatisticsProvider>(
      builder: (context, provider, child) {
        if (provider.state.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (provider.state.error != null) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${provider.state.error}',
                    style: theme.bodyMedium?.copyWith(
                      color: AppColors.errorRed,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.load(),
                    child: const Text(AppStrings.retry),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: Insets.hMd,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  const SliverToBoxAdapter(
                    child: AppBarActions(
                      title: AppStrings.statisticsTitle,
                      showLeft: false,
                      showRight: false,
                      isRootTab: true,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.statisticsSummaryMetrics,
                          style: theme.titleLarge?.copyWith(
                            color: AppColors.textWhite,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gaps.hLg,
                        // Detailed stats section
                        DetailedStats(
                          total: provider.state.summary.total,
                          accuracy: provider.state.summary.accuracyPct,
                          correct: provider.state.summary.correct,
                          missed: provider.state.summary.missed,
                          avgOdds: provider.state.summary.averageOdds,
                          predictionsPerWeek:
                              provider.state.summary.averagePerWeek,
                        ),
                        Gaps.hLg,

                        // Outcomes Predicted section
                        Text(
                          AppStrings.statisticsOutcomesPredicted,
                          style: theme.titleLarge?.copyWith(
                            color: AppColors.textWhite,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gaps.hLg,
                        StatsDonutChart(
                          data: provider.state.outcomeDistribution,
                          legend: const [
                            DonutLegendItem(
                              label: AppStrings.statisticsHomeWin,
                              color: AppColors.accentBlue,
                            ),
                            DonutLegendItem(
                              label: AppStrings.statisticsDraw,
                              color: AppColors.errorRed,
                            ),
                            DonutLegendItem(
                              label: AppStrings.statisticsAwayWin,
                              color: AppColors.accentOrange,
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // Predictions by Weekday section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.statisticsPredictionsByWeekday,
                              style: theme.titleLarge?.copyWith(
                                color: AppColors.textWhite,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Gaps.hLg,
                            StatsBarChart(
                              data: provider.state.weekdayCounts,
                              xLabels: const [
                                'Mon',
                                'Tue',
                                'Wed',
                                'Thu',
                                'Fri',
                                'Sat',
                                'Sun',
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // Accuracy Trend section
                        Text(
                          AppStrings.statisticsAccuracyTrend,
                          style: theme.titleLarge?.copyWith(
                            color: AppColors.textWhite,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (provider.state.accuracyTrend.isNotEmpty)
                          StatsLineChart(
                            data: provider.state.accuracyTrend,
                            xLabels: _generateWeekLabels(
                              provider.state.accuracyTrend.length,
                            ),
                          )
                        else
                          Container(
                            height: 140,
                            padding: Insets.allMd,
                            decoration: const BoxDecoration(
                              color: AppColors.cardDark,
                              borderRadius: AppRadius.cardLg,
                            ),
                            child: Center(
                              child: Text(
                                'No finished matches yet',
                                style: theme.bodyMedium?.copyWith(
                                  color: AppColors.textGray,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 32),

                        // Achievements block
                        Text(
                          AppStrings.statisticsAchievementsBlock,
                          style: theme.titleLarge?.copyWith(
                            color: AppColors.textWhite,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SummaryStats(
                          wins: provider.state.wins,
                          perfectDays: provider.state.perfectDays,
                          predictions: provider.state.summary.total,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: TranslucentTintedButton(
                            label: AppStrings.statisticsViewAllAchievements,
                            color: AppColors.accentOrange,
                            onPressed: () async {
                              await Navigator.of(
                                context,
                              ).pushNamed(AppRoutes.achievements);
                            },
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Reset Stats button
                        SizedBox(
                          width: double.infinity,
                          child: DangerRedButton(
                            label: AppStrings.statisticsResetStats,
                            onPressed: () =>
                                _showResetConfirmationDialog(context),
                          ),
                        ),
                        Gaps.hLg,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<String> _generateWeekLabels(int dataLength) {
    final now = DateTime.now();
    final labels = <String>[];

    // Generate labels for last 4 weeks (including current)
    for (var i = 3; i >= 0; i--) {
      final weekDate = now.subtract(Duration(days: i * 7));
      final weekNumber = _getWeekNumber(weekDate);
      labels.add('Week $weekNumber');
    }

    return labels.take(dataLength).toList();
  }

  int _getWeekNumber(DateTime date) {
    final firstDayOfYear = DateTime(date.year);
    final dayOfYear = date.difference(firstDayOfYear).inDays + 1;
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  Future<void> _showResetConfirmationDialog(BuildContext context) async {
    final userProfileProvider = context.read<UserProfileProvider>();
    await showDialog<void>(
      context: context,
      builder: (context) => ResetConfirmationDialog(
        onStatsOnly: () async {
          Navigator.of(context).pop();
          await userProfileProvider.resetStatisticsOnly();
        },
        onAllData: () async {
          Navigator.of(context).pop();
          await userProfileProvider.resetAllData();
        },
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }
}
