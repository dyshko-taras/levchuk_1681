// path: lib/data/models/odds_snapshot.dart
// OddsSnapshot - odds for a fixture captured at a point in time (PRD models).
// Fields per PRD: fixtureId, home, draw, away, ts (DateTime). :contentReference[oaicite:3]{index=3}
import 'package:FlutterApp/data/models/base_equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'odds_snapshot.g.dart';

@JsonSerializable()
class OddsSnapshot extends EquatableModel {
  const OddsSnapshot({
    required this.fixtureId,
    required this.home,
    required this.draw,
    required this.away,
    required this.ts,
  });

  @JsonKey(readValue: _readFixtureId)
  final int fixtureId;

  @JsonKey(readValue: _readHomeOdd)
  final double home;

  @JsonKey(readValue: _readDrawOdd)
  final double draw;

  @JsonKey(readValue: _readAwayOdd)
  final double away;

  /// Timestamp when odds were captured.
  @JsonKey(readValue: _readTimestamp)
  final DateTime ts;

  factory OddsSnapshot.fromJson(Map<String, dynamic> json) =>
      _$OddsSnapshotFromJson(json);

  Map<String, dynamic> toJson() => _$OddsSnapshotToJson(this);

  @override
  List<Object?> get props => [fixtureId, home, draw, away, ts];
}

Object? _readFixtureId(Map<dynamic, dynamic> json, String key) =>
    _asNullableInt(_valueOrPath(json, key, const ['fixture', 'id']));

Object? _readHomeOdd(Map<dynamic, dynamic> json, String key) =>
    _asNullableDouble(_extractOdd(json, key, const ['home', '1']));

Object? _readDrawOdd(Map<dynamic, dynamic> json, String key) =>
    _asNullableDouble(_extractOdd(json, key, const ['draw', 'x']));

Object? _readAwayOdd(Map<dynamic, dynamic> json, String key) =>
    _asNullableDouble(_extractOdd(json, key, const ['away', '2']));

Object? _readTimestamp(Map<dynamic, dynamic> json, String key) {
  final direct = json[key];
  if (direct is String) return direct;
  if (direct is DateTime) return direct.toIso8601String();
  final fromUpdate = _valueOrPath(json, 'update', const ['update']);
  if (fromUpdate is DateTime) return fromUpdate.toIso8601String();
  if (fromUpdate is String) return fromUpdate;
  return direct;
}

Object? _extractOdd(
  Map<dynamic, dynamic> json,
  String directKey,
  List<String> labels,
) {
  final direct = json[directKey];
  if (direct != null) return direct;

  final odds = json['odds'];
  if (odds is Map<String, dynamic>) {
    for (final label in labels) {
      final candidate = odds[label] ?? odds[label.toLowerCase()];
      if (candidate != null) return candidate;
    }
  }

  final bookmakers = json['bookmakers'];
  if (bookmakers is Iterable) {
    for (final bookmaker in bookmakers) {
      if (bookmaker is Map) {
        final bets = bookmaker['bets'];
        if (bets is Iterable) {
          for (final bet in bets) {
            if (bet is Map) {
              final name = bet['name']?.toString().toLowerCase();
              if (name == null ||
                  !(name.contains('match') && name.contains('winner')) &&
                      !name.contains('1x2')) {
                continue;
              }
              final values = bet['values'];
              if (values is Iterable) {
                for (final value in values) {
                  if (value is Map) {
                    final label = value['value']?.toString().toLowerCase();
                    if (label == null) continue;
                    if (labels
                        .map((l) => l.toLowerCase())
                        .contains(label.replaceAll(' ', ''))) {
                      return value['odd'];
                    }
                    if (label.startsWith('home') && labels.contains('home')) {
                      return value['odd'];
                    }
                    if (label.startsWith('draw') && labels.contains('draw')) {
                      return value['odd'];
                    }
                    if (label.startsWith('away') && labels.contains('away')) {
                      return value['odd'];
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  return direct;
}

Object? _valueOrPath(
  Map<dynamic, dynamic> json,
  String directKey,
  List<String> path,
) {
  if (json.containsKey(directKey)) {
    return json[directKey];
  }
  return _nestedValue(json, path);
}

Object? _nestedValue(Object? node, List<String> path) {
  Object? current = node;
  for (final segment in path) {
    if (current is Map<String, dynamic>) {
      current = current[segment];
    } else if (current is Map) {
      current = current[segment];
    } else if (current is List && current.isNotEmpty) {
      current = current.first;
      if (current is Map<String, dynamic>) {
        current = current[segment];
      } else if (current is Map) {
        current = current[segment];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
  return current;
}

double? _asNullableDouble(Object? value) {
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return value is double ? value : null;
}

int? _asNullableInt(Object? value) {
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return value is int ? value : null;
}
