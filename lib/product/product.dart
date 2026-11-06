class Product {
  final String id;
  final String name;
  final double price;
  final double? originalPrice; // null = không giảm giá
  final String category;
  final String imageUrl;
  final String description;
  final double rating;
  final int reviewCount;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.originalPrice,
    required this.category,
    required this.imageUrl,
    required this.description,
    this.rating = 0,
    this.reviewCount = 0,
  });

  /// % giảm giá, tự tính từ 2 mức giá
  double? get discountPercent {
    final original = originalPrice;
    if (original == null || original <= price) return null;
    return ((1 - price / original) * 100).roundToDouble();
  }
}