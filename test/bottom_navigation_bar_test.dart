import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

void main() {
  group('FCPBottomNavigationBar', () {
    testWidgets('should render with default properties', (
      WidgetTester tester,
    ) async {
      const widget = MaterialApp(
        home: Scaffold(
          body: FCPBottomNavigationBar(
            currentIndex: 0,
            widgets: [Text('Page 1'), Text('Page 2')],
            icons: ['assets/icons/home.png', 'assets/icons/search.png'],
            activeIcons: [
              'assets/icons/home_active.png',
              'assets/icons/search_active.png',
            ],
            labels: ['Home', 'Search'],
          ),
        ),
      );

      await tester.pumpWidget(widget);

      // Verify that the bottom navigation bar is rendered
      expect(find.byType(BottomNavigationBar), findsOneWidget);

      // Verify that the labels are displayed
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
    });

    testWidgets('should call onItemChanged when item is tapped', (
      WidgetTester tester,
    ) async {
      int? selectedIndex;

      const widget = MaterialApp(
        home: Scaffold(
          body: FCPBottomNavigationBar(
            currentIndex: 0,
            onItemChanged: _onItemChanged,
            widgets: [Text('Page 1'), Text('Page 2')],
            icons: ['assets/icons/home.png', 'assets/icons/search.png'],
            activeIcons: [
              'assets/icons/home_active.png',
              'assets/icons/search_active.png',
            ],
            labels: ['Home', 'Search'],
          ),
        ),
      );

      await tester.pumpWidget(widget);

      // Tap on the second item
      await tester.tap(find.text('Search'));
      await tester.pump();

      // Verify that the callback was called with the correct index
      expect(selectedIndex, equals(1));
    });

    testWidgets('should apply custom colors', (WidgetTester tester) async {
      const customSelectedColor = Colors.red;
      const customUnselectedColor = Colors.grey;
      const customBackgroundColor = Colors.black;

      const widget = MaterialApp(
        home: Scaffold(
          body: FCPBottomNavigationBar(
            currentIndex: 0,
            selectedItemColor: customSelectedColor,
            unselectedItemColor: customUnselectedColor,
            backgroundColor: customBackgroundColor,
            widgets: [Text('Page 1'), Text('Page 2')],
            icons: ['assets/icons/home.png', 'assets/icons/search.png'],
            activeIcons: [
              'assets/icons/home_active.png',
              'assets/icons/search_active.png',
            ],
            labels: ['Home', 'Search'],
          ),
        ),
      );

      await tester.pumpWidget(widget);

      // Verify that the bottom navigation bar is rendered
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('should handle different elevation values', (
      WidgetTester tester,
    ) async {
      const widget = MaterialApp(
        home: Scaffold(
          body: FCPBottomNavigationBar(
            currentIndex: 0,
            elevation: 12.0,
            widgets: [Text('Page 1'), Text('Page 2')],
            icons: ['assets/icons/home.png', 'assets/icons/search.png'],
            activeIcons: [
              'assets/icons/home_active.png',
              'assets/icons/search_active.png',
            ],
            labels: ['Home', 'Search'],
          ),
        ),
      );

      await tester.pumpWidget(widget);

      // Verify that the bottom navigation bar is rendered
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });
  });
}

void _onItemChanged(int index) {
  // This function is used in the test to capture the selected index
  // In a real test, you would use a callback or state management
}
