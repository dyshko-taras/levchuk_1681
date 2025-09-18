// path: lib/core/endpoints.dart
// Typed REST endpoints & helpers, no networking side effects.
import 'package:FlutterApp/core/env.dart';
import 'package:flutter/foundation.dart';

/// REST paths used by Retrofit services.
/// Centralized to avoid scattering strings across the codebase.
@immutable
final class Endpoints {
  const Endpoints._();

  /// Base URL for all API calls.
  static const String baseUrl = Env.apiBaseUrl; // confirmed by user

  /// GET /leagues?country={NAME}&season={YYYY}
  static String leagues({required String country, required int season}) =>
      '/leagues?country=$country&season=$season';

  /// GET /fixtures?league={id}&season={YYYY}&date=YYYY-MM-DD&timezone=Europe/Kyiv
  static String fixturesByLeagueDate({
    required int leagueId,
    required int season,
    required DateTime date,
  }) {
    final d =
        '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
    return '/fixtures?league=$leagueId&season=$season&date=$d&timezone=${Uri.encodeQueryComponent(Env.tz)}';
  }

  /// GET /odds?fixture={id}
  static String oddsByFixture({required int fixtureId}) =>
      '/odds?fixture=$fixtureId';

  /// Optional batch: GET /fixtures?ids=1-2-3
  static String fixturesByIds(List<int> ids) =>
      '/fixtures?ids=${ids.join('-')}&timezone=${Uri.encodeQueryComponent(Env.tz)}';
}
