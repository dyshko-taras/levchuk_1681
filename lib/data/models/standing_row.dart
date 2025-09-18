// path: lib/data/models/standing_row.dart
// StandingRow - a normalized row in the standings table (PRD models).
// Fields: team(TeamRef), rank, played, win, draw, lose, points, form?
// Source: PRD models. :contentReference[oaicite:4]{index=4}
import 'package:json_annotation/json_annotation.dart';

import 'team_ref.dart';

part 'standing_row.g.dart';

@JsonSerializable(explicitToJson: true)
class StandingRow {
  const StandingRow({
    @JsonKey(readValue: _readTeam) required this.team,
    @JsonKey(readValue: _readRank) required this.rank,
    @JsonKey(readValue: _readPlayed) required this.played,
    @JsonKey(readValue: _readWin) required this.win,
    @JsonKey(readValue: _readDraw) required this.draw,
    @JsonKey(readValue: _readLose) required this.lose,
    @JsonKey(readValue: _readPoints) required this.points,
    @JsonKey(readValue: _readForm) this.form,
  });

  final TeamRef team;
  final int rank;
  final int played;
  final int win;
  final int draw;
  final int lose;
  final int points;

  /// Recent form string like "WWDLD". :contentReference[oaicite:5]{index=5}
  final String? form;

  factory StandingRow.fromJson(Map<String, dynamic> json) =>
      _$StandingRowFromJson(json);
  Map<String, dynamic> toJson() => _$StandingRowToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StandingRow &&
          runtimeType == other.runtimeType &&
          team == other.team &&
          rank == other.rank &&
          played == other.played &&
          win == other.win &&
          draw == other.draw &&
          lose == other.lose &&
          points == other.points &&
          form == other.form;

  @override
  int get hashCode =>
      Object.hash(team, rank, played, win, draw, lose, points, form);
}

Object? _readTeam(Map<dynamic, dynamic> json, String key) =>
    _readMapValue(json, key, const ['team']);

Object? _readRank(Map<dynamic, dynamic> json, String key) =>
    _readNumeric(json, key, const ['rank']);

Object? _readPlayed(Map<dynamic, dynamic> json, String key) =>
    _readNumeric(json, key, const ['all', 'played']);

Object? _readWin(Map<dynamic, dynamic> json, String key) =>
    _readNumeric(json, key, const ['all', 'win']);

Object? _readDraw(Map<dynamic, dynamic> json, String key) =>
    _readNumeric(json, key, const ['all', 'draw']);

Object? _readLose(Map<dynamic, dynamic> json, String key) =>
    _readNumeric(json, key, const ['all', 'lose']);

Object? _readPoints(Map<dynamic, dynamic> json, String key) =>
    _readNumeric(json, key, const ['points']);

Object? _readForm(Map<dynamic, dynamic> json, String key) =>
    _readValue(json, key, const ['form']);

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

Object? _readNumeric(
  Map<dynamic, dynamic> json,
  String directKey,
  List<String> path,
) {
  final value = _readValue(json, directKey, path);
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return value;
}

Object? _readMapValue(
  Map<dynamic, dynamic> json,
  String directKey,
  List<String> path,
) {
  final direct = json[directKey];
  if (direct is Map<String, dynamic>) {
    return direct;
  }
  final nested = _nestedValue(json, path);
  if (nested is Map<String, dynamic>) {
    return nested;
  }
  return direct;
}

Object? _nestedValue(Object? node, List<String> path) {
  Object? current = node;
  for (final segment in path) {
    if (current is Map<String, dynamic>) {
      current = current[segment];
    } else if (current is Map) {
      current = (current as Map)[segment];
    } else {
      return null;
    }
  }
  return current;
}
