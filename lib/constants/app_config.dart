import 'package:flutter/foundation.dart';

@immutable
final class AppConfig {
  const AppConfig._();

  /// API-Sports key (from PRD) injected via --dart-define.
  /// PRD headers require: x-apisports-key, accept: application/json.
  static const String apiKey = String.fromEnvironment(
    'API_KEY',
    defaultValue: 'a9b8c2c99b6c3659a0b139caf6b23d6b', //TODO change
  );

  /// Common HTTP headers for API-Sports.
  static Map<String, String> get apiHeaders => <String, String>{
    'accept': 'application/json',
    if (apiKey.isNotEmpty) 'x-apisports-key': apiKey,
    'content-type': 'application/json',
  };
}
