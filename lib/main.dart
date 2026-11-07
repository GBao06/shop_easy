import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'theme/theme_controller.dart';
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
        // 🟢 Lắng nghe thay đổi cỡ chữ
        return ValueListenableBuilder<double>(
          valueListenable: textScaleNotifier,
          builder: (context, textScale, child) {
            return ValueListenableBuilder<Locale>(
              valueListenable: localeNotifier,
              builder: (context, locale, _) {
                return MaterialApp(
                  title: 'ShopEasy',
                  debugShowCheckedModeBanner: false,
                  themeAnimationDuration: Duration.zero,
                  locale: locale,
                  supportedLocales: const [Locale('vi'), Locale('en')],
                  localizationsDelegates: const [
                    // Các delegate để hỗ trợ đa ngôn ngữ
                    GlobalMaterialLocalizations.delegate,
                    // Các delegate khác nếu cần
                    GlobalWidgetsLocalizations.delegate,
                    // Delegate cho Cupertino (iOS style)
                    GlobalCupertinoLocalizations.delegate,
                  ],
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
                    appBarTheme: const AppBarTheme(
                      backgroundColor: Color(
                        0xFF1B2A44,
                      ), // xanh đậm hơn, dịu mắt trong chế độ tối
                      foregroundColor: Colors.white,
                    ),
                    cardTheme: const CardThemeData(color: Color(0xFF1E1E1E)),
                  ),

                  // Tự động thay đổi giữa Light và Dark dựa vào trạng thái isDark
                  themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

                  // Cỡ chữ toàn cục
                  builder: (context, child) {
                    return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(textScaler: TextScaler.linear(textScale)),
                      child: child!,
                    );
                  },
                  home: const ProductListScreen(),
                );
              },
            );
          },
        );
      },
    );
  }
}
