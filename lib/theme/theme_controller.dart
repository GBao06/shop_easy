import 'package:flutter/material.dart';

// ValueNotifier toàn cục để lắng nghe và chuyển đổi Theme
final ValueNotifier<bool> isDarkModeNotifier = ValueNotifier<bool>(false);
final textScaleNotifier = ValueNotifier<double>(1.0);