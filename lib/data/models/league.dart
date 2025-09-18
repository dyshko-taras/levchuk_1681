// path: lib/data/models/league.dart
// League - normalized league/competition entity (PRD models).
// Fields per PRD: id, name, country?, season?, type?, logo?  :contentReference[oaicite:2]{index=2}
import 'package:FlutterApp/data/models/base_equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'league.g.dart';

@JsonSerializable(explicitToJson: true)
class League extends EquatableModel {
  const League({
    required this.id,
    required this.name,
    this.country,
    this.season,
    this.type,
    this.logo,
  });

  @JsonKey(readValue: _readLeagueId)
  final int id;

  @JsonKey(readValue: _readLeagueName)
  final String name;

  @JsonKey(readValue: _readLeagueCountry)
  final String? country;

  @JsonKey(readValue: _readLeagueSeason)
  final int? season;

  /// League/Cup
  @JsonKey(readValue: _readLeagueType)
  final String? type;

  @JsonKey(readValue: _readLeagueLogo)
  final String? logo;

  factory League.fromJson(Map<String, dynamic> json) => _$LeagueFromJson(json);
  Map<String, dynamic> toJson() => _$LeagueToJson(this);

  @override
  List<Object?> get props => [id, name, country, season, type, logo];
}

Object? _readLeagueId(Map<dynamic, dynamic> json, String key) =>
    _asNullableInt(_readLeagueField(json, key));

Object? _readLeagueName(Map<dynamic, dynamic> json, String key) =>
    _readLeagueField(json, key);

Object? _readLeagueCountry(Map<dynamic, dynamic> json, String key) =>
    _readLeagueField(json, key);

Object? _readLeagueSeason(Map<dynamic, dynamic> json, String key) =>
    _asNullableInt(_readLeagueField(json, key));

Object? _readLeagueType(Map<dynamic, dynamic> json, String key) =>
    _readLeagueField(json, key);

Object? _readLeagueLogo(Map<dynamic, dynamic> json, String key) =>
    _readLeagueField(json, key);

Object? _readLeagueField(Map<dynamic, dynamic> json, String key) {
  if (json.containsKey(key)) {
    return json[key];
  }
  final league = json['league'];
  if (league is Map<String, dynamic>) {
    return league[key];
  } else if (league is Map) {
    return league[key];
  }
  return null;
}

int? _asNullableInt(Object? value) {
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return value is int ? value : null;
}
