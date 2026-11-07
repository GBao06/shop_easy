import 'package:flutter/material.dart';
import 'package:shop_easy/cart/CartScreen.dart';
import 'package:shop_easy/data/sample_products.dart';
import 'package:shop_easy/home/category_row.dart';
import 'package:shop_easy/home/home_header.dart';
import 'package:shop_easy/home/promo_banner.dart';
import 'package:shop_easy/l10n/app_strings.dart';
import 'package:shop_easy/product/ProductCard.dart';
import 'package:shop_easy/product/ProductDetailScreen.dart';
import 'package:shop_easy/product/product.dart';
import 'package:shop_easy/setting.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  int _navIndex = 0;
  AppStrings get s => AppStrings.of(context);
  String _selectedCategory = Categories.all;
  String _searchQuery = '';

  // Giỏ hàng (được truyền sang CartScreen theo tham chiếu)
  final List<CartItem> _cartItems = [];
  // Đếm số lượng sản phẩm trong giỏ hàng
  int get cartCount =>
      _cartItems.fold<int>(0, (sum, item) => sum + item.quantity);

  // Thêm sản phẩm vào giỏ hàng, nếu đã có thì cộng thêm số lượng
  void _addItem(Product product, {bool increment = true}) {
    setState(() {
      final index = _cartItems.indexWhere((i) => i.id == product.id);
      if (index >= 0) {
        if (increment) _cartItems[index].quantity++;
      } else {
        _cartItems.add(
          CartItem(
            id: product.id,
            name: product.name,
            price: product.price,
            imageUrl: product.imageUrl,
          ),
        );
      }
    });
  }

  // Mua ngay: thêm vào giỏ hàng (nếu chưa có) và mở màn hình giỏ hàng
  void _buyNow(Product product) {
    _addItem(product, increment: false);
    _openCartScreen();
  }

  // Thêm sản phẩm vào giỏ hàng và hiển thị SnackBar
  void _addToCart(Product product) {
    _addItem(product);
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(s.added+  " ${product.name} " + s.toyourcart),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(label: s.opencart, onPressed: _openCartScreen),
        ),
      );
  }

  // Mở giỏ hàng và cập nhật lại badge khi quay về
  void _openCartScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(cartItems: _cartItems),
      ),
    ).then((_) {
      if (mounted) setState(() {});
    });
  }

  // Lọc kết hợp giữa danh mục và tìm kiếm
  List<Product> get _filteredProducts {
    final query = _searchQuery.toLowerCase().trim();
    return sampleProducts.where((product) {
      final matchesCategory =
          _selectedCategory == Categories.all ||
          product.category == _selectedCategory;
      final matchesSearch = product.name.toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final products = _filteredProducts; // tính một lần
    final cs = Theme.of(context).colorScheme;
    // Scaffold: khung chính của màn hình, có AppBar, body, bottomNavigationBar
    return Scaffold(
      body: SafeArea(
        // Nội dung chính: danh sách sản phẩm
        child: CustomScrollView(
          // Slivers: các phần tử cuộn được, có thể là SliverToBoxAdapter (khối cố định) hoặc SliverGrid (lưới)
          slivers: [
            // 1. Header
            SliverToBoxAdapter(
              child: HomeHeader(
                cartCount: cartCount,
                onCartTap: _openCartScreen,
              ),
            ),

            // 2. Ô tìm kiếm
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    hintText: s.searchHint,
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    fillColor: cs.surface, // đổi theo dark mode
                  ),
                ),
              ),
            ),

            // 3. Danh mục dạng icon
            SliverToBoxAdapter(
              child: CategoryRow(
                selected: _selectedCategory,
                onSelected: (c) => setState(() => _selectedCategory = c),
              ),
            ),

            // 4. Banner
            const SliverToBoxAdapter(child: PromoBanner()),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),

            // 5. Lưới sản phẩm (hoặc thông báo rỗng)
            if (products.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(child: Text(s.noProductsFound)),
                ),
              )
            else
              // Lưới sản phẩm
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                // SliverGrid: hiển thị danh sách sản phẩm dạng lưới
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    // 2 cột, chiều cao cố định, khoảng cách giữa các ô
                    crossAxisCount: 2,
                    mainAxisExtent: 310,
                    // Khoảng cách giữa các ô theo chiều ngang và dọc
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  // SliverChildBuilderDelegate: tạo các ô sản phẩm theo chỉ số
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final product = products[index];
                    // Khi bấm vào ô sản phẩm, mở trang chi tiết sản phẩm
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                              product: product,
                              onBuyNow: () {
                                Navigator.pop(context); // đóng trang chi tiết
                                _buyNow(product);
                              },
                            ),
                          ),
                        );
                      },
                      
                      child: ProductCard(
                        product: product,
                        onBuyNow: () => _buyNow(product),
                        onAddToCart: () => _addToCart(product),
                      ),
                    );
                  }, childCount: products.length),
                ),
              ),
              //
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
          ],
        ),
      ),

      // 6. Thanh điều hướng dưới
      bottomNavigationBar: NavigationBar(
        selectedIndex: _navIndex,
        onDestinationSelected: (int index) {
          if (index == 2) {
            // Chuyển sang màn hình Cài đặt khi chọn nút thứ 3
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingPage()),
            );
          } else {
            setState(() {
              _navIndex = index;
            });
          }
        },
        destinations:[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: s.home,
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: s.category,
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: s.settings,
          ),
        ],
      ),
    );
  }
}
