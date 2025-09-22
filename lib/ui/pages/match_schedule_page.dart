// path: lib/ui/pages/match_schedule_page.dart
import 'package:FlutterApp/constants/app_icons.dart';
import 'package:FlutterApp/constants/app_routes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/data/models/fixture.dart';
import 'package:FlutterApp/data/models/prediction.dart';
import 'package:FlutterApp/providers/matches_provider.dart';
import 'package:FlutterApp/ui/widgets/common/app_bar_actions.dart';
import 'package:FlutterApp/ui/widgets/common/empty_view.dart';
import 'package:FlutterApp/ui/widgets/common/error_view.dart';
import 'package:FlutterApp/ui/widgets/common/segmented_tabs.dart';
import 'package:FlutterApp/ui/widgets/match/match_card.dart';
import 'package:FlutterApp/ui/widgets/match/match_card_config.dart';
import 'package:FlutterApp/ui/widgets/match/parts/card_cta.dart';
import 'package:FlutterApp/ui/widgets/schedule/counters_triple.dart';
import 'package:FlutterApp/ui/widgets/schedule/filters_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const List<FilterOption<int>> _leagueOptions = <FilterOption<int>>[
  FilterOption(value: 39, label: AppStrings.leaguePremierLeague),
  FilterOption(value: 140, label: AppStrings.leagueLaLiga),
  FilterOption(value: 78, label: AppStrings.leagueBundesliga),
  FilterOption(value: 2, label: AppStrings.leagueUcl),
  FilterOption(value: 135, label: AppStrings.leagueSerieA),
  FilterOption(value: 61, label: AppStrings.leagueLigue1),
];

const Set<int> _allowedLeagueIds = <int>{39, 140, 78, 2, 135, 61};

const List<FilterOption<String>> _countryOptions = <FilterOption<String>>[
  FilterOption(
    value: AppStrings.countryEngland,
    label: AppStrings.countryEngland,
  ),
  FilterOption(value: AppStrings.countrySpain, label: AppStrings.countrySpain),
  FilterOption(
    value: AppStrings.countryGermany,
    label: AppStrings.countryGermany,
  ),
  FilterOption(
    value: AppStrings.countryFrance,
    label: AppStrings.countryFrance,
  ),
  FilterOption(value: AppStrings.countryItaly, label: AppStrings.countryItaly),
  FilterOption(
    value: AppStrings.countryUkraine,
    label: AppStrings.countryUkraine,
  ),
];

const Set<String> _allowedCountryValues = <String>{
  AppStrings.countryEngland,
  AppStrings.countrySpain,
  AppStrings.countryGermany,
  AppStrings.countryFrance,
  AppStrings.countryItaly,
  AppStrings.countryUkraine,
};

class MatchSchedulePage extends StatelessWidget {
  const MatchSchedulePage({super.key});
  @override
  Widget build(BuildContext context) => const _MatchScheduleView();
}

class _MatchScheduleView extends StatefulWidget {
  const _MatchScheduleView();
  @override
  State<_MatchScheduleView> createState() => _MatchScheduleViewState();
}

class _MatchScheduleViewState extends State<_MatchScheduleView> {
  @override
  Widget build(BuildContext context) {
    final matchesProvider = context.watch<MatchesProvider>();
    final state = matchesProvider.state;
    final slivers = <Widget>[
      SliverToBoxAdapter(
        child: _Header(
          state: state,
          onDaySelected: matchesProvider.selectDay,
          onFilterTap: () => _openFilters(context, matchesProvider),
          filtersActive: !state.filters.isEmpty,
        ),
      ),
    ];
    if (state.isLoading) {
      slivers.add(
        const SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    } else if (state.error != null) {
      slivers.add(
        SliverFillRemaining(
          hasScrollBody: false,
          child: ErrorView(
            message: state.error!,
            onRetry: matchesProvider.load,
          ),
        ),
      );
    } else if (state.items.isEmpty) {
      slivers.add(
        const SliverFillRemaining(
          hasScrollBody: false,
          child: EmptyView(
            title: AppStrings.matchScheduleEmptyTitle,
            subtitle: AppStrings.matchScheduleEmpty,
          ),
        ),
      );
    } else {
      slivers.add(
        SliverList.builder(
          itemCount: state.items.length,
          itemBuilder: (context, index) {
            final fixture = state.items[index];
            final config = _buildConfig(fixture, matchesProvider);
            return Padding(
              padding: Insets.vMd,
              child: MatchCard(
                config: config,
                onOpenMatch: () => _openMatch(context, fixture.fixtureId),
                onMakePrediction: () => _openMatch(context, fixture.fixtureId),
                onToggleFavorite: () =>
                    matchesProvider.toggleFavorite(fixture.fixtureId),
              ),
            );
          },
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: matchesProvider.refresh,
      child: SafeArea(
        child: Padding(
          padding: Insets.hMd,
          child: CustomScrollView(slivers: slivers),
        ),
      ),
    );
  }

  Future<void> _openFilters(
    BuildContext context,
    MatchesProvider provider,
  ) async {
    const leagues = _leagueOptions;
    const countries = _countryOptions;
    final statusOptions = provider.availableStatuses.toSet();
    final statuses = statusOptions.toList()..sort((a, b) => a.compareTo(b));
    final filterState = provider.filters;
    final initial = ScheduleFilterValue(
      leagues: filterState.leagueIds.where(_allowedLeagueIds.contains).toSet(),
      countries: filterState.countries
          .where(_allowedCountryValues.contains)
          .toSet(),
      statuses: filterState.statuses.where(statusOptions.contains).toSet(),
      favoritesOnly: filterState.favoritesOnly,
    );
    final result = await showScheduleFiltersSheet(
      context: context,
      initialValue: initial,
      leagues: leagues,
      countries: countries,
      statuses: statuses
          .map((status) => FilterOption<String>(value: status, label: status))
          .toList(),
    );
    if (result != null) {
      provider.updateFilters(
        MatchesFilters(
          leagueIds: result.leagues,
          countries: result.countries,
          statuses: result.statuses,
          favoritesOnly: result.favoritesOnly,
        ),
      );
    }
  }

  Future<void> _openMatch(BuildContext context, int fixtureId) async {
    await Navigator.of(context).pushNamed(AppRoutes.matchDetails(fixtureId));
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.state,
    required this.onDaySelected,
    required this.onFilterTap,
    required this.filtersActive,
  });
  final MatchesState state;
  final ValueChanged<String> onDaySelected;
  final VoidCallback onFilterTap;
  final bool filtersActive;
  @override
  Widget build(BuildContext context) {
    final filterLabel = filtersActive
        ? AppStrings.matchScheduleFilterActive
        : AppStrings.matchScheduleFilter;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppBarActions(
          title: AppStrings.matchScheduleTitle,
          showLeft: false,
          showRight: false,
        ),
        Gaps.hMd,
        SegmentedTabs(
          items: const [
            SegmentedTabItem(
              id: 'yesterday',
              label: AppStrings.matchScheduleSegmentYesterday,
            ),
            SegmentedTabItem(
              id: 'today',
              label: AppStrings.matchScheduleSegmentToday,
            ),
            SegmentedTabItem(
              id: 'tomorrow',
              label: AppStrings.matchScheduleSegmentTomorrow,
            ),
          ],
          selectedId: state.selectedDayId,
          onChange: onDaySelected,
          size: SegmentedTabsSize.md,
        ),
        Gaps.hLg,
        CountersTriple(
          predicted: state.predicted,
          upcoming: state.upcoming,
          completed: state.completed,
        ),
        Gaps.hLg,
        SizedBox(
          width: double.infinity,
          child: CardCTA(
            label: filterLabel,
            variant: CardCtaVariant.primary,
            onPressed: onFilterTap,
            leadingIcon: AppIcons.actionFilter,
          ),
        ),
      ],
    );
  }
}

MatchCardConfig _buildConfig(
  Fixture fixture,
  MatchesProvider provider,
) {
  final prediction = provider.predictionForFixture(fixture.fixtureId);
  final state = _mapStatus(fixture.status);
  final userPick = _mapUserPick(prediction, fixture.status);
  final isFavorite = provider.isFavorite(fixture.fixtureId);
  return MatchCardConfig(
    match: fixture,
    context: MatchCardContext.schedule,
    density: MatchCardDensity.regular,
    state: state,
    userPick: userPick,
    isFavorite: isFavorite,
    isExpanded: false,
    prediction: prediction,
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
