// path: lib/data/models/favorite.dart
// Favorite - tracks user favorites (league/team/match) locally per PRD.
import 'package:FlutterApp/data/models/base_equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite.g.dart';

enum FavoriteType { leagues, teams, matches }

@JsonSerializable()
class Favorite extends EquatableModel {
  const Favorite({
    required this.id,
    required this.type,
    required this.refId,
    required this.createdAt,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);

  final int id;

  @JsonKey(readValue: _readType)
  final FavoriteType type;

  @JsonKey(readValue: _readRefId)
  final int refId;

  @JsonKey(readValue: _readCreatedAt)
  final DateTime createdAt;
  Map<String, dynamic> toJson() => _$FavoriteToJson(this);

  @override
  List<Object?> get props => [id, type, refId, createdAt];
}

Object? _readType(Map<dynamic, dynamic> json, String key) {
  final value = json[key] ?? json['type'];
  if (value == null) return null;
  final normalized = value.toString().toLowerCase();
  switch (normalized) {
    case 'league':
      return FavoriteType.leagues;
    case 'team':
      return FavoriteType.teams;
    case 'match':
      return FavoriteType.matches;
  }
  throw ArgumentError.value(value, key, 'Unsupported favorite type');
}

Object? _readRefId(Map<dynamic, dynamic> json, String key) {
  final value = json[key] ?? json['ref_id'] ?? json['refId'];
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return value;
}

Object? _readCreatedAt(Map<dynamic, dynamic> json, String key) {
  final value = json[key] ?? json['created_at'];
  if (value is DateTime) return value.toIso8601String();
  if (value is String) return value;
  return value;
}
