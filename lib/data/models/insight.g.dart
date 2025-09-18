// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Insight _$InsightFromJson(Map<String, dynamic> json) => Insight(
  id: json['id'] as String,
  title: json['title'] as String,
  value: json['value'] as String,
  computedAt: DateTime.parse(_readComputedAt(json, 'computedAt') as String),
);

Map<String, dynamic> _$InsightToJson(Insight instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'value': instance.value,
  'computedAt': instance.computedAt.toIso8601String(),
};
