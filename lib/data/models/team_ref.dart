// path: lib/data/models/team_ref.dart
// TeamRef - lightweight reference to a team (id, name, optional logo URL).
// PRD Models list + data/models/team_ref.dart :contentReference[oaicite:0]{index=0}
import 'package:json_annotation/json_annotation.dart';

part 'team_ref.g.dart';

@JsonSerializable(explicitToJson: true)
class TeamRef {
  const TeamRef({
    @JsonKey(readValue: _readTeamId) required this.id,
    @JsonKey(readValue: _readTeamName) required this.name,
    @JsonKey(readValue: _readTeamLogo) this.logo,
  });

  /// Team ID.
  final int id;

  /// Display name.
  final String name;

  /// Optional logo URL (may be null for some leagues/levels).
  final String? logo;

  /// JSON factory (generated).
  factory TeamRef.fromJson(Map<String, dynamic> json) =>
      _$TeamRefFromJson(json);

  /// JSON encoder (generated).
  Map<String, dynamic> toJson() => _$TeamRefToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamRef &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          logo == other.logo;

  @override
  int get hashCode => Object.hash(id, name, logo);
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
    return (team as Map)[key];
  }
  return null;
}

int? _asNullableInt(Object? value) {
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return value is int ? value : null;
}
