// path: lib/data/api/football_service.dart
// Retrofit interface for API-Sports (football) endpoints.
// Typed returns follow PRD "response_model" declarations.
import 'package:FlutterApp/core/env.dart';
import 'package:FlutterApp/data/api/api_client.dart';
import 'package:FlutterApp/data/models/fixture.dart';
import 'package:FlutterApp/data/models/league.dart';
import 'package:FlutterApp/data/models/odds_snapshot.dart';
import 'package:FlutterApp/data/models/standing_row.dart';
import 'package:FlutterApp/data/models/team_ref.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'football_service.g.dart';

@RestApi(baseUrl: '')
abstract class FootballService {
  factory FootballService(Dio dio, {String baseUrl}) = _FootballService;

  // -------- Fixtures (matches) ---------------------------------------------

  /// GET /fixtures?date=YYYY-MM-DD&timezone=Europe/Kyiv
  @GET('/fixtures')
  Future<List<Fixture>> getFixturesByDate({
    @Query('date') required String dateYmd,
    @Query('timezone') String timezone = Env.tz,
  }); // PRD endpoints. :contentReference[oaicite:0]{index=0}

  /// GET /fixtures?league={id}&season={YYYY}&date?&status?&timezone=Europe/Kyiv
  @GET('/fixtures')
  Future<List<Fixture>> getFixturesByLeague({
    @Query('league') required int leagueId,
    @Query('season') required int season,
    @Query('date') String? dateYmd,
    @Query('status') String? status,
    @Query('timezone') String timezone = Env.tz,
  }); // :contentReference[oaicite:1]{index=1}

  /// GET /fixtures?ids=123-456&timezone=Europe/Kyiv
  @GET('/fixtures')
  Future<List<Fixture>> getFixturesByIds({
    @Query('ids') required String idsDashSeparated,
    @Query('timezone') String timezone = Env.tz,
  }); // :contentReference[oaicite:2]{index=2}

  /// GET /fixtures?live=all&timezone=Europe/Kyiv
  @GET('/fixtures')
  Future<List<Fixture>> getLiveFixtures({
    @Query('live') String live = 'all',
    @Query('timezone') String timezone = Env.tz,
  }); // :contentReference[oaicite:3]{index=3}

  /// GET /fixtures?id={id}&timezone=Europe/Kyiv → returns a list with 1 item
  @GET('/fixtures')
  Future<List<Fixture>> getFixtureById({
    @Query('id') required int id,
    @Query('timezone') String timezone = Env.tz,
  }); // :contentReference[oaicite:4]{index=4}

  // -------- Odds -----------------------------------------------------------

  /// GET /odds?fixture={id}
  @GET('/odds')
  Future<OddsSnapshot> getOddsByFixture({
    @Query('fixture') required int fixtureId,
  }); // :contentReference[oaicite:5]{index=5}

  // -------- Leagues/Teams/Stats -------------------------------------------

  /// GET /leagues?country?&type?&season?
  @GET('/leagues')
  Future<List<League>> getLeagues({
    @Query('country') String? country,
    @Query('type') String? type,
    @Query('season') int? season,
  }); // :contentReference[oaicite:6]{index=6}

 /// GET /teams?id={teamId}[&season={YYYY}]
 @GET('/teams')
 Future<List<TeamRef>> getTeamsById({
   @Query('id') required int teamId,
   @Query('season') int? season,
 });

  /// GET /standings?league={id}&season={YYYY}
  @GET('/standings')
  Future<List<StandingRow>> getStandings({
    @Query('league') required int leagueId,
    @Query('season') required int season,
  }); // :contentReference[oaicite:9]{index=9}
}

/// Factory helper wired to our configured Dio.
FootballService createFootballService() =>
    FootballService(ApiClient.dio, baseUrl: ApiClient.dio.options.baseUrl);
