import 'package:dio/dio.dart';
import 'package:shop_easy/core/constants/api_constants.dart';
import 'package:shop_easy/core/network/api_error.dart';
import 'package:shop_easy/core/network/dio_client.dart';
import 'package:shop_easy/features/auth/data/model/auth_tokens.dart';
import 'package:shop_easy/features/auth/data/model/user.dart';

class AuthService {
  
  AuthService({Dio? dio}) : _dio = dio ?? DioClient.instance;

  final Dio _dio;

  /// Đăng nhập: trả về user + token (chưa lưu token ở đây)
  Future<LoginResult> login(String username, String password) async {
    try {
      final res = await _dio.post(
        ApiConstants.login,
        data: {
          'username': username,
          'password': password,
          'expiresInMins': 60,
        },
      );
      final data = res.data as Map<String, dynamic>;
      return LoginResult(
        user: User.fromJson(data),       // user nằm phẳng cùng cấp với token
        tokens: AuthTokens.fromJson(data),
      );
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  /// Lấy user hiện tại bằng accessToken.
  /// Khi có interceptor gắn token tự động thì bỏ tham số và phần options.
  Future<User> getCurrentUser(String accessToken) async {
    try {
      final res = await _dio.get(
        ApiConstants.authMe,
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      return User.fromJson(res.data);
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  /// Đổi refreshToken lấy cặp token mới
  Future<AuthTokens> refresh(String refreshToken) async {
    try {
      final res = await _dio.post(
        ApiConstants.authRefresh,
        data: {'refreshToken': refreshToken, 'expiresInMins': 60},
      );
      return AuthTokens.fromJson(res.data);
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }
}