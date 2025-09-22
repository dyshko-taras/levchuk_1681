// path: lib/ui/pages/insights_page.dart
// Insights page showing personal trends, strengths/weaknesses, and actionable advice.
import 'package:FlutterApp/constants/app_icons.dart';
import 'package:FlutterApp/constants/app_routes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/providers/insights_provider.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:FlutterApp/ui/widgets/buttons/translucent_tinted_button.dart';
import 'package:FlutterApp/ui/widgets/common/app_bar_actions.dart';
import 'package:FlutterApp/ui/widgets/insights/advice_row.dart';
import 'package:FlutterApp/ui/widgets/insights/focus_point_card.dart';
import 'package:FlutterApp/ui/widgets/insights/metric_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InsightsPage extends StatefulWidget {
  const InsightsPage({super.key});

  @override
  State<InsightsPage> createState() => _InsightsPageState();
}

class _InsightsPageState extends State<InsightsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<InsightsProvider>().loadAndComputeInsights();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InsightsProvider>(
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
                        'Error loading insights',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Gaps.hMd,
                      ElevatedButton(
                        onPressed: () => provider.loadAndComputeInsights(),
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
                      title: AppStrings.insightsTitle,
                      showRight: false,
                      leftIcon: AppIcons.actionBack,
                      onLeft: () =>
                          Navigator.pushNamed(context, AppRoutes.profile),
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
                        // Your Trends section
                        Text(
                          'Your Trends',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: AppColors.textWhite,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Gaps.hMd,

                        // Trends grid (2x2)
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: AppSpacing.md,
                          mainAxisSpacing: AppSpacing.md,
                          childAspectRatio: 1.8,
                          children: [
                            MetricTile(
                              title: 'Home Wins',
                              value:
                                  '${state.pickAccuracy['home']?.toStringAsFixed(0) ?? '0'}%',
                            ),
                            MetricTile(
                              title: 'Draw accuracy',
                              value:
                                  '${state.pickAccuracy['draw']?.toStringAsFixed(0) ?? '0'}%',
                            ),
                            MetricTile(
                              title: 'Avg odds',
                              value: state.averageOdds.toStringAsFixed(2),
                            ),
                            MetricTile(
                              title: 'Most active',
                              value: state.mostActiveDay,
                            ),
                          ],
                        ),

                        Gaps.hLg,

                        // Focus Points section
                        Text(
                          'Focus Points',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: AppColors.textWhite,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Gaps.hMd,

                        // Strengths card
                        if (state.strengths.isNotEmpty)
                          FocusPointCard(
                            title: 'Strengths',
                            items: state.strengths,
                            isStrengths: true,
                          ),

                        if (state.strengths.isNotEmpty) Gaps.hMd,

                        // Weaknesses card
                        if (state.weaknesses.isNotEmpty)
                          FocusPointCard(
                            title: 'Weaknesses',
                            items: state.weaknesses,
                            isStrengths: false,
                          ),

                        Gaps.hLg,

                        // Advice section
                        Text(
                          'Advice',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: AppColors.textWhite,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Gaps.hMd,

                        // Advice list
                        if (state.advice.isNotEmpty)
                          Column(
                            children: state.advice
                                .map(
                                  (advice) => Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: AppSpacing.sm,
                                    ),
                                    child: AdviceRow(text: advice),
                                  ),
                                )
                                .toList(),
                          ),

                        Gaps.hLg,

                        // Improve Strategy button
                        SizedBox(
                          width: double.infinity,
                          child: TranslucentTintedButton(
                            label: 'Improve Strategy',
                            color: AppColors.successGreen,
                            onPressed: () async {
                              // Navigate to Statistics page
                              await Navigator.of(context).pushNamed('/stats');
                            },
                          ),
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
}
