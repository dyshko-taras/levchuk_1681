// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prediction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Prediction _$PredictionFromJson(Map<String, dynamic> json) => Prediction(
  fixtureId: (_readFixtureId(json, 'fixtureId') as num).toInt(),
  pick: json['pick'] as String,
  odds: (_readOdds(json, 'odds') as num?)?.toDouble(),
  madeAt: DateTime.parse(_readMadeAt(json, 'madeAt') as String),
  lockedAt: _readLockedAt(json, 'lockedAt') == null
      ? null
      : DateTime.parse(_readLockedAt(json, 'lockedAt') as String),
  gradedAt: _readGradedAt(json, 'gradedAt') == null
      ? null
      : DateTime.parse(_readGradedAt(json, 'gradedAt') as String),
  result: json['result'] as String?,
  openedDetails: _readOpenedDetails(json, 'openedDetails') as bool? ?? false,
);

Map<String, dynamic> _$PredictionToJson(Prediction instance) =>
    <String, dynamic>{
      'fixtureId': instance.fixtureId,
      'pick': instance.pick,
      'odds': instance.odds,
      'madeAt': instance.madeAt.toIso8601String(),
      'lockedAt': instance.lockedAt?.toIso8601String(),
      'gradedAt': instance.gradedAt?.toIso8601String(),
      'result': instance.result,
      'openedDetails': instance.openedDetails,
    };
