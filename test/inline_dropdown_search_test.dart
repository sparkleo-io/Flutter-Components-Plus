import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

void main() {
  group('FCPInlineDropdown Search Tests', () {
    testWidgets('should filter items when searching', (
      WidgetTester tester,
    ) async {
      final items = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FCPInlineDropdown(
              title: 'Select Fruit',
              items: items,
              onItemSelected: (value) {},
              isSearchEnabled: true,
              searchHintText: 'Search fruits...',
            ),
          ),
        ),
      );

      // Find and tap the dropdown to open it
      final dropdown = find.byType(FCPInlineDropdown);
      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      // Verify search field is visible
      expect(find.byType(FCPInputField), findsOneWidget);
      expect(find.text('Search fruits...'), findsOneWidget);

      // Debug: Print initial state
      print('Initial state - All items should be visible:');
      for (final item in items) {
        final finder = find.text(item);
        if (finder.evaluate().isNotEmpty) {
          print('  Found: $item');
        } else {
          print('  Not found: $item');
        }
      }

      // Enter search text
      final searchField = find.byType(FCPInputField);
      await tester.enterText(searchField, 'a');
      await tester.pumpAndSettle();

      // Debug: Print search field state
      print(
        'Search field text: "${tester.widget<FCPInputField>(searchField).controller?.text}"',
      );

      // Wait for debounce
      await tester.pump(const Duration(milliseconds: 350));

      // Debug: Print state after search
      print('After searching for "a":');
      for (final item in items) {
        final finder = find.text(item);
        if (finder.evaluate().isNotEmpty) {
          print('  Found: $item');
        } else {
          print('  Not found: $item');
        }
      }

      // Verify filtered items are shown
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Banana'), findsOneWidget);
      expect(find.text('Date'), findsOneWidget);
      expect(find.text('Cherry'), findsNothing); // Should be filtered out
      expect(find.text('Elderberry'), findsNothing); // Should be filtered out
    });

    testWidgets('should allow selection of custom item builder items', (
      WidgetTester tester,
    ) async {
      final items = ['Option 1', 'Option 2', 'Option 3'];
      int? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FCPInlineDropdown(
              title: 'Select Option',
              items: items,
              onItemSelected: (value) {
                selectedValue = value as int;
              },
              isSearchEnabled: true,
              searchHintText: 'Search options...',
              customItemBuilder: (item, index, isSelected) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue.withOpacity(0.1) : null,
                    borderRadius: BorderRadius.circular(8),
                    border: isSelected
                        ? Border.all(color: Colors.blue, width: 2)
                        : null,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: isSelected ? Colors.blue : Colors.grey,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          item,
                          style: TextStyle(
                            fontWeight: isSelected
                                ? FontWeight.bold
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
        ),
      );

      // Open dropdown
      await tester.tap(find.byType(FCPInlineDropdown));
      await tester.pumpAndSettle();

      // Verify custom items are visible
      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
      expect(find.text('Option 3'), findsOneWidget);

      // Tap on a custom item
      await tester.tap(find.text('Option 2'));
      await tester.pumpAndSettle();

      // Verify the selection callback was called
      expect(selectedValue, equals(1)); // Index 1 for "Option 2"
    });
  });
}
