// path: lib/data/models/standing_row.dart
// StandingRow - a normalized row in the standings table (PRD models).
// Fields: team(TeamRef), rank, played, win, draw, lose, points, form?
// Source: PRD models. :contentReference[oaicite:4]{index=4}
import 'package:FlutterApp/data/models/base_equatable.dart';
import 'package:FlutterApp/data/models/team_ref.dart';
import 'package:json_annotation/json_annotation.dart';

part 'standing_row.g.dart';

@JsonSerializable(explicitToJson: true)
class StandingRow extends EquatableModel {
  const StandingRow({
    required this.team,
    required this.rank,
    required this.played,
    required this.win,
    required this.draw,
    required this.lose,
    required this.points,
    this.form,
  });

  @JsonKey(readValue: _readTeam)
  final TeamRef team;

  @JsonKey(readValue: _readRank)
  final int rank;

  @JsonKey(readValue: _readPlayed)
  final int played;

  @JsonKey(readValue: _readWin)
  final int win;

  @JsonKey(readValue: _readDraw)
  final int draw;

  @JsonKey(readValue: _readLose)
  final int lose;

  @JsonKey(readValue: _readPoints)
  final int points;

  /// Recent form string like "WWDLD". :contentReference[oaicite:5]{index=5}
  @JsonKey(readValue: _readForm)
  final String? form;

  factory StandingRow.fromJson(Map<String, dynamic> json) =>
      _$StandingRowFromJson(json);
  Map<String, dynamic> toJson() => _$StandingRowToJson(this);

  @override
  List<Object?> get props => [team, rank, played, win, draw, lose, points, form];
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
      current = current[segment];
    } else {
      return null;
    }
  }
  return current;
}
