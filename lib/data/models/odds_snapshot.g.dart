// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'odds_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OddsSnapshot _$OddsSnapshotFromJson(Map<String, dynamic> json) => OddsSnapshot(
  fixtureId: (_readFixtureId(json, 'fixtureId') as num).toInt(),
  home: (_readHomeOdd(json, 'home') as num).toDouble(),
  draw: (_readDrawOdd(json, 'draw') as num).toDouble(),
  away: (_readAwayOdd(json, 'away') as num).toDouble(),
  ts: DateTime.parse(_readTimestamp(json, 'ts') as String),
);

Map<String, dynamic> _$OddsSnapshotToJson(OddsSnapshot instance) =>
    <String, dynamic>{
      'fixtureId': instance.fixtureId,
      'home': instance.home,
      'draw': instance.draw,
      'away': instance.away,
      'ts': instance.ts.toIso8601String(),
    };
