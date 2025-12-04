import 'dart:developer';

import 'package:dio/dio.dart';

class DioApiClient {
  final Dio _dio;

  DioApiClient._(this._dio);

  /// Экземпляр Dio
  Dio get dio => _dio;

  /// Создаёт и настраивает [DioApiClient].
  ///
  /// [baseUrl] – базовый URL для всех запросов.
  static Future<DioApiClient> create({required String baseUrl}) async {
    final dio = Dio(BaseOptions(baseUrl: baseUrl));

    // Логгер запросов/ответов для отладки (можно убрать или ограничить).
    dio.interceptors.addAll([LogInterceptor(requestBody: true, responseBody: true), _TokensInterceptor(dio)]);

    return DioApiClient._(dio);
  }
}

class _TokensInterceptor extends Interceptor {
  final Dio dio;

  _TokensInterceptor(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Content-Type'] = 'application/json';

    return handler.next(options);
  }
}
