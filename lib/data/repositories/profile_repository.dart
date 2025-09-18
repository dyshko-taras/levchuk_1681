// path: lib/data/repositories/profile_repository.dart
// Repository for the local user profile row.
import 'package:FlutterApp/data/local/database/daos/profile_dao.dart';
import 'package:FlutterApp/data/models/user_profile.dart';

class ProfileRepository {
  ProfileRepository(this._dao);

  final ProfileDao _dao;

  Future<UserProfile> getProfile() async {
    final profile = await _dao.getProfile();
    if (profile != null) return profile;
    final fallback = UserProfile(
      id: 1,
      username: 'Analyst',
      avatarId: 1,
      metricsCache: const <String, dynamic>{},
      resetMarkers: const <String, dynamic>{},
      updatedAt: DateTime.now(),
    );
    await _dao.upsert(fallback);
    return fallback;
  }

  Future<void> updateProfile({
    String? username,
    int? avatarId,
    Map<String, dynamic>? metricsCache,
    Map<String, dynamic>? resetMarkers,
  }) async {
    await _dao.updateProfile(
      username: username,
      avatarId: avatarId,
      metricsCache: metricsCache,
      resetMarkers: resetMarkers,
    );
  }
}
