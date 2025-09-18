// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prediction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Prediction _$PredictionFromJson(Map<String, dynamic> json) => Prediction(
  fixtureId: (json['fixtureId'] as num).toInt(),
  pick: json['pick'] as String,
  odds: (json['odds'] as num?)?.toDouble(),
  madeAt: DateTime.parse(json['madeAt'] as String),
  lockedAt: json['lockedAt'] == null
      ? null
      : DateTime.parse(json['lockedAt'] as String),
  result: json['result'] as String?,
);

Map<String, dynamic> _$PredictionToJson(Prediction instance) =>
    <String, dynamic>{
      'fixtureId': instance.fixtureId,
      'pick': instance.pick,
      'odds': instance.odds,
      'madeAt': instance.madeAt.toIso8601String(),
      'lockedAt': instance.lockedAt?.toIso8601String(),
      'result': instance.result,
    };
