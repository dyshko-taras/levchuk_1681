// path: lib/data/models/prediction.dart
// Prediction - local model for user picks and grading per PRD. :contentReference[oaicite:2]{index=2}
import 'package:FlutterApp/data/models/base_equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'prediction.g.dart';

@JsonSerializable()
class Prediction extends EquatableModel {
  const Prediction({
    required this.fixtureId,
    required this.pick, // "home" | "draw" | "away"
    required this.madeAt,
    this.odds,
    this.lockedAt,
    this.gradedAt,
    this.result, // "correct" | "missed" | null (pending)
    this.openedDetails = false,
  });

  @JsonKey(readValue: _readFixtureId)
  final int fixtureId;

  final String pick;

  @JsonKey(readValue: _readMadeAt)
  final DateTime madeAt;

  @JsonKey(readValue: _readOdds)
  final double? odds;

  /// When edits are locked (nullable until locked). :contentReference[oaicite:3]{index=3}
  @JsonKey(readValue: _readLockedAt)
  final DateTime? lockedAt;

  /// When the prediction was graded (nullable until finished).
  @JsonKey(readValue: _readGradedAt)
  final DateTime? gradedAt;

  /// Result after grading ("correct" | "missed" | null). :contentReference[oaicite:4]{index=4}
  final String? result;

  /// Whether the user opened match details before submitting.
  @JsonKey(readValue: _readOpenedDetails)
  final bool openedDetails;

  factory Prediction.fromJson(Map<String, dynamic> json) =>
      _$PredictionFromJson(json);
  Map<String, dynamic> toJson() => _$PredictionToJson(this);

  @override
  List<Object?> get props => [
        fixtureId,
        pick,
        madeAt,
        odds,
        lockedAt,
        gradedAt,
        result,
        openedDetails,
      ];
}

Object? _readFixtureId(Map<dynamic, dynamic> json, String key) {
  final direct = json[key];
  if (direct != null) return _asNullableInt(direct);
  final alt = json['fixture_id'] ?? json['fixtureId'];
  if (alt != null) return _asNullableInt(alt);
  final nested = json['fixture'];
  if (nested is Map) {
    final value = nested['id'] ?? nested['fixture_id'];
    return _asNullableInt(value);
  }
  return null;
}

Object? _readMadeAt(Map<dynamic, dynamic> json, String key) =>
    _asIsoString(json[key] ?? json['created_at']);

double? _readOdds(Map<dynamic, dynamic> json, String key) =>
    _asNullableDouble(json[key]);

Object? _readLockedAt(Map<dynamic, dynamic> json, String key) =>
    _asIsoString(json[key] ?? json['locked_at']);

Object? _readGradedAt(Map<dynamic, dynamic> json, String key) =>
    _asIsoString(json[key] ?? json['graded_at']);

Object? _readOpenedDetails(Map<dynamic, dynamic> json, String key) {
  final value = json[key] ?? json['opened_details'] ?? json['openedDetails'];
  if (value is bool) return value;
  if (value is num) return value != 0;
  if (value is String) {
    final lower = value.toLowerCase();
    if (lower == 'true' || lower == 'yes') return true;
    if (lower == 'false' || lower == 'no') return false;
  }
  return false;
}

double? _asNullableDouble(Object? value) {
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return value is double ? value : null;
}

int? _asNullableInt(Object? value) {
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return value is int ? value : null;
}

String? _asIsoString(Object? value) {
  if (value == null) return null;
  if (value is DateTime) return value.toIso8601String();
  if (value is String) return value;
  return value.toString();
}
