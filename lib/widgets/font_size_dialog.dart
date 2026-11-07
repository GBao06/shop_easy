import 'package:flutter/material.dart';
import 'package:shop_easy/theme/theme_controller.dart';

void showFontSizeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return ValueListenableBuilder<double>(
        valueListenable: textScaleNotifier,
        builder: (_, currentScale,_) {
          return AlertDialog(
            title: const Text('Chọn cỡ chữ'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _option(dialogContext, 'Nhỏ', 0.85, currentScale),
                _option(dialogContext, 'Vừa (Mặc định)', 1.0, currentScale),
                _option(dialogContext, 'Lớn', 1.15, currentScale),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _option(
  BuildContext context,
  String label,
  double value,
  double groupValue,
) {
  return RadioListTile<double>(
    title: Text(label),
    value: value,
    // ignore: deprecated_member_use
    groupValue: groupValue,
    // ignore: deprecated_member_use
    onChanged: (v) {
      textScaleNotifier.value = v!;
      Navigator.pop(context);
    },
  );
}