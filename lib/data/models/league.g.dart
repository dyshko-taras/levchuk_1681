// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

League _$LeagueFromJson(Map<String, dynamic> json) => League(
  id: (_readLeagueId(json, 'id') as num).toInt(),
  name: _readLeagueName(json, 'name') as String,
  country: _readLeagueCountry(json, 'country') as String?,
  season: (_readLeagueSeason(json, 'season') as num?)?.toInt(),
  type: _readLeagueType(json, 'type') as String?,
  logo: _readLeagueLogo(json, 'logo') as String?,
);

Map<String, dynamic> _$LeagueToJson(League instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'country': instance.country,
  'season': instance.season,
  'type': instance.type,
  'logo': instance.logo,
};
