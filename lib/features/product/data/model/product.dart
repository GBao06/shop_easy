class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final String thumbnail;
  final List<String> images;
  final double price;
  final double discountPercentage;
  final double rating;
  final int reviewCount;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.thumbnail,
    required this.images,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.reviewCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      thumbnail: json['thumbnail'] as String? ?? '',
      images: List<String>.from(json['images'] ?? const []),
      price: (json['price'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      reviewCount: (json['reviews'] as List?)?.length ?? 0,
    );
  }

  // Getter tương thích với UI cũ (productCard, detail, cart)
  String get name => title;
  String get imageUrl => thumbnail;
  int? get discountPercent =>
      discountPercentage > 0 ? discountPercentage.round() : null;
  double? get originalPrice => discountPercentage > 0
      ? price / (1 - discountPercentage / 100)
      : null;
}