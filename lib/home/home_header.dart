import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final int cartCount;
  final VoidCallback onCartTap;

  const HomeHeader({super.key, required this.cartCount, required this.onCartTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 4, 8),
      child: Row(
        children: [
          Icon(Icons.storefront, size: 36, color: cs.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Shop Easy',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold, color: cs.primary)),
                Text('Mua sắm dễ dàng',
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          Badge(
            isLabelVisible: cartCount > 0,
            label: Text('$cartCount'),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: onCartTap,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}