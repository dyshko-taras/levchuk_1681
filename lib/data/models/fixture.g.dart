// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fixture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fixture _$FixtureFromJson(Map<String, dynamic> json) => Fixture(
  fixtureId: (json['fixtureId'] as num).toInt(),
  leagueId: (json['leagueId'] as num).toInt(),
  leagueName: json['leagueName'] as String,
  country: json['country'] as String?,
  dateUtc: DateTime.parse(json['dateUtc'] as String),
  status: json['status'] as String,
  minute: (json['minute'] as num?)?.toInt(),
  homeTeam: TeamRef.fromJson(json['homeTeam'] as Map<String, dynamic>),
  awayTeam: TeamRef.fromJson(json['awayTeam'] as Map<String, dynamic>),
  goalsHome: (json['goalsHome'] as num?)?.toInt(),
  goalsAway: (json['goalsAway'] as num?)?.toInt(),
);

Map<String, dynamic> _$FixtureToJson(Fixture instance) => <String, dynamic>{
  'fixtureId': instance.fixtureId,
  'leagueId': instance.leagueId,
  'leagueName': instance.leagueName,
  'country': instance.country,
  'dateUtc': instance.dateUtc.toIso8601String(),
  'status': instance.status,
  'minute': instance.minute,
  'homeTeam': instance.homeTeam,
  'awayTeam': instance.awayTeam,
  'goalsHome': instance.goalsHome,
  'goalsAway': instance.goalsAway,
};
