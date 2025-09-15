# Table Theme Solution for Flutter Components Plus

## Problem Statement

When using a Flutter package, the theme from the package takes precedence over the app's theme. This means that if you use the `CHIDataTable` component from the Flutter Components Plus package in your project, the package's hardcoded theme will be applied instead of respecting your app's theme.

## Solution Overview

We've implemented a comprehensive theme configuration system that allows you to:

1. **Respect App Theme (Default)**: The table automatically uses your app's theme by default
2. **Override with Custom Themes**: You can specify custom themes that override the app theme
3. **Hybrid Approach**: Mix app theme with custom styling for specific elements

## Implementation Details

### 1. Theme Configuration Class

The `TableThemeConfig` class provides granular control over table appearance:

```dart
class TableThemeConfig {
  final Color? headerBackgroundColor;
  final Color? rowAlternateColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? iconColor;
  final Color? tableBackgroundColor;  // Overall table background color
  
  final TextStyle? headerTextStyle;
  final TextStyle? rowTextStyle;
  final TextStyle? paginationTextStyle;
  
  final double? headerHeight;
  final double? rowHeight;
  final double? borderWidth;
  final double? borderRadius;
  
  final bool useAppTheme;        // Default: true
  final bool useCustomColors;    // Default: false
}
```

### 2. Predefined Theme Configurations

We provide several ready-to-use theme configurations:

```dart
// Respects your app's theme (default behavior)
TableThemes.defaultTheme

// Custom light theme with predefined colors
TableThemes.lightTheme

// Custom dark theme with predefined colors
TableThemes.darkTheme

// Material 3 enhanced theme
TableThemes.material3Theme
```

### 3. Usage Examples

#### Basic Usage (Respects App Theme)

```dart
CHIDataTable(
  dataList: data,
  columns: columns,
  title: 'My Table',
  page: currentPage,
  totalRecords: totalRecords,
  rowsPerPage: rowsPerPage,
  // No themeConfig specified - automatically respects app theme
)
```

#### Using Predefined Themes

```dart
CHIDataTable(
  dataList: data,
  columns: columns,
  title: 'Custom Light Theme',
  page: currentPage,
  totalRecords: totalRecords,
  rowsPerPage: rowsPerPage,
  themeConfig: TableThemes.lightTheme, // Override with custom theme
)
```

#### Fully Custom Theme

```dart
final customTheme = TableThemeConfig(
  useAppTheme: false,
  useCustomColors: true,
  headerBackgroundColor: const Color(0xFFE3F2FD),
  rowAlternateColor: const Color(0xFFF3E5F5),
  tableBackgroundColor: const Color(0xFFF8F9FA),  // Light gray background
  textColor: const Color(0xFF1565C0),
  iconColor: const Color(0xFF1976D2),
  headerTextStyle: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1565C0),
  ),
  borderRadius: 16.0,
  borderWidth: 2.0,
);

CHIDataTable(
  dataList: data,
  columns: columns,
  title: 'Fully Custom Theme',
  page: currentPage,
  totalRecords: totalRecords,
  rowsPerPage: rowsPerPage,
  themeConfig: customTheme,
)
```

#### Hybrid Approach (App Theme + Custom Styling)

```dart
final hybridTheme = TableThemeConfig(
  useAppTheme: true,           // Use app theme as base
  useCustomColors: false,      // Don't override colors
  headerTextStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    // Will inherit color from app theme
  ),
  borderRadius: 12.0,          // Custom border radius
);

CHIDataTable(
  dataList: data,
  columns: columns,
  title: 'Hybrid Theme',
  page: currentPage,
  totalRecords: totalRecords,
  rowsPerPage: rowsPerPage,
  themeConfig: hybridTheme,
)
```

#### Custom Table Background Only

```dart
final backgroundOnlyTheme = TableThemeConfig(
  useAppTheme: true,           // Keep app theme for most elements
  useCustomColors: true,       // Enable custom colors for specific elements
  tableBackgroundColor: const Color(0xFFF5F5F5),  // Only override background
  // All other elements will use app theme
);

CHIDataTable(
  dataList: data,
  columns: columns,
  title: 'Custom Background Only',
  page: currentPage,
  totalRecords: totalRecords,
  rowsPerPage: rowsPerPage,
  themeConfig: backgroundOnlyTheme,
)
```

## How It Works

### 1. Theme Resolution Priority

The system follows this priority order:

1. **Custom Theme**: If `themeConfig` is provided and `useCustomColors` is true
2. **App Theme**: If `useAppTheme` is true (default)
3. **Fallback**: Hardcoded package colors as last resort

### 2. Automatic Theme Detection

The table automatically detects your app's theme:

```dart
final theme = Theme.of(context);
final isDark = theme.brightness == Brightness.dark;

// Automatically adapts to light/dark mode
final headerColor = isDark 
    ? theme.colorScheme.surfaceVariant.withOpacity(0.3)
    : theme.colorScheme.surfaceVariant.withOpacity(0.1);
```

### 3. Seamless Integration

The theme configuration is passed down to all table components:

- `TableHeader`: Uses theme for title styling and search icon colors
- `CHIDataSource`: Uses theme for row colors and text styling
- `Paginator`: Uses theme for text and icon colors
- Column headers: Use theme for background and text styling
- **Table Background**: Uses theme for overall table background color

## Benefits

### 1. **App Theme Consistency**
- Tables automatically match your app's design language
- Seamless integration with Material 3 design system
- Automatic light/dark mode support

### 2. **Flexibility**
- Override specific elements while keeping app theme for others
- Create completely custom themes when needed
- Mix and match different styling approaches

### 3. **Maintainability**
- No need to modify package source code
- Easy to update themes across your app
- Centralized theme management

### 4. **Performance**
- No runtime theme calculations when using custom themes
- Efficient theme resolution with fallbacks
- Minimal memory overhead

## Migration Guide

### From Old Hardcoded Themes

**Before (Hardcoded Package Theme):**
```dart
// Package theme was always applied, ignoring app theme
CHIDataTable(
  dataList: data,
  columns: columns,
  // ... other properties
)
```

**After (Theme-Aware):**
```dart
// Automatically respects app theme
CHIDataTable(
  dataList: data,
  columns: columns,
  // ... other properties
  // No themeConfig needed - automatically uses app theme
)
```

### Adding Custom Themes

**Step 1: Import the theme configuration**
```dart
import 'package:flutter_components_plus/flutter_components_plus.dart';
```

**Step 2: Choose your approach**
```dart
// Option A: Use predefined theme
themeConfig: TableThemes.lightTheme

// Option B: Create custom theme
themeConfig: TableThemeConfig(
  useAppTheme: false,
  useCustomColors: true,
  headerBackgroundColor: Colors.blue[100],
  // ... other customizations
)

// Option C: Hybrid approach
themeConfig: TableThemeConfig(
  useAppTheme: true,
  headerTextStyle: TextStyle(fontSize: 18),
  borderRadius: 16.0,
)
```

## Best Practices

### 1. **Start with Default Theme**
```dart
// Always start with no themeConfig to respect app theme
CHIDataTable(
  // ... properties
  // No themeConfig = automatic app theme respect
)
```

### 2. **Use Predefined Themes for Consistency**
```dart
// For consistent branding across your app
themeConfig: TableThemes.lightTheme
themeConfig: TableThemes.darkTheme
```

### 3. **Customize Only What You Need**
```dart
// Don't override everything - just what's necessary
final minimalCustomTheme = TableThemeConfig(
  useAppTheme: true,           // Keep app theme
  headerTextStyle: TextStyle(  // Only customize header text
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
);
```

### 4. **Consider Dark Mode**
```dart
// Always test both light and dark themes
final adaptiveTheme = TableThemeConfig(
  useAppTheme: true,           // Automatically adapts to theme changes
  borderRadius: 12.0,          // Custom value that works in both themes
);
```

## Troubleshooting

### Common Issues

**1. Theme Not Applying**
- Check if `themeConfig` is properly passed
- Verify `useAppTheme` and `useCustomColors` settings
- Ensure your app has a proper theme set

**2. Colors Not Changing**
- Make sure `useCustomColors` is true when using custom colors
- Check if custom colors are properly defined
- Verify color opacity and contrast

**3. Text Styles Not Working**
- Ensure text styles are properly defined
- Check if `useAppTheme` conflicts with custom styles
- Verify font weights and sizes

### Debug Mode

Enable debug mode to see theme resolution:

```dart
// Add this to see which theme is being used
print('Current theme: ${Theme.of(context).brightness}');
print('Theme config: ${themeConfig?.useAppTheme}');
```

## Conclusion

This solution provides the best of both worlds:

1. **Automatic App Theme Respect**: Tables automatically match your app's design
2. **Custom Theme Override**: Full control when you need custom styling
3. **Hybrid Flexibility**: Mix app theme with custom elements
4. **Zero Breaking Changes**: Existing code continues to work

The table now seamlessly integrates with your app's theme while giving you the flexibility to customize when needed. Your app's design language will be consistently applied across all tables, creating a cohesive user experience.
