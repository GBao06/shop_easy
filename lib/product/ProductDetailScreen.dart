import 'package:flutter/material.dart';
import 'package:shop_easy/l10n/app_strings.dart';
import 'package:shop_easy/product/product.dart';
import 'package:shop_easy/utils/format.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final VoidCallback onBuyNow;
  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.onBuyNow,
  });
  
  @override
  Widget build(BuildContext context) {
    final AppStrings s = AppStrings.of(context);
    return Scaffold(
      appBar: AppBar(
        title:  Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh sản phẩm lớn
            Image.asset(
              product.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tên sản phẩm
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Giá
                  Row(
                    children: [
                      //gia hien tai
                      Text(
                        formatPrice(product.price),
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      // gia goc
                      if (product.originalPrice != null)
                        Text(
                          formatPrice(product.originalPrice!),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Mô tả sản phẩm
                  Text(
                    s.productDescription,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle( height: 1.4),
                  ),
                  Text(
                    'Sản phẩm chính hãng, bảo hành 12 tháng. Hỗ trợ đổi trả trong vòng 7 ngày nếu có lỗi từ nhà sản xuất.',
                    style: TextStyle( height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Nút Mua ngay ở đáy màn hình
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface, // thay Colors.white
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05), // thay withOpacity
              blurRadius: 5,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onBuyNow,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child:  Text(
            s.buy,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
