import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class MultiInlineDropdownExamples extends StatefulWidget {
  const MultiInlineDropdownExamples({super.key});

  @override
  State<MultiInlineDropdownExamples> createState() =>
      _MultiInlineDropdownExamplesState();
}

class _MultiInlineDropdownExamplesState
    extends State<MultiInlineDropdownExamples> {
  List<FCPMultiInlineItem> _basicItems = [];
  List<FCPMultiInlineItem> _searchableItems = [];
  List<FCPMultiInlineItem> _customItems = [];
  List<FCPMultiInlineItem> _limitedItems = [];

  @override
  void initState() {
    super.initState();
    _initializeItems();
  }

  void _initializeItems() {
    // Basic multi-select items
    _basicItems = [
      const FCPMultiInlineItem(label: 'Apple', value: 'apple'),
      const FCPMultiInlineItem(label: 'Banana', value: 'banana'),
      const FCPMultiInlineItem(label: 'Cherry', value: 'cherry'),
      const FCPMultiInlineItem(label: 'Date', value: 'date'),
      const FCPMultiInlineItem(label: 'Elderberry', value: 'elderberry'),
    ];

    // Searchable multi-select items
    _searchableItems = [
      const FCPMultiInlineItem(label: 'React', value: 'react'),
      const FCPMultiInlineItem(label: 'Vue.js', value: 'vue'),
      const FCPMultiInlineItem(label: 'Angular', value: 'angular'),
      const FCPMultiInlineItem(label: 'Svelte', value: 'svelte'),
      const FCPMultiInlineItem(label: 'Next.js', value: 'nextjs'),
      const FCPMultiInlineItem(label: 'Nuxt.js', value: 'nuxtjs'),
      const FCPMultiInlineItem(label: 'Ember.js', value: 'ember'),
      const FCPMultiInlineItem(label: 'Backbone.js', value: 'backbone'),
    ];

    // Custom multi-select items
    _customItems = [
      const FCPMultiInlineItem(label: 'Design', value: 'design'),
      const FCPMultiInlineItem(label: 'Development', value: 'development'),
      const FCPMultiInlineItem(label: 'Marketing', value: 'marketing'),
      const FCPMultiInlineItem(label: 'Sales', value: 'sales'),
      const FCPMultiInlineItem(label: 'Support', value: 'support'),
    ];

    // Limited multi-select items
    _limitedItems = [
      const FCPMultiInlineItem(label: 'Red', value: 'red'),
      const FCPMultiInlineItem(label: 'Green', value: 'green'),
      const FCPMultiInlineItem(label: 'Blue', value: 'blue'),
      const FCPMultiInlineItem(label: 'Yellow', value: 'yellow'),
      const FCPMultiInlineItem(label: 'Purple', value: 'purple'),
      const FCPMultiInlineItem(label: 'Orange', value: 'orange'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Basic Multi-Select Inline Dropdown'),
            const SizedBox(height: 16),
            FCPMultiInlineDropdown(
              title: 'Select Fruits',
              items: _basicItems,
              onSelectionChanged: (selectedItems) {
                setState(() {
                  _basicItems = selectedItems;
                });
                _showSelectionSnackBar('Basic', selectedItems);
              },
              enableBorder: true,
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Searchable Multi-Select Inline Dropdown'),
            const SizedBox(height: 16),
            FCPMultiInlineDropdown(
              title: 'Select Frameworks',
              items: _searchableItems,
              onSelectionChanged: (selectedItems) {
                setState(() {
                  _searchableItems = selectedItems;
                });
                _showSelectionSnackBar('Searchable', selectedItems);
              },
              isSearchEnabled: true,
              enableBorder: true,
              showSelectAll: true,
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Custom Multi-Select Inline Dropdown'),
            const SizedBox(height: 16),
            FCPMultiInlineDropdown(
              title: 'Select Departments',
              items: _customItems,
              onSelectionChanged: (selectedItems) {
                setState(() {
                  _customItems = selectedItems;
                });
                _showSelectionSnackBar('Custom', selectedItems);
              },
              enableBorder: true,
              prefixIcon: Icons.business,
              customItemBuilder: (item, index, isSelected, onChanged) {
                return Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: isSelected
                        ? Theme.of(
                            context,
                          ).colorScheme.primaryContainer.withValues(alpha: 0.2)
                        : null,
                    border: isSelected
                        ? Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          )
                        : null,
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: isSelected,
                        onChanged: onChanged,
                        activeColor: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          item.label,
                          style: TextStyle(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.star,
                          color: Theme.of(context).colorScheme.primary,
                          size: 16,
                        ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Limited Multi-Select Inline Dropdown'),
            const SizedBox(height: 16),
            FCPMultiInlineDropdown(
              title: 'Select Colors (Max 3)',
              items: _limitedItems,
              onSelectionChanged: (selectedItems) {
                setState(() {
                  _limitedItems = selectedItems;
                });
                _showSelectionSnackBar('Limited', selectedItems);
              },
              maxSelections: 3,
              enableBorder: true,
              showSelectAll: true,
              prefixIcon: Icons.palette,
              showDivider: false,
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Disabled Multi-Select Inline Dropdown'),
            const SizedBox(height: 16),
            FCPMultiInlineDropdown(
              title: 'Disabled Dropdown',
              items: _basicItems,
              onSelectionChanged: (selectedItems) {
                // This won't be called when disabled
              },
              disabled: true,
              enableBorder: true,
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Current Selections'),
            const SizedBox(height: 16),
            _buildSelectionsDisplay(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildSelectionsDisplay() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Selections:',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildSelectionItem('Basic Fruits', _basicItems),
            _buildSelectionItem('Searchable Frameworks', _searchableItems),
            _buildSelectionItem('Custom Departments', _customItems),
            _buildSelectionItem('Limited Colors', _limitedItems),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionItem(String label, List<FCPMultiInlineItem> items) {
    final selectedItems = items.where((item) => item.isSelected).toList();
    final selectedLabels = selectedItems.map((item) => item.label).join(', ');

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              selectedLabels.isEmpty ? 'None selected' : selectedLabels,
              style: TextStyle(
                color: selectedLabels.isEmpty
                    ? Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.6)
                    : null,
                fontStyle: selectedLabels.isEmpty
                    ? FontStyle.italic
                    : FontStyle.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSelectionSnackBar(
    String type,
    List<FCPMultiInlineItem> selectedItems,
  ) {
    final selectedLabels = selectedItems
        .where((item) => item.isSelected)
        .map((item) => item.label)
        .join(', ');
    final message = selectedLabels.isEmpty
        ? '$type: No items selected'
        : '$type: ${selectedItems.where((item) => item.isSelected).length} items selected';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Details',
          onPressed: () {
            if (selectedLabels.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Selected: $selectedLabels'),
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
