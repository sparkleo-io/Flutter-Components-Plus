import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class FCPMultiSelectExamples extends StatefulWidget {
  const FCPMultiSelectExamples({super.key});

  @override
  State<FCPMultiSelectExamples> createState() => _FCPMultiSelectExamplesState();
}

class _FCPMultiSelectExamplesState extends State<FCPMultiSelectExamples> {
  List<FCPMultiSelectItem> categories = [
    const FCPMultiSelectItem(label: 'Technology', value: 'tech'),
    const FCPMultiSelectItem(label: 'Sports', value: 'sports'),
    const FCPMultiSelectItem(label: 'Music', value: 'music'),
    const FCPMultiSelectItem(label: 'Movies', value: 'movies'),
    const FCPMultiSelectItem(label: 'Books', value: 'books'),
    const FCPMultiSelectItem(label: 'Travel', value: 'travel'),
  ];

  List<FCPMultiSelectItem> tags = [
    const FCPMultiSelectItem(label: 'Flutter', value: 'flutter'),
    const FCPMultiSelectItem(label: 'Dart', value: 'dart'),
    const FCPMultiSelectItem(label: 'Mobile', value: 'mobile'),
    const FCPMultiSelectItem(label: 'Web', value: 'web'),
    const FCPMultiSelectItem(label: 'Desktop', value: 'desktop'),
    const FCPMultiSelectItem(label: 'Cross-platform', value: 'cross-platform'),
  ];

  List<FCPMultiSelectItem> colors = [
    const FCPMultiSelectItem(label: 'Red', value: 'red'),
    const FCPMultiSelectItem(label: 'Blue', value: 'blue'),
    const FCPMultiSelectItem(label: 'Green', value: 'green'),
    const FCPMultiSelectItem(label: 'Yellow', value: 'yellow'),
    const FCPMultiSelectItem(label: 'Purple', value: 'purple'),
    const FCPMultiSelectItem(label: 'Orange', value: 'orange'),
  ];

  List<FCPMultiSelectItem> users = [
    const FCPMultiSelectItem(label: 'John Doe', value: 'john'),
    const FCPMultiSelectItem(label: 'Jane Smith', value: 'jane'),
    const FCPMultiSelectItem(label: 'Bob Johnson', value: 'bob'),
    const FCPMultiSelectItem(label: 'Alice Brown', value: 'alice'),
    const FCPMultiSelectItem(label: 'Charlie Wilson', value: 'charlie'),
    const FCPMultiSelectItem(label: 'Diana Davis', value: 'diana'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi-Select Dropdown Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Basic Multi-Select'),
            const SizedBox(height: 8),
            FCPMultiSelectDropdown(
              title: 'Select Categories',
              items: categories,
              onSelectionChanged: (selectedItems) {
                setState(() {
                  categories = selectedItems;
                });
              },
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Multi-Select with Search and Select All'),
            const SizedBox(height: 8),
            FCPMultiSelectDropdown(
              title: 'Select Tags',
              items: tags,
              onSelectionChanged: (selectedItems) {
                setState(() {
                  tags = selectedItems;
                });
              },
              showSelectAll: true,
              isSearchEnabled: true,
              searchHintText: 'Search tags...',
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Multi-Select with Maximum Selections'),
            const SizedBox(height: 8),
            FCPMultiSelectDropdown(
              title: 'Select Colors (Max 3)',
              items: colors,
              onSelectionChanged: (selectedItems) {
                setState(() {
                  colors = selectedItems;
                });
              },
              maxSelections: 3,
              showSelectAll: true,
              isSearchEnabled: true,
              searchHintText: 'Search colors...',
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Multi-Select with Icon and Border'),
            const SizedBox(height: 8),
            FCPMultiSelectDropdown(
              title: 'Select Users',
              items: users,
              onSelectionChanged: (selectedItems) {
                setState(() {
                  users = selectedItems;
                });
              },
              prefixIcon: Icons.people,
              enableBorder: true,
              showSelectAll: true,
              isSearchEnabled: true,
              searchHintText: 'Search users...',
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Custom Styled Multi-Select'),
            const SizedBox(height: 8),
            FCPMultiSelectDropdown(
              title: 'Select Options',
              items: [
                const FCPMultiSelectItem(label: 'Option 1', value: 'opt1'),
                const FCPMultiSelectItem(label: 'Option 2', value: 'opt2'),
                const FCPMultiSelectItem(label: 'Option 3', value: 'opt3'),
                const FCPMultiSelectItem(label: 'Option 4', value: 'opt4'),
              ],
              onSelectionChanged: (selectedItems) {
                print(
                  'Selected: ${selectedItems.map((item) => item.label).toList()}',
                );
              },
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
              showSelectAll: true,
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Extension Method Example'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                context.showFCPMultiSelectDropdown(
                  title: 'Select from Extension',
                  items: [
                    const FCPMultiSelectItem(label: 'Item A', value: 'a'),
                    const FCPMultiSelectItem(label: 'Item B', value: 'b'),
                    const FCPMultiSelectItem(label: 'Item C', value: 'c'),
                    const FCPMultiSelectItem(label: 'Item D', value: 'd'),
                  ],
                  onSelectionChanged: (selectedItems) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Selected: ${selectedItems.map((item) => item.label).toList()}',
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  showSelectAll: true,
                  isSearchEnabled: true,
                  searchHintText: 'Search items...',
                );
              },
              child: const Text('Show Multi-Select via Extension'),
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Selected Values'),
            const SizedBox(height: 16),
            _buildSelectedValues('Categories', categories),
            _buildSelectedValues('Tags', tags),
            _buildSelectedValues('Colors', colors),
            _buildSelectedValues('Users', users),
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

  Widget _buildSelectedValues(String label, List<FCPMultiSelectItem> items) {
    final selectedItems = items.where((item) => item.isSelected).toList();
    final selectedLabels = selectedItems.map((item) => item.label).toList();

    String displayText;
    if (selectedLabels.isEmpty) {
      displayText = 'None selected';
    } else if (selectedLabels.length == 1) {
      displayText = selectedLabels.first;
    } else if (selectedLabels.length <= 3) {
      displayText = selectedLabels.join(', ');
    } else {
      displayText =
          '${selectedLabels.take(3).join(', ')} and ${selectedLabels.length - 3} more';
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label: ',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              displayText,
              style: TextStyle(
                color: selectedLabels.isEmpty ? Colors.grey : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FCPMultiSelectUsageExamples {
  static const String basicExample = '''
// Basic multi-select usage
FCPMultiSelectDropdown(
  title: 'Select Categories',
  items: [
    FCPMultiSelectItem(label: 'Technology', value: 'tech'),
    FCPMultiSelectItem(label: 'Sports', value: 'sports'),
    FCPMultiSelectItem(label: 'Music', value: 'music'),
  ],
  onSelectionChanged: (selectedItems) {
    print('Selected: \${selectedItems.map((item) => item.label).toList()}');
  },
)
''';

  static const String searchExample = '''
// Multi-select with search and select all
FCPMultiSelectDropdown(
  title: 'Select Tags',
  items: [
    FCPMultiSelectItem(label: 'Flutter', value: 'flutter'),
    FCPMultiSelectItem(label: 'Dart', value: 'dart'),
    FCPMultiSelectItem(label: 'Mobile', value: 'mobile'),
  ],
  onSelectionChanged: (selectedItems) {
    print('Selected: \${selectedItems.map((item) => item.label).toList()}');
  },
  showSelectAll: true,
  isSearchEnabled: true,
  searchHintText: 'Search tags...',
)
''';

  static const String maxSelectionsExample = '''
// Multi-select with maximum selections
FCPMultiSelectDropdown(
  title: 'Select Colors (Max 3)',
  items: [
    FCPMultiSelectItem(label: 'Red', value: 'red'),
    FCPMultiSelectItem(label: 'Blue', value: 'blue'),
    FCPMultiSelectItem(label: 'Green', value: 'green'),
  ],
  onSelectionChanged: (selectedItems) {
    print('Selected: \${selectedItems.map((item) => item.label).toList()}');
  },
  maxSelections: 3,
  showSelectAll: true,
)
''';

  static const String customStylingExample = '''
// Multi-select with custom styling
FCPMultiSelectDropdown(
  title: 'Select Options',
  items: [
    FCPMultiSelectItem(label: 'Option 1', value: 'opt1'),
    FCPMultiSelectItem(label: 'Option 2', value: 'opt2'),
    FCPMultiSelectItem(label: 'Option 3', value: 'opt3'),
  ],
  onSelectionChanged: (selectedItems) {
    print('Selected: \${selectedItems.map((item) => item.label).toList()}');
  },
  prefixIcon: Icons.category,
  enableBorder: true,
  titleStyle: TextStyle(fontWeight: FontWeight.bold),
  itemTextStyle: TextStyle(fontSize: 16),
  selectedItemTextStyle: TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.w600,
  ),
  selectedItemIconColor: Colors.blue,
)
''';

  static const String extensionExample = '''
// Using the extension method
context.showFCPMultiSelectDropdown(
  title: 'Select Items',
  items: [
    FCPMultiSelectItem(label: 'Item 1', value: 'item1'),
    FCPMultiSelectItem(label: 'Item 2', value: 'item2'),
    FCPMultiSelectItem(label: 'Item 3', value: 'item3'),
  ],
  onSelectionChanged: (selectedItems) {
    print('Selected: \${selectedItems.map((item) => item.label).toList()}');
  },
  showSelectAll: true,
  isSearchEnabled: true,
);
''';

  static const String customBuilderExample = '''
// Multi-select with custom item builder
FCPMultiSelectDropdown(
  title: 'Select Users',
  items: [
    FCPMultiSelectItem(label: 'John Doe', value: 'john'),
    FCPMultiSelectItem(label: 'Jane Smith', value: 'jane'),
    FCPMultiSelectItem(label: 'Bob Johnson', value: 'bob'),
  ],
  onSelectionChanged: (selectedItems) {
    print('Selected: \${selectedItems.map((item) => item.label).toList()}');
  },
  customItemBuilder: (item, index, isSelected, onChanged) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(item.label[0]),
      ),
      title: Text(item.label),
      trailing: Checkbox(
        value: isSelected,
        onChanged: onChanged,
      ),
    );
  },
)
''';
}
