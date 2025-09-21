// path: lib/ui/pages/match_details_page.dart
import 'dart:async';

import 'package:FlutterApp/constants/app_icons.dart';
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/data/models/fixture.dart';
import 'package:FlutterApp/data/models/odds_snapshot.dart';
import 'package:FlutterApp/data/models/prediction.dart';
import 'package:FlutterApp/data/repositories/favorites_repository.dart';
import 'package:FlutterApp/data/repositories/matches_repository.dart';
import 'package:FlutterApp/data/repositories/notes_repository.dart';
import 'package:FlutterApp/data/repositories/odds_repository.dart';
import 'package:FlutterApp/data/repositories/predictions_repository.dart';
import 'package:FlutterApp/providers/match_details_provider.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:FlutterApp/ui/widgets/buttons/primary_button.dart';
import 'package:FlutterApp/ui/widgets/buttons/secondary_green_button_light.dart';
import 'package:FlutterApp/ui/widgets/common/app_bar_actions.dart';
import 'package:FlutterApp/ui/widgets/common/empty_view.dart';
import 'package:FlutterApp/ui/widgets/common/error_view.dart';
import 'package:FlutterApp/ui/widgets/common/info_row.dart';
import 'package:FlutterApp/ui/widgets/common/segmented_tabs.dart';
import 'package:FlutterApp/ui/widgets/common/tab_switcher.dart';
import 'package:FlutterApp/ui/widgets/dialogs/add_to_favorites_dialog.dart';
import 'package:FlutterApp/ui/widgets/dialogs/prediction_dialog.dart';
import 'package:FlutterApp/ui/widgets/fields/notes_text_field.dart';
import 'package:FlutterApp/ui/widgets/match/match_card.dart';
import 'package:FlutterApp/ui/widgets/match/match_card_config.dart';
import 'package:FlutterApp/ui/widgets/match/parts/prediction_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MatchDetailsPage extends StatelessWidget {
  const MatchDetailsPage({required this.fixtureId, super.key});

  final int fixtureId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MatchDetailsProvider>(
      create: (context) => MatchDetailsProvider(
        matchesRepository: context.read<MatchesRepository>(),
        oddsRepository: context.read<OddsRepository>(),
        predictionsRepository: context.read<PredictionsRepository>(),
        favoritesRepository: context.read<FavoritesRepository>(),
        notesRepository: context.read<NotesRepository>(),
      )..load(fixtureId),
      child: _MatchDetailsView(fixtureId: fixtureId),
    );
  }
}

class _MatchDetailsView extends StatefulWidget {
  const _MatchDetailsView({required this.fixtureId});

  final int fixtureId;

  @override
  State<_MatchDetailsView> createState() => _MatchDetailsViewState();
}

class _MatchDetailsViewState extends State<_MatchDetailsView> {
  static const List<String> _tabs = <String>['info', 'prediction', 'notes'];
  static const Duration _noteDebounceDuration = Duration(milliseconds: 500);

  Timer? _noteDebounce;
  String? _latestNote;
  String? _lastError;

  @override
  void dispose() {
    _noteDebounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MatchDetailsProvider>(
      builder: (context, provider, _) {
        final state = provider.state;
        _latestNote ??= state.noteText;
        _maybeShowError(context, state.error);

        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                AppBarActions(
                  title: AppStrings.matchDetailsTitle,
                  leftIcon: AppIcons.actionBack,
                  rightIcon: state.isFavorite
                      ? AppIcons.starFilled
                      : AppIcons.star,
                  onLeft: () => Navigator.of(context).maybePop(),
                  onRight: () => _handleFavoriteTap(context, provider),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      _buildBody(context, provider, state),
                      if (state.isLoading && state.fixture != null)
                        const Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          child: LinearProgressIndicator(minHeight: 2),
                        ),
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

  Widget _buildBody(
    BuildContext context,
    MatchDetailsProvider provider,
    MatchDetailsState state,
  ) {
    if (state.isLoading && state.fixture == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.error != null && state.fixture == null) {
      return Center(
        child: ErrorView(
          message: state.error!,
          onRetry: () => provider.load(widget.fixtureId),
        ),
      );
    }

    final fixture = state.fixture;
    if (fixture == null) {
      return const EmptyView();
    }

    final config = _buildHeaderConfig(fixture, state);
    final tabIndex = _tabIndex(state.activeTabId);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.md,
          ),
          sliver: SliverToBoxAdapter(
            child: MatchCard(
              config: config,
              onMakePrediction: provider.canEditPrediction
                  ? () => _openPredictionDialog(context, provider)
                  : null,
              onToggleFavorite: provider.toggleFavorite,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SegmentedTabs(
                  items: const [
                    SegmentedTabItem(
                      id: 'info',
                      label: AppStrings.matchDetailsTabInfo,
                    ),
                    SegmentedTabItem(
                      id: 'prediction',
                      label: AppStrings.matchDetailsTabPrediction,
                    ),
                    SegmentedTabItem(
                      id: 'notes',
                      label: AppStrings.matchDetailsTabNotes,
                    ),
                  ],
                  selectedId: state.activeTabId,
                  onChange: provider.changeTab,
                ),
                Gaps.hLg,
                TabSwitcher(
                  index: tabIndex,
                  children: [
                    _InfoTab(fixture: fixture),
                    _PredictionTab(
                      odds: state.odds,
                      selectedPick: provider.selectedPick,
                      prediction: state.prediction,
                      matchState: config.state,
                      canEdit: provider.canEditPrediction,
                      isSaving: state.isSavingPrediction,
                      onSelect: provider.selectPick,
                      onCta: () => _openPredictionDialog(context, provider),
                    ),
                    _NotesTab(
                      value: state.noteText,
                      isSaving: state.isSavingNote,
                      onChanged: _onNoteChanged,
                      onSubmit: _onNoteSubmitted,
                    ),
                  ],
                ),
                Gaps.hLg,
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onNoteChanged(String value) {
    _latestNote = value;
    _noteDebounce?.cancel();
    _noteDebounce = Timer(
      _noteDebounceDuration,
      () => context.read<MatchDetailsProvider>().saveNote(value),
    );
  }

  void _onNoteSubmitted() {
    _noteDebounce?.cancel();
    final provider = context.read<MatchDetailsProvider>();
    provider.saveNote(_latestNote ?? provider.state.noteText);
  }

  Future<void> _openPredictionDialog(
    BuildContext context,
    MatchDetailsProvider provider,
  ) async {
    if (!provider.canEditPrediction) {
      return;
    }
    final odds = provider.state.odds;
    if (odds == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.oddsUnavailable)),
      );
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => PredictionDialog(
        odds: odds,
        selected: provider.selectedPick,
        onSelect: provider.selectPick,
        onCancel: () => Navigator.of(dialogContext).pop(),
        onConfirm: (pick) async {
          provider.selectPick(pick);
          await provider.savePrediction();
          if (dialogContext.mounted) {
            Navigator.of(dialogContext).pop();
          }
        },
      ),
    );
  }

  Future<void> _handleFavoriteTap(
    BuildContext context,
    MatchDetailsProvider provider,
  ) async {
    final state = provider.state;
    final fixture = state.fixture;
    if (fixture == null) {
      return;
    }

    if (state.isFavorite) {
      await provider.toggleFavorite();
      return;
    }

    final selection = await showDialog<AddToFavoritesSelection>(
      context: context,
      builder: (dialogContext) => AddToFavoritesDialog(
        league: fixture.leagueName,
        homeTeam: fixture.homeTeam.name,
        awayTeam: fixture.awayTeam.name,
        onCancel: () => Navigator.of(dialogContext).pop(),
        onAdd: (choice) => Navigator.of(dialogContext).pop(choice),
      ),
    );

    if (selection != null) {
      await provider.applyFavoritesSelection(selection);
    }
  }

  void _maybeShowError(BuildContext context, String? error) {
    if (error == null || error.isEmpty || error == _lastError) {
      return;
    }
    _lastError = error;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    });
  }

  MatchCardConfig _buildHeaderConfig(
    Fixture fixture,
    MatchDetailsState state,
  ) {
    final matchState = _mapStatus(fixture.status);
    final userPick = _mapUserPick(state.prediction, fixture.status);
    return MatchCardConfig(
      match: fixture,
      context: MatchCardContext.schedule,
      density: MatchCardDensity.expanded,
      state: matchState,
      userPick: userPick,
      isFavorite: state.isFavorite,
      isExpanded: false,
      odds: state.odds,
      prediction: state.prediction,
      userNote: state.noteText,
    );
  }

  int _tabIndex(String tabId) {
    final index = _tabs.indexOf(tabId);
    return index < 0 ? 0 : index;
  }

  MatchCardState _mapStatus(String status) {
    final normalized = status.toUpperCase();
    const finished = <String>{'FT', 'AET', 'PEN'};
    const live = <String>{'1H', '2H', 'ET', 'P', 'LIVE'};
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
}

class _InfoTab extends StatelessWidget {
  const _InfoTab({required this.fixture});

  final Fixture fixture;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InfoRow(
          label: AppStrings.matchDetailsInfoStadium,
          value: _valueOrDash(fixture.stadium),
        ),
        Gaps.hSm,
        InfoRow(
          label: AppStrings.matchDetailsInfoCity,
          value: _valueOrDash(fixture.city),
        ),
        Gaps.hSm,
        InfoRow(
          label: AppStrings.matchDetailsInfoReferee,
          value: _valueOrDash(fixture.referee),
        ),
      ],
    );
  }

  String _valueOrDash(String? value) =>
      (value == null || value.isEmpty) ? '-' : value;
}

class _PredictionTab extends StatelessWidget {
  const _PredictionTab({
    required this.odds,
    required this.selectedPick,
    required this.prediction,
    required this.matchState,
    required this.canEdit,
    required this.isSaving,
    required this.onSelect,
    required this.onCta,
  });

  final OddsSnapshot? odds;
  final String? selectedPick;
  final Prediction? prediction;
  final MatchCardState matchState;
  final bool canEdit;
  final bool isSaving;
  final ValueChanged<String> onSelect;
  final VoidCallback onCta;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final panel = odds == null
        ? const _OddsUnavailable(message: AppStrings.oddsUnavailable)
        : PredictionPanel(
            odds: odds!,
            selected: selectedPick,
            onSelect: onSelect,
          );

    final panelWidget = canEdit
        ? panel
        : IgnorePointer(
            child: Opacity(opacity: 0.6, child: panel),
          );

    final hasPrediction = prediction != null;
    final predictionText = hasPrediction
        ? AppStrings.matchDetailsPredicted(
            _formatPickLabel(prediction!.pick),
            _formatOdds(prediction!.odds),
          )
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        panelWidget,
        Gaps.hMd,
        if (canEdit)
          PrimaryButton(
            label: hasPrediction
                ? AppStrings.matchDetailsEditPrediction
                : AppStrings.matchDetailsMakePrediction,
            onPressed: isSaving ? null : onCta,
            enabled: !isSaving,
          )
        else
          const SecondaryGreenButtonLight(
            label: AppStrings.matchDetailsEditDisabled,
            onPressed: null,
            enabled: false,
          ),
        if (isSaving) ...[
          Gaps.hSm,
          const LinearProgressIndicator(minHeight: 2),
        ],
        if (predictionText != null) ...[
          Gaps.hSm,
          Text(
            predictionText,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textWhite,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }

  String _statusLabel() {
    final result = prediction?.result?.toLowerCase();
    if (matchState == MatchCardState.finished) {
      if (result == 'correct') {
        return AppStrings.matchDetailsStatusCorrect;
      }
      if (result == 'missed') {
        return AppStrings.matchDetailsStatusMissed;
      }
      return AppStrings.matchDetailsStatusPending;
    }
    if (matchState == MatchCardState.live) {
      return AppStrings.matchDetailsStatusLive;
    }
    return AppStrings.matchDetailsStatusUpcoming;
  }

  String _formatPickLabel(String pick) {
    switch (pick.toLowerCase()) {
      case 'home':
        return 'Home Win';
      case 'draw':
        return 'Draw';
      case 'away':
        return 'Away Win';
    }
    return pick;
  }

  String _formatOdds(double? value) =>
      value == null ? '-' : value.toStringAsFixed(2);
}

class _NotesTab extends StatelessWidget {
  const _NotesTab({
    required this.value,
    required this.isSaving,
    required this.onChanged,
    required this.onSubmit,
  });

  final String value;
  final bool isSaving;
  final ValueChanged<String> onChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        NotesTextField(
          value: value,
          onChanged: onChanged,
          onSubmit: onSubmit,
          hintText: AppStrings.matchDetailsNotesPlaceholder,
          enabled: !isSaving,
        ),
        if (isSaving) ...[
          Gaps.hSm,
          Text(
            AppStrings.matchDetailsNotesSaving,
            style: theme.textTheme.labelSmall?.copyWith(
              color: AppColors.textGray,
            ),
          ),
        ],
      ],
    );
  }
}

class _OddsUnavailable extends StatelessWidget {
  const _OddsUnavailable({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: AppRadius.cardLg,
        border: Border.all(
          color: AppColors.borderGray,
        ),
      ),
      child: Text(
        message,
        style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textGray),
        textAlign: TextAlign.center,
      ),
    );
  }
}
