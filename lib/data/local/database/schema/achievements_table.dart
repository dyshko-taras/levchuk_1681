// path: lib/data/local/database/schema/achievements_table.dart
// Drift table storing earned achievements (Implementation Plan §4).
import 'package:drift/drift.dart';

class AchievementsTable extends Table {
  TextColumn get code => text().named('code')();
  TextColumn get title => text().named('title')();
  TextColumn get description => text().named('description')();
  DateTimeColumn get earnedAt => dateTime().named('earned_at').nullable()();

  @override
  Set<Column> get primaryKey => {code};
}
