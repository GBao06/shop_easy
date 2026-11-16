import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shop_easy/core/constants/api_constants.dart';

class DioClient {
  DioClient._();

  // Một instance Dio duy nhất cho toàn app
  static final Dio instance = _create();

  static Dio _create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // Chỉ log khi chạy debug
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: false));
    }

    return dio;
  }
}