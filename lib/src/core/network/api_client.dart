import 'dart:async';

import 'package:dio/dio.dart';

import '../config/app_config.dart';
import '../error/app_exception.dart';

typedef AccessTokenResolver = Future<String?> Function();

typedef RefreshTokenHandler = Future<String?> Function();

typedef OnUnauthorized = Future<void> Function();

abstract interface class ApiClient {
  Future<Map<String, dynamic>> getJson(
    String path, {
    Map<String, dynamic>? queryParameters,
  });

  Future<Map<String, dynamic>> postJson(
    String path, {
    Object? body,
  });

  Future<Map<String, dynamic>> patchJson(
    String path, {
    Object? body,
  });

  Future<void> delete(String path);
}

final class DioApiClient implements ApiClient {
  DioApiClient(
    AppConfig config, {
    AccessTokenResolver? accessTokenResolver,
    RefreshTokenHandler? refreshTokenHandler,
    OnUnauthorized? onUnauthorized,
  }) : _dio = Dio(
          BaseOptions(
            baseUrl: config.apiBaseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 20),
            sendTimeout: const Duration(seconds: 20),
          ),
        ) {
    if (accessTokenResolver != null) {
      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            final token = await accessTokenResolver();
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            return handler.next(options);
          },
          onError: (error, handler) async {
            if (error.response?.statusCode == 401 &&
                refreshTokenHandler != null &&
                onUnauthorized != null) {
              try {
                final newToken = await refreshTokenHandler();
                if (newToken != null && newToken.isNotEmpty) {
                  final requestOptions = error.requestOptions;
                  requestOptions.headers['Authorization'] = 'Bearer $newToken';
                  final response = await _dio.request<Object?>(
                    requestOptions.path,
                    data: requestOptions.data,
                    queryParameters: requestOptions.queryParameters,
                    options: Options(
                      method: requestOptions.method,
                      headers: requestOptions.headers,
                    ),
                  );
                  return handler.resolve(response);
                }
              } on Exception {
                await onUnauthorized();
              }
            }
            return handler.next(error);
          },
        ),
      );
    }
  }

  final Dio _dio;

  @override
  Future<Map<String, dynamic>> getJson(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _request(
      () => _dio.get<Object?>(path, queryParameters: queryParameters),
    );
  }

  @override
  Future<Map<String, dynamic>> postJson(String path, {Object? body}) async {
    return _request(() => _dio.post<Object?>(path, data: body));
  }

  @override
  Future<Map<String, dynamic>> patchJson(String path, {Object? body}) async {
    return _request(() => _dio.patch<Object?>(path, data: body));
  }

  @override
  Future<void> delete(String path) async {
    await _request(() => _dio.delete<Object?>(path));
  }

  Future<Map<String, dynamic>> _request(
    Future<Response<Object?>> Function() request,
  ) async {
    try {
      final response = await request();
      final data = response.data;
      if (data == null) {
        return <String, dynamic>{};
      }
      if (data is Map<String, dynamic>) {
        return data;
      }
      throw const NetworkException('Unexpected API response shape');
    } on DioException catch (error, stackTrace) {
      throw NetworkException(
        'Network request failed',
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }
}
