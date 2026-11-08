import 'package:flutter/material.dart';
import 'package:shop_easy/l10n/app_strings.dart';
import 'package:shop_easy/product/product.dart';
import 'package:shop_easy/utils/format.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isFavorite;
  final VoidCallback? onAddToCart;
  final VoidCallback? onFavoriteToggle;

  const ProductCard({
    super.key,
    required this.product,
    this.isFavorite = false,
    this.onAddToCart,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    // Tự động lấy dữ liệu trực tiếp từ đối tượng product
    final String imageUrl = product.imageUrl;
    final String title = product.name;
    final String currentPrice = formatPrice(product.price);
    final int? discount = product.discountPercent;
    final double? original = product.originalPrice;
    final AppStrings s = AppStrings.of(context);
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias, // Bo tròn đồng bộ nội dung bên trong
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1 & 2. Khối Ảnh + Nhãn Giảm Giá + Nút Yêu Thích
          Expanded(
            child: Stack(
              fit: StackFit.expand, // lấp đầy khung
              children: [
                Image.asset(
                  imageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.image,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                ),

                // Nhãn giảm giá (chỉ hiện khi có giảm)
                if (discount != null)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '-$discount%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                // Nút yêu thích
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 18,
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey.shade600,
                      ),
                      onPressed: onFavoriteToggle,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Khối thông tin bên dưới
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 3. Tên sản phẩm (tối đa 2 dòng)
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 6),

                // 4. Hàng đánh giá (5 sao + số điểm + lượt đánh giá)
                Row(
                  children: [
                    // 5 ngôi sao đánh giá
                    Row(
                      children: List.generate(5, (index) {
                        // Hiển thị ngôi sao đầy, nửa đầy hoặc rỗng dựa trên điểm đánh giá
                        if (index < product.rating.floor()) {
                          return const Icon(
                            Icons.star,
                            size: 12,
                            color: Colors.amber,
                          );
                          // Nếu điểm đánh giá là số lẻ, hiển thị nửa ngôi sao cho phần thập phân
                        } else if (index < product.rating) {
                          return const Icon(
                            Icons.star_half,
                            size: 12,
                            color: Colors.amber,
                          );
                        } else {
                          // Hiển thị ngôi sao rỗng cho các ngôi sao còn lại
                          return const Icon(
                            Icons.star_border,
                            size: 12,
                            color: Colors.grey,
                          );
                        }
                      }),
                    ),
                    const SizedBox(width: 4),
                    // Điểm đánh giá
                    Text(
                      product.rating.toStringAsFixed(1),
                      style: const TextStyle(fontSize: 11),
                    ),
                    const SizedBox(width: 4),
                    // Số lượt đánh giá
                    Flexible(
                      child: Text(
                        '(${product.reviewCount})',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // 5. Giá hiện tại và Giá gốc
                Wrap(
                  spacing: 6,
                  runSpacing: 2,
                  children: [
                    // Giá hiện tại
                    Text(
                      currentPrice,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Giá gốc (nếu có)
                    if (original != null && original > product.price)
                      Text(
                        formatPrice(original),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 34,
                        child: FilledButton(
                          onPressed: onAddToCart,
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.deepOrange,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: Text(
                            s.addToCart,
                            style: TextStyle(fontSize: 11, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
