import 'package:flutter/material.dart';
import 'filter_state.dart';

class FilterChips extends StatelessWidget {
  final FilterManager filterManager;
  final Function(String columnName) onRemoveFilter;
  final Function() onClearAllFilters;

  const FilterChips({
    super.key,
    required this.filterManager,
    required this.onRemoveFilter,
    required this.onClearAllFilters,
  });

  @override
  Widget build(BuildContext context) {
    if (!filterManager.hasActiveFilters()) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        children: [
          // Clear all button
          ActionChip(
            label: const Text('Clear All'),
            onPressed: onClearAllFilters,
            backgroundColor: Colors.grey.shade200,
            labelStyle: const TextStyle(fontSize: 12),
          ),
          // Individual filter chips
          ...filterManager.filters.entries
              .where((entry) => entry.value.isNotEmpty)
              .map(
                (entry) => _buildFilterChip(context, entry.key, entry.value),
              ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    String columnName,
    FilterState filter,
  ) {
    return Chip(
      label: Text(_getFilterDisplayText(columnName, filter)),
      onDeleted: () => onRemoveFilter(columnName),
      backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
      labelStyle: TextStyle(
        fontSize: 12,
        color: Theme.of(context).primaryColor,
      ),
      deleteIcon: Icon(
        Icons.close,
        size: 16,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  String _getFilterDisplayText(String columnName, FilterState filter) {
    switch (filter.filterType) {
      case 'text':
        return '$columnName: "${filter.filterValue}"';

      case 'select':
        if (filter.filterOptions != null && filter.filterOptions!.isNotEmpty) {
          final options = filter.filterOptions!.take(2).join(', ');
          final suffix = filter.filterOptions!.length > 2 ? '...' : '';
          return '$columnName: $options$suffix';
        }
        return '$columnName: ${filter.filterValue}';

      case 'number':
        final parts = <String>[];
        if (filter.minValue != null) parts.add('≥${filter.minValue}');
        if (filter.maxValue != null) parts.add('≤${filter.maxValue}');
        return '$columnName: ${parts.join(' and ')}';

      case 'date':
        final parts = <String>[];
        if (filter.startDate != null) {
          parts.add('from ${_formatDate(filter.startDate!)}');
        }
        if (filter.endDate != null) {
          parts.add('to ${_formatDate(filter.endDate!)}');
        }
        return '$columnName: ${parts.join(' ')}';

      default:
        return '$columnName: ${filter.filterValue}';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
