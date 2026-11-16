import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shop_easy/features/auth/data/model/auth_tokens.dart';

class TokenStorage {
  TokenStorage._();

  static const _storage = FlutterSecureStorage();
  static const _accessKey = 'access_token';
  static const _refreshKey = 'refresh_token';

  static Future<void> save(AuthTokens tokens) async {
    await _storage.write(key: _accessKey, value: tokens.accessToken);
    await _storage.write(key: _refreshKey, value: tokens.refreshToken);
  }

  static Future<String?> readAccessToken() => _storage.read(key: _accessKey);

  static Future<String?> readRefreshToken() => _storage.read(key: _refreshKey);

  static Future<void> clear() async {
    await _storage.delete(key: _accessKey);
    await _storage.delete(key: _refreshKey);
  }
}