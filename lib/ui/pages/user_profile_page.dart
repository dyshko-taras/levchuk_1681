// path: lib/ui/pages/user_profile_page.dart
// User profile page WITHOUT Scaffold; proper paddings; fill missing data.

import 'package:FlutterApp/constants/app_routes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/providers/user_profile_provider.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:FlutterApp/ui/widgets/common/app_bar_actions.dart';
import 'package:FlutterApp/ui/widgets/profile/action_buttons.dart';
import 'package:FlutterApp/ui/widgets/profile/avatar_modal.dart';
import 'package:FlutterApp/ui/widgets/profile/detailed_stats.dart';
import 'package:FlutterApp/ui/widgets/profile/profile_header.dart';
import 'package:FlutterApp/ui/widgets/profile/recent_predictions.dart';
import 'package:FlutterApp/ui/widgets/profile/reset_confirmation_dialog.dart';
import 'package:FlutterApp/ui/widgets/profile/summary_stats.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProfileProvider>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Consumer<UserProfileProvider>(
      builder: (context, provider, child) {
        if (provider.state.isLoading) {
          return const SafeArea(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (provider.state.error != null) {
          return SafeArea(
            child: Center(
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

        final profile = provider.state.profile;
        if (profile == null) {
          return const SafeArea(
            child: Center(child: Text('No profile data available')),
          );
        }

        // ---- Derived/missing data ----
        final stats = provider.state.statistics;
        final wins = stats.correct; // використовуємо кількість вірних як 'Wins'
        final perfectDays =
            provider.state.earnedBadges; // тимчасово: бейджі як "Perfect Days"
        final avgOdds = _avgOdds(provider.state.recentPredictions);
        final predsPerWeek = _predictionsPerWeek(
          total: stats.total,
          recent: provider.state.recentPredictions,
        );

        return SafeArea(
          child: Padding(
            padding: Insets.hMd,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(
                  child: AppBarActions(
                    title: AppStrings.profileTitle,
                    showLeft: false,
                    showRight: false,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      // Header
                      ProfileHeader(
                        username: profile.username.isNotEmpty
                            ? profile.username
                            : 'User',
                        avatarId: profile.avatarId,
                        onEditProfile: () => _showAvatarModal(provider),
                      ),
                      Gaps.hLg,

                      // Summary stats
                      SummaryStats(
                        wins: wins,
                        perfectDays: perfectDays,
                        predictions: stats.total,
                      ),
                      Gaps.hLg,

                      // Detailed stats (4 колонки + 2 широкі)
                      DetailedStats(
                        total: stats.total,
                        accuracy: stats.accuracyPct,
                        correct: stats.correct,
                        missed: stats.missed,
                        avgOdds: avgOdds,
                        predictionsPerWeek: predsPerWeek,
                      ),
                      Gaps.hLg,

                      // Recent predictions
                      RecentPredictions(
                        predictions: provider.state.recentPredictions,
                      ),
                      Gaps.hLg,

                      // Action buttons
                      ActionButtons(
                        onViewStatistics: () async {
                          await Navigator.pushNamed(context, AppRoutes.stats);
                        },
                        onViewPredictions: () async {
                          await Navigator.pushNamed(
                            context,
                            AppRoutes.myPredictions,
                          );
                        },
                        onViewFavorites: () async {
                          await Navigator.pushNamed(
                            context,
                            AppRoutes.favorites,
                          );
                        },
                        onOpenJournal: () async {
                          await Navigator.pushNamed(context, AppRoutes.journal);
                        },
                        onOpenInsights: () async {
                          await Navigator.pushNamed(
                            context,
                            AppRoutes.insights,
                          );
                        },
                        onResetStats: () =>
                            _showResetConfirmationDialog(provider),
                      ),
                      Gaps.hLg,
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAvatarModal(UserProfileProvider provider) {
    final profile = provider.state.profile;
    if (profile == null) return;

    showDialog<void>(
      context: context,
      builder: (context) => AvatarModal(
        currentAvatarId: profile.avatarId,
        currentName: profile.username.isNotEmpty ? profile.username : '',
        onSave: (name, avatarId) {
          provider.updateProfile(
            username: name.isNotEmpty ? name : null,
            avatarId: avatarId,
          );
          Navigator.of(context).pop();
        },
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }

  void _showResetConfirmationDialog(UserProfileProvider provider) {
    showDialog<void>(
      context: context,
      builder: (context) => ResetConfirmationDialog(
        onStatsOnly: () async {
          Navigator.of(context).pop();
          await provider.resetStatisticsOnly();
        },
        onAllData: () async {
          Navigator.of(context).pop();
          await provider.resetAllData();
        },
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }
}

// ---- helpers to derive missing values on the fly ---------------------------

double _avgOdds(List<RecentPredictionInfo> items) {
  final odds = items
      .map((e) => e.prediction.odds)
      .where((v) => v != null)
      .cast<double>()
      .toList();
  if (odds.isEmpty) return 0;
  final sum = odds.fold<double>(0, (a, b) => a + b);
  return sum / odds.length;
}

/// Estimate predictions/week.
/// If we have at least 2 recent predictions, use their time span to estimate a rate,
/// otherwise fall back to a simple heuristic based on total over 4 weeks.
double _predictionsPerWeek({
  required int total,
  required List<RecentPredictionInfo> recent,
}) {
  if (recent.length >= 2) {
    recent.sort((a, b) => a.prediction.madeAt.compareTo(b.prediction.madeAt));
    final first = recent.first.prediction.madeAt;
    final last = recent.last.prediction.madeAt;
    final days = last.difference(first).inDays.abs().clamp(1, 365);
    final weeks = days / 7.0;
    final rateRecent = recent.length / weeks;
    // scale to overall total loosely if recent span < 2 weeks
    if (weeks < 2 && total > recent.length) {
      return (rateRecent + (total / 8.0)) / 2.0;
    }
    return rateRecent;
  }
  // fallback heuristic: spread total across ~8 weeks if we don't have timestamps
  if (total == 0) return 0;
  return total / 8.0;
}
