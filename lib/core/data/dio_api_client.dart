import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class DioApiClient {
  final Dio _dio;

  DioApiClient._(this._dio);

  /// Экземпляр Dio
  Dio get dio => _dio;

  /// Создаёт и настраивает [DioApiClient].
  ///
  /// [baseUrl] – базовый URL для всех запросов.
  static Future<DioApiClient> create({required String baseUrl}) async {
    final dio = Dio(
      BaseOptions(baseUrl: baseUrl, connectTimeout: const Duration(seconds: 3), receiveTimeout: Duration(seconds: 5)),
    );

    // Логгер запросов/ответов для отладки (можно убрать или ограничить).
    dio.interceptors.addAll([
      if (kDebugMode)
        TalkerDioLogger(
          settings: const TalkerDioLoggerSettings(
            printResponseData: false,
            printRequestData: false,
            printResponseHeaders: true,
            printRequestHeaders: true,
          ),
        ),
      _BaseInterceptor(dio),
      _RetryInterceptor(dio, retries: 1),
    ]);

    return DioApiClient._(dio);
  }
}

class _RetryInterceptor extends Interceptor {
  final Dio dio;
  final int retries;

  _RetryInterceptor(this.dio, {this.retries = 2});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout ||
        err.response?.statusCode == 500) {
      int attempt = err.requestOptions.extra["retry_attempt"] ?? 0;

      if (attempt < retries) {
        final opts = err.requestOptions;
        opts.extra["retry_attempt"] = attempt + 1;

        try {
          final response = await dio.fetch(opts);
          return handler.resolve(response);
        } catch (_) {}
      }
    }

    return handler.next(err);
  }
}

class _BaseInterceptor extends Interceptor {
  final Dio dio;

  _BaseInterceptor(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Content-Type'] = 'application/json';

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    final data = err.response?.data;

    // Сообщение от сервера если есть
    String? serverMessage;
    if (data is Map && data['message'] is String) {
      serverMessage = data['message'] as String;
    }

    // Сообщение по HTTP статусу
    String? httpMessage;
    if (statusCode != null) {
      httpMessage = switch (statusCode) {
        400 => "Некорректный запрос",
        401 => "Необходима авторизация",
        403 => "Нет доступа к ресурсу",
        404 => "По запросу ничего не найдено",
        500 => "Ошибка сервера",
        _ => null, // остальные не трогаем
      };
    }

    // Сообщение по типу Dio ошибки
    String? dioMessage = switch (err.type) {
      DioExceptionType.connectionTimeout => "Timeout connecting to server",
      DioExceptionType.sendTimeout => "Timeout sending request",
      DioExceptionType.receiveTimeout => "Timeout receiving data",
      DioExceptionType.connectionError => "Нет подключения к интернету",
      _ => null,
    };

    // Итоговое сообщение
    final message = httpMessage ?? serverMessage ?? dioMessage ?? err.message ?? "Неизвестная ошибка";

    final newError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: message,
    );

    return handler.next(newError);
  }
}
