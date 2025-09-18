// path: lib/data/local/database/schema/profile_table.dart
// Drift table storing the single user profile row (Implementation Plan §4).
import 'package:drift/drift.dart';

class ProfileTable extends Table {
  IntColumn get id => integer().named('id').withDefault(const Constant(1))();
  TextColumn get username => text().named('username')();
  IntColumn get avatarId => integer().named('avatar_id')();
  TextColumn get metricsCacheJson =>
      text().named('metrics_cache_json').nullable()();
  TextColumn get resetMarkersJson =>
      text().named('reset_markers_json').nullable()();
  DateTimeColumn get updatedAt => dateTime().named('updated_at').nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
