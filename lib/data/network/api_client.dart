// path: lib/data/network/api_client.dart
import 'package:FlutterApp/constants/app_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Centralized Dio client configured from AppConfig.
/// All services receive this instance (with baseUrl + headers).
class ApiClient {
  ApiClient._internal()
    : dio =
          Dio(
              BaseOptions(
                baseUrl: AppConfig.apiBaseUrl,
                connectTimeout: const Duration(seconds: 20),
                receiveTimeout: const Duration(seconds: 20),
                sendTimeout: const Duration(seconds: 20),
                headers: AppConfig.defaultHeaders,
              ),
            )
            ..interceptors.add(
              InterceptorsWrapper(
                onRequest: (options, handler) async {
                  // Ensure default timezone param on GET requests unless provided.
                  if (options.method.toUpperCase() == 'GET' &&
                      !options.queryParameters.containsKey('timezone')) {
                    options.queryParameters['timezone'] =
                        AppConfig.defaultTimezone;
                  }
                  handler.next(options);
                },
                onError: (e, handler) {
                  if (kDebugMode) {
                    // ignore: avoid_print
                    print('[DioError] ${e.requestOptions.uri} -> ${e.message}');
                  }
                  handler.next(e);
                },
              ),
            );

  static final ApiClient I = ApiClient._internal();

  final Dio dio;
}
