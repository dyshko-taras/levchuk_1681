// path: lib/data/models/favorite.dart
// Favorite - tracks user favorites (league/team/match) locally per PRD.
import 'package:json_annotation/json_annotation.dart';

part 'favorite.g.dart';

enum FavoriteType { league, team, match }

@JsonSerializable()
class Favorite {
  const Favorite({
    required this.id,
    @JsonKey(readValue: _readType) required this.type,
    @JsonKey(readValue: _readRefId) required this.refId,
    @JsonKey(readValue: _readCreatedAt) required this.createdAt,
  });

  final int id;
  final FavoriteType type;
  final int refId;
  final DateTime createdAt;

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Favorite &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          type == other.type &&
          refId == other.refId &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hash(id, type, refId, createdAt);
}

Object? _readType(Map<dynamic, dynamic> json, String key) {
  final value = json[key] ?? json['type'];
  if (value == null) return null;
  final normalized = value.toString().toLowerCase();
  switch (normalized) {
    case 'league':
      return FavoriteType.league;
    case 'team':
      return FavoriteType.team;
    case 'match':
      return FavoriteType.match;
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
