import 'package:flutter/material.dart';

class SearchFilterBar extends StatelessWidget {
  final TextEditingController searchController;
  final String hintText;
  final List<Widget>? filters;
  final VoidCallback? onSearch;
  final VoidCallback? onFilter;

  const SearchFilterBar({
    super.key,
    required this.searchController,
    required this.hintText,
    this.filters,
    this.onSearch,
    this.onFilter,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Search Field
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onSubmitted: (_) => onSearch?.call(),
            ),
          ),
          const SizedBox(width: 16),
          // Filter Button
          if (filters != null)
            PopupMenuButton(
              icon: const Icon(Icons.filter_list),
              tooltip: 'Filter',
              onSelected: (_) => onFilter?.call(),
              itemBuilder: (context) => filters!
                  .map(
                    (filter) => PopupMenuItem(
                      child: filter,
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}
