import 'package:flutter/material.dart';

class NewsCategoryFilter extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const NewsCategoryFilter({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  static const categories = [
    'All',
    'Hardware',
    'Gaming',
    'Reviews',
    'Releases',
    'Deals',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;
          
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FilterChip(
              selected: isSelected,
              label: Text(category),
              onSelected: (_) => onCategorySelected(category),
              backgroundColor: isSelected ? Theme.of(context).primaryColor : null,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : null,
              ),
            ),
          );
        },
      ),
    );
  }
} 