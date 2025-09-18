// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standing_row.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StandingRow _$StandingRowFromJson(Map<String, dynamic> json) => StandingRow(
  team: TeamRef.fromJson(_readTeam(json, 'team') as Map<String, dynamic>),
  rank: (_readRank(json, 'rank') as num).toInt(),
  played: (_readPlayed(json, 'played') as num).toInt(),
  win: (_readWin(json, 'win') as num).toInt(),
  draw: (_readDraw(json, 'draw') as num).toInt(),
  lose: (_readLose(json, 'lose') as num).toInt(),
  points: (_readPoints(json, 'points') as num).toInt(),
  form: _readForm(json, 'form') as String?,
);

Map<String, dynamic> _$StandingRowToJson(StandingRow instance) =>
    <String, dynamic>{
      'team': instance.team.toJson(),
      'rank': instance.rank,
      'played': instance.played,
      'win': instance.win,
      'draw': instance.draw,
      'lose': instance.lose,
      'points': instance.points,
      'form': instance.form,
    };
