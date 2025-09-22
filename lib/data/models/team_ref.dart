// path: lib/data/models/team_ref.dart
// TeamRef - lightweight reference to a team (id, name, optional logo URL).
// PRD Models list + data/models/team_ref.dart :contentReference[oaicite:0]{index=0}
import 'package:FlutterApp/data/models/base_equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team_ref.g.dart';

@JsonSerializable(explicitToJson: true)
class TeamRef extends EquatableModel {
  const TeamRef({
    required this.id,
    required this.name,
    this.logo,
  });

  /// JSON factory (generated).
  factory TeamRef.fromJson(Map<String, dynamic> json) =>
      _$TeamRefFromJson(json);

  /// Team ID.
  @JsonKey(readValue: _readTeamId)
  final int id;

  /// Display name.
  @JsonKey(readValue: _readTeamName)
  final String name;

  /// Optional logo URL (may be null for some leagues/levels).
  @JsonKey(readValue: _readTeamLogo)
  final String? logo;

  /// JSON encoder (generated).
  Map<String, dynamic> toJson() => _$TeamRefToJson(this);

  @override
  List<Object?> get props => [id, name, logo];
}

Object? _readTeamId(Map<dynamic, dynamic> json, String key) =>
    _asNullableInt(_readTeamField(json, key));

Object? _readTeamName(Map<dynamic, dynamic> json, String key) =>
    _readTeamField(json, key);

Object? _readTeamLogo(Map<dynamic, dynamic> json, String key) =>
    _readTeamField(json, key);

Object? _readTeamField(Map<dynamic, dynamic> json, String key) {
  if (json.containsKey(key)) {
    return json[key];
  }
  final team = json['team'];
  if (team is Map<String, dynamic>) {
    return team[key];
  } else if (team is Map) {
    return team[key];
  }
  return null;
}

int? _asNullableInt(Object? value) {
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return value is int ? value : null;
}
