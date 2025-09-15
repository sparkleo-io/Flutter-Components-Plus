# Table Background Color Example

This example demonstrates how to use the new `tableBackgroundColor` property in the `TableThemeConfig`.

## Basic Usage

### 1. Default Behavior (Uses App Theme)

```dart
CHIDataTable(
  dataList: data,
  columns: columns,
  title: 'My Table',
  // No themeConfig specified - automatically uses app theme background
)
```

The table will automatically use your app's `theme.colorScheme.surface` as the background color.

### 2. Custom Background Color Only

```dart
final customBackgroundTheme = TableThemeConfig(
  useAppTheme: true,           // Keep app theme for other elements
  useCustomColors: true,       // Enable custom colors for specific elements
  tableBackgroundColor: const Color(0xFFF5F5F5),  // Light gray background
);

CHIDataTable(
  dataList: data,
  columns: columns,
  title: 'Custom Background',
  themeConfig: customBackgroundTheme,
)
```

### 3. Complete Custom Theme with Background

```dart
final completeCustomTheme = TableThemeConfig(
  useAppTheme: false,
  useCustomColors: true,
  tableBackgroundColor: const Color(0xFFE8F5E8),  // Light green background
  headerBackgroundColor: const Color(0xFF4CAF50), // Green header
  rowAlternateColor: const Color(0xFFF1F8E9),    // Very light green
  textColor: const Color(0xFF2E7D32),            // Dark green text
  iconColor: const Color(0xFF388E3C),            // Medium green icons
);

CHIDataTable(
  dataList: data,
  columns: columns,
  title: 'Green Theme Table',
  themeConfig: completeCustomTheme,
)
```

### 4. Dark Theme with Custom Background

```dart
final darkCustomTheme = TableThemeConfig(
  useAppTheme: false,
  useCustomColors: true,
  tableBackgroundColor: const Color(0xFF1A1A1A),  // Dark background
  headerBackgroundColor: const Color(0xFF333333), // Darker header
  rowAlternateColor: const Color(0xFF2A2A2A),    // Slightly lighter rows
  textColor: const Color(0xFFE0E0E0),            // Light text
  iconColor: const Color(0xFFBDBDBD),            // Medium icons
);

CHIDataTable(
  dataList: data,
  columns: columns,
  title: 'Dark Custom Theme',
  themeConfig: darkCustomTheme,
)
```

### 5. Gradient-Inspired Background

```dart
final gradientTheme = TableThemeConfig(
  useAppTheme: false,
  useCustomColors: true,
  tableBackgroundColor: const Color(0xFFF0F8FF),  // Alice blue background
  headerBackgroundColor: const Color(0xFFE6F3FF), // Lighter blue header
  rowAlternateColor: const Color(0xFFF8FBFF),    // Very light blue rows
  textColor: const Color(0xFF1E3A8A),            // Dark blue text
  iconColor: const Color(0xFF3B82F6),            // Blue icons
);

CHIDataTable(
  dataList: data,
  columns: columns,
  title: 'Blue Gradient Theme',
  themeConfig: gradientTheme,
)
```

## How It Works

The `tableBackgroundColor` property:

1. **Overrides the default**: When `useCustomColors` is true and `tableBackgroundColor` is set
2. **Falls back to app theme**: When `useAppTheme` is true and no custom background is set
3. **Uses fallback color**: When neither custom nor app theme is available (defaults to white)

## Best Practices

### 1. **Consider Contrast**
```dart
// Good: High contrast between background and text
final goodTheme = TableThemeConfig(
  tableBackgroundColor: const Color(0xFFF5F5F5),  // Light background
  textColor: const Color(0xFF212121),             // Dark text
);

// Avoid: Low contrast
final badTheme = TableThemeConfig(
  tableBackgroundColor: const Color(0xFFE0E0E0),  // Light background
  textColor: const Color(0xFF9E9E9E),             // Light text (low contrast)
);
```

### 2. **Match Your Brand**
```dart
// Use your app's brand colors
final brandTheme = TableThemeConfig(
  tableBackgroundColor: YourAppColors.background,
  headerBackgroundColor: YourAppColors.primary,
  textColor: YourAppColors.onBackground,
);
```

### 3. **Test Both Themes**
```dart
// Always test in both light and dark modes
final adaptiveTheme = TableThemeConfig(
  useAppTheme: true,           // Automatically adapts to theme changes
  tableBackgroundColor: isDarkMode 
      ? const Color(0xFF1A1A1A)  // Dark background
      : const Color(0xFFF5F5F5), // Light background
);
```

## Complete Example

Here's a complete working example:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class TableBackgroundExample extends StatefulWidget {
  const TableBackgroundExample({super.key});

  @override
  State<TableBackgroundExample> createState() => _TableBackgroundExampleState();
}

class _TableBackgroundExampleState extends State<TableBackgroundExample> {
  int _currentPage = 1;
  int _rowsPerPage = 10;

  // Sample data
  final List<List<Map<String, dynamic>>> _data = [
    [
      {'columnName': 'id', 'value': 1},
      {'columnName': 'name', 'value': 'John Doe'},
      {'columnName': 'email', 'value': 'john@example.com'},
    ],
    [
      {'columnName': 'id', 'value': 2},
      {'columnName': 'name', 'value': 'Jane Smith'},
      {'columnName': 'email', 'value': 'jane@example.com'},
    ],
  ];

  final List<Map<String, dynamic>> _columns = [
    {'columnName': 'ID', 'key': 'id'},
    {'columnName': 'Name', 'key': 'name'},
    {'columnName': 'Email', 'key': 'email'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Table Background Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Table with custom background
            Expanded(
              child: CHIDataTable(
                dataList: _data,
                columns: _columns,
                title: 'Custom Background Table',
                page: _currentPage,
                totalRecords: _data.length,
                rowsPerPage: _rowsPerPage,
                themeConfig: TableThemeConfig(
                  useAppTheme: false,
                  useCustomColors: true,
                  tableBackgroundColor: const Color(0xFFE8F5E8),  // Light green
                  headerBackgroundColor: const Color(0xFF4CAF50), // Green header
                  rowAlternateColor: const Color(0xFFF1F8E9),    // Very light green
                  textColor: const Color(0xFF2E7D32),            // Dark green text
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

This example shows how easy it is to customize the table background while maintaining all the other theme-aware functionality!
