// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fixture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fixture _$FixtureFromJson(Map<String, dynamic> json) => Fixture(
  fixtureId: (_readFixtureId(json, 'fixtureId') as num).toInt(),
  leagueId: (_readLeagueId(json, 'leagueId') as num).toInt(),
  leagueName: _readLeagueName(json, 'leagueName') as String,
  country: _readLeagueCountry(json, 'country') as String?,
  dateUtc: DateTime.parse(_readDateUtc(json, 'dateUtc') as String),
  status: _readStatus(json, 'status') as String,
  minute: (_readMinute(json, 'minute') as num?)?.toInt(),
  homeTeam: TeamRef.fromJson(
    _readHomeTeam(json, 'homeTeam') as Map<String, dynamic>,
  ),
  awayTeam: TeamRef.fromJson(
    _readAwayTeam(json, 'awayTeam') as Map<String, dynamic>,
  ),
  goalsHome: (_readGoalsHome(json, 'goalsHome') as num?)?.toInt(),
  goalsAway: (_readGoalsAway(json, 'goalsAway') as num?)?.toInt(),
);

Map<String, dynamic> _$FixtureToJson(Fixture instance) => <String, dynamic>{
  'fixtureId': instance.fixtureId,
  'leagueId': instance.leagueId,
  'leagueName': instance.leagueName,
  'country': instance.country,
  'dateUtc': instance.dateUtc.toIso8601String(),
  'status': instance.status,
  'minute': instance.minute,
  'homeTeam': instance.homeTeam.toJson(),
  'awayTeam': instance.awayTeam.toJson(),
  'goalsHome': instance.goalsHome,
  'goalsAway': instance.goalsAway,
};
