// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) => Note(
  id: (json['id'] as num).toInt(),
  fixtureId: (_readFixtureId(json, 'fixtureId') as num).toInt(),
  text: json['text'] as String,
  updatedAt: DateTime.parse(_readUpdatedAt(json, 'updatedAt') as String),
);

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
  'id': instance.id,
  'fixtureId': instance.fixtureId,
  'text': instance.text,
  'updatedAt': instance.updatedAt.toIso8601String(),
};
