// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_ref.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamRef _$TeamRefFromJson(Map<String, dynamic> json) => TeamRef(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  logo: json['logo'] as String?,
);

Map<String, dynamic> _$TeamRefToJson(TeamRef instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'logo': instance.logo,
};
