class AppConfig {
  AppConfig._();

  /// API-Sports base URL (v3).
  static const String apiBaseUrl = 'https://v3.football.api-sports.io';

  /// Default business timezone for all API requests.
  static const String defaultTimezone = 'Europe/Kyiv';

  /// API key from build-time environment (never hardcode).
  /// Pass with: --dart-define=API_KEY=xxxxx
  static const String apiKey = String.fromEnvironment(
    'API_KEY',
    defaultValue: 'a9b8c2c99b6c3659a0b139caf6b23d6b',//TODO change
  );

  /// Required default headers for API requests.
  static Map<String, String> get defaultHeaders => <String, String>{
    'x-apisports-key': apiKey,
    'accept': 'application/json',
  };

  /// Whether API key is present (basic guard for early boot).
  static bool get hasApiKey => apiKey.isNotEmpty;
}
