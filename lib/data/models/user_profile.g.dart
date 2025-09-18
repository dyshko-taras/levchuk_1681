// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
  id: (_readId(json, 'id') as num).toInt(),
  username: _readUsername(json, 'username') as String,
  avatarId: (_readAvatarId(json, 'avatarId') as num).toInt(),
  metricsCache:
      _readMetricsCache(json, 'metricsCache') as Map<String, dynamic>?,
  resetMarkers:
      _readResetMarkers(json, 'resetMarkers') as Map<String, dynamic>?,
  updatedAt: _readUpdatedAt(json, 'updatedAt') == null
      ? null
      : DateTime.parse(_readUpdatedAt(json, 'updatedAt') as String),
);

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatarId': instance.avatarId,
      'metricsCache': instance.metricsCache,
      'resetMarkers': instance.resetMarkers,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
