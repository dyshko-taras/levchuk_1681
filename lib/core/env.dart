// path: lib/core/env.dart
// Environment & base configuration (no I/O here)
import 'package:flutter/foundation.dart';

/// App-wide environment flags and configuration.
/// Values here are read by Endpoints and other low-level services.
@immutable
final class Env {
  const Env._();

  /// Whether this build is production.
  static const bool isProd = bool.fromEnvironment(
    'IS_PROD',
    defaultValue: true,
  );

  /// API base URL (from user confirmation).
  /// PRD/Plan: Network Layer → Base & endpoints.
  static const String apiBaseUrl = 'https://v3.football.api-sports.io';

  /// Default timezone for business logic.
  /// PRD meta: Europe/Kyiv.
  static const String tz = 'Europe/Kyiv';
}
