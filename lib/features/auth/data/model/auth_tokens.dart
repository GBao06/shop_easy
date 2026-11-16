import 'package:shop_easy/features/auth/data/model/user.dart';

/// Cặp token dùng chung cho login và refresh
class AuthTokens {
  final String accessToken;
  final String refreshToken;

  const AuthTokens({required this.accessToken, required this.refreshToken});

  factory AuthTokens.fromJson(Map<String, dynamic> json) {
    return AuthTokens(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }
}

/// Kết quả đăng nhập: user + token
class LoginResult {
  final User user;
  final AuthTokens tokens;

  const LoginResult({required this.user, required this.tokens});
}