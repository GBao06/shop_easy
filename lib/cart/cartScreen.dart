import 'package:flutter/material.dart';
import 'package:shop_easy/l10n/app_strings.dart';
import 'package:shop_easy/utils/format.dart';
import 'package:shop_easy/cart/cart_item.dart';

class CartScreen extends StatefulWidget {
  final List<CartItem> cartItems; // 1. Thêm biến nhận dữ liệu

  const CartScreen({super.key, required this.cartItems});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // 2. Sử dụng danh sách truyền vào
  late List<CartItem> _cartItems;

  @override
  void initState() {
    super.initState();
    _cartItems = widget.cartItems;
  }

  // Các hàm tính tiền và xử lý giữ nguyên...
  double get _subtotal {
    return _cartItems.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }

  double get _shippingFee {
    if (_subtotal == 0 || _subtotal >= 500000) return 0;
    return 30000;
  }

  double get _total => _subtotal + _shippingFee;

  void _removeItem(int index) {
    final removedItem = _cartItems[index];
    final removedIndex = index;
    final AppStrings s = AppStrings.of(context);
    setState(() {
      _cartItems.removeAt(index);
    });

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(s.removedItem(removedItem.name)),
          duration: const Duration(seconds: 3),
          persist: false, // tự tắt sau 3 giây dù có nút Hoàn tác
          action: SnackBarAction(
            label: s.undo,
            textColor: const Color.fromARGB(255, 255, 59, 59),
            onPressed: () {
              setState(() {
                _cartItems.insert(removedIndex, removedItem);
              });
            },
          ),
        ),
      );
  }

  void _incrementQuantity(CartItem item) {
    setState(() {
      item.quantity++;
    });
  }

  void _decrementQuantity(int index) {
    if (_cartItems[index].quantity > 1) {
      setState(() {
        _cartItems[index].quantity--;
      });
    } else {
      _removeItem(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppStrings s = AppStrings.of(context);
    // Scaffold hiển thị giỏ hàng
    return Scaffold(
      appBar: AppBar(title: Text(s.cart), elevation: 0),
      // Hiển thị danh sách sản phẩm hoặc thông báo giỏ hàng trống
      body: _cartItems.isEmpty ? _buildEmptyCart() : _buildCartList(),
    );
  }

  Widget _buildEmptyCart() {
    // Hiển thị khi giỏ hàng trống
    final AppStrings s = AppStrings.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 100,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              s.isempty,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(s.isempty2, style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF203D67),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(s.continueShopping, style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartList() {
    final AppStrings s = AppStrings.of(context);
    // Hiển thị danh sách sản phẩm trong giỏ hàng
    return Column(
      children: [
        // Danh sách sản phẩm trong giỏ
        Expanded(
          child: ListView.builder(
            itemCount: _cartItems.length,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              final item = _cartItems[index];
              // Widget cho mỗi mục trong danh sách
              return Dismissible(
                key: Key(item.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                onDismissed: (direction) => _removeItem(index),
                // Child widget for the list item
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    // Widget con cho mỗi mục trong danh sách
                    child: Row(
                      children: [
                        // Ảnh sản phẩm
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            item.imageUrl,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  width: 70,
                                  height: 70,
                                  color: Colors.grey.shade200,
                                ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Thông tin sản phẩm và số lượng
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 6),
                              // Giá sản phẩm
                              Text(
                                formatPrice(item.price),
                                style: const TextStyle(
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Widget điều chỉnh số lượng
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).dividerColor,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              // Nút giảm số lượng
                              IconButton(
                                constraints: const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                                padding: EdgeInsets.zero,
                                icon: const Icon(Icons.remove, size: 16),
                                onPressed: () => _decrementQuantity(index),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: Text(
                                  '${item.quantity}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              // Nút tăng số lượng
                              IconButton(
                                constraints: const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                                padding: EdgeInsets.zero,
                                icon: const Icon(Icons.add, size: 16),
                                onPressed: () => _incrementQuantity(item),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        // phan tam tinh va thanh toan
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          // Widget hiển thị tạm tính, phí vận chuyển và tổng cộng
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(s.subtotal, style: TextStyle(color: Colors.grey)),
                  Text(
                    formatPrice(_subtotal),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Phí vận chuyển
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(s.shipping, style: TextStyle(color: Colors.grey)),
                  Text(
                    _shippingFee == 0 ? s.free : formatPrice(_shippingFee),
                    style: TextStyle(
                      color: _shippingFee == 0
                          ? const Color.fromARGB(255, 255, 0, 0)
                          : Theme.of(context).colorScheme.onSurface,
                      fontWeight: _shippingFee == 0
                          ? FontWeight.bold
                          : FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Divider(height: 20),
              // Tổng cộng
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    s.total,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    formatPrice(_total),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Nút Thanh toán
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF203D67),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    s.checkout,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
