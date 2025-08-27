import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class FCPDropdownExamples extends StatefulWidget {
  const FCPDropdownExamples({super.key});

  @override
  State<FCPDropdownExamples> createState() => _FCPDropdownExamplesState();
}

class _FCPDropdownExamplesState extends State<FCPDropdownExamples> {
  int? selectedCountryIndex;
  int? selectedCityIndex;
  int? selectedUserIndex;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dropdown Bottom Sheet Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Basic Dropdown'),
            const SizedBox(height: 8),
            FCPDropdownBottomSheet(
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

            _buildSectionTitle('Dropdown with Search'),
            const SizedBox(height: 8),
            FCPDropdownBottomSheet(
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

            _buildSectionTitle('Dropdown with Icon and Border'),
            const SizedBox(height: 8),
            FCPDropdownBottomSheet(
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

            _buildSectionTitle('Custom Styled Dropdown'),
            const SizedBox(height: 8),
            FCPDropdownBottomSheet(
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
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Custom Item Builder'),
            const SizedBox(height: 8),
            FCPDropdownBottomSheet(
              title: 'Select User with Avatar',
              items: users,
              selectedIndex: selectedUserIndex,
              onItemSelected: (value) {
                setState(() {
                  selectedUserIndex = value as int;
                });
              },
              customItemBuilder: (item, index, isSelected) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 8),
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
                        backgroundColor: Colors.blue[100],
                        child: Text(
                          item[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.blue,
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
            const SizedBox(height: 24),

            _buildSectionTitle('Extension Method Example'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                context.showFCPDropdownBottomSheet(
                  title: 'Select from Extension',
                  items: ['Item A', 'Item B', 'Item C', 'Item D'],
                  onItemSelected: (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Selected: $value'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  isSearchEnabled: true,
                  searchHintText: 'Search items...',
                );
              },
              child: const Text('Show Dropdown via Extension'),
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Selected Values'),
            const SizedBox(height: 16),
            _buildSelectedValue('Country', selectedCountryIndex, countries),
            _buildSelectedValue('City', selectedCityIndex, cities),
            _buildSelectedValue('User', selectedUserIndex, users),
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

class FCPDropdownUsageExamples {
  static const String basicExample = '''
// Basic dropdown usage
FCPDropdownBottomSheet(
  title: 'Select Country',
  items: ['USA', 'Canada', 'UK', 'Germany'],
  onItemSelected: (value) {
    print('Selected: \$value');
  },
)
''';

  static const String searchExample = '''
// Dropdown with search functionality
FCPDropdownBottomSheet(
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
// Dropdown with custom styling
FCPDropdownBottomSheet(
  title: 'Select Option',
  items: ['Option 1', 'Option 2', 'Option 3'],
  onItemSelected: (value) {
    print('Selected: \$value');
  },
  prefixIcon: Icons.location_on,
  enableBorder: true,
  selectedIndex: 1,
  titleStyle: TextStyle(fontWeight: FontWeight.bold),
  itemTextStyle: TextStyle(fontSize: 16),
  selectedItemTextStyle: TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.w600,
  ),
)
''';

  static const String extensionExample = '''
// Using the extension method
context.showFCPDropdownBottomSheet(
  title: 'Select Item',
  items: ['Item 1', 'Item 2', 'Item 3'],
  onItemSelected: (value) {
    print('Selected: \$value');
  },
  isSearchEnabled: true,
);
''';

  static const String customBuilderExample = '''
// Dropdown with custom item builder
FCPDropdownBottomSheet(
  title: 'Select User',
  items: ['John Doe', 'Jane Smith', 'Bob Johnson'],
  onItemSelected: (value) {
    print('Selected: \$value');
  },
  customItemBuilder: (item, index, isSelected) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(item[0]),
      ),
      title: Text(item),
      trailing: isSelected ? Icon(Icons.check, color: Colors.green) : null,
    );
  },
)
''';
}
