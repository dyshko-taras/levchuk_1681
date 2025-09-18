// path: lib/data/models/note.dart
// Note - per-fixture personal note stored locally.
import 'package:FlutterApp/data/models/base_equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class Note extends EquatableModel {
  const Note({
    required this.id,
    required this.fixtureId,
    required this.text,
    required this.updatedAt,
  });

  final int id;

  @JsonKey(readValue: _readFixtureId)
  final int fixtureId;

  final String text;

  @JsonKey(readValue: _readUpdatedAt)
  final DateTime updatedAt;

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
  Map<String, dynamic> toJson() => _$NoteToJson(this);

  @override
  List<Object?> get props => [id, fixtureId, text, updatedAt];
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
