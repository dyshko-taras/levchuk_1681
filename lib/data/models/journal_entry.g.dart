// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JournalEntry _$JournalEntryFromJson(Map<String, dynamic> json) => JournalEntry(
  date: DateTime.parse(_readDate(json, 'date') as String),
  events: (_readEvents(json, 'events') as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$JournalEntryToJson(JournalEntry instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'events': instance.events,
    };
