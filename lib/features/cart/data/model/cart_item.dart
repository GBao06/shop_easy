import 'package:shop_easy/features/product/data/model/product.dart';

// Model mô tả một sản phẩm trong giỏ hàng
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  // Các getter để code khác đọc nhanh thông tin sản phẩm
  int get id => product.id;
  String get name => product.name;
  double get price => product.price;
  String get imageUrl => product.imageUrl;

  double get total => price * quantity;
}