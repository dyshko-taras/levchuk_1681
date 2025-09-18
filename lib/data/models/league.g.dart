// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

League _$LeagueFromJson(Map<String, dynamic> json) => League(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  country: json['country'] as String?,
  season: (json['season'] as num?)?.toInt(),
  type: json['type'] as String?,
  logo: json['logo'] as String?,
);

Map<String, dynamic> _$LeagueToJson(League instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'country': instance.country,
  'season': instance.season,
  'type': instance.type,
  'logo': instance.logo,
};
