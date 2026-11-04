import 'package:flutter/material.dart';

import 'theme_controller.dart';
import 'product/ProductListScreen.dart'; // Màn hình chính ứng dụng

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDark, child) {
        return MaterialApp(
          title: 'ShopEasy',
          debugShowCheckedModeBanner: false,

          // Giao diện Sáng (Light Mode)
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorSchemeSeed: const Color(0xFF203D67),
            scaffoldBackgroundColor: Colors.grey.shade100,
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF203D67),
              foregroundColor: Colors.white,
            ),
            cardTheme: const CardThemeData(color: Colors.white),
          ),

          // Giao diện Tối (Dark Mode)
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorSchemeSeed: const Color(0xFF203D67),
            scaffoldBackgroundColor: const Color(0xFF121212),
            cardTheme: const CardThemeData(color: Color(0xFF1E1E1E)),
          ),

          // Tự động thay đổi giữa Light và Dark dựa vào trạng thái isDark
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

          home: const ProductListScreen(),
        );
      },
    );
  }
}
