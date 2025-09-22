// path: lib/data/models/insight.dart
// Insight - local computed metric or text insight (offline analytics).
import 'package:FlutterApp/data/models/base_equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'insight.g.dart';

@JsonSerializable()
class Insight extends EquatableModel {
  const Insight({
    required this.id,
    required this.title,
    required this.value, // text or formatted %
    required this.computedAt,
  });

  factory Insight.fromJson(Map<String, dynamic> json) =>
      _$InsightFromJson(json);

  final String id;
  final String title;
  final String value;

  @JsonKey(readValue: _readComputedAt)
  final DateTime computedAt;
  Map<String, dynamic> toJson() => _$InsightToJson(this);

  @override
  List<Object?> get props => [id, title, value, computedAt];
}

Object? _readComputedAt(Map<dynamic, dynamic> json, String key) =>
    _asIsoString(json[key] ?? json['computed_at']);

String? _asIsoString(Object? value) {
  if (value == null) return null;
  if (value is DateTime) return value.toIso8601String();
  if (value is String) return value;
  return value.toString();
}
