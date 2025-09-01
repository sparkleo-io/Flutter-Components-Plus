# Inline Dropdown Components

This directory contains inline dropdown components that open directly below the dropdown button instead of as a bottom sheet. These components provide a more compact and immediate user experience.

## Components

### 1. FCPInlineDropdown (Single Select)

A professional inline dropdown component for single item selection that opens right below the dropdown button.

**File:** `inline_dropdown.dart`

#### Features:
- Opens directly below the button (not as bottom sheet)
- Smooth animations with scale and opacity effects
- Search functionality with debouncing
- Custom styling support
- Prefix icons
- Border options
- Disabled state support
- Empty state handling

#### Basic Usage:

```dart
FCPInlineDropdown(
  title: 'Select Country',
  items: ['USA', 'Canada', 'UK', 'Germany'],
  selectedIndex: selectedIndex,
  onItemSelected: (value) {
    setState(() {
      selectedIndex = value as int;
    });
  },
)
```

#### Advanced Usage:

```dart
FCPInlineDropdown(
  title: 'Select Country',
  items: countries,
  selectedIndex: selectedIndex,
  prefixIcon: Icons.location_on,
  enableBorder: true,
  isSearchEnabled: true,
  searchHintText: 'Search countries...',
  backgroundColor: Colors.blue.shade50,
  selectedItemIconColor: Colors.blue,
  titleStyle: TextStyle(fontWeight: FontWeight.w600),
  onItemSelected: (value) {
    setState(() {
      selectedIndex = value as int;
    });
  },
)
```

### 2. FCPInlineMultiSelectDropdown (Multi-Select)

A professional inline multi-select dropdown component that opens right below the dropdown button.

**File:** `multi_inline_dropdown.dart`

#### Features:
- Multiple item selection
- Select all/deselect all functionality
- Maximum selection limits
- Search functionality with debouncing
- Custom styling support
- Prefix icons
- Border options
- Disabled state support
- Empty state handling
- Selection count badge

#### Basic Usage:

```dart
FCPInlineMultiSelectDropdown(
  title: 'Select Skills',
  items: [
    FCPInlineDropdownItem(label: 'Flutter', value: 'flutter'),
    FCPInlineDropdownItem(label: 'Dart', value: 'dart'),
    FCPInlineDropdownItem(label: 'React Native', value: 'react_native'),
  ],
  onSelectionChanged: (selectedItems) {
    setState(() {
      selectedSkills = selectedItems;
    });
  },
)
```

#### Advanced Usage:

```dart
FCPInlineMultiSelectDropdown(
  title: 'Select Skills',
  items: skills,
  showSelectAll: true,
  maxSelections: 3,
  isSearchEnabled: true,
  prefixIcon: Icons.code,
  enableBorder: true,
  backgroundColor: Colors.blue.shade50,
  selectedItemIconColor: Colors.blue,
  titleStyle: TextStyle(fontWeight: FontWeight.w600),
  onSelectionChanged: (selectedItems) {
    setState(() {
      selectedSkills = selectedItems;
    });
  },
)
```

## Data Models

### FCPInlineDropdownItem

Used for multi-select dropdowns to represent items with additional properties.

```dart
class FCPInlineDropdownItem {
  const FCPInlineDropdownItem({
    required this.label,
    this.value,
    this.isSelected = false,
    this.disabled = false,
  });

  final String label;        // Display text
  final String? value;       // Associated value
  final bool isSelected;     // Initial selection state
  final bool disabled;       // Whether item is disabled
}
```

## Key Differences from Bottom Sheet Dropdowns

1. **Opening Behavior**: Opens directly below the button instead of as a modal bottom sheet
2. **Positioning**: Uses `CompositedTransformFollower` for precise positioning
3. **Animation**: Scale and opacity animations from the top center
4. **Size**: Constrained height (max 300px) with scrolling for long lists
5. **Interaction**: Closes when clicking outside or selecting an item
6. **Performance**: More lightweight than bottom sheet implementations

## Common Properties

### Single Select (FCPInlineDropdown)

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `title` | `String` | Required | Display text when no item is selected |
| `items` | `List<String>` | Required | List of selectable items |
| `onItemSelected` | `Function(dynamic)` | Required | Callback when item is selected |
| `selectedIndex` | `int?` | `null` | Currently selected item index |
| `prefixIcon` | `IconData?` | `null` | Icon displayed before the title |
| `enableBorder` | `bool` | `false` | Whether to show a border around the trigger |
| `disabled` | `bool` | `false` | Whether the dropdown is disabled |
| `isSearchEnabled` | `bool` | `false` | Whether to enable search functionality |
| `indexed` | `bool` | `true` | Whether to pass index or value to callback |
| `borderRadius` | `double` | `16.0` | Border radius for the dropdown |
| `itemHeight` | `double` | `56.0` | Height of each item |
| `itemSpacing` | `double` | `8.0` | Spacing between items |
| `titleStyle` | `TextStyle?` | `null` | Custom style for the title |
| `itemTextStyle` | `TextStyle?` | `null` | Custom style for items |
| `selectedItemTextStyle` | `TextStyle?` | `null` | Custom style for selected item |
| `selectedItemIconColor` | `Color?` | `null` | Color for the selected item check icon |
| `backgroundColor` | `Color?` | `null` | Background color for the dropdown |
| `searchHintText` | `String` | `'Search'` | Hint text for search field |
| `emptyStateText` | `String` | `'No items found'` | Text when no items match search |
| `showEmptyState` | `bool` | `true` | Whether to show empty state |
| `customItemBuilder` | `Widget Function(String, int, bool)?` | `null` | Custom item builder |
| `onSearchChanged` | `Function(String)?` | `null` | Search change callback |
| `searchDebounceDuration` | `Duration` | `300ms` | Search debounce duration |

### Multi-Select (FCPInlineMultiSelectDropdown)

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `title` | `String` | Required | Display text when no items are selected |
| `items` | `List<FCPInlineDropdownItem>` | Required | List of selectable items |
| `onSelectionChanged` | `Function(List<FCPInlineDropdownItem>)` | Required | Callback when selection changes |
| `disabled` | `bool` | `false` | Whether the dropdown is disabled |
| `prefixIcon` | `IconData?` | `null` | Icon displayed before the title |
| `enableBorder` | `bool` | `false` | Whether to show a border around the trigger |
| `borderRadius` | `double` | `16.0` | Border radius for the dropdown |
| `itemHeight` | `double` | `56.0` | Height of each item |
| `itemSpacing` | `double` | `8.0` | Spacing between items |
| `titleStyle` | `TextStyle?` | `null` | Custom style for the title |
| `itemTextStyle` | `TextStyle?` | `null` | Custom style for items |
| `selectedItemTextStyle` | `TextStyle?` | `null` | Custom style for selected items |
| `selectedItemIconColor` | `Color?` | `null` | Color for the selected item check icon |
| `backgroundColor` | `Color?` | `null` | Background color for the dropdown |
| `searchHintText` | `String` | `'Search'` | Hint text for search field |
| `emptyStateText` | `String` | `'No items found'` | Text when no items match search |
| `showEmptyState` | `bool` | `true` | Whether to show empty state |
| `isSearchEnabled` | `bool` | `false` | Whether to enable search functionality |
| `maxSelections` | `int?` | `null` | Maximum number of selections allowed |
| `showSelectAll` | `bool` | `false` | Whether to show select all/deselect all options |
| `selectAllText` | `String` | `'Select All'` | Text for select all button |
| `deselectAllText` | `String` | `'Deselect All'` | Text for deselect all button |
| `onSearchChanged` | `Function(String)?` | `null` | Search change callback |
| `searchDebounceDuration` | `Duration` | `300ms` | Search debounce duration |
| `customItemBuilder` | `Widget Function(FCPInlineDropdownItem, int, bool)?` | `null` | Custom item builder |

## Examples

### Basic Single Select

```dart
FCPInlineDropdown(
  title: 'Select Country',
  items: ['USA', 'Canada', 'UK', 'Germany'],
  selectedIndex: selectedIndex,
  onItemSelected: (value) {
    setState(() {
      selectedIndex = value as int;
    });
  },
)
```

### Single Select with Search

```dart
FCPInlineDropdown(
  title: 'Select City',
  items: cities,
  selectedIndex: selectedCityIndex,
  isSearchEnabled: true,
  prefixIcon: Icons.location_city,
  onItemSelected: (value) {
    setState(() {
      selectedCityIndex = value as int;
    });
  },
)
```

### Basic Multi-Select

```dart
FCPInlineMultiSelectDropdown(
  title: 'Select Skills',
  items: [
    FCPInlineDropdownItem(label: 'Flutter', value: 'flutter'),
    FCPInlineDropdownItem(label: 'Dart', value: 'dart'),
    FCPInlineDropdownItem(label: 'React Native', value: 'react_native'),
  ],
  onSelectionChanged: (selectedItems) {
    setState(() {
      selectedSkills = selectedItems;
    });
  },
)
```

### Multi-Select with Select All and Max Selections

```dart
FCPInlineMultiSelectDropdown(
  title: 'Select Skills (Max 3)',
  items: skills,
  maxSelections: 3,
  showSelectAll: true,
  isSearchEnabled: true,
  prefixIcon: Icons.code,
  enableBorder: true,
  onSelectionChanged: (selectedItems) {
    setState(() {
      selectedSkills = selectedItems;
    });
  },
)
```

## Styling

Both components support extensive customization through various style properties:

- **Colors**: Background, text, icon, and border colors
- **Typography**: Custom text styles for titles, items, and selected items
- **Layout**: Item height, spacing, border radius
- **Icons**: Prefix icons and selection indicators
- **Borders**: Optional borders with customizable colors

## Best Practices

1. **Use appropriate titles**: Make titles descriptive and clear
2. **Limit item count**: For better performance, keep lists under 100 items
3. **Enable search for long lists**: Use `isSearchEnabled: true` for lists with many items
4. **Set max selections**: Use `maxSelections` to prevent users from selecting too many items
5. **Provide meaningful values**: Use the `value` property in `FCPInlineDropdownItem` for data processing
6. **Handle empty states**: Customize empty state text for better UX
7. **Use consistent styling**: Maintain visual consistency across your app

## Accessibility

Both components include:
- Proper semantic labels
- Keyboard navigation support
- Screen reader compatibility
- Focus management
- Disabled state handling

## Performance Considerations

- Components use efficient list rendering with `ListView.separated`
- Search includes debouncing to prevent excessive filtering
- Animations are optimized with `AnimationController`
- Overlay management ensures proper cleanup
