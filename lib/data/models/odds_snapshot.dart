// path: lib/data/models/odds_snapshot.dart
// OddsSnapshot - odds for a fixture captured at a point in time (PRD models).
// Fields per PRD: fixtureId, home, draw, away, ts (DateTime).
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

  factory OddsSnapshot.fromJson(Map<String, dynamic> json) =>
      _$OddsSnapshotFromJson(json);

  /// Supports both a flattened shape and the API envelope at: response[0].fixture.id
  @JsonKey(readValue: _readFixtureId)
  final int fixtureId;

  /// Extracted from first bookmaker having "Match Winner" / "1x2" market.
  /// Values can be labeled "Home/Draw/Away" or "1/X/2".
  @JsonKey(readValue: _readHomeOdd)
  final double home;

  @JsonKey(readValue: _readDrawOdd)
  final double draw;

  @JsonKey(readValue: _readAwayOdd)
  final double away;

  /// Timestamp when odds were captured.
  /// Mapped from envelope: response[0].update (ISO 8601) -> DateTime
  @JsonKey(readValue: _readTimestamp)
  final DateTime ts;

  Map<String, dynamic> toJson() => _$OddsSnapshotToJson(this);

  @override
  List<Object?> get props => [fixtureId, home, draw, away, ts];
}

// ---- read helpers ----

Object? _readFixtureId(Map<dynamic, dynamic> json, String key) {
  final root = _rootObject(json);
  final value = _nestedValue(root, const ['fixture', 'id']);
  return _asNullableInt(value);
}

Object? _readHomeOdd(Map<dynamic, dynamic> json, String key) {
  final root = _rootObject(json);
  return _asNullableDouble(_extractOdd(root, const ['home', '1']));
}

Object? _readDrawOdd(Map<dynamic, dynamic> json, String key) {
  final root = _rootObject(json);
  return _asNullableDouble(_extractOdd(root, const ['draw', 'x']));
}

Object? _readAwayOdd(Map<dynamic, dynamic> json, String key) {
  final root = _rootObject(json);
  return _asNullableDouble(_extractOdd(root, const ['away', '2']));
}

Object? _readTimestamp(Map<dynamic, dynamic> json, String key) {
  final root = _rootObject(json);

  // direct (already DateTime or ISO string)
  final direct = json[key];
  if (direct is String) return direct;
  if (direct is DateTime) return direct.toIso8601String();

  // envelope "update"
  final update = root['update'];
  if (update is String) return update;
  if (update is DateTime) return update.toIso8601String();

  return direct;
}

// Return inner object if API envelope present, otherwise original map.
Map<dynamic, dynamic> _rootObject(Map<dynamic, dynamic> json) {
  final response = json['response'];
  if (response is List && response.isNotEmpty && response.first is Map) {
    return response.first as Map<dynamic, dynamic>;
  }
  return json;
}

Object? _extractOdd(
  Map<dynamic, dynamic> root,
  List<String> labels, // e.g. ['home','1'] or ['draw','x'] or ['away','2']
) {
  // If odds provided in a flattened shape like: { 'odds': {'home': '3.5', ...} }
  final odds = root['odds'];
  if (odds is Map) {
    for (final l in labels) {
      final v = odds[l] ?? odds[l.toLowerCase()];
      if (v != null) return v;
    }
  }

  // API envelope shape: response[0].bookmakers[].bets[].values[]
  final bookmakers = root['bookmakers'];
  if (bookmakers is Iterable) {
    // pick the first bookmaker that has a "Match Winner" / "1x2" market
    Map<dynamic, dynamic>? chosenBet;

    for (final bookmaker in bookmakers) {
      if (bookmaker is! Map) continue;
      final bets = bookmaker['bets'];
      if (bets is! Iterable) continue;

      for (final bet in bets) {
        if (bet is! Map) continue;
        final name = bet['name']?.toString().toLowerCase();
        if (name == null) continue;
        final isMatchWinner =
            (name.contains('match') && name.contains('winner')) ||
            name.contains('1x2');
        if (isMatchWinner) {
          chosenBet = bet;
          break;
        }
      }
      if (chosenBet != null) break;
    }

    final values = chosenBet?['values'];
    if (values is Iterable) {
      for (final value in values) {
        if (value is! Map) continue;
        final rawLabel = value['value']?.toString().toLowerCase();
        if (rawLabel == null) continue;

        // normalize: "home"/"draw"/"away" or "1"/"x"/"2" (with/without spaces)
        final normalized = rawLabel.replaceAll(' ', '');

        final labelSet = labels.map((e) => e.toLowerCase()).toSet();
        if (labelSet.contains(normalized)) {
          return value['odd'];
        }
        if (normalized.startsWith('home') && labelSet.contains('home')) {
          return value['odd'];
        }
        if (normalized.startsWith('draw') && labelSet.contains('draw')) {
          return value['odd'];
        }
        if (normalized.startsWith('away') && labelSet.contains('away')) {
          return value['odd'];
        }
      }
    }
  }

  return null;
}

// ---- generic nested helpers ----

Object? _nestedValue(Object? node, List<String> path) {
  var current = node;
  for (final segment in path) {
    if (current is Map) {
      current = current[segment];
    } else if (current is List && current.isNotEmpty) {
      current = current.first;
      if (current is Map) {
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
