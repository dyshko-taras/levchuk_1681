// path: lib/data/models/journal_entry.dart
// JournalEntry - local list of daily notes/events used in Prediction Journal.
import 'package:json_annotation/json_annotation.dart';

part 'journal_entry.g.dart';

@JsonSerializable()
class JournalEntry {
  const JournalEntry({
    @JsonKey(readValue: _readDate) required this.date,
    @JsonKey(readValue: _readEvents) required this.events,
  });

  /// The day this journal entry belongs to (UTC or app-default timezone handling at repo level).
  final DateTime date;

  /// Short notes/events of the day.
  final List<String> events;

  factory JournalEntry.fromJson(Map<String, dynamic> json) =>
      _$JournalEntryFromJson(json);
  Map<String, dynamic> toJson() => _$JournalEntryToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JournalEntry &&
          runtimeType == other.runtimeType &&
          date == other.date &&
          _listEquals(events, other.events);

  @override
  int get hashCode => Object.hash(date, Object.hashAll(events));
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

bool _listEquals<T>(List<T> a, List<T> b) {
  if (identical(a, b)) return true;
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
