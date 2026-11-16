import 'package:dio/dio.dart';

// Khởi tạo Dio dùng chung với baseUrl
final dio = Dio(
  BaseOptions(
    baseUrl: 'https://dummyjson.com',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  ),
);

Future<void> layMotSanPham() async {
  try {
    final response = await dio.get('/products/1');

    print('Status: ${response.statusCode}');
    print('Tên SP: ${response.data['title']}');
    print('Giá: \$${response.data['price']}');
  } on DioException catch (e) {
    print('Lỗi khi lấy sản phẩm: ${e.message}');
  }
}

Future<void> timKiem() async {
  try {
    final response = await dio.get(
      '/products/search',
      queryParameters: {'q': 'phone', 'limit': 10},
    );

    // Dữ liệu tìm kiếm nằm trong key 'products'
    final List products = response.data['products'];
    print('Tìm thấy ${products.length} sản phẩm:');

    for (var item in products) {
      print('- ${item['title']} (\$${item['price']})');
    }
  } on DioException catch (e) {
    print('Lỗi khi tìm kiếm: ${e.message}');
  }
}

Future<void> main() async {
  await layMotSanPham();
  print('-------------------');
  await timKiem();
}