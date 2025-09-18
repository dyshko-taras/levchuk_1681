// path: lib/data/models/odds_snapshot.dart
import 'package:json_annotation/json_annotation.dart';
import 'base_equatable.dart';

part 'odds_snapshot.g.dart';

/// Single snapshot of 1X2 odds for a fixture at time `ts`.
@JsonSerializable()
class OddsSnapshot extends EquatableModel {
  const OddsSnapshot({
    required this.fixtureId,
    required this.home,
    required this.draw,
    required this.away,
    required this.ts,
  });

  final int fixtureId;
  final double home;
  final double draw;
  final double away;
  final DateTime ts;

  OddsSnapshot copyWith({
    int? fixtureId,
    double? home,
    double? draw,
    double? away,
    DateTime? ts,
  }) {
    return OddsSnapshot(
      fixtureId: fixtureId ?? this.fixtureId,
      home: home ?? this.home,
      draw: draw ?? this.draw,
      away: away ?? this.away,
      ts: ts ?? this.ts,
    );
  }

  factory OddsSnapshot.fromJson(Map<String, dynamic> json) =>
      _$OddsSnapshotFromJson(json);
  Map<String, dynamic> toJson() => _$OddsSnapshotToJson(this);

  @override
  List<Object?> get props => <Object?>[fixtureId, home, draw, away, ts];
}
