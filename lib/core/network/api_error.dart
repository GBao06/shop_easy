import 'package:dio/dio.dart';

String handleDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.sendTimeout:
      return 'Kết nối quá hạn, vui lòng thử lại';
    case DioExceptionType.connectionError:
      return 'Không có kết nối mạng';
    case DioExceptionType.badResponse:
      // DummyJSON trả về {"message": "..."} khi lỗi
      final data = e.response?.data;
      if (data is Map && data['message'] is String) {
        return data['message'] as String;
      }
      return 'Lỗi server: ${e.response?.statusCode}';
    default:
      return 'Đã có lỗi xảy ra';
  }
}