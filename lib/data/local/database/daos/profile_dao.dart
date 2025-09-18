// path: lib/data/local/database/daos/profile_dao.dart
// DAO for reading and writing the single user profile row.
import 'dart:convert';

import 'package:FlutterApp/data/local/database/app_database.dart';
import 'package:FlutterApp/data/local/database/schema/profile_table.dart';
import 'package:FlutterApp/data/models/user_profile.dart';
import 'package:drift/drift.dart';

part 'profile_dao.g.dart';

@DriftAccessor(tables: [ProfileTable])
class ProfileDao extends DatabaseAccessor<AppDatabase> with _$ProfileDaoMixin {
  ProfileDao(super.db);

  Future<UserProfile?> getProfile() async {
    final row = await (select(profileTable)..limit(1)).getSingleOrNull();
    if (row == null) return null;
    return _fromData(row);
  }

  Future<void> upsert(UserProfile profile) async {
    await into(profileTable).insertOnConflictUpdate(_toCompanion(profile));
  }

  Future<void> updateProfile({
    String? username,
    int? avatarId,
    Map<String, dynamic>? metricsCache,
    Map<String, dynamic>? resetMarkers,
  }) async {
    final companion = ProfileTableCompanion(
      username: username == null ? const Value.absent() : Value(username),
      avatarId: avatarId == null ? const Value.absent() : Value(avatarId),
      metricsCacheJson: metricsCache == null
          ? const Value.absent()
          : Value(jsonEncode(metricsCache)),
      resetMarkersJson: resetMarkers == null
          ? const Value.absent()
          : Value(jsonEncode(resetMarkers)),
      updatedAt: Value(DateTime.now().toUtc()),
    );
    await (update(
      profileTable,
    )..where((tbl) => tbl.id.equals(1))).write(companion);
  }

  ProfileTableCompanion _toCompanion(UserProfile profile) =>
      ProfileTableCompanion(
        id: Value(profile.id),
        username: Value(profile.username),
        avatarId: Value(profile.avatarId),
        metricsCacheJson: profile.metricsCache == null
            ? const Value(null)
            : Value(jsonEncode(profile.metricsCache)),
        resetMarkersJson: profile.resetMarkers == null
            ? const Value(null)
            : Value(jsonEncode(profile.resetMarkers)),
        updatedAt: profile.updatedAt == null
            ? const Value(null)
            : Value(profile.updatedAt!.toUtc()),
      );

  UserProfile _fromData(ProfileTableData data) => UserProfile(
    id: data.id,
    username: data.username,
    avatarId: data.avatarId,
    metricsCache: _decodeMap(data.metricsCacheJson),
    resetMarkers: _decodeMap(data.resetMarkersJson),
    updatedAt: data.updatedAt?.toLocal(),
  );

  Map<String, dynamic>? _decodeMap(String? json) {
    if (json == null || json.isEmpty) return null;
    return jsonDecode(json) as Map<String, dynamic>;
  }
}
