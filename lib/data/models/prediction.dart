// path: lib/data/models/prediction.dart
import 'package:json_annotation/json_annotation.dart';
import 'base_equatable.dart';

part 'prediction.g.dart';

/// User prediction record (fixture pick with optional odds and outcome).
@JsonSerializable()
class Prediction extends EquatableModel {
  const Prediction({
    required this.fixtureId,
    required this.pick, // 'home' | 'draw' | 'away'
    this.odds,
    required this.madeAt,
    this.lockedAt,
    this.result, // 'correct' | 'missed' | null
  });

  final int fixtureId;
  final String pick;
  final double? odds;
  final DateTime madeAt;
  final DateTime? lockedAt;
  final String? result;

  Prediction copyWith({
    int? fixtureId,
    String? pick,
    double? odds,
    DateTime? madeAt,
    DateTime? lockedAt,
    String? result,
  }) {
    return Prediction(
      fixtureId: fixtureId ?? this.fixtureId,
      pick: pick ?? this.pick,
      odds: odds ?? this.odds,
      madeAt: madeAt ?? this.madeAt,
      lockedAt: lockedAt ?? this.lockedAt,
      result: result ?? this.result,
    );
  }

  factory Prediction.fromJson(Map<String, dynamic> json) =>
      _$PredictionFromJson(json);
  Map<String, dynamic> toJson() => _$PredictionToJson(this);

  @override
  List<Object?> get props => <Object?>[
    fixtureId,
    pick,
    odds,
    madeAt,
    lockedAt,
    result,
  ];
}
