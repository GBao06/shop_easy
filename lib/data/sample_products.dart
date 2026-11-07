import 'package:shop_easy/product/product.dart';

/// Tên danh mục dùng chung cho dữ liệu, bộ lọc và CategoryRow.
class Categories {
  static const all = 'Tất cả';
  static const racket = 'Vợt cầu lông';
  static const shirt = 'Áo cầu lông';
  static const shorts = 'Quần cầu lông';
  static const shoes = 'Giày cầu lông';
}

/// Dữ liệu sản phẩm mẫu.
final List<Product> sampleProducts = [
  // --- VỢT CẦU LÔNG ---
  Product(
    id: '1',
    name: 'Vợt cầu lông Yonex Astrox 88D Pro',
    price: 3950000,
    originalPrice: 4500000,
    rating: 4.8,
    reviewCount: 214,
    category: Categories.racket,
    imageUrl: 'assets/images/products/votcau_long_yonex_astrox_88d_pro.jpg',
    description:
        'Vợt cầu lông Yonex Astrox 88D Pro, thiết kế cho người chơi tấn công, giúp tăng tốc độ và sức mạnh cú đánh.',
  ),
  Product(
    id: '2',
    name: 'Vợt cầu lông Victor Thruster K12',
    price: 2850000,
    originalPrice: 3200000,
    rating: 4.5,
    reviewCount: 98,
    category: Categories.racket,
    imageUrl: 'assets/images/products/Victor_Thruster_K12.png',
    description:
        'Vợt cầu lông Victor Thruster K12, thiết kế mạnh mẽ, phù hợp cho người chơi tấn công.',
  ),

  // --- ÁO CẦU LÔNG ---
  Product(
    id: '3',
    name: 'Áo cầu lông Yonex Nam thoáng khí',
    price: 450000,
    originalPrice: 500000,
    rating: 4.2,
    reviewCount: 56,
    category: Categories.shirt,
    imageUrl: 'assets/images/products/aocaulongyonex.jpg',
    description:
        'Áo cầu lông Yonex Nam thoáng khí, chất liệu nhẹ, phù hợp cho các trận đấu và luyện tập.',
  ),
  Product(
    id: '4',
    name: 'Áo cầu lông Li-Ning chính hãng',
    price: 380000,
    // originalPrice: 420000,
    rating: 4.0,
    reviewCount: 34,
    category: Categories.shirt,
    imageUrl: 'assets/images/products/aolining.jpg',
    description:
        'Áo cầu lông Li-Ning chính hãng, chất liệu thoáng khí, phù hợp cho các trận đấu và luyện tập.',
  ),

  // --- QUẦN CẦU LÔNG ---
  Product(
    id: '5',
    name: 'Quần thun thể thao Yonex co giãn',
    price: 290000,
    originalPrice: 320000,
    rating: 4.3,
    reviewCount: 45,
    category: Categories.shorts,
    imageUrl: 'assets/images/products/quanyonexchinhhang.jpg',
    description:
        'Quần thun thể thao Yonex co giãn, thoáng khí, phù hợp cho cầu lông và các hoạt động thể thao khác.',
  ),
  Product(
    id: '6',
    name: 'Quần đùi cầu lông Victor đen',
    price: 320000,
    originalPrice: 350000,
    rating: 4.1,
    reviewCount: 29,
    category: Categories.shorts,
    imageUrl: 'assets/images/products/quanvictor.jpg',
    description:
        'Quần đùi cầu lông Victor màu đen, chất liệu nhẹ, thoáng khí, thích hợp cho các trận đấu và luyện tập.',
  ),

  // --- GIÀY CẦU LÔNG ---
  Product(
    id: '7',
    name: 'Giày cầu lông Yonex Power Cushion 65Z3',
    price: 2990000,
    originalPrice: 3500000,
    rating: 4.6,
    reviewCount: 112,
    category: Categories.shoes,
    imageUrl: 'assets/images/products/Yonex_Power_Cushion_65Z3.jpg',
    description:
        'Giày cầu lông Yonex Power Cushion 65Z3 với công nghệ Power Cushion giúp giảm chấn và tăng độ nảy, mang lại sự thoải mái tối đa khi chơi.',
  ),
  Product(
    id: '8',
    name: 'Giày cầu lông Victor P9200 chống lật cổ chân',
    price: 2450000,
    // originalPrice: 2800000,
    rating: 4.4,
    reviewCount: 87,
    category: Categories.shoes,
    imageUrl: 'assets/images/products/Victor_P9200.jpg',
    description:
        'Giày cầu lông Victor P9200 với thiết kế chống lật cổ chân, mang lại sự ổn định và thoải mái trong các trận đấu.',
  ),
];