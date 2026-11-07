import 'package:flutter/material.dart';
import 'package:shop_easy/data/sample_products.dart';

class CategoryRow extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelected;

  const CategoryRow({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    // SingleChildScrollView: cho phép cuộn ngang danh mục
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: categoryList.map((item) {
          final name = item.name;
          final icon = item.icon;
          final isSelected = selected == name;

          return SizedBox(
            width: 72,
            // InkWell: tạo hiệu ứng nhấn và xử lý sự kiện chọn danh mục
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => onSelected(name),
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
