// path: lib/data/network/services/odds_service.dart
import 'package:FlutterApp/constants/app_config.dart';
import 'package:FlutterApp/data/models/odds_snapshot.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'odds_service.g.dart';

/// Retrofit API for odds (1X2 market snapshot).
@RestApi(baseUrl: AppConfig.apiBaseUrl)
abstract class OddsService {
  factory OddsService(Dio dio, {String baseUrl}) = _OddsService;

  /// GET /odds?fixture={id}
  @GET('/odds')
  Future<OddsSnapshot> getOddsForFixture({
    @Query('fixture') required int fixtureId,
    @Query('timezone') String timezone = AppConfig.defaultTimezone,
  });
}
