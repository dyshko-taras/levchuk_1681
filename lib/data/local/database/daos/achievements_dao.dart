// path: lib/data/local/database/daos/achievements_dao.dart
// DAO for achievements table interactions.
import 'package:FlutterApp/data/local/database/app_database.dart';
import 'package:FlutterApp/data/local/database/schema/achievements_table.dart';
import 'package:FlutterApp/data/models/achievement.dart';
import 'package:drift/drift.dart';

part 'achievements_dao.g.dart';

@DriftAccessor(tables: [AchievementsTable])
class AchievementsDao extends DatabaseAccessor<AppDatabase>
    with _$AchievementsDaoMixin {
  AchievementsDao(super.db);

  Future<List<Achievement>> getAll() async {
    final rows = await select(achievementsTable).get();
    return rows.map(_fromData).toList();
  }

  Future<void> upsertAll(Iterable<Achievement> achievements) async {
    if (achievements.isEmpty) return;
    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        achievementsTable,
        achievements.map(_toCompanion),
      );
    });
  }

  Future<void> setEarned(String code, DateTime? earnedAt) async {
    await (update(
      achievementsTable,
    )..where((tbl) => tbl.code.equals(code))).write(
      AchievementsTableCompanion(
        earnedAt: earnedAt == null
            ? const Value(null)
            : Value(earnedAt.toUtc()),
      ),
    );
  }

  Achievement _fromData(AchievementsTableData data) => Achievement(
    id: data.code,
    title: data.title,
    description: data.description,
    earnedAt: data.earnedAt?.toLocal(),
  );

  AchievementsTableCompanion _toCompanion(Achievement achievement) =>
      AchievementsTableCompanion(
        code: Value(achievement.id),
        title: Value(achievement.title),
        description: Value(achievement.description),
        earnedAt: achievement.earnedAt == null
            ? const Value(null)
            : Value(achievement.earnedAt!.toUtc()),
      );
}
