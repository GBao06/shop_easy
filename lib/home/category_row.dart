import 'package:flutter/material.dart';

class CategoryRow extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelected;

  const CategoryRow({super.key, required this.selected, required this.onSelected});

static const _items = [
  ('Tất cả', Icons.apps),           
  ('Vợt cầu lông', Icons.sports_tennis),
  ('Áo cầu lông', Icons.checkroom),
  ('Quần cầu lông', Icons.dry_cleaning),
  ('Giày cầu lông', Icons.directions_run),
];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: _items.map((item) {
          final (name, icon) = item;
          final isSelected = selected == name;
          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              // bấm lần nữa thì bỏ lọc
              onTap: () => onSelected(isSelected ? 'Tất cả' : name),
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
                    child: Icon(icon,
                        color: isSelected ? cs.onPrimary : cs.primary),
                  ),
                  const SizedBox(height: 6),
                  Text(name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}