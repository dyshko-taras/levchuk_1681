// path: lib/providers/my_predictions_provider.dart
// Lists user predictions with hydrated fixture information.
import 'package:FlutterApp/data/models/favorite.dart';
import 'package:FlutterApp/data/models/fixture.dart';
import 'package:FlutterApp/data/models/prediction.dart';
import 'package:FlutterApp/data/repositories/favorites_repository.dart';
import 'package:FlutterApp/data/repositories/matches_repository.dart';
import 'package:FlutterApp/data/repositories/predictions_repository.dart';
import 'package:flutter/foundation.dart';

@immutable
class MyPredictionItem {
  const MyPredictionItem({
    required this.prediction,
    required this.fixture,
    required this.isFavorite,
  });

  final Prediction prediction;
  final Fixture? fixture;
  final bool isFavorite;

  MyPredictionItem copyWith({
    Prediction? prediction,
    Fixture? fixture,
    bool? isFavorite,
  }) {
    return MyPredictionItem(
      prediction: prediction ?? this.prediction,
      fixture: fixture ?? this.fixture,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

@immutable
class MyPredictionsState {
  const MyPredictionsState({
    required this.isLoading,
    required this.error,
    required this.items,
  });

  final bool isLoading;
  final String? error;
  final List<MyPredictionItem> items;

  MyPredictionsState copyWith({
    bool? isLoading,
    Object? error = _sentinel,
    List<MyPredictionItem>? items,
  }) {
    return MyPredictionsState(
      isLoading: isLoading ?? this.isLoading,
      error: identical(error, _sentinel) ? this.error : error as String?,
      items: items ?? this.items,
    );
  }

  static const Object _sentinel = Object();
}

class MyPredictionsProvider extends ChangeNotifier {
  MyPredictionsProvider({
    required PredictionsRepository predictionsRepository,
    required MatchesRepository matchesRepository,
    required FavoritesRepository favoritesRepository,
  })  : _predictionsRepository = predictionsRepository,
        _matchesRepository = matchesRepository,
        _favoritesRepository = favoritesRepository,
        _state = const MyPredictionsState(
          isLoading: false,
          error: null,
          items: <MyPredictionItem>[],
        );

  final PredictionsRepository _predictionsRepository;
  final MatchesRepository _matchesRepository;
  final FavoritesRepository _favoritesRepository;

  MyPredictionsState _state;

  MyPredictionsState get state => _state;

  Future<void> load() async {
    _state = _state.copyWith(isLoading: true, error: MyPredictionsState._sentinel);
    notifyListeners();
    try {
      final predictions = await _predictionsRepository.getAll();
      final favorites = await _favoritesRepository.getFavorites(
        type: FavoriteType.match,
      );
      final favoriteIds = favorites.map((favorite) => favorite.refId).toSet();

      final items = await Future.wait(predictions.map((prediction) async {
        final fixture = await _matchesRepository.getById(prediction.fixtureId);
        return MyPredictionItem(
          prediction: prediction,
          fixture: fixture,
          isFavorite: favoriteIds.contains(prediction.fixtureId),
        );
      }));

      _state = _state.copyWith(
        isLoading: false,
        items: items,
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

  Future<void> refresh() async => load();

  Future<void> toggleFavorite(int fixtureId) async {
    final toggled = await _favoritesRepository.toggleFavorite(
      FavoriteType.match,
      fixtureId,
    );
    final updated = _state.items
        .map(
          (item) => item.prediction.fixtureId == fixtureId
              ? item.copyWith(isFavorite: toggled)
              : item,
        )
        .toList();
    _state = _state.copyWith(items: updated);
    notifyListeners();
  }

  Future<void> deletePrediction(int fixtureId) async {
    await _predictionsRepository.deletePrediction(fixtureId);
    final updated = _state.items
        .where((item) => item.prediction.fixtureId != fixtureId)
        .toList();
    _state = _state.copyWith(items: updated);
    notifyListeners();
  }
}

