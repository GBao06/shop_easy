import 'package:flutter/material.dart';
import 'package:shop_easy/core/l10n/app_strings.dart';

/// Slug đại diện cho mục "Tất cả"
const String kAllCategories = 'all';

class CategoryRow extends StatelessWidget {
  /// Danh sách slug lấy từ API (không gồm "all")
  final List<String> categories;
  final String selected;
  final ValueChanged<String> onSelected;

  const CategoryRow({
    super.key,
    required this.categories,
    required this.selected,
    required this.onSelected,
  });

  // slug -> icon (slug nào chưa có sẽ dùng icon mặc định)
  static const Map<String, IconData> _icons = {
    'beauty': Icons.face_retouching_natural,
    'fragrances': Icons.spa,
    'furniture': Icons.chair,
    'groceries': Icons.shopping_basket,
    'laptops': Icons.laptop,
    'smartphones': Icons.smartphone,
    'tablets': Icons.tablet_mac,
    'mobile-accessories': Icons.headphones,
    'sunglasses': Icons.wb_sunny,
    'sports-accessories': Icons.sports_soccer,
    'motorcycle': Icons.two_wheeler,
    'vehicle': Icons.directions_car,
    'skin-care': Icons.water_drop,
    'kitchen-accessories': Icons.kitchen,
    'home-decoration': Icons.home,
  };

  // "mens-shirts" -> "Mens shirts"
  static String _label(String slug) {
    final text = slug.replaceAll('-', ' ');
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final s = AppStrings.of(context);
    final items = [kAllCategories, ...categories];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: items.map((slug) {
          final isAll = slug == kAllCategories;
          final name = isAll ? s.all : _label(slug);
          final icon = isAll ? Icons.apps : (_icons[slug] ?? Icons.category);
          final isSelected = selected == slug;

          return SizedBox(
            width: 72,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => onSelected(slug),
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: isSelected ? cs.primary : cs.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: cs.outlineVariant),
                    ),
                    child: Icon(
                      icon,
                      color: isSelected ? cs.onPrimary : cs.primary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}