import 'package:dio/dio.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'https://dummyjson.com',
    headers: {'Content-Type': 'application/json'},
  ),
);

Future<String?> dangNhap(String username, String password) async {
  try {
    final response = await dio.post(
      '/auth/login',
      data: {
        'username': username,
        'password': password,
        'expiresInMins': 30, // Tùy chọn: thời gian hết hạn token (phút)
      },
    );

    print('Đăng nhập thành công! Status: ${response.statusCode}');
    print('Họ tên: ${response.data['firstName']} ${response.data['lastName']}');
    print('Email: ${response.data['email']}');

    // Lấy accessToken để dùng cho các request cần xác thực sau này
    final String accessToken = response.data['accessToken'];
    print('Access Token: $accessToken');

    return accessToken;
  } on DioException catch (e) {
    // Lỗi 400 thường là do sai tài khoản hoặc mật khẩu
    if (e.response != null) {
      print('Đăng nhập thất bại (${e.response?.statusCode}): ${e.response?.data['message']}');
    } else {
      print('Lỗi kết nối: ${e.message}');
    }
    return null;
  }
}

// Ví dụ dùng token vừa nhận được để lấy thông tin user hiện tại
Future<void> layThongTinUser(String token) async {
  try {
    final response = await dio.get(
      '/auth/me',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    print('Dữ liệu từ /auth/me: ${response.data['username']} - ${response.data['role']}');
  } on DioException catch (e) {
    print('Lỗi xác thực: ${e.message}');
  }
}

Future<void> main() async {
  // Tài khoản mẫu có sẵn của DummyJSON
  final token = await dangNhap('emilys', 'emilyspass');

  if (token != null) {
    print('-------------------');
    await layThongTinUser(token);
  }
}