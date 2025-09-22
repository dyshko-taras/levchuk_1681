// path: lib/data/models/user_profile.dart
// UserProfile - persisted avatar/name/settings with cached metrics per PRD.
import 'package:FlutterApp/data/models/base_equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile extends EquatableModel {
  const UserProfile({
    required this.id,
    required this.username,
    required this.avatarId,
    this.metricsCache,
    this.resetMarkers,
    this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  @JsonKey(readValue: _readId)
  final int id;

  @JsonKey(readValue: _readUsername)
  final String username;

  @JsonKey(readValue: _readAvatarId)
  final int avatarId;

  @JsonKey(readValue: _readMetricsCache)
  final Map<String, dynamic>? metricsCache;

  @JsonKey(readValue: _readResetMarkers)
  final Map<String, dynamic>? resetMarkers;

  @JsonKey(readValue: _readUpdatedAt)
  final DateTime? updatedAt;
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  @override
  List<Object?> get props => [
    id,
    username,
    avatarId,
    _mapProp(metricsCache),
    _mapProp(resetMarkers),
    updatedAt,
  ];
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

List<Object?>? _mapProp(Map<String, dynamic>? value) {
  if (value == null) return null;
  final entries = value.entries.toList()
    ..sort((a, b) => a.key.compareTo(b.key));
  return List<Object?>.unmodifiable(
    entries.expand<Object?>((entry) => [entry.key, entry.value]).toList(),
  );
}
