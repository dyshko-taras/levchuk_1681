// path: lib/data/models/fixture.dart
import 'package:json_annotation/json_annotation.dart';
import 'base_equatable.dart';
import 'team_ref.dart';

part 'fixture.g.dart';

/// Match fixture snapshot (PRD).
@JsonSerializable()
class Fixture extends EquatableModel {
  const Fixture({
    required this.fixtureId,
    required this.leagueId,
    required this.leagueName,
    this.country,
    required this.dateUtc,
    required this.status,
    this.minute,
    required this.homeTeam,
    required this.awayTeam,
    this.goalsHome,
    this.goalsAway,
  });

  final int fixtureId;
  final int leagueId;
  final String leagueName;
  final String? country;
  final DateTime dateUtc;

  /// Status codes like NS/1H/HT/2H/FT/ET/PST...
  final String status;

  /// Live minute, when applicable.
  final int? minute;

  final TeamRef homeTeam;
  final TeamRef awayTeam;

  final int? goalsHome;
  final int? goalsAway;

  bool get isFinished => status == 'FT';
  bool get isLive =>
      status == '1H' || status == '2H' || status == 'ET' || status == 'P';

  Fixture copyWith({
    int? fixtureId,
    int? leagueId,
    String? leagueName,
    String? country,
    DateTime? dateUtc,
    String? status,
    int? minute,
    TeamRef? homeTeam,
    TeamRef? awayTeam,
    int? goalsHome,
    int? goalsAway,
  }) {
    return Fixture(
      fixtureId: fixtureId ?? this.fixtureId,
      leagueId: leagueId ?? this.leagueId,
      leagueName: leagueName ?? this.leagueName,
      country: country ?? this.country,
      dateUtc: dateUtc ?? this.dateUtc,
      status: status ?? this.status!,
      minute: minute ?? this.minute,
      homeTeam: homeTeam ?? this.homeTeam,
      awayTeam: awayTeam ?? this.awayTeam,
      goalsHome: goalsHome ?? this.goalsHome,
      goalsAway: goalsAway ?? this.goalsAway,
    );
  }

  factory Fixture.fromJson(Map<String, dynamic> json) =>
      _$FixtureFromJson(json);
  Map<String, dynamic> toJson() => _$FixtureToJson(this);

  @override
  List<Object?> get props => <Object?>[
    fixtureId,
    leagueId,
    leagueName,
    country,
    dateUtc,
    status,
    minute,
    homeTeam,
    awayTeam,
    goalsHome,
    goalsAway,
  ];
}
