// path: lib/data/models/insight.dart
// Insight - local computed metric or text insight (offline analytics).
import 'package:json_annotation/json_annotation.dart';

part 'insight.g.dart';

@JsonSerializable()
class Insight {
  const Insight({
    required this.id,
    required this.title,
    required this.value, // text or formatted %
    @JsonKey(readValue: _readComputedAt) required this.computedAt,
  });

  final String id;
  final String title;
  final String value;
  final DateTime computedAt;

  factory Insight.fromJson(Map<String, dynamic> json) =>
      _$InsightFromJson(json);
  Map<String, dynamic> toJson() => _$InsightToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Insight &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          value == other.value &&
          computedAt == other.computedAt;

  @override
  int get hashCode => Object.hash(id, title, value, computedAt);
}

Object? _readComputedAt(Map<dynamic, dynamic> json, String key) =>
    _asIsoString(json[key] ?? json['computed_at']);

String? _asIsoString(Object? value) {
  if (value == null) return null;
  if (value is DateTime) return value.toIso8601String();
  if (value is String) return value;
  return value.toString();
}
