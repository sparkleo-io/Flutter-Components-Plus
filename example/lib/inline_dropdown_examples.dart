import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class FCPInlineDropdownExamples extends StatefulWidget {
  const FCPInlineDropdownExamples({super.key});

  @override
  State<FCPInlineDropdownExamples> createState() =>
      _FCPInlineDropdownExamplesState();
}

class _FCPInlineDropdownExamplesState extends State<FCPInlineDropdownExamples> {
  int? selectedCountryIndex;
  int? selectedCityIndex;
  int? selectedUserIndex;
  int? selectedCategoryIndex;
  int? selectedSizeIndex;
  String? selectedCustomItem;

  final List<String> countries = [
    'United States',
    'Canada',
    'United Kingdom',
    'Germany',
    'France',
    'Japan',
    'Australia',
    'Brazil',
    'India',
    'China',
  ];

  final List<String> cities = [
    'New York',
    'London',
    'Tokyo',
    'Paris',
    'Berlin',
    'Sydney',
    'Toronto',
    'Mumbai',
    'Beijing',
    'Rio de Janeiro',
  ];

  final List<String> users = [
    'John Doe',
    'Jane Smith',
    'Bob Johnson',
    'Alice Brown',
    'Charlie Wilson',
    'Diana Davis',
    'Edward Miller',
    'Fiona Garcia',
  ];

  final List<String> categories = [
    'Technology',
    'Sports',
    'Music',
    'Movies',
    'Books',
    'Food',
    'Travel',
    'Fashion',
  ];

  final List<String> sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

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
            FCPInlineDropdown(
              title: 'Select Country',
              items: countries,
              selectedIndex: selectedCountryIndex,
              onItemSelected: (value) {
                setState(() {
                  selectedCountryIndex = value as int;
                });
              },
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Inline Dropdown with Search'),
            const SizedBox(height: 8),
            FCPInlineDropdown(
              title: 'Select City',
              items: cities,
              selectedIndex: selectedCityIndex,
              onItemSelected: (value) {
                setState(() {
                  selectedCityIndex = value as int;
                });
              },
              isSearchEnabled: true,
              searchHintText: 'Search cities...',
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Inline Dropdown with Icon and Border'),
            const SizedBox(height: 8),
            FCPInlineDropdown(
              title: 'Select User',
              items: users,
              selectedIndex: selectedUserIndex,
              onItemSelected: (value) {
                setState(() {
                  selectedUserIndex = value as int;
                });
              },
              prefixIcon: Icons.person,
              enableBorder: true,
              isSearchEnabled: true,
              searchHintText: 'Search users...',
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Custom Styled Inline Dropdown'),
            const SizedBox(height: 8),
            FCPInlineDropdown(
              title: 'Select Category',
              items: categories,
              selectedIndex: selectedCategoryIndex,
              onItemSelected: (value) {
                setState(() {
                  selectedCategoryIndex = value as int;
                });
              },
              prefixIcon: Icons.category,
              enableBorder: true,
              isSearchEnabled: true,
              searchHintText: 'Search categories...',
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
              maxHeight: 250,
              itemHeight: 52,
              borderRadius: 12,
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Enhanced Custom Item Builder'),
            const SizedBox(height: 8),
            FCPInlineDropdown(
              title: 'Select User with Enhanced Avatar',
              items: users,
              selectedIndex: selectedUserIndex,
              onItemSelected: (value) {
                setState(() {
                  selectedUserIndex = value as int;
                });
              },
              prefixIcon: Icons.people,
              enableBorder: true,
              isSearchEnabled: true,
              searchHintText: 'Search users...',
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
                        backgroundColor: isSelected
                            ? Colors.blue
                            : Colors.grey[300],
                        radius: 18,
                        child: Text(
                          item[0].toUpperCase(),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item,
                              style: TextStyle(
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                color: isSelected ? Colors.blue : null,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'User ID: ${index + 1001}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Non-Indexed Inline Dropdown'),
            const SizedBox(height: 8),
            FCPInlineDropdown(
              title: 'Select Option',
              items: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
              selectedIndex: selectedCustomItem != null
                  ? [
                      'Option 1',
                      'Option 2',
                      'Option 3',
                      'Option 4',
                    ].indexOf(selectedCustomItem!)
                  : null,
              onItemSelected: (value) {
                setState(() {
                  selectedCustomItem = value as String;
                });
              },

              indexed: false,
              prefixIcon: Icons.settings,
              enableBorder: true,
              isSearchEnabled: true,
              searchHintText: 'Search options...',
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Compact Inline Dropdown'),
            const SizedBox(height: 8),
            FCPInlineDropdown(
              dropdownWidth: 200,
              buttonWidth: 250,
              showDivider: false,
              title: 'Select Size',
              items: sizes,
              selectedIndex: selectedSizeIndex,
              onItemSelected: (value) {
                setState(() {
                  selectedSizeIndex = value as int;
                });
              },
              prefixIcon: Icons.straighten,
              enableBorder: true,
              maxHeight: 150,
              itemHeight: 40,
              itemSpacing: 2,
              borderRadius: 6,
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Disabled Inline Dropdown'),
            const SizedBox(height: 8),
            FCPInlineDropdown(
              title: 'Disabled Dropdown',
              items: ['Item 1', 'Item 2', 'Item 3'],
              onItemSelected: (value) {},
              disabled: true,
              prefixIcon: Icons.lock,
              enableBorder: true,
            ),
            const SizedBox(height: 24),

            // const SizedBox(height: 24),

            // _buildSectionTitle('Extension Method Example'),
            // const SizedBox(height: 8),
            // ElevatedButton(
            //   onPressed: () {
            //     final layerLink = LayerLink();
            //     context.showFCPDropdownOverlay(
            //       layerLink: layerLink,
            //       items: ['Item A', 'Item B', 'Item C', 'Item D'],
            //       onItemSelected: (value) {
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           SnackBar(
            //             content: Text('Selected: $value'),
            //             duration: const Duration(seconds: 2),
            //           ),
            //         );
            //       },
            //       isSearchEnabled: true,
            //       searchHintText: 'Search items...',
            //     );
            //   },
            //   child: const Text('Show Dropdown via Extension'),
            // ),
            // const SizedBox(height: 24),
            _buildSectionTitle('Selected Values'),
            const SizedBox(height: 16),
            _buildSelectedValue('Country', selectedCountryIndex, countries),
            _buildSelectedValue('City', selectedCityIndex, cities),
            _buildSelectedValue('User', selectedUserIndex, users),
            _buildSelectedValue('Category', selectedCategoryIndex, categories),
            _buildSelectedValue('Size', selectedSizeIndex, sizes),
            _buildSelectedValue('Custom', null, null, selectedCustomItem),
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

class FCPInlineDropdownUsageExamples {
  static const String basicExample = '''
// Basic inline dropdown usage
FCPInlineDropdown(
  title: 'Select Country',
  items: ['USA', 'Canada', 'UK', 'Germany'],
  onItemSelected: (value) {
    print('Selected: \$value');
  },
)
''';

  static const String searchExample = '''
// Inline dropdown with search functionality
FCPInlineDropdown(
  title: 'Select City',
  items: ['New York', 'London', 'Tokyo', 'Paris'],
  onItemSelected: (value) {
    print('Selected: \$value');
  },
  isSearchEnabled: true,
  searchHintText: 'Search cities...',
)
''';

  static const String customStylingExample = '''
// Inline dropdown with comprehensive custom styling
FCPInlineDropdown(
  title: 'Select Option',
  items: ['Option 1', 'Option 2', 'Option 3'],
  onItemSelected: (value) {
    print('Selected: \$value');
  },
  prefixIcon: Icons.location_on,
  enableBorder: true,
  selectedIndex: 1,
  titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
  itemTextStyle: TextStyle(fontSize: 16),
  selectedItemTextStyle: TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  ),
  selectedItemIconColor: Colors.blue,
  backgroundColor: Colors.grey[50],
  maxHeight: 250,
  itemHeight: 52,
  borderRadius: 12,
)
''';

  static const String enhancedCustomBuilderExample = '''
// Inline dropdown with enhanced custom item builder
FCPInlineDropdown(
  title: 'Select User',
  items: ['John Doe', 'Jane Smith', 'Bob Johnson'],
  onItemSelected: (value) {
    print('Selected: \$value');
  },
  customItemBuilder: (item, index, isSelected) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withValues(alpha: 0.1) : null,
        borderRadius: BorderRadius.circular(8),
        border: isSelected ? Border.all(color: Colors.blue, width: 1) : null,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
            radius: 18,
            child: Text(
              item[0].toUpperCase(),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? Colors.blue : null,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'User ID: \${index + 1001}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          if (isSelected)
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.check, color: Colors.white, size: 16),
            ),
        ],
      ),
    );
  },
)
''';

  static const String compactExample = '''
// Compact inline dropdown with custom dimensions
FCPInlineDropdown(
  title: 'Select Size',
  items: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
  onItemSelected: (value) {
    print('Selected: \$value');
  },
  prefixIcon: Icons.straighten,
  enableBorder: true,
  maxHeight: 150,
  itemHeight: 40,
  itemSpacing: 2,
  borderRadius: 6,
)
''';

  static const String material3Example = '''
// Material 3 themed inline dropdown
FCPInlineDropdown(
  title: 'Material 3 Style',
  items: ['Primary', 'Secondary', 'Tertiary'],
  onItemSelected: (value) {
    print('Selected: \$value');
  },
  prefixIcon: Icons.palette,
  enableBorder: true,
  isSearchEnabled: true,
  searchHintText: 'Search styles...',
  titleStyle: TextStyle(
    fontWeight: FontWeight.w500,
    color: Theme.of(context).colorScheme.primary,
  ),
  itemTextStyle: TextStyle(
    fontSize: 16,
    color: Theme.of(context).colorScheme.onSurface,
  ),
  selectedItemTextStyle: TextStyle(
    color: Theme.of(context).colorScheme.primary,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  ),
  selectedItemIconColor: Theme.of(context).colorScheme.primary,
  backgroundColor: Theme.of(context).colorScheme.surface,
  maxHeight: 200,
  itemHeight: 56,
  borderRadius: 16,
)
''';

  static const String extensionExample = '''
// Using the extension method
context.showFCPDropdownOverlay(
  layerLink: layerLink,
  items: ['Item 1', 'Item 2', 'Item 3'],
  onItemSelected: (value) {
    print('Selected: \$value');
  },
  isSearchEnabled: true,
);
''';

  static const String nonIndexedExample = '''
// Non-indexed inline dropdown (returns string value instead of index)
FCPInlineDropdown(
  title: 'Select Option',
  items: ['Option 1', 'Option 2', 'Option 3'],
  onItemSelected: (value) {
    print('Selected: \$value'); // Returns string value
  },
  indexed: false,
)
''';

  static const String disabledExample = '''
// Disabled inline dropdown
FCPInlineDropdown(
  title: 'Disabled Dropdown',
  items: ['Item 1', 'Item 2', 'Item 3'],
  onItemSelected: (value) {},
  disabled: true,
  prefixIcon: Icons.lock,
)
''';

  static const String allPropertiesExample = '''
// Complete inline dropdown with all properties
FCPInlineDropdown(
  title: 'Complete Example',
  items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
  selectedIndex: 0,
  onItemSelected: (value) {
    print('Selected: \$value');
  },
  indexed: true,
  prefixIcon: Icons.star,
  enableBorder: true,
  isSearchEnabled: true,
  searchHintText: 'Search items...',
  titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  itemTextStyle: TextStyle(fontSize: 16),
  selectedItemTextStyle: TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  ),
  selectedItemIconColor: Colors.blue,
  backgroundColor: Colors.grey[50],
  maxHeight: 300,
  itemHeight: 56,
  itemSpacing: 4,
  borderRadius: 16,
  disabled: false,
)
''';
}
