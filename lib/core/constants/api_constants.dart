class ApiConstants {
  ApiConstants._(); // không cho tạo instance

  static const String baseUrl = 'https://dummyjson.com';

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);

  // Endpoint
  static const String products = '/products';
  static const String productSearch = '/products/search';
  static const String categoryList = '/products/category-list';
  static const String login = '/auth/login';

  static const String authMe = '/auth/me';
  static const String authRefresh = '/auth/refresh';
}
