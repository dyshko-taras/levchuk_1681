// path: lib/data/models/fixture.dart
import 'package:FlutterApp/data/models/base_equatable.dart';
import 'package:FlutterApp/data/models/team_ref.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fixture.g.dart';

@JsonSerializable(explicitToJson: true)
class Fixture extends EquatableModel {
  const Fixture({
    required this.fixtureId,
    required this.leagueId,
    required this.leagueName,
    required this.dateUtc,
    required this.status,
    required this.homeTeam,
    required this.awayTeam,
    this.country,
    this.minute,
    this.goalsHome,
    this.goalsAway,
    this.stadium,
    this.city,
    this.referee,
  });

  factory Fixture.fromJson(Map<String, dynamic> json) =>
      _$FixtureFromJson(json);

  /// Unique fixture identifier.
  @JsonKey(readValue: _readFixtureId)
  final int fixtureId;

  /// League identifier that this fixture belongs to.
  @JsonKey(readValue: _readLeagueId)
  final int leagueId;

  /// Human-readable league name (e.g., "Premier League").
  @JsonKey(readValue: _readLeagueName)
  final String leagueName;

  /// Country (nullable for international/cups).
  @JsonKey(readValue: _readLeagueCountry)
  final String? country;

  /// Kickoff in UTC.
  @JsonKey(readValue: _readDateUtc)
  final DateTime dateUtc;

  /// Status code (NS/1H/HT/2H/FT/ET/PST).
  @JsonKey(readValue: _readStatus)
  final String status;

  /// Current live minute (nullable if not live).
  @JsonKey(readValue: _readMinute)
  final int? minute;

  /// Home team reference.
  @JsonKey(readValue: _readHomeTeam)
  final TeamRef homeTeam;

  /// Away team reference.
  @JsonKey(readValue: _readAwayTeam)
  final TeamRef awayTeam;

  /// Current/full-time home goals (nullable pre-kickoff).
  @JsonKey(readValue: _readGoalsHome)
  final int? goalsHome;

  /// Current/full-time away goals (nullable pre-kickoff).
  @JsonKey(readValue: _readGoalsAway)
  final int? goalsAway;

  /// Stadium name (fixture.venue.name).
  @JsonKey(readValue: _readStadium)
  final String? stadium;

  /// City of the venue (fixture.venue.city).
  @JsonKey(readValue: _readCity)
  final String? city;

  /// Referee (fixture.referee).
  @JsonKey(readValue: _readReferee)
  final String? referee;

  Map<String, dynamic> toJson() => _$FixtureToJson(this);

  @override
  List<Object?> get props => [
    fixtureId,
    leagueId,
    leagueName,
    country,
    dateUtc,
    status,
    minute,
    homeTeam,
    awayTeam,
    goalsHome,
    goalsAway,
    stadium,
    city,
    referee,
  ];
}

// -------------------- JSON read helpers --------------------

Object? _readFixtureId(Map<dynamic, dynamic> json, String key) =>
    _asNullableInt(_readValue(json, key, const ['fixture', 'id']));

Object? _readLeagueId(Map<dynamic, dynamic> json, String key) =>
    _asNullableInt(_readValue(json, key, const ['league', 'id']));

Object? _readLeagueName(Map<dynamic, dynamic> json, String key) =>
    _readValue(json, key, const ['league', 'name']);

Object? _readLeagueCountry(Map<dynamic, dynamic> json, String key) =>
    _readValue(json, key, const ['league', 'country']);

Object? _readDateUtc(Map<dynamic, dynamic> json, String key) {
  final value = _readValue(json, key, const ['fixture', 'date']);
  if (value is DateTime) {
    return value.toIso8601String();
  }
  return value;
}

Object? _readStatus(Map<dynamic, dynamic> json, String key) =>
    _readValue(json, key, const ['fixture', 'status', 'short']);

Object? _readMinute(Map<dynamic, dynamic> json, String key) => _asNullableInt(
  _readValue(json, key, const ['fixture', 'status', 'elapsed']),
);

Object? _readHomeTeam(Map<dynamic, dynamic> json, String key) =>
    _readMapValue(json, key, const ['teams', 'home']);

Object? _readAwayTeam(Map<dynamic, dynamic> json, String key) =>
    _readMapValue(json, key, const ['teams', 'away']);

Object? _readGoalsHome(Map<dynamic, dynamic> json, String key) =>
    _asNullableInt(_readValue(json, key, const ['goals', 'home']));

Object? _readGoalsAway(Map<dynamic, dynamic> json, String key) =>
    _asNullableInt(_readValue(json, key, const ['goals', 'away']));

Object? _readStadium(Map<dynamic, dynamic> json, String key) =>
    _readValue(json, key, const ['fixture', 'venue', 'name']);

Object? _readCity(Map<dynamic, dynamic> json, String key) =>
    _readValue(json, key, const ['fixture', 'venue', 'city']);

Object? _readReferee(Map<dynamic, dynamic> json, String key) =>
    _readValue(json, key, const ['fixture', 'referee']);

// -------------------- Helpers --------------------

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
  var current = node;
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

int? _asNullableInt(Object? value) {
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return value is int ? value : null;
}
