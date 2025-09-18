// path: lib/data/models/team_ref.dart
import 'package:FlutterApp/data/models/base_equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team_ref.g.dart';

/// Minimal reference to a team (PRD: id, name, optional logo).
@JsonSerializable()
class TeamRef extends EquatableModel {
  const TeamRef({
    required this.id,
    required this.name,
    this.logo,
  });

  factory TeamRef.fromJson(Map<String, dynamic> json) =>
      _$TeamRefFromJson(json);

  final int id;
  final String name;
  final String? logo;

  TeamRef copyWith({
    int? id,
    String? name,
    String? logo,
  }) {
    return TeamRef(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
    );
  }

  Map<String, dynamic> toJson() => _$TeamRefToJson(this);

  @override
  List<Object?> get props => <Object?>[id, name, logo];
}
