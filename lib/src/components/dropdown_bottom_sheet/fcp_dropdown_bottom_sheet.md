# FCPDropdownBottomSheet Component

A professional dropdown component that displays a bottom sheet with selectable items, supporting search functionality and custom styling.

## Features

- **Bottom Sheet Interface**: Modern bottom sheet presentation
- **Search Functionality**: Built-in search with debouncing
- **Custom Styling**: Full control over colors, typography, and spacing
- **Multiple Selection**: Support for single and multiple selection
- **Accessibility**: Proper touch targets and screen reader support
- **Responsive**: Automatic sizing and responsive design
- **Interactive**: Smooth animations and transitions

## Basic Usage

### Simple Dropdown
```dart
FCPDropdownBottomSheet(
  title: 'Select Country',
  items: ['United States', 'Canada', 'United Kingdom', 'Australia'],
  onItemSelected: (selectedItem) {
    print('Selected: $selectedItem');
  },
)
```

### Dropdown with Search
```dart
FCPDropdownBottomSheet(
  title: 'Select City',
  items: cities,
  onItemSelected: (selectedItem) {
    print('Selected: $selectedItem');
  },
  isSearchEnabled: true,
  searchHintText: 'Search cities...',
)
```

### Dropdown with Custom Styling
```dart
FCPDropdownBottomSheet(
  title: 'Select Option',
  items: options,
  onItemSelected: (selectedItem) {
    print('Selected: $selectedItem');
  },
  backgroundColor: Colors.grey[100],
  borderRadius: 20,
  itemHeight: 60,
  itemSpacing: 12,
  titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  itemTextStyle: TextStyle(fontSize: 16),
)
```

## Advanced Usage

### Dropdown with Prefix Icon
```dart
FCPDropdownBottomSheet(
  title: 'Select Category',
  items: categories,
  onItemSelected: (selectedItem) {
    print('Selected: $selectedItem');
  },
  prefixIcon: Icons.category,
  enableBorder: true,
)
```

### Dropdown with Selected Item
```dart
FCPDropdownBottomSheet(
  title: 'Select Language',
  items: languages,
  selectedIndex: 2, // Pre-select the third item
  onItemSelected: (selectedItem) {
    print('Selected: $selectedItem');
  },
  selectedItemTextStyle: TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  ),
  selectedItemIconColor: Colors.blue,
)
```

### Dropdown with Custom Item Builder
```dart
FCPDropdownBottomSheet(
  title: 'Select User',
  items: users,
  onItemSelected: (selectedItem) {
    print('Selected: $selectedItem');
  },
  customItemBuilder: (context, index, item, isSelected) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(userAvatars[index]),
      ),
      title: Text(item),
      subtitle: Text('User ID: ${index + 1}'),
      trailing: isSelected ? Icon(Icons.check, color: Colors.blue) : null,
    );
  },
)
```

### Dropdown with Search Callback
```dart
FCPDropdownBottomSheet(
  title: 'Select Product',
  items: products,
  onItemSelected: (selectedItem) {
    print('Selected: $selectedItem');
  },
  isSearchEnabled: true,
  onSearchChanged: (searchQuery) {
    print('Searching for: $searchQuery');
    // Implement custom search logic
  },
  searchDebounceDuration: Duration(milliseconds: 500),
)
```

### Disabled Dropdown
```dart
FCPDropdownBottomSheet(
  title: 'Select Option',
  items: options,
  onItemSelected: (selectedItem) {
    print('Selected: $selectedItem');
  },
  disabled: true,
)
```

### Custom Height and Spacing
```dart
FCPDropdownBottomSheet(
  title: 'Select Item',
  items: items,
  onItemSelected: (selectedItem) {
    print('Selected: $selectedItem');
  },
  heightFactor: 0.8, // 80% of screen height
  itemHeight: 70,
  itemSpacing: 16,
  borderRadius: 24,
)
```

## Inline Dropdown Components

### FCPInlineDropdown
A compact inline dropdown for forms and settings.

```dart
FCPInlineDropdown(
  label: 'Country',
  items: countries,
  selectedItem: selectedCountry,
  onChanged: (value) {
    setState(() => selectedCountry = value);
  },
  hint: 'Select your country',
  prefixIcon: Icons.public,
)
```

### FCPMultiInlineDropdown
A multi-select inline dropdown.

```dart
FCPMultiInlineDropdown(
  label: 'Skills',
  items: skills,
  selectedItems: selectedSkills,
  onChanged: (values) {
    setState(() => selectedSkills = values);
  },
  hint: 'Select your skills',
  maxSelections: 5,
)
```

### FCPMultiSelectDropdown
A full-featured multi-select dropdown.

```dart
FCPMultiSelectDropdown(
  title: 'Select Features',
  items: features,
  selectedItems: selectedFeatures,
  onChanged: (values) {
    setState(() => selectedFeatures = values);
  },
  maxSelections: 3,
  showSelectAll: true,
  showClearAll: true,
)
```

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class DropdownExample extends StatefulWidget {
  @override
  _DropdownExampleState createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownExample> {
  String? selectedCountry;
  String? selectedCity;
  List<String> selectedSkills = [];
  List<String> selectedFeatures = [];

  final List<String> countries = [
    'United States',
    'Canada',
    'United Kingdom',
    'Australia',
    'Germany',
    'France',
    'Japan',
    'Brazil',
  ];

  final List<String> cities = [
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston',
    'Phoenix',
    'Philadelphia',
    'San Antonio',
    'San Diego',
  ];

  final List<String> skills = [
    'Flutter',
    'Dart',
    'React Native',
    'Swift',
    'Kotlin',
    'JavaScript',
    'Python',
    'Java',
  ];

  final List<String> features = [
    'Push Notifications',
    'Offline Support',
    'Dark Mode',
    'Biometric Auth',
    'Cloud Sync',
    'Analytics',
    'Crash Reporting',
    'A/B Testing',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dropdown Examples')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Basic Dropdown
            FCPDropdownBottomSheet(
              title: 'Select Country',
              items: countries,
              selectedIndex: countries.indexOf(selectedCountry ?? ''),
              onItemSelected: (selectedItem) {
                setState(() => selectedCountry = selectedItem);
              },
            ),
            SizedBox(height: 16),
            
            // Dropdown with Search
            FCPDropdownBottomSheet(
              title: 'Select City',
              items: cities,
              selectedIndex: cities.indexOf(selectedCity ?? ''),
              onItemSelected: (selectedItem) {
                setState(() => selectedCity = selectedItem);
              },
              isSearchEnabled: true,
              searchHintText: 'Search cities...',
              prefixIcon: Icons.location_city,
            ),
            SizedBox(height: 16),
            
            // Inline Dropdown
            FCPInlineDropdown(
              label: 'Country',
              items: countries,
              selectedItem: selectedCountry,
              onChanged: (value) {
                setState(() => selectedCountry = value);
              },
              hint: 'Select your country',
              prefixIcon: Icons.public,
            ),
            SizedBox(height: 16),
            
            // Multi-select Inline Dropdown
            FCPMultiInlineDropdown(
              label: 'Skills',
              items: skills,
              selectedItems: selectedSkills,
              onChanged: (values) {
                setState(() => selectedSkills = values);
              },
              hint: 'Select your skills',
              maxSelections: 5,
            ),
            SizedBox(height: 16),
            
            // Multi-select Dropdown
            FCPMultiSelectDropdown(
              title: 'Select Features',
              items: features,
              selectedItems: selectedFeatures,
              onChanged: (values) {
                setState(() => selectedFeatures = values);
              },
              maxSelections: 3,
              showSelectAll: true,
              showClearAll: true,
            ),
            SizedBox(height: 16),
            
            // Custom Styled Dropdown
            FCPDropdownBottomSheet(
              title: 'Custom Styled',
              items: ['Option 1', 'Option 2', 'Option 3'],
              onItemSelected: (selectedItem) {
                print('Selected: $selectedItem');
              },
              backgroundColor: Colors.blue[50],
              borderRadius: 20,
              itemHeight: 60,
              itemSpacing: 12,
              titleStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              itemTextStyle: TextStyle(fontSize: 16),
              selectedItemTextStyle: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
              selectedItemIconColor: Colors.blue,
            ),
            SizedBox(height: 16),
            
            // Disabled Dropdown
            FCPDropdownBottomSheet(
              title: 'Disabled Dropdown',
              items: ['Option 1', 'Option 2', 'Option 3'],
              onItemSelected: (selectedItem) {
                print('Selected: $selectedItem');
              },
              disabled: true,
            ),
          ],
        ),
      ),
    );
  }
}
```

## API Reference

### FCPDropdownBottomSheet Properties

| Property | Type | Description |
|----------|--------|-------------|
| `title` | `String` | Dropdown title |
| `items` | `List<String>` | List of items |
| `onItemSelected` | `Function(dynamic)` | Selection callback |
| `selectedIndex` | `int?` | Currently selected index |
| `prefixIcon` | `IconData?` | Prefix icon |
| `enableBorder` | `bool` | Show border |
| `disabled` | `bool` | Disabled state |
| `isSearchEnabled` | `bool` | Enable search |
| `indexed` | `bool` | Pass index or value |
| `heightFactor` | `double` | Height factor (0.0-1.0) |
| `borderRadius` | `double` | Border radius |
| `itemHeight` | `double` | Item height |
| `itemSpacing` | `double` | Item spacing |
| `titleStyle` | `TextStyle?` | Title text style |
| `itemTextStyle` | `TextStyle?` | Item text style |
| `selectedItemTextStyle` | `TextStyle?` | Selected item text style |
| `selectedItemIconColor` | `Color?` | Selected item icon color |
| `backgroundColor` | `Color?` | Background color |
| `searchHintText` | `String` | Search hint text |
| `emptyStateText` | `String` | Empty state text |
| `showEmptyState` | `bool` | Show empty state |
| `customItemBuilder` | `Widget Function(BuildContext, int, String, bool)?` | Custom item builder |
| `onSearchChanged` | `Function(String)?` | Search callback |
| `searchDebounceDuration` | `Duration` | Search debounce duration |

### FCPInlineDropdown Properties

| Property | Type | Description |
|----------|--------|-------------|
| `label` | `String` | Field label |
| `items` | `List<String>` | List of items |
| `selectedItem` | `String?` | Selected item |
| `onChanged` | `Function(String?)?` | Change callback |
| `hint` | `String?` | Hint text |
| `prefixIcon` | `IconData?` | Prefix icon |
| `suffixIcon` | `IconData?` | Suffix icon |
| `enabled` | `bool` | Enabled state |
| `required` | `bool` | Required field |
| `errorText` | `String?` | Error text |
| `helperText` | `String?` | Helper text |

### FCPMultiInlineDropdown Properties

| Property | Type | Description |
|----------|--------|-------------|
| `label` | `String` | Field label |
| `items` | `List<String>` | List of items |
| `selectedItems` | `List<String>` | Selected items |
| `onChanged` | `Function(List<String>)?` | Change callback |
| `hint` | `String?` | Hint text |
| `maxSelections` | `int?` | Maximum selections |
| `enabled` | `bool` | Enabled state |
| `required` | `bool` | Required field |
| `errorText` | `String?` | Error text |
| `helperText` | `String?` | Helper text |

### FCPMultiSelectDropdown Properties

| Property | Type | Description |
|----------|--------|-------------|
| `title` | `String` | Dropdown title |
| `items` | `List<String>` | List of items |
| `selectedItems` | `List<String>` | Selected items |
| `onChanged` | `Function(List<String>)?` | Change callback |
| `maxSelections` | `int?` | Maximum selections |
| `showSelectAll` | `bool` | Show select all option |
| `showClearAll` | `bool` | Show clear all option |
| `isSearchEnabled` | `bool` | Enable search |
| `searchHintText` | `String` | Search hint text |
| `heightFactor` | `double` | Height factor |
| `borderRadius` | `double` | Border radius |
| `itemHeight` | `double` | Item height |
| `itemSpacing` | `double` | Item spacing |

## Best Practices

1. **Clear Labels**: Use descriptive titles and labels
2. **Search Functionality**: Enable search for long lists
3. **Selection Limits**: Set appropriate limits for multi-select
4. **Error Handling**: Provide clear error messages
5. **Accessibility**: Ensure proper touch targets and labels
6. **Performance**: Use debouncing for search functionality
7. **User Experience**: Provide clear feedback for selections

## Accessibility

- All dropdowns support proper touch targets
- Screen reader support for options and selections
- Keyboard navigation support
- High contrast mode support
- Proper semantic structure for assistive technologies
