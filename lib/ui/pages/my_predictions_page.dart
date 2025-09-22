// path: lib/ui/pages/my_predictions_page.dart
// My predictions page with paddings & scroll like MatchSchedulePage, using MatchCard + note.

import 'package:FlutterApp/constants/app_icons.dart';
import 'package:FlutterApp/constants/app_routes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/data/models/fixture.dart';
import 'package:FlutterApp/data/models/note.dart';
import 'package:FlutterApp/data/models/prediction.dart';
import 'package:FlutterApp/data/repositories/notes_repository.dart';
import 'package:FlutterApp/providers/my_predictions_provider.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:FlutterApp/ui/widgets/common/app_bar_actions.dart';
import 'package:FlutterApp/ui/widgets/match/match_card.dart';
import 'package:FlutterApp/ui/widgets/match/match_card_config.dart';
import 'package:FlutterApp/ui/widgets/predictions/predictions_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPredictionsPage extends StatefulWidget {
  const MyPredictionsPage({super.key});

  @override
  State<MyPredictionsPage> createState() => _MyPredictionsPageState();
}

class _MyPredictionsPageState extends State<MyPredictionsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyPredictionsProvider>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final provider = context.watch<MyPredictionsProvider>();
    final state = provider.state;

    final slivers = <Widget>[
      SliverToBoxAdapter(
        child: AppBarActions(
          title: AppStrings.myPredictionsTitle,
          showRight: false,
          leftIcon: AppIcons.actionBack,
          onLeft: () => Navigator.of(context).pushNamed(AppRoutes.matches),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error: ${state.error}',
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.errorRed,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: provider.load,
                child: const Text(AppStrings.retry),
              ),
            ],
          ),
        ),
      );
    } else if (state.items.isEmpty) {
      slivers.add(
        SliverFillRemaining(
          hasScrollBody: false,
          child: PredictionsEmptyState(
            onGoToMatches: () async {
              await Navigator.pushNamed(context, AppRoutes.matches);
            },
          ),
        ),
      );
    } else {
      slivers.add(
        SliverList.builder(
          itemCount: state.items.length,
          itemBuilder: (context, index) {
            final item = state.items[index];
            final fixture = item.fixture;
            if (fixture == null) return const SizedBox.shrink();

            return FutureBuilder<Note?>(
              future: context.read<NotesRepository>().getNote(
                item.prediction.fixtureId,
              ),
              builder: (context, snap) {
                final noteText = snap.data?.text;
                final config = _buildConfig(fixture, item, noteText);
                return Padding(
                  padding: Insets.vMd,
                  child: MatchCard(
                    config: config,
                    onOpenMatch: () => Navigator.of(context).pushNamed(
                      AppRoutes.matchDetails(item.prediction.fixtureId),
                    ),
                    onMakePrediction: () => Navigator.of(context).pushNamed(
                      AppRoutes.matchDetails(item.prediction.fixtureId),
                    ),
                    onToggleFavorite: () => provider.toggleFavorite(
                      item.prediction.fixtureId,
                    ),
                    onExpandToggle: () => provider.toggleFavorite(
                      item.prediction.fixtureId,
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: provider.refresh,
        child: SafeArea(
          child: Padding(
            padding: Insets.hMd,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: slivers,
            ),
          ),
        ),
      ),
    );
  }
}

// ---- helpers ---------------------------------------------------------------

MatchCardConfig _buildConfig(
  Fixture fixture,
  MyPredictionItem item, [
  String? noteText,
]) {
  final state = _mapStatus(fixture.status);
  final userPick = _mapUserPick(item.prediction, fixture.status);
  return MatchCardConfig(
    match: fixture,
    context: MatchCardContext.favorites,
    density: MatchCardDensity.regular,
    state: state,
    userPick: userPick,
    isFavorite: item.isFavorite,
    isExpanded: true,
    prediction: item.prediction,
    userNote: noteText,
  );
}

MatchCardState _mapStatus(String status) {
  final s = status.toUpperCase();
  const finished = {'FT', 'AET', 'PEN'};
  const live = {'1H', '2H', 'ET', 'P', 'LIVE'};
  if (finished.contains(s)) return MatchCardState.finished;
  if (live.contains(s)) return MatchCardState.live;
  return MatchCardState.upcoming;
}

MatchCardUserPick _mapUserPick(Prediction? prediction, String status) {
  final s = status.toUpperCase();
  const finished = {'FT', 'AET', 'PEN'};
  if (prediction == null) {
    return finished.contains(s)
        ? MatchCardUserPick.finished
        : MatchCardUserPick.none;
  }
  final result = prediction.result?.toLowerCase();
  if (result == 'correct') return MatchCardUserPick.correct;
  if (result == 'missed') return MatchCardUserPick.missed;
  return MatchCardUserPick.predicted;
}
