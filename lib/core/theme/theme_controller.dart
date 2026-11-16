import 'package:flutter/material.dart';

// ValueNotifier toàn cục để lắng nghe và chuyển đổi Theme
final ValueNotifier<bool> isDarkModeNotifier = ValueNotifier<bool>(false);
final ValueNotifier<double> textScaleNotifier = ValueNotifier<double>(1.0);
final ValueNotifier<Locale> localeNotifier = ValueNotifier<Locale>(
  const Locale('vi'),
);
