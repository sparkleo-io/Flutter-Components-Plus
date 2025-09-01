import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class SimpleInlineDropdownTest extends StatefulWidget {
  const SimpleInlineDropdownTest({super.key});

  @override
  State<SimpleInlineDropdownTest> createState() =>
      _SimpleInlineDropdownTestState();
}

class _SimpleInlineDropdownTestState extends State<SimpleInlineDropdownTest> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Inline Dropdown Test')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Simple test with minimal configuration
              FCPInlineDropdown(
                title: 'Select an option',
                items: const ['Apple', 'Banana', 'Orange', 'Grape'],
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

              const SizedBox(height: 40),

              // Show selected value
              Text(
                'Selected: ${selectedIndex != null ? ['Apple', 'Banana', 'Orange', 'Grape'][selectedIndex!] : 'None'}',
                style: const TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 40),

              // Test button to verify state updates work
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = null;
                  });
                },
                child: const Text('Reset Selection'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
