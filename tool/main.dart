import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// Khởi tạo Dio dùng chung toàn app
final dio = Dio(
  BaseOptions(
    baseUrl: 'https://dummyjson.com',
    headers: {'Content-Type': 'application/json'},
  ),
);

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
  ));
}

// ==========================================
// 1. MÀN HÌNH ĐĂNG NHẬP
// ==========================================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Điền sẵn tài khoản mẫu của DummyJSON để test nhanh
  final _usernameController = TextEditingController(text: 'emilys');
  final _passwordController = TextEditingController(text: 'emilyspass');
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    setState(() => _isLoading = true);

    try {
      final response = await dio.post(
        '/auth/login',
        data: {
          'username': _usernameController.text.trim(),
          'password': _passwordController.text.trim(),
        },
      );

      final String accessToken = response.data['accessToken'];

      if (!mounted) return;

      // Đăng nhập thành công -> Chuyển sang trang chi tiết sản phẩm /products/1
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailScreen(accessToken: accessToken),
        ),
      );
    } on DioException catch (e) {
      if (!mounted) return;
      final errorMsg = e.response?.data['message'] ?? 'Lỗi kết nối mạng';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đăng nhập thất bại: $errorMsg'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng nhập')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Tên đăng nhập',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Mật khẩu',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleLogin,
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Đăng nhập'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 2. MÀN HÌNH CHI TIẾT SẢN PHẨM (/products/1)
// ==========================================
class ProductDetailScreen extends StatefulWidget {
  final String accessToken;

  const ProductDetailScreen({super.key, required this.accessToken});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Future<Map<String, dynamic>> _fetchProduct() async {
    final response = await dio.get(
      '/products/1',
      options: Options(
        headers: {'Authorization': 'Bearer ${widget.accessToken}'},
      ),
    );
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết sản phẩm'),
        actions: [
          // Nút đăng xuất quay lại màn hình Login
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _fetchProduct(),
        builder: (context, snapshot) {
          // 1. Đang tải dữ liệu
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Có lỗi xảy ra
          if (snapshot.hasError) {
            return Center(child: Text('Lỗi tải sản phẩm: ${snapshot.error}'));
          }

          // 3. Tải thành công -> Hiển thị giao diện
          final product = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    product['thumbnail'],
                    height: 220,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  product['title'],
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${product['price']}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Danh mục: ${product['category']}  •  Đánh giá: ⭐ ${product['rating']}',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const Divider(height: 32),
                const Text(
                  'Mô tả sản phẩm',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  product['description'],
                  style: const TextStyle(fontSize: 15, height: 1.5),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}