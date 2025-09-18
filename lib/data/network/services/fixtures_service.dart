// path: lib/data/network/services/fixtures_service.dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../constants/app_config.dart';
import '../../models/fixture.dart';

part 'fixtures_service.g.dart';

/// Retrofit API for fixtures (match schedule/details).
@RestApi(baseUrl: AppConfig.apiBaseUrl)
abstract class FixturesService {
  factory FixturesService(Dio dio, {String baseUrl}) = _FixturesService;

  /// GET /fixtures?date=YYYY-MM-DD&timezone=Europe/Kyiv
  @GET('/fixtures')
  Future<List<Fixture>> getFixturesByDate({
    @Query('date') required String yyyyMmDd,
    @Query('timezone') String timezone = AppConfig.defaultTimezone,
  });

  /// GET /fixtures?id={fixtureId}
  @GET('/fixtures')
  Future<Fixture> getFixtureById({
    @Query('id') required int fixtureId,
    @Query('timezone') String timezone = AppConfig.defaultTimezone,
  });
}
