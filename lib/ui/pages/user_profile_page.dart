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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<UserProfileProvider>().load();
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
        final wins = stats.correct;
        final perfectDays = provider.state.earnedBadges;

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

                      DetailedStats(
                        total: stats.total,
                        accuracy: stats.accuracyPct,
                        correct: stats.correct,
                        missed: stats.missed,
                        avgOdds: stats.averageOdds,
                        predictionsPerWeek: stats.averagePerWeek,
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

  Future<void> _showAvatarModal(UserProfileProvider provider) async {
    final profile = provider.state.profile;
    if (profile == null) return;

    await showDialog<void>(
      context: context,
      builder: (context) => AvatarModal(
        currentAvatarId: profile.avatarId,
        currentName: profile.username.isNotEmpty ? profile.username : '',
        onSave: (name, avatarId) async {
          await provider.updateProfile(
            username: name.isNotEmpty ? name : null,
            avatarId: avatarId,
          );
          Navigator.of(context).pop();
        },
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }

  Future<void> _showResetConfirmationDialog(
    UserProfileProvider provider,
  ) async {
    await showDialog<void>(
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
