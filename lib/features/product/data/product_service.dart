import 'package:dio/dio.dart';
import 'package:shop_easy/features/product/data/model/product.dart';

//
class ProductService {
  ProductService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'https://dummyjson.com',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

  final Dio _dio;

  Future<List<Product>> getProducts({int limit = 20, int skip = 0}) async {
    try {
      final res = await _dio.get(
        '/products',
        queryParameters: {'limit': limit, 'skip': skip},
      );
      final list = res.data['products'] as List;
      return list.map((e) => Product.fromJson(e)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Product> getProductById(int id) async {
    try {
      final res = await _dio.get('/products/$id');
      return Product.fromJson(res.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    try {
      final res = await _dio.get(
        '/products/search',
        queryParameters: {'q': query},
      );
      final list = res.data['products'] as List;
      return list.map((e) => Product.fromJson(e)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Kết nối quá hạn, vui lòng thử lại';
      case DioExceptionType.connectionError:
        return 'Không có kết nối mạng';
      case DioExceptionType.badResponse:
        return 'Lỗi server: ${e.response?.statusCode}';
      default:
        return 'Đã có lỗi xảy ra';
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final res = await _dio.get('/products/category-list');
      return List<String>.from(res.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<Product>> getProductsByCategory(String slug) async {
    try {
      final res = await _dio.get('/products/category/$slug');
      final list = res.data['products'] as List;
      return list.map((e) => Product.fromJson(e)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
}
