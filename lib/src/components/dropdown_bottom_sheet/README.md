# FCPDropdownBottomSheet

A professional dropdown component that displays a bottom sheet with selectable items. This component provides a modern, customizable dropdown experience with search functionality, custom styling, and accessibility features.

## Features

- **Modern Design**: Clean, professional appearance with Material Design 3 support
- **Search Functionality**: Built-in search with debouncing for better performance
- **Customizable Styling**: Extensive customization options for colors, text styles, and layout
- **Accessibility**: Full accessibility support with proper semantics
- **Responsive**: Adapts to different screen sizes and orientations
- **Dark Mode Support**: Automatic theme adaptation
- **Custom Item Builder**: Support for custom item layouts
- **Empty State**: Configurable empty state when no items match search

## Usage

### Basic Usage

```dart
FCPDropdownBottomSheet(
  title: 'Select Country',
  items: ['USA', 'Canada', 'UK', 'Germany', 'France'],
  onItemSelected: (value) {
    print('Selected: $value');
  },
)
```

### With Search Enabled

```dart
FCPDropdownBottomSheet(
  title: 'Select Country',
  items: ['USA', 'Canada', 'UK', 'Germany', 'France'],
  onItemSelected: (value) {
    print('Selected: $value');
  },
  isSearchEnabled: true,
  searchHintText: 'Search countries...',
)
```

### With Custom Styling

```dart
FCPDropdownBottomSheet(
  title: 'Select Option',
  items: ['Option 1', 'Option 2', 'Option 3'],
  onItemSelected: (value) {
    print('Selected: $value');
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
```

### Using the Extension Method

```dart
// Show dropdown directly without creating a widget
context.showFCPDropdownBottomSheet(
  title: 'Select Item',
  items: ['Item 1', 'Item 2', 'Item 3'],
  onItemSelected: (value) {
    print('Selected: $value');
  },
  isSearchEnabled: true,
);
```

### With Custom Item Builder

```dart
FCPDropdownBottomSheet(
  title: 'Select User',
  items: ['John Doe', 'Jane Smith', 'Bob Johnson'],
  onItemSelected: (value) {
    print('Selected: $value');
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
```

## Properties

### Required Properties

- `title` (String): The title displayed in the dropdown trigger and bottom sheet header
- `items` (List<String>): List of items to display in the dropdown
- `onItemSelected` (Function(dynamic)): Callback function when an item is selected

### Optional Properties

#### Appearance
- `prefixIcon` (IconData?): Optional prefix icon for the dropdown trigger
- `enableBorder` (bool): Whether to show a border around the dropdown trigger (default: false)
- `borderRadius` (double): Border radius for the bottom sheet (default: 16.0)
- `backgroundColor` (Color?): Background color for the bottom sheet

#### Behavior
- `disabled` (bool): Whether the dropdown is disabled (default: false)
- `selectedIndex` (int?): Currently selected item index
- `indexed` (bool): Whether to pass index or value to onItemSelected callback (default: true)
- `isSearchEnabled` (bool): Whether to enable search functionality (default: false)

#### Layout
- `heightFactor` (double): Height factor for the bottom sheet (0.0 to 1.0, default: 0.64)
- `itemHeight` (double): Height of each item in the list (default: 56.0)
- `itemSpacing` (double): Spacing between items (default: 8.0)

#### Styling
- `titleStyle` (TextStyle?): Custom text style for the title
- `itemTextStyle` (TextStyle?): Custom text style for items
- `selectedItemTextStyle` (TextStyle?): Custom text style for selected item
- `selectedItemIconColor` (Color?): Color for the selected item check icon

#### Search
- `searchHintText` (String): Hint text for the search field (default: 'Search')
- `searchDebounceDuration` (Duration): Debounce duration for search input (default: 300ms)
- `onSearchChanged` (Function(String)?): Callback for search changes

#### Empty State
- `emptyStateText` (String): Text to display when no items are found (default: 'No items found')
- `showEmptyState` (bool): Whether to show empty state when no items match search (default: true)

#### Customization
- `customItemBuilder` (Widget Function(String item, int index, bool isSelected)?): Custom builder for items

## Extension Methods

### showFCPDropdownBottomSheet

The package provides an extension method on `BuildContext` to show the dropdown bottom sheet directly:

```dart
Future<T?> showFCPDropdownBottomSheet<T>({
  required String title,
  required List<String> items,
  required Function(dynamic) onItemSelected,
  // ... all other properties from FCPDropdownBottomSheet
})
```

This method returns a `Future<T?>` that resolves when the bottom sheet is dismissed.

## Theming

The component automatically adapts to your app's theme:

- **Light Mode**: Uses light theme colors with subtle shadows and borders
- **Dark Mode**: Uses dark theme colors with appropriate contrast
- **Material 3**: Supports Material 3 color schemes and design tokens

## Accessibility

The component includes full accessibility support:

- Proper semantic labels for screen readers
- Keyboard navigation support
- Focus management
- High contrast mode support
- Screen reader announcements for selection changes

## Performance

- **Debounced Search**: Search input is debounced to prevent excessive filtering
- **Efficient Rendering**: Uses `ListView.builder` for large item lists
- **Memory Management**: Proper disposal of timers and controllers
- **Optimized Rebuilds**: Minimal widget rebuilds during interactions

## Examples

See the example app for comprehensive usage examples and demonstrations of all features.
