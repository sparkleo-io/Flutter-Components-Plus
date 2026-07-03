import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class DebugInlineDropdown extends StatefulWidget {
  const DebugInlineDropdown({super.key});

  @override
  State<DebugInlineDropdown> createState() => _DebugInlineDropdownState();
}

class _DebugInlineDropdownState extends State<DebugInlineDropdown> {
  int? selectedIndex;
  String? selectedCustomItem;

  final List<String> items = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Basic Inline Dropdown'),
            const SizedBox(height: 8),
            Container(
              width: 300,
              child: FCPInlineDropdown(
                title: 'Select Option',
                items: items,
                selectedIndex: selectedIndex,
                onItemSelected: (value) {
                  print('DEBUG: Item selected: $value');
                  setState(() {
                    selectedIndex = value as int;
                  });
                },
                enableBorder: true,
                prefixIcon: Icons.arrow_drop_down,
              ),
            ),

            const SizedBox(height: 24),

            _buildSectionTitle('Inline Dropdown with Search'),
            const SizedBox(height: 8),
            Container(
              width: 300,
              child: FCPInlineDropdown(
                title: 'Select with Search',
                items: items,
                selectedIndex: selectedIndex,
                onItemSelected: (value) {
                  print('DEBUG: Item selected: $value');
                  setState(() {
                    selectedIndex = value as int;
                  });
                },
                isSearchEnabled: true,
                searchHintText: 'Search options...',
                enableBorder: true,
                prefixIcon: Icons.search,
              ),
            ),

            const SizedBox(height: 24),

            _buildSectionTitle('Custom Styled Inline Dropdown'),
            const SizedBox(height: 8),
            Container(
              width: 300,
              child: FCPInlineDropdown(
                title: 'Custom Styled',
                items: items,
                selectedIndex: selectedIndex,
                onItemSelected: (value) {
                  print('DEBUG: Item selected: $value');
                  setState(() {
                    selectedIndex = value as int;
                  });
                },
                prefixIcon: Icons.star,
                enableBorder: true,
                isSearchEnabled: true,
                searchHintText: 'Search...',
                titleStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                itemTextStyle: const TextStyle(fontSize: 16),
                selectedItemTextStyle: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                selectedItemIconColor: Colors.blue,
                backgroundColor: Colors.grey[50],
                maxHeight: 200,
                itemHeight: 48,
                borderRadius: 12,
              ),
            ),

            const SizedBox(height: 24),

            _buildSectionTitle('Custom Item Builder'),
            const SizedBox(height: 8),
            Container(
              width: 300,
              child: FCPInlineDropdown(
                title: 'Custom Items',
                items: items,
                selectedIndex: selectedIndex,
                onItemSelected: (value) {
                  print('DEBUG: Item selected: $value');
                  setState(() {
                    selectedIndex = value as int;
                  });
                },
                prefixIcon: Icons.person,
                enableBorder: true,
                isSearchEnabled: true,
                searchHintText: 'Search...',
                customItemBuilder: (item, index, isSelected) {
                  return Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 4),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.blue.withValues(alpha: 0.1)
                          : null,
                      borderRadius: BorderRadius.circular(8),
                      border: isSelected
                          ? Border.all(color: Colors.blue, width: 1)
                          : null,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: isSelected
                              ? Colors.blue
                              : Colors.grey[300],
                          child: Text(
                            item[0],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            item,
                            style: TextStyle(
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              color: isSelected ? Colors.blue : null,
                            ),
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 20,
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            _buildSectionTitle('Non-Indexed Inline Dropdown'),
            const SizedBox(height: 8),
            Container(
              width: 300,
              child: FCPInlineDropdown(
                title: 'Non-Indexed',
                items: items,
                selectedIndex: selectedCustomItem != null
                    ? items.indexOf(selectedCustomItem!)
                    : null,
                onItemSelected: (value) {
                  print('DEBUG: Item selected: $value');
                  setState(() {
                    selectedCustomItem = value as String;
                  });
                },
                indexed: false,
                prefixIcon: Icons.settings,
                enableBorder: true,
                isSearchEnabled: true,
                searchHintText: 'Search...',
              ),
            ),

            const SizedBox(height: 24),

            _buildSectionTitle('Compact Inline Dropdown'),
            const SizedBox(height: 8),
            Container(
              width: 300,
              child: FCPInlineDropdown(
                title: 'Compact Style',
                items: items,
                selectedIndex: selectedIndex,
                onItemSelected: (value) {
                  print('DEBUG: Item selected: $value');
                  setState(() {
                    selectedIndex = value as int;
                  });
                },
                prefixIcon: Icons.straighten,
                enableBorder: true,
                maxHeight: 150,
                itemHeight: 40,
                itemSpacing: 2,
                borderRadius: 6,
              ),
            ),

            const SizedBox(height: 24),

            _buildSectionTitle('Disabled Inline Dropdown'),
            const SizedBox(height: 8),
            Container(
              width: 300,
              child: FCPInlineDropdown(
                title: 'Disabled Dropdown',
                items: items,
                onItemSelected: (value) {},
                disabled: true,
                prefixIcon: Icons.lock,
                enableBorder: true,
              ),
            ),

            const SizedBox(height: 40),

            _buildSectionTitle('Selected Values'),
            const SizedBox(height: 16),
            _buildSelectedValue('Indexed', selectedIndex, items),
            _buildSelectedValue('Non-Indexed', null, null, selectedCustomItem),

            const SizedBox(height: 40),

            // Test button to verify state updates
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = null;
                    selectedCustomItem = null;
                  });
                },
                child: const Text('Reset All Selections'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSelectedValue(
    String label,
    int? index,
    List<String>? items, [
    String? customValue,
  ]) {
    String value = 'Not selected';
    if (customValue != null) {
      value = customValue;
    } else if (index != null &&
        items != null &&
        index >= 0 &&
        index < items.length) {
      value = items[index];
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w500)),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: value == 'Not selected' ? Colors.grey : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
