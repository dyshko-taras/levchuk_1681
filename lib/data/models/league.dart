// path: lib/data/models/league.dart
import 'package:FlutterApp/data/models/base_equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'league.g.dart';

/// League metadata (PRD).
@JsonSerializable()
class League extends EquatableModel {
  const League({
    required this.id,
    required this.name,
    this.country,
    this.season,
    this.type,
    this.logo,
  });

  factory League.fromJson(Map<String, dynamic> json) => _$LeagueFromJson(json);

  final int id;
  final String name;
  final String? country;
  final int? season;
  final String? type; // League/Cup
  final String? logo;

  League copyWith({
    int? id,
    String? name,
    String? country,
    int? season,
    String? type,
    String? logo,
  }) {
    return League(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      season: season ?? this.season,
      type: type ?? this.type,
      logo: logo ?? this.logo,
    );
  }

  Map<String, dynamic> toJson() => _$LeagueToJson(this);

  @override
  List<Object?> get props => <Object?>[id, name, country, season, type, logo];
}
