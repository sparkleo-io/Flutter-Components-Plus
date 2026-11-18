import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class InlineDropdownTest extends StatefulWidget {
  const InlineDropdownTest({super.key});

  @override
  State<InlineDropdownTest> createState() => _InlineDropdownTestState();
}

class _InlineDropdownTestState extends State<InlineDropdownTest> {
  int? selectedIndex;

  final List<String> items = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Test 1: Basic dropdown
            FCPInlineDropdown(
              title: 'Select Option',
              items: items,
              selectedIndex: selectedIndex,
              onItemSelected: (value) {
                setState(() {
                  selectedIndex = value as int;
                });
              },
            ),

            const SizedBox(height: 20),

            // Test 2: With search
            FCPInlineDropdown(
              title: 'Select with Search',
              items: items,
              selectedIndex: selectedIndex,
              onItemSelected: (value) {
                setState(() {
                  selectedIndex = value as int;
                });
              },
              isSearchEnabled: true,
              searchHintText: 'Search...',
            ),

            const SizedBox(height: 20),

            // Test 3: With icon and border
            FCPInlineDropdown(
              title: 'Select with Icon',
              items: items,
              selectedIndex: selectedIndex,
              onItemSelected: (value) {
                setState(() {
                  selectedIndex = value as int;
                });
              },
              prefixIcon: Icons.arrow_drop_down,
              enableBorder: true,
            ),

            const SizedBox(height: 20),

            // Display selected value
            Text(
              'Selected: ${selectedIndex != null ? items[selectedIndex!] : 'None'}',
            ),
          ],
        ),
      ),
    );
  }
}
