import 'package:flutter/material.dart';
import 'package:shop_easy/features/cart/presentation/cart_screen.dart';
import 'package:shop_easy/features/home/presentation/widgets/category_row.dart';
import 'package:shop_easy/features/home/presentation/widgets/home_header.dart';
import 'package:shop_easy/features/home/presentation/widgets/promo_banner.dart';
import 'package:shop_easy/core/l10n/app_strings.dart';
import 'package:shop_easy/features/product/data/model/product.dart';
import 'package:shop_easy/features/product/data/product_service.dart';
import 'package:shop_easy/features/product/presentation/screens/product_detail_screen.dart';
import 'package:shop_easy/features/product/presentation/widgets/product_card.dart';

import 'package:shop_easy/features/setting/presentation/setting.dart';
import 'package:shop_easy/features/cart/data/model/cart_item.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  int _navIndex = 0;
  AppStrings get s => AppStrings.of(context);
  String _selectedCategory = kAllCategories;
  String _searchQuery = '';

  // ===== Dữ liệu từ API =====
  final ProductService _service = ProductService();
  List<Product> _products = [];
  List<String> _categories = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Tải sản phẩm + danh mục cùng lúc
  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final results = await Future.wait([
        _service.getProducts(limit: 10),
        _service.getCategories(),
      ]);
      if (!mounted) return;
      setState(() {
        _products = results[0] as List<Product>;
        _categories = results[1] as List<String>;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = '$e';
        _isLoading = false;
      });
    }
  }

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
        _cartItems.add(CartItem(product: product));
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
          content: Text(s.addProduct(product.name)),
          duration: const Duration(seconds: 2),
          persist: false,
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

  // Lọc kết hợp giữa danh mục và tìm kiếm (lọc trên dữ liệu đã tải từ API)
  List<Product> get _filteredProducts {
    final query = _searchQuery.toLowerCase().trim();
    return _products.where((product) {
      final matchesCategory =
          _selectedCategory == kAllCategories ||
          product.category == _selectedCategory;
      final matchesSearch = product.name.toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  // Phần thay thế lưới sản phẩm khi đang tải / lỗi / rỗng
  Widget _buildStatus(Widget child) => SliverToBoxAdapter(
    child: Padding(padding: const EdgeInsets.all(32), child: Center(child: child)),
  );

  @override
  Widget build(BuildContext context) {
    final products = _filteredProducts; // tính một lần
    final cs = Theme.of(context).colorScheme;
    // Scaffold: khung chính của màn hình, có AppBar, body, bottomNavigationBar
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadData, // kéo xuống để tải lại
          child: CustomScrollView(
            // Luôn cho phép kéo để refresh kể cả khi nội dung ngắn
            physics: const AlwaysScrollableScrollPhysics(),
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

              // 3. Danh mục (lấy từ API)
              SliverToBoxAdapter(
                child: CategoryRow(
                  categories: _categories,
                  selected: _selectedCategory,
                  onSelected: (c) => setState(() => _selectedCategory = c),
                ),
              ),

              // 4. Banner
              const SliverToBoxAdapter(child: PromoBanner()),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),

              // 5. Đang tải / lỗi / rỗng / lưới sản phẩm
              if (_isLoading)
                _buildStatus(const CircularProgressIndicator())
              else if (_error != null)
                _buildStatus(
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_error!, textAlign: TextAlign.center),
                      const SizedBox(height: 12),
                      FilledButton.icon(
                        onPressed: _loadData,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Thử lại'),
                      ),
                    ],
                  ),
                )
              else if (products.isEmpty)
                _buildStatus(Text(s.noProductsFound))
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 310,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
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
                                onAddToCart: () {
                                  Navigator.pop(context); // đóng trang chi tiết
                                  _addToCart(product);
                                },
                              ),
                            ),
                          );
                        },
                        child: ProductCard(
                          product: product,
                          onAddToCart: () => _addToCart(product),
                        ),
                      );
                    }, childCount: products.length),
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ],
          ),
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
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: s.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.grid_view_outlined),
            selectedIcon: const Icon(Icons.grid_view),
            label: s.category,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: s.settings,
          ),
        ],
      ),
    );
  }
}