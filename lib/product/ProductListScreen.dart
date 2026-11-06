import 'package:flutter/material.dart';
import 'package:shop_easy/product/ProductCard.dart';
import 'package:shop_easy/product/ProductDetailScreen.dart';
import 'package:shop_easy/product/product.dart';
import 'package:shop_easy/setting.dart';
import 'package:shop_easy/cart/CartScreen.dart'; // hoặc đường dẫn tương ứng đến file CartScreen

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  int _navIndex = 0;
  String _selectedCategory = 'Tất cả';
  String _searchQuery = '';

  int get cartCount =>
      _cartItems.fold<int>(0, (sum, item) => sum + item.quantity);

  // Khai báo danh sách giỏ hàng trong _ProductListScreenState
  final List<CartItem> _cartItems = [];

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

  void _buyNow(Product product) {
    _addItem(product, increment: false); // đã có thì không cộng thêm
    _openCartScreen(); // tái dùng hàm có sẵn
  }

  void _addToCart(Product product) {
    _addItem(product);
    // giữ nguyên phần SnackBar
  }

  // Hàm chuyển sang CartScreen và tự cập nhật lại số lượng giỏ hàng khi quay về
  void _openCartScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(cartItems: _cartItems),
      ),
    ).then((_) {
      // Cập nhật lại giao diện badge sau khi người dùng quay lại từ màn hình giỏ hàng
      setState(() {});
    });
  }

  final List<String> _categories = [
    'Tất cả',
    'Vợt cầu lông',
    'Áo cầu lông',
    'Quần cầu lông',
    'Giày cầu lông',
  ];

  // Dữ liệu sản phẩm mẫu
  final List<Product> _allProducts = [
    // --- VỢT CẦU LÔNG ---
    Product(
      id: '1',
      name: 'Vợt cầu lông Yonex Astrox 88D Pro',
      price: 3950000,
      originalPrice: 4500000,
      rating: 4.8,
      reviewCount: 214,
      category: 'Vợt cầu lông',
      imageUrl: 'assets/images/products/votcau_long_yonex_astrox_88d_pro.jpg',
    ),
    Product(
      id: '2',
      name: 'Vợt cầu lông Victor Thruster K12',
      price: 2850000,
      originalPrice: 3200000,
      rating: 4.5,
      reviewCount: 98,
      category: 'Vợt cầu lông',
      imageUrl: 'assets/images/products/Victor_Thruster_K12.png',
    ),

    // --- ÁO CẦU LÔNG ---
    Product(
      id: '3',
      name: 'Áo cầu lông Yonex Nam thoáng khí',
      price: 450000,
      originalPrice: 500000,
      rating: 4.2,
      reviewCount: 56,
      category: 'Áo cầu lông',
      imageUrl: 'assets/images/products/aocaulongyonex.jpg',
    ),
    Product(
      id: '4',
      name: 'Áo cầu lông Li-Ning chính hãng',
      price: 380000,
      // originalPrice: 420000,
      rating: 4.0,
      reviewCount: 34,
      category: 'Áo cầu lông',
      imageUrl: 'assets/images/products/aolining.jpg',
    ),

    // --- QUẦN CẦU LÔNG ---
    Product(
      id: '5',
      name: 'Quần thun thể thao Yonex co giãn',
      price: 290000,
      originalPrice: 320000,
      rating: 4.3,
      reviewCount: 45,
      category: 'Quần cầu lông',
      imageUrl: 'assets/images/products/quanyonexchinhhang.jpg',
    ),
    Product(
      id: '6',
      name: 'Quần đùi cầu lông Victor đen',
      price: 320000,
      originalPrice: 350000,
      rating: 4.1,
      reviewCount: 29,
      category: 'Quần cầu lông',
      imageUrl: 'assets/images/products/quanvictor.jpg',
    ),

    // --- GIÀY CẦU LÔNG ---
    Product(
      id: '7',
      name: 'Giày cầu lông Yonex Power Cushion 65Z3',
      price: 2990000,
      originalPrice: 3500000,
      rating: 4.6,
      reviewCount: 112,
      category: 'Giày cầu lông',
      imageUrl: 'assets/images/products/Yonex_Power_Cushion_65Z3.jpg',
    ),
    Product(
      id: '8',
      name: 'Giày cầu lông Victor P9200 chống lật cổ chân',
      price: 2450000,
      // originalPrice: 2800000,
      rating: 4.4,
      reviewCount: 87,
      category: 'Giày cầu lông',
      imageUrl: 'assets/images/products/Victor_P9200.jpg',
    ),
  ];

  // Logic lọc kết hợp giữa Danh mục và Tìm kiếm
  List<Product> get _filteredProducts {
    return _allProducts.where((product) {
      final matchesCategory =
          _selectedCategory == 'Tất cả' ||
          product.category == _selectedCategory;
      final matchesSearch = product.name.toLowerCase().contains(
        _searchQuery.toLowerCase().trim(),
      );
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. AppBar tiêu đề + Nút Tìm kiếm & Giỏ hàng có Badge
      appBar: AppBar(
        title: const Text('ShopEasy', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF203D67),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Badge(
              isLabelVisible: cartCount > 0,
              label: Text('$cartCount'),
              child: IconButton(
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
                onPressed: _openCartScreen, // Gọi hàm mở giỏ hàng
              ),
            ),
          ),
        ],
      ),

      // Thân giao diện chính
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            const SizedBox(height: 8),

            // 2. Ô tìm kiếm bo tròn
            TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Tìm sản phẩm...',
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),

            const SizedBox(height: 12),

            // 3. Hàng Chip danh mục cuộn ngang
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((category) {
                  final isSelected = _selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      selectedColor: Theme.of(context)
                          .colorScheme
                          .primaryContainer,
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 12),

            // 4. Lưới sản phẩm 2 cột
            Expanded(
              child: _filteredProducts.isEmpty
                  ? const Center(child: Text('Không tìm thấy sản phẩm nào'))
                  : GridView.builder(
                      itemCount: _filteredProducts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            // 🛠 SỬA TẠI ĐÂY: Giảm tỉ lệ Rộng/Cao xuống 0.50 hoặc 0.52 để ô cao hơn
                            childAspectRatio: 0.55,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                      itemBuilder: (context, index) {
                        final product = _filteredProducts[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(
                                  product: product,
                                  onBuyNow: () {
                                    Navigator.pop(
                                      context,
                                    ); // đóng trang chi tiết trước
                                    _buyNow(
                                      product,
                                    ); // rồi thêm vào giỏ và mở giỏ hàng
                                  },
                                ),
                              ),
                            );
                          },
                          child: ProductCard(
                            product: product,
                            onBuyNow: () =>
                                _buyNow(product), // 🛠 Gọi hàm Mua ngay
                            onAddToCart: () =>
                                _addToCart(product), // Gọi hàm Thêm vào giỏ
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      // 5. Thanh điều hướng dưới
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
              _navIndex = index; // đã sửa: cập nhật biến _navIndex
            });
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Danh mục',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Cài đặt',
          ),
        ],
      ),
    );
  }
}
