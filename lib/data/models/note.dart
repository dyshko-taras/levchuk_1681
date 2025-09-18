// path: lib/data/models/note.dart
// Note - per-fixture personal note stored locally.
import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class Note {
  const Note({
    required this.id,
    @JsonKey(readValue: _readFixtureId) required this.fixtureId,
    required this.text,
    @JsonKey(readValue: _readUpdatedAt) required this.updatedAt,
  });

  final int id;
  final int fixtureId;
  final String text;
  final DateTime updatedAt;

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
  Map<String, dynamic> toJson() => _$NoteToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Note &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          fixtureId == other.fixtureId &&
          text == other.text &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => Object.hash(id, fixtureId, text, updatedAt);
}

Object? _readFixtureId(Map<dynamic, dynamic> json, String key) {
  final value = json[key] ?? json['fixture_id'] ?? json['fixtureId'];
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return value;
}

Object? _readUpdatedAt(Map<dynamic, dynamic> json, String key) {
  final value = json[key] ?? json['updated_at'];
  if (value is DateTime) return value.toIso8601String();
  if (value is String) return value;
  return value;
}
