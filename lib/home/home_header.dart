import 'package:flutter/material.dart';
import 'package:shop_easy/l10n/app_strings.dart';

class HomeHeader extends StatelessWidget {
  final int cartCount;
  final VoidCallback onCartTap;

  const HomeHeader({super.key, required this.cartCount, required this.onCartTap});

  @override
  Widget build(BuildContext context) {
      final AppStrings s = AppStrings.of(context);
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 4, 8),
      child: Row(
        children: [
          Icon(Icons.storefront, size: 36, color: cs.primary),
          const SizedBox(width: 10),
          // Expanded: chiếm phần còn lại của Row
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Shop Easy',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold, color: cs.primary)),
                Text(s.easyShopping,
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          // 2 nút thông báo và giỏ hàng
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          // Hiển thị số lượng sản phẩm trong giỏ hàng
          Badge(
            isLabelVisible: cartCount > 0,
            label: Text('$cartCount'),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: onCartTap,
            ),
          ),
          // Thêm khoảng cách giữa các nút
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}