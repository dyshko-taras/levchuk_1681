// path: lib/ui/pages/favorites_page.dart
import 'package:FlutterApp/constants/app_routes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/data/models/favorite.dart';
import 'package:FlutterApp/data/models/fixture.dart';
import 'package:FlutterApp/data/models/prediction.dart';
import 'package:FlutterApp/providers/favorites_provider.dart';
import 'package:FlutterApp/ui/widgets/common/app_bar_actions.dart';
import 'package:FlutterApp/ui/widgets/common/segmented_tabs.dart';
import 'package:FlutterApp/ui/widgets/favorites/favorites_empty_state.dart';
import 'package:FlutterApp/ui/widgets/favorites/league_card.dart';
import 'package:FlutterApp/ui/widgets/favorites/team_card.dart';
import 'package:FlutterApp/ui/widgets/match/match_card.dart';
import 'package:FlutterApp/ui/widgets/match/match_card_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<FavoritesProvider>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, provider, child) {
        if (provider.state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.state.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error: ${provider.state.error}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => provider.load(),
                  child: const Text(AppStrings.retry),
                ),
              ],
            ),
          );
        }

        return SafeArea(
          child: Padding(
            padding: Insets.allMd,
            child: CustomScrollView(
              slivers: [
                // AppBarActions
                const SliverToBoxAdapter(
                  child: AppBarActions(
                    title: AppStrings.favoritesTitle,
                    showLeft: false,
                    showRight: false,
                    isRootTab: true,
                  ),
                ),

                // Segmented tabs
                SliverToBoxAdapter(
                  child: SegmentedTabs(
                    items: const [
                      SegmentedTabItem(
                        id: 'matches',
                        label: AppStrings.favoritesTabMatches,
                      ),
                      SegmentedTabItem(
                        id: 'teams',
                        label: AppStrings.favoritesTabTeams,
                      ),
                      SegmentedTabItem(
                        id: 'leagues',
                        label: AppStrings.favoritesTabLeagues,
                      ),
                    ],
                    selectedId: provider.state.activeTab.name,
                    onChange: (tabId) {
                      final type = FavoriteType.values.firstWhere(
                        (type) => type.name == tabId,
                      );
                      provider.selectTab(type);
                    },
                  ),
                ),

                // Content based on active tab
                if (provider.items.isEmpty)
                  SliverFillRemaining(
                    child: FavoritesEmptyState(
                      onGoToMatches: () async {
                        await Navigator.pushNamed(
                          context,
                          AppRoutes.matches,
                        );
                      },
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = provider.items[index];
                        return Padding(
                          padding: Insets.vMd,
                          child: _buildItemCard(context, provider, item),
                        );
                      },
                      childCount: provider.items.length,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildItemCard(
    BuildContext context,
    FavoritesProvider provider,
    Favorite item,
  ) {
    switch (item.type) {
      case FavoriteType.leagues:
        return FutureBuilder(
          future: provider.loadLeague(item.refId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final league = snapshot.data!;
              return FutureBuilder<int>(
                future: provider.matchesToday(item.refId),
                builder: (context, mSnap) {
                  final count = mSnap.data ?? 0;
                  return LeagueCard(
                    leagueId: item.refId,
                    name: league.name,
                    country: league.country ?? 'Unknown',
                    matchesToday: count,
                    isFavorite: true,
                    onViewMatches: () async {
                      await Navigator.pushNamed(
                        context,
                        AppRoutes.matches, //TODO
                      );
                    },
                    onToggleFavorite: () => provider.toggleFavorite(
                      FavoriteType.leagues,
                      item.refId,
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        );

      case FavoriteType.teams:
        return FutureBuilder(
          future: provider.loadTeam(teamId: item.refId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final team = snapshot.data!;
              return FutureBuilder<Fixture?>(
                future: provider.lastMatchForTeam(item.refId),
                builder: (context, mSnap) {
                  var subtitle1 = '';
                  var subtitle2 = '';
                  if (mSnap.hasData && mSnap.data != null) {
                    final homeTeam = mSnap.data!.homeTeam;
                    final awayTeam = mSnap.data!.awayTeam;
                    subtitle1 = mSnap.data!.leagueName;
                    subtitle2 = team.id == homeTeam.id
                        ? 'vs ${awayTeam.name}'
                        : 'vs ${homeTeam.name}';
                  }
                  return TeamCard(
                    teamId: item.refId,
                    name: team.name,
                    subtitle1: subtitle1,
                    subtitle2: subtitle2,
                    isFavorite: true,
                    logoAssetConst: team.logo,
                    action: TeamCardAction(
                      label: AppStrings.favoritesOpenMatch,
                      onPressed: () {
                        if (mSnap.hasData && mSnap.data != null) {
                          Navigator.of(context).pushNamed(
                            AppRoutes.matchDetails(mSnap.data!.fixtureId),
                          );
                        }
                      },
                    ),
                    onToggleFavorite: () => provider.toggleFavorite(
                      FavoriteType.teams,
                      item.refId,
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        );

      case FavoriteType.matches:
        return FutureBuilder(
          future: provider.loadMatch(item.refId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final match = snapshot.data!;
              final config = _buildConfig(match, provider);
              return MatchCard(
                config: config,
                onOpenMatch: () => Navigator.of(context).pushNamed(
                  AppRoutes.matchDetails(match.fixtureId),
                ),
                onMakePrediction: () => Navigator.of(context).pushNamed(
                  AppRoutes.matchDetails(match.fixtureId),
                ),
                onToggleFavorite: () => provider.toggleFavorite(
                  FavoriteType.matches,
                  item.refId,
                ),
              );
            }
            return const SizedBox.shrink();
          },
        );
    }
  }
}

MatchCardConfig _buildConfig(
  Fixture fixture,
  FavoritesProvider provider,
) {
  final prediction = provider.predictionForFixture(fixture.fixtureId);
  final state = _mapStatus(fixture.status);
  final userPick = _mapUserPick(prediction, fixture.status);
  return MatchCardConfig(
    match: fixture,
    context: MatchCardContext.favorites,
    density: MatchCardDensity.regular,
    state: state,
    userPick: userPick,
    isFavorite: true,
    isExpanded: false,
    // prediction: prediction,
  );
}

MatchCardState _mapStatus(String status) {
  final normalized = status.toUpperCase();
  const finished = {'FT', 'AET', 'PEN'};
  const live = {'1H', '2H', 'ET', 'P', 'LIVE'};
  if (finished.contains(normalized)) {
    return MatchCardState.finished;
  }
  if (live.contains(normalized)) {
    return MatchCardState.live;
  }
  return MatchCardState.upcoming;
}

MatchCardUserPick _mapUserPick(Prediction? prediction, String status) {
  final normalized = status.toUpperCase();
  const finished = {'FT', 'AET', 'PEN'};
  if (prediction == null) {
    if (finished.contains(normalized)) {
      return MatchCardUserPick.finished;
    }
    return MatchCardUserPick.none;
  }
  final result = prediction.result?.toLowerCase();
  if (result == 'correct') {
    return MatchCardUserPick.correct;
  }
  if (result == 'missed') {
    return MatchCardUserPick.missed;
  }
  return MatchCardUserPick.predicted;
}
