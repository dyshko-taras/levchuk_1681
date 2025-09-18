class Endpoints {
  Endpoints._();

  /// API-Sports base URL (v3).
  static const String baseUrl = 'https://v3.football.api-sports.io';

  // -------- Fixtures (matches)
  /// GET /fixtures?date=YYYY-MM-DD&timezone=Europe/Kyiv
  static const String fixtures = '/fixtures';

  // -------- Odds
  /// GET /odds?fixture={id}
  static const String odds = '/odds';
}
