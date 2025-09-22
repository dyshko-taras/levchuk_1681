// path: lib/data/models/achievement.dart
import 'package:FlutterApp/data/models/base_equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'achievement.g.dart';

@JsonSerializable()
class Achievement extends EquatableModel {
  const Achievement({
    required this.id, // slug/code
    required this.title,
    required this.description,
    this.earnedAt,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);

  final String id;
  final String title;
  final String description;

  @JsonKey(readValue: _readEarnedAt)
  final DateTime? earnedAt;
  Map<String, dynamic> toJson() => _$AchievementToJson(this);

  @override
  List<Object?> get props => [id, title, description, earnedAt];
}

Object? _readEarnedAt(Map<dynamic, dynamic> json, String key) =>
    _asIsoString(json[key] ?? json['earned_at'] ?? json['earnedAt']);

String? _asIsoString(Object? value) {
  if (value == null) return null;
  if (value is DateTime) return value.toIso8601String();
  if (value is String) return value;
  return value.toString();
}
