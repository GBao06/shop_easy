import 'package:flutter/material.dart';
import 'package:shop_easy/l10n/app_strings.dart';
import 'package:shop_easy/theme/theme_controller.dart';

void showLanguageDialog(BuildContext context) {
  final s = AppStrings.of(context);
  // Hiển thị hộp thoại chọn ngôn ngữ
  showDialog(
    context: context,
    builder: (dialogContext) => SimpleDialog(
      title: Text(s.language),
      children: [
        _item(dialogContext, 'Tiếng Việt', 'vi'),
        _item(dialogContext, 'English', 'en'),
      ],
    ),
  );
}
// Widget để tạo một mục ngôn ngữ trong hộp thoại
Widget _item(BuildContext context, String label, String code) {
  final selected = localeNotifier.value.languageCode == code;
  return SimpleDialogOption(
    onPressed: () {
      localeNotifier.value = Locale(code);
      Navigator.pop(context);
    },
    child: Row(
      children: [
        Expanded(child: Text(label)),
        if (selected) const Icon(Icons.check),
      ],
    ),
  );
}