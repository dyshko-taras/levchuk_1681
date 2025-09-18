// path: lib/data/models/team_stats.dart
// TeamStats - per-team aggregates in a league/season (PRD models).
// Fields: teamId, leagueId, season, form?, goalsForAvg?, goalsAgainstAvg?, cleanSheets?, failedToScore?
// Source: PRD models. :contentReference[oaicite:2]{index=2}
import 'package:FlutterApp/data/models/base_equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team_stats.g.dart';

@JsonSerializable()
class TeamStats extends EquatableModel {
  const TeamStats({
    required this.teamId,
    required this.leagueId,
    required this.season,
    this.form,
    this.goalsForAvg,
    this.goalsAgainstAvg,
    this.cleanSheets,
    this.failedToScore,
  });

  @JsonKey(readValue: _readTeamId)
  final int teamId;

  @JsonKey(readValue: _readLeagueId)
  final int leagueId;

  @JsonKey(readValue: _readSeason)
  final int season;

  /// Recent form, e.g., "WWDLD". :contentReference[oaicite:3]{index=3}
  @JsonKey(readValue: _readForm)
  final String? form;

  @JsonKey(readValue: _readGoalsForAvg)
  final double? goalsForAvg;

  @JsonKey(readValue: _readGoalsAgainstAvg)
  final double? goalsAgainstAvg;

  @JsonKey(readValue: _readCleanSheets)
  final int? cleanSheets;

  @JsonKey(readValue: _readFailedToScore)
  final int? failedToScore;

  factory TeamStats.fromJson(Map<String, dynamic> json) =>
      _$TeamStatsFromJson(json);
  Map<String, dynamic> toJson() => _$TeamStatsToJson(this);

  @override
  List<Object?> get props => [
        teamId,
        leagueId,
        season,
        form,
        goalsForAvg,
        goalsAgainstAvg,
        cleanSheets,
        failedToScore,
      ];
}

Object? _readTeamId(Map<dynamic, dynamic> json, String key) =>
    _asNullableInt(_readValue(json, key, const ['team', 'id']));

Object? _readLeagueId(Map<dynamic, dynamic> json, String key) =>
    _asNullableInt(_readValue(json, key, const ['league', 'id']));

Object? _readSeason(Map<dynamic, dynamic> json, String key) =>
    _asNullableInt(_readValue(json, key, const ['league', 'season']));

Object? _readForm(Map<dynamic, dynamic> json, String key) =>
    _readValue(json, key, const ['form']);

Object? _readGoalsForAvg(Map<dynamic, dynamic> json, String key) =>
    _asNullableDouble(
      _readValue(json, key, const ['goals', 'for', 'average', 'total']),
    );

Object? _readGoalsAgainstAvg(Map<dynamic, dynamic> json, String key) =>
    _asNullableDouble(
      _readValue(json, key, const ['goals', 'against', 'average', 'total']),
    );

Object? _readCleanSheets(Map<dynamic, dynamic> json, String key) =>
    _asNullableInt(_readValue(json, key, const ['clean_sheet', 'total']));

Object? _readFailedToScore(Map<dynamic, dynamic> json, String key) =>
    _asNullableInt(_readValue(json, key, const ['failed_to_score', 'total']));

Object? _readValue(
  Map<dynamic, dynamic> json,
  String directKey,
  List<String> path,
) {
  if (json.containsKey(directKey)) {
    return json[directKey];
  }
  return _nestedValue(json, path);
}

Object? _nestedValue(Object? node, List<String> path) {
  Object? current = node;
  for (final segment in path) {
    if (current is Map<String, dynamic>) {
      current = current[segment];
    } else if (current is Map) {
      current = current[segment];
    } else {
      return null;
    }
  }
  return current;
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
