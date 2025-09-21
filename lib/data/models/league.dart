// League - normalized league/competition entity (PRD models).
// Fields per PRD: id, name, country?, season?, type?, logo?
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

  /// Country name, e.g. "England" / "World"
  @JsonKey(readValue: _readLeagueCountry)
  final String? country;

  /// Current/selected season (may be null for /leagues listing)
  @JsonKey(readValue: _readLeagueSeason)
  final int? season;

  /// "League" / "Cup"
  @JsonKey(readValue: _readLeagueType)
  final String? type;

  @JsonKey(readValue: _readLeagueLogo)
  final String? logo;

  factory League.fromJson(Map<String, dynamic> json) => _$LeagueFromJson(json);
  Map<String, dynamic> toJson() => _$LeagueToJson(this);

  @override
  List<Object?> get props => [id, name, country, season, type, logo];
}

// -------------------- read helpers --------------------

Object? _readLeagueId(Map<dynamic, dynamic> json, String key) =>
    _asNullableInt(_readLeagueField(json, key));

Object? _readLeagueName(Map<dynamic, dynamic> json, String key) =>
    _readLeagueField(json, key);

Object? _readLeagueCountry(Map<dynamic, dynamic> json, String key) {
  // 1) Перевага внутрішньому league.country якщо це String
  final directFromLeague = _readFromNestedMap(json, 'league', key);
  if (directFromLeague is String) return directFromLeague;

  // 2) Якщо на верхньому рівні country — це мапа, беремо country.name
  final countryObj = json['country'];
  if (countryObj is Map) {
    final name = countryObj['name'];
    if (name is String) return name;
  }

  // 3) Якщо чомусь поле вже є рядком на верхньому рівні
  final direct = json[key];
  if (direct is String) return direct;

  return null;
}

Object? _readLeagueSeason(Map<dynamic, dynamic> json, String key) =>
    _asNullableInt(_readLeagueField(json, key));

Object? _readLeagueType(Map<dynamic, dynamic> json, String key) =>
    _readLeagueField(json, key);

Object? _readLeagueLogo(Map<dynamic, dynamic> json, String key) =>
    _readLeagueField(json, key);

/// Повертає або верхньорівневе поле, або league[key] якщо воно там.
Object? _readLeagueField(Map<dynamic, dynamic> json, String key) {
  final direct = json[key];
  if (direct != null) return direct;

  return _readFromNestedMap(json, 'league', key);
}

Object? _readFromNestedMap(
  Map<dynamic, dynamic> json,
  String mapKey,
  String key,
) {
  final nested = json[mapKey];
  if (nested is Map<String, dynamic>) return nested[key];
  if (nested is Map) return nested[key];
  return null;
}

int? _asNullableInt(Object? value) {
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return value is int ? value : null;
}
