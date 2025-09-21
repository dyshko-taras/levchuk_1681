// path: lib/data/local/database/daos/favorites_dao.dart
// DAO for favorites (league/team/match) per Implementation Plan section 4.
import 'package:FlutterApp/data/local/database/app_database.dart';
import 'package:FlutterApp/data/local/database/schema/favorites_notes_tables.dart';
import 'package:FlutterApp/data/models/favorite.dart';
import 'package:drift/drift.dart';

part 'favorites_dao.g.dart';

@DriftAccessor(tables: [FavoritesTable])
class FavoritesDao extends DatabaseAccessor<AppDatabase>
    with _$FavoritesDaoMixin {
  FavoritesDao(super.db);

  Future<int> addFavorite(Favorite favorite) => into(favoritesTable).insert(
    FavoritesTableCompanion(
      type: Value(favorite.type.name),
      refId: Value(favorite.refId),
      createdAt: Value(favorite.createdAt),
    ),
    mode: InsertMode.insertOrIgnore,
  );

  Future<int> removeFavorite(FavoriteType type, int refId) => (delete(
    favoritesTable,
  )..where((tbl) => tbl.type.equals(type.name) & tbl.refId.equals(refId))).go();

  Future<bool> isFavorite(FavoriteType type, int refId) async {
    final count =
        await (selectOnly(favoritesTable)
              ..addColumns([favoritesTable.id.count()])
              ..where(
                favoritesTable.type.equals(type.name) &
                    favoritesTable.refId.equals(refId),
              ))
            .map((row) => row.read(favoritesTable.id.count()) ?? 0)
            .getSingle();
    return count > 0;
  }

  Future<List<Favorite>> getAll() async {
    final rows = await select(favoritesTable).get();
    return rows.map(_fromData).toList();
  }

  Favorite _fromData(FavoritesTableData data) => Favorite(
    id: data.id,
    type: FavoriteType.values.firstWhere(
      (t) => t.name == data.type,
      orElse: () => FavoriteType.matches,
    ),
    refId: data.refId,
    createdAt: data.createdAt,
  );
}
