// path: lib/data/repositories/favorites_repository.dart
// Repository for user favorites backed by the local database.
import 'package:FlutterApp/data/local/database/daos/favorites_dao.dart';
import 'package:FlutterApp/data/models/favorite.dart';

class FavoritesRepository {
  FavoritesRepository(this._dao);

  final FavoritesDao _dao;

  Future<List<Favorite>> getFavorites({FavoriteType? type}) async {
    final all = await _dao.getAll();
    if (type == null) return all;
    return all.where((fav) => fav.type == type).toList();
  }

  Future<bool> toggleFavorite(FavoriteType type, int refId) async {
    final isFav = await _dao.isFavorite(type, refId);
    if (isFav) {
      await _dao.removeFavorite(type, refId);
      return false;
    }
    await _dao.addFavorite(
      Favorite(
        id: 0,
        type: type,
        refId: refId,
        createdAt: DateTime.now(),
      ),
    );
    return true;
  }

  Future<void> addFavorite(Favorite favorite) => _dao.addFavorite(favorite);

  Future<void> removeFavorite(FavoriteType type, int refId) =>
      _dao.removeFavorite(type, refId);

  Future<bool> isFavorite(FavoriteType type, int refId) =>
      _dao.isFavorite(type, refId);
}

