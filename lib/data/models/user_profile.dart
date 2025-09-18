// path: lib/data/models/user_profile.dart
// UserProfile - persisted avatar/name/settings with cached metrics per PRD.
import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile {
  const UserProfile({
    @JsonKey(readValue: _readId) required this.id,
    @JsonKey(readValue: _readUsername) required this.username,
    @JsonKey(readValue: _readAvatarId) required this.avatarId,
    @JsonKey(readValue: _readMetricsCache) this.metricsCache,
    @JsonKey(readValue: _readResetMarkers) this.resetMarkers,
    @JsonKey(readValue: _readUpdatedAt) this.updatedAt,
  });

  final int id;
  final String username;
  final int avatarId;
  final Map<String, dynamic>? metricsCache;
  final Map<String, dynamic>? resetMarkers;
  final DateTime? updatedAt;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfile &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          username == other.username &&
          avatarId == other.avatarId &&
          const DeepCollectionEquality().equals(
            metricsCache,
            other.metricsCache,
          ) &&
          const DeepCollectionEquality().equals(
            resetMarkers,
            other.resetMarkers,
          ) &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => Object.hash(
    id,
    username,
    avatarId,
    metricsCache == null
        ? null
        : const DeepCollectionEquality().hash(metricsCache),
    resetMarkers == null
        ? null
        : const DeepCollectionEquality().hash(resetMarkers),
    updatedAt,
  );
}

Object? _readId(Map<dynamic, dynamic> json, String key) {
  final value = json[key] ?? json['id'];
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value) ?? 1;
  return 1;
}

Object? _readUsername(Map<dynamic, dynamic> json, String key) =>
    json[key] ?? json['username'] ?? json['name'];

Object? _readAvatarId(Map<dynamic, dynamic> json, String key) {
  final value =
      json[key] ?? json['avatar'] ?? json['avatar_id'] ?? json['avatarId'];
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return value;
}

Object? _readMetricsCache(Map<dynamic, dynamic> json, String key) =>
    _normalizeMap(json[key] ?? json['metrics_cache']);

Object? _readResetMarkers(Map<dynamic, dynamic> json, String key) =>
    _normalizeMap(json[key] ?? json['reset_markers']);

Object? _readUpdatedAt(Map<dynamic, dynamic> json, String key) {
  final value = json[key] ?? json['updated_at'];
  if (value is DateTime) return value.toIso8601String();
  if (value is String) return value;
  return value;
}

Map<String, dynamic>? _normalizeMap(Object? value) {
  if (value == null) return null;
  if (value is Map<String, dynamic>) return Map<String, dynamic>.from(value);
  if (value is Map) {
    return value.map((key, dynamic val) => MapEntry(key.toString(), val));
  }
  return null;
}
