// path: lib/data/models/journal_entry.dart
// JournalEntry - local list of daily notes/events used in Prediction Journal.
import 'package:FlutterApp/data/models/base_equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'journal_entry.g.dart';

@JsonSerializable()
class JournalEntry extends EquatableModel {
  const JournalEntry({
    required this.date,
    required this.events,
  });

  /// The day this journal entry belongs to (UTC or app-default timezone handling at repo level).
  @JsonKey(readValue: _readDate)
  final DateTime date;

  /// Short notes/events of the day.
  @JsonKey(readValue: _readEvents)
  final List<String> events;

  factory JournalEntry.fromJson(Map<String, dynamic> json) =>
      _$JournalEntryFromJson(json);
  Map<String, dynamic> toJson() => _$JournalEntryToJson(this);

  @override
  List<Object?> get props => <Object?>[date, ...events];
}

Object? _readDate(Map<dynamic, dynamic> json, String key) =>
    _asIsoString(json[key] ?? json['date_ymd']);

Object? _readEvents(Map<dynamic, dynamic> json, String key) {
  final value = json[key] ?? json['events'] ?? const <String>[];
  if (value is List) {
    return value.map((e) => e.toString()).toList();
  }
  if (value is String) {
    return <String>[value];
  }
  return const <String>[];
}

String? _asIsoString(Object? value) {
  if (value == null) return null;
  if (value is DateTime) return value.toIso8601String();
  if (value is String) return value;
  return value.toString();
}
