// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favorite _$FavoriteFromJson(Map<String, dynamic> json) => Favorite(
  id: (json['id'] as num).toInt(),
  type: $enumDecode(_$FavoriteTypeEnumMap, _readType(json, 'type')),
  refId: (_readRefId(json, 'refId') as num).toInt(),
  createdAt: DateTime.parse(_readCreatedAt(json, 'createdAt') as String),
);

Map<String, dynamic> _$FavoriteToJson(Favorite instance) => <String, dynamic>{
  'id': instance.id,
  'type': _$FavoriteTypeEnumMap[instance.type]!,
  'refId': instance.refId,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$FavoriteTypeEnumMap = {
  FavoriteType.league: 'league',
  FavoriteType.team: 'team',
  FavoriteType.match: 'match',
};
