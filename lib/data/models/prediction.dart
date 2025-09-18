// path: lib/data/models/prediction.dart
// Prediction - local model for user's pick and grading per PRD. :contentReference[oaicite:2]{index=2}
import 'package:json_annotation/json_annotation.dart';

part 'prediction.g.dart';

@JsonSerializable()
class Prediction {
  const Prediction({
    @JsonKey(readValue: _readFixtureId) required this.fixtureId,
    required this.pick, // "home" | "draw" | "away"
    @JsonKey(readValue: _readOdds) this.odds,
    @JsonKey(readValue: _readMadeAt) required this.madeAt,
    @JsonKey(readValue: _readLockedAt) this.lockedAt,
    @JsonKey(readValue: _readGradedAt) this.gradedAt,
    this.result, // "correct" | "missed" | null (pending)
    @JsonKey(readValue: _readOpenedDetails) this.openedDetails = false,
  });

  final int fixtureId;
  final String pick;
  final double? odds;
  final DateTime madeAt;

  /// When edits are locked (nullable until locked). :contentReference[oaicite:3]{index=3}
  final DateTime? lockedAt;

  /// When the prediction was graded (nullable until finished).
  final DateTime? gradedAt;

  /// Result after grading ("correct" | "missed" | null). :contentReference[oaicite:4]{index=4}
  final String? result;

  /// Whether the user opened match details before submitting.
  final bool openedDetails;

  factory Prediction.fromJson(Map<String, dynamic> json) =>
      _$PredictionFromJson(json);
  Map<String, dynamic> toJson() => _$PredictionToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Prediction &&
          runtimeType == other.runtimeType &&
          fixtureId == other.fixtureId &&
          pick == other.pick &&
          odds == other.odds &&
          madeAt == other.madeAt &&
          lockedAt == other.lockedAt &&
          gradedAt == other.gradedAt &&
          result == other.result &&
          openedDetails == other.openedDetails;

  @override
  int get hashCode => Object.hash(
    fixtureId,
    pick,
    odds,
    madeAt,
    lockedAt,
    gradedAt,
    result,
    openedDetails,
  );
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

double? _readOdds(Map<dynamic, dynamic> json, String key) =>
    _asNullableDouble(json[key]);

Object? _readMadeAt(Map<dynamic, dynamic> json, String key) =>
    _asIsoString(json[key] ?? json['created_at']);

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

