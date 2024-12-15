import 'package:flutter/material.dart';

class FilterChipList extends StatelessWidget {
  final List<String> filters;
  final List<String> selectedFilters;
  final Function(String) onFilterSelected;

  const FilterChipList({
    super.key,
    required this.filters,
    required this.selectedFilters,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: filters.map((filter) {
        final isSelected = selectedFilters.contains(filter);
        return FilterChip(
          label: Text(filter),
          selected: isSelected,
          onSelected: (_) => onFilterSelected(filter),
          backgroundColor: isSelected ? Theme.of(context).primaryColor : null,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : null,
          ),
        );
      }).toList(),
    );
  }
} 