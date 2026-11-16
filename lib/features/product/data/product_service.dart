import 'package:dio/dio.dart';
import 'package:shop_easy/core/constants/api_constants.dart';
import 'package:shop_easy/core/network/api_error.dart';
import 'package:shop_easy/core/network/dio_client.dart';
import 'package:shop_easy/features/product/data/model/product.dart';

class ProductService {
  // Mặc định dùng Dio chung; truyền Dio khác vào khi cần test
  ProductService({Dio? dio}) : _dio = dio ?? DioClient.instance;

  final Dio _dio;

  Future<List<Product>> getProducts({int limit = 20, int skip = 0}) async {
    try {
      final res = await _dio.get(
        ApiConstants.products,
        queryParameters: {'limit': limit, 'skip': skip},
      );
      return _parseList(res.data);
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<Product> getProductById(int id) async {
    try {
      final res = await _dio.get('${ApiConstants.products}/$id');
      return Product.fromJson(res.data);
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    try {
      final res = await _dio.get(
        ApiConstants.productSearch,
        queryParameters: {'q': query},
      );
      return _parseList(res.data);
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final res = await _dio.get(ApiConstants.categoryList);
      return List<String>.from(res.data);
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<List<Product>> getProductsByCategory(String slug) async {
    try {
      final res = await _dio.get('${ApiConstants.products}/category/$slug');
      return _parseList(res.data);
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  // Gom đoạn parse lặp lại
  List<Product> _parseList(dynamic data) {
    final list = data['products'] as List;
    return list.map((e) => Product.fromJson(e)).toList();
  }
}