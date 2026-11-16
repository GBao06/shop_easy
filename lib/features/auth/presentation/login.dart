import 'package:flutter/material.dart';
import 'package:shop_easy/features/auth/data/auth_service.dart';
import 'package:shop_easy/features/auth/data/token_storage.dart';
import 'package:shop_easy/features/product/presentation/screens/product_list_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController taiKhoanController = TextEditingController();
  final TextEditingController matKhauController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool _obscurePassword = true;

  Future<void> _handleLogin() async {
    final taiKhoan = taiKhoanController.text.trim();
    final matKhau = matKhauController.text;

    // Kiểm tra rỗng trước khi gọi API
    if (taiKhoan.isEmpty || matKhau.isEmpty) {
      _showError('Vui lòng nhập tài khoản và mật khẩu');
      return;
    }

    setState(() => _isLoading = true);
    try {
      final result = await _authService.login(taiKhoan, matKhau);
      await TokenStorage.save(result.tokens);

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProductListScreen()),
      );
    } catch (e) {
      if (!mounted) return;
      _showError('Đăng nhập thất bại: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    taiKhoanController.dispose();
    matKhauController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SafeArea + cuộn để không bị tràn khi bàn phím hiện lên
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // login
              const Padding(
                padding: EdgeInsets.all(50.0),
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: taiKhoanController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'emilys',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: matKhauController,
                  obscureText: _obscurePassword, // ẩn mật khẩu
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _isLoading ? null : _handleLogin(),
                  decoration: InputDecoration(
                    labelText: 'emilyspass',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Đăng nhập',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextButton(
                        onPressed: () => _showError('Tính năng đang phát triển'),
                        child: const Text('Quên mật khẩu'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: TextButton(
                        onPressed: () => _showError('Tính năng đang phát triển'),
                        child: const Text('Đăng kí'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}