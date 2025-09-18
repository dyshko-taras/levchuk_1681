// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamStats _$TeamStatsFromJson(Map<String, dynamic> json) => TeamStats(
  teamId: (_readTeamId(json, 'teamId') as num).toInt(),
  leagueId: (_readLeagueId(json, 'leagueId') as num).toInt(),
  season: (_readSeason(json, 'season') as num).toInt(),
  form: _readForm(json, 'form') as String?,
  goalsForAvg: (_readGoalsForAvg(json, 'goalsForAvg') as num?)?.toDouble(),
  goalsAgainstAvg: (_readGoalsAgainstAvg(json, 'goalsAgainstAvg') as num?)
      ?.toDouble(),
  cleanSheets: (_readCleanSheets(json, 'cleanSheets') as num?)?.toInt(),
  failedToScore: (_readFailedToScore(json, 'failedToScore') as num?)?.toInt(),
);

Map<String, dynamic> _$TeamStatsToJson(TeamStats instance) => <String, dynamic>{
  'teamId': instance.teamId,
  'leagueId': instance.leagueId,
  'season': instance.season,
  'form': instance.form,
  'goalsForAvg': instance.goalsForAvg,
  'goalsAgainstAvg': instance.goalsAgainstAvg,
  'cleanSheets': instance.cleanSheets,
  'failedToScore': instance.failedToScore,
};
