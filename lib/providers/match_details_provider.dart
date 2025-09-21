// path: lib/providers/match_details_provider.dart
// Manages match detail screen state: fixture, odds, prediction, notes, favorites.
import 'package:FlutterApp/constants/app_durations.dart';
import 'package:FlutterApp/data/models/favorite.dart';
import 'package:FlutterApp/data/models/fixture.dart';
import 'package:FlutterApp/data/models/note.dart';
import 'package:FlutterApp/data/models/odds_snapshot.dart';
import 'package:FlutterApp/data/models/prediction.dart';
import 'package:FlutterApp/data/repositories/favorites_repository.dart';
import 'package:FlutterApp/data/repositories/matches_repository.dart';
import 'package:FlutterApp/data/repositories/notes_repository.dart';
import 'package:FlutterApp/data/repositories/odds_repository.dart';
import 'package:FlutterApp/data/repositories/predictions_repository.dart';
import 'package:flutter/foundation.dart';

@immutable
class MatchDetailsState {
  const MatchDetailsState({
    required this.isLoading,
    required this.error,
    required this.fixtureId,
    required this.fixture,
    required this.odds,
    required this.prediction,
    required this.isFavorite,
    required this.noteText,
    required this.activeTabId,
    required this.isSavingPrediction,
    required this.isSavingNote,
  });

  final bool isLoading;
  final String? error;
  final int? fixtureId;
  final Fixture? fixture;
  final OddsSnapshot? odds;
  final Prediction? prediction;
  final bool isFavorite;
  final String noteText;
  final String activeTabId;
  final bool isSavingPrediction;
  final bool isSavingNote;

  MatchDetailsState copyWith({
    bool? isLoading,
    Object? error = _sentinel,
    int? fixtureId,
    Object? fixture = _sentinel,
    Object? odds = _sentinel,
    Object? prediction = _sentinel,
    bool? isFavorite,
    String? noteText,
    String? activeTabId,
    bool? isSavingPrediction,
    bool? isSavingNote,
  }) {
    return MatchDetailsState(
      isLoading: isLoading ?? this.isLoading,
      error: identical(error, _sentinel) ? this.error : error as String?,
      fixtureId: fixtureId ?? this.fixtureId,
      fixture: identical(fixture, _sentinel)
          ? this.fixture
          : fixture as Fixture?,
      odds: identical(odds, _sentinel) ? this.odds : odds as OddsSnapshot?,
      prediction: identical(prediction, _sentinel)
          ? this.prediction
          : prediction as Prediction?,
      isFavorite: isFavorite ?? this.isFavorite,
      noteText: noteText ?? this.noteText,
      activeTabId: activeTabId ?? this.activeTabId,
      isSavingPrediction: isSavingPrediction ?? this.isSavingPrediction,
      isSavingNote: isSavingNote ?? this.isSavingNote,
    );
  }

  static const Object _sentinel = Object();
}

class MatchDetailsProvider extends ChangeNotifier {
  MatchDetailsProvider({
    required MatchesRepository matchesRepository,
    required OddsRepository oddsRepository,
    required PredictionsRepository predictionsRepository,
    required FavoritesRepository favoritesRepository,
    required NotesRepository notesRepository,
  }) : _matchesRepository = matchesRepository,
       _oddsRepository = oddsRepository,
       _predictionsRepository = predictionsRepository,
       _favoritesRepository = favoritesRepository,
       _notesRepository = notesRepository,
       _state = const MatchDetailsState(
         isLoading: false,
         error: null,
         fixtureId: null,
         fixture: null,
         odds: null,
         prediction: null,
         isFavorite: false,
         noteText: '',
         activeTabId: 'info',
         isSavingPrediction: false,
         isSavingNote: false,
       );

  final MatchesRepository _matchesRepository;
  final OddsRepository _oddsRepository;
  final PredictionsRepository _predictionsRepository;
  final FavoritesRepository _favoritesRepository;
  final NotesRepository _notesRepository;

  MatchDetailsState _state;
  String? _pendingPick;
  OddsSnapshot? _cachedOdds;
  Note? _currentNote;

  MatchDetailsState get state => _state;

  String? get selectedPick => _pendingPick ?? state.prediction?.pick;

  bool get hasPrediction => state.prediction != null;

bool get canEditPrediction {
    final fixture = state.fixture;
    if (fixture == null) return false;
    final status = fixture.status.toUpperCase();

    const lockedStatuses = {'FT', 'AET', 'PEN'};
    if (lockedStatuses.contains(status)) {
      return false;
    }

    final lockTime = fixture.dateUtc.toUtc().subtract(
      AppDurations.predictionLock,
    );
    if (status == 'NS') {
      return DateTime.now().toUtc().isBefore(lockTime);
    }

    return true;
  }


  Future<void> load(int fixtureId) async {
    if (_state.isLoading && _state.fixtureId == fixtureId) {
      return;
    }
    _state = _state.copyWith(
      isLoading: true,
      fixtureId: fixtureId,
      activeTabId: 'info',
    );
    notifyListeners();

    try {
      final fixture =
          await _matchesRepository.getById(
            fixtureId,
            forceRefresh: true,
          ) ??
          await _matchesRepository.getById(fixtureId);
      final odds = await _oddsRepository.getByFixture(fixtureId);
      final prediction = await _predictionsRepository.getByFixture(fixtureId);
      final favorite = await _favoritesRepository.isFavorite(
        FavoriteType.match,
        fixtureId,
      );
      final note = await _notesRepository.getNote(fixtureId);

      _cachedOdds = odds;
      _pendingPick = prediction?.pick;
      _currentNote = note;

      _state = _state.copyWith(
        isLoading: false,
        fixture: fixture,
        odds: odds,
        prediction: prediction,
        isFavorite: favorite,
        noteText: note?.text ?? '',
        error: null,
      );
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
    notifyListeners();
  }

  void changeTab(String tabId) {
    if (tabId == _state.activeTabId) return;
    _state = _state.copyWith(activeTabId: tabId);
    notifyListeners();
  }

  void selectPick(String pick) {
    _pendingPick = pick;
    notifyListeners();
  }

  Future<void> savePrediction() async {
    final fixture = state.fixture;
    final pick = _pendingPick;
    if (fixture == null || pick == null) {
      return;
    }
    if (!canEditPrediction) {
      return;
    }
    _state = _state.copyWith(isSavingPrediction: true);
    notifyListeners();
    try {
      final oddsValue = _oddsForPick(pick);
      final prediction = Prediction(
        fixtureId: fixture.fixtureId,
        pick: pick,
        odds: oddsValue,
        madeAt: DateTime.now(),
        lockedAt: state.prediction?.lockedAt,
        gradedAt: state.prediction?.gradedAt,
        result: state.prediction?.result,
        openedDetails: true,
      );
      await _predictionsRepository.savePrediction(prediction);
      final refreshed = await _predictionsRepository.getByFixture(
        fixture.fixtureId,
      );
      _state = _state.copyWith(
        prediction: refreshed,
        isSavingPrediction: false,
      );
    } catch (e) {
      _state = _state.copyWith(
        isSavingPrediction: false,
        error: e.toString(),
      );
    }
    notifyListeners();
  }

  Future<void> deletePrediction() async {
    final fixture = state.fixture;
    if (fixture == null) return;
    _state = _state.copyWith(isSavingPrediction: true);
    notifyListeners();
    try {
      await _predictionsRepository.deletePrediction(fixture.fixtureId);
      _state = _state.copyWith(
        prediction: null,
        isSavingPrediction: false,
      );
      _pendingPick = null;
    } catch (e) {
      _state = _state.copyWith(
        isSavingPrediction: false,
        error: e.toString(),
      );
    }
    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    final fixture = state.fixture;
    if (fixture == null) return;
    final toggled = await _favoritesRepository.toggleFavorite(
      FavoriteType.match,
      fixture.fixtureId,
    );
    _state = _state.copyWith(isFavorite: toggled);
    notifyListeners();
  }

  Future<void> saveNote(String text) async {
    final fixture = state.fixture;
    if (fixture == null) return;
    _state = _state.copyWith(isSavingNote: true);
    notifyListeners();
    try {
      final note = Note(
        id: _currentNote?.id ?? 0,
        fixtureId: fixture.fixtureId,
        text: text,
        updatedAt: DateTime.now(),
      );
      await _notesRepository.saveNote(note);
      _currentNote = note;
      _state = _state.copyWith(
        noteText: text,
        isSavingNote: false,
      );
    } catch (e) {
      _state = _state.copyWith(
        isSavingNote: false,
        error: e.toString(),
      );
    }
    notifyListeners();
  }

  Future<void> deleteNote() async {
    final fixture = state.fixture;
    if (fixture == null || _currentNote == null) return;
    _state = _state.copyWith(isSavingNote: true);
    notifyListeners();
    try {
      await _notesRepository.deleteNote(fixture.fixtureId);
      _currentNote = null;
      _state = _state.copyWith(
        noteText: '',
        isSavingNote: false,
      );
    } catch (e) {
      _state = _state.copyWith(
        isSavingNote: false,
        error: e.toString(),
      );
    }
    notifyListeners();
  }

  Future<void> applyFavoritesSelection(
    ({bool league, bool homeTeam, bool awayTeam, bool match}) selection,
  ) async {
    final fixture = state.fixture;
    if (fixture == null) {
      return;
    }

    if (selection.league) {
      await _ensureFavorite(FavoriteType.league, fixture.leagueId);
    }
    if (selection.homeTeam) {
      await _ensureFavorite(FavoriteType.team, fixture.homeTeam.id);
    }
    if (selection.awayTeam) {
      await _ensureFavorite(FavoriteType.team, fixture.awayTeam.id);
    }

    var isFavorite = state.isFavorite;
    if (selection.match) {
      await _ensureFavorite(FavoriteType.match, fixture.fixtureId);
      isFavorite = true;
    }

    if (isFavorite != state.isFavorite) {
      _state = _state.copyWith(isFavorite: isFavorite);
      notifyListeners();
    }
  }

  Future<void> _ensureFavorite(FavoriteType type, int refId) async {
    final exists = await _favoritesRepository.isFavorite(type, refId);
    if (exists) {
      return;
    }
    await _favoritesRepository.addFavorite(
      Favorite(
        id: 0,
        type: type,
        refId: refId,
        createdAt: DateTime.now(),
      ),
    );
  }

  double? _oddsForPick(String pick) {
    final snapshot = _cachedOdds;
    if (snapshot == null) return null;
    switch (pick) {
      case 'home':
        return snapshot.home;
      case 'draw':
        return snapshot.draw;
      case 'away':
        return snapshot.away;
    }
    return null;
  }
}
