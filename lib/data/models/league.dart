// path: lib/data/models/league.dart
// League - normalized league/competition entity (PRD models).
// Fields per PRD: id, name, country?, season?, type?, logo?  :contentReference[oaicite:2]{index=2}
import 'package:json_annotation/json_annotation.dart';

part 'league.g.dart';

@JsonSerializable(explicitToJson: true)
class League {
  const League({
    @JsonKey(readValue: _readLeagueId) required this.id,
    @JsonKey(readValue: _readLeagueName) required this.name,
    @JsonKey(readValue: _readLeagueCountry) this.country,
    @JsonKey(readValue: _readLeagueSeason) this.season,
    @JsonKey(readValue: _readLeagueType) this.type,
    @JsonKey(readValue: _readLeagueLogo) this.logo,
  });

  final int id;
  final String name;
  final String? country;
  final int? season;

  /// League/Cup
  final String? type;
  final String? logo;

  factory League.fromJson(Map<String, dynamic> json) => _$LeagueFromJson(json);
  Map<String, dynamic> toJson() => _$LeagueToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is League &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          country == other.country &&
          season == other.season &&
          type == other.type &&
          logo == other.logo;

  @override
  int get hashCode => Object.hash(id, name, country, season, type, logo);
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
    return (league as Map)[key];
  }
  return null;
}

int? _asNullableInt(Object? value) {
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return value is int ? value : null;
}
