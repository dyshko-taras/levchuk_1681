// path: lib/data/api/api_client.dart
// Base Dio client per Guidelines → Networking structure.
import 'package:FlutterApp/constants/app_config.dart';
import 'package:FlutterApp/core/endpoints.dart';
import 'package:FlutterApp/core/env.dart';
import 'package:dio/dio.dart';

class ApiClient {
  ApiClient._();

  static final Dio dio =
      Dio(
          BaseOptions(
            baseUrl: Endpoints.baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: AppConfig.apiHeaders,
          ),
        )
        ..interceptors.addAll([
          if (!Env.isProd) LogInterceptor(),
          _RetryOn429Interceptor(),
        ]);

  /// Update headers (e.g., if the key changes at runtime).
  static void refreshHeaders() {
    dio.options.headers = AppConfig.apiHeaders;
  }
}

/// Simple retry/backoff for idempotent GETs (429/5xx), per Plan.
/// Backoff: 500ms, 1500ms, 3000ms with jitter.
class _RetryOn429Interceptor extends Interceptor {
  static const _delays = <int>[500, 1500, 3000];

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final req = err.requestOptions;
    final isGet = req.method.toUpperCase() == 'GET';
    final code = err.response?.statusCode ?? 0;
    final shouldRetry = isGet && (code == 429 || (code >= 500 && code < 600));
    final attempt = (req.extra['retry_attempt'] as int?) ?? 0;

    if (!shouldRetry || attempt >= _RetryOn429Interceptor._delays.length) {
      return handler.next(err);
    }

    final baseDelayMs = _RetryOn429Interceptor._delays[attempt];
    final jitter = (baseDelayMs * 0.2).toInt();
    final waitMs = baseDelayMs + (DateTime.now().microsecond % (jitter + 1));
    await Future<void>.delayed(Duration(milliseconds: waitMs));

    final clone = await _retryRequest(req, attempt + 1);
    return handler.resolve(clone);
  }

  Future<Response<dynamic>> _retryRequest(RequestOptions req, int attempt) {
    final opts = Options(
      method: req.method,
      headers: req.headers,
      responseType: req.responseType,
      followRedirects: req.followRedirects,
      contentType: req.contentType,
      validateStatus: req.validateStatus,
      receiveDataWhenStatusError: req.receiveDataWhenStatusError,
      extra: <String, Object?>{...req.extra, 'retry_attempt': attempt},
    );
    return ApiClient.dio.request<dynamic>(
      req.path,
      data: req.data,
      queryParameters: req.queryParameters,
      options: opts,
      cancelToken: req.cancelToken,
      onReceiveProgress: req.onReceiveProgress,
      onSendProgress: req.onSendProgress,
    );
  }
}
