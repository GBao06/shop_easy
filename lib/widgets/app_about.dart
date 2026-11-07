import 'package:flutter/material.dart';
import 'package:shop_easy/l10n/app_strings.dart';

void showAppAboutDialog(BuildContext context) {
  final s = AppStrings.of(context);

  showAboutDialog(
    context: context,
    applicationName: 'ShopEasy',
    applicationVersion: '1.0.0',
    applicationIcon: const Icon(Icons.storefront, size: 48),
    applicationLegalese: '© 2026 ShopEasy',
    children: [
      const SizedBox(height: 12),
      Text(s.aboutDescription),
    ],
  );
}