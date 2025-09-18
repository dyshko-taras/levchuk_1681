// path: lib/data/models/achievement.dart
// Achievement - local achievements with optional earned date. :contentReference[oaicite:5]{index=5}
import 'package:json_annotation/json_annotation.dart';

part 'achievement.g.dart';

@JsonSerializable()
class Achievement {
  const Achievement({
    required this.id, // slug/code
    required this.title,
    required this.description,
    @JsonKey(readValue: _readEarnedAt) this.earnedAt,
  });

  final String id;
  final String title;
  final String description;
  final DateTime? earnedAt;

  factory Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);
  Map<String, dynamic> toJson() => _$AchievementToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Achievement &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          earnedAt == other.earnedAt;

  @override
  int get hashCode => Object.hash(id, title, description, earnedAt);
}

Object? _readEarnedAt(Map<dynamic, dynamic> json, String key) =>
    _asIsoString(json[key] ?? json['earned_at'] ?? json['earnedAt']);

String? _asIsoString(Object? value) {
  if (value == null) return null;
  if (value is DateTime) return value.toIso8601String();
  if (value is String) return value;
  return value.toString();
}
