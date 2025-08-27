# FCPMultiSelectDropdown

A professional multi-select dropdown component that displays a bottom sheet with selectable items. This component provides a modern, customizable multi-selection experience with search functionality, select all options, and accessibility features.

## Features

- **Multi-Selection**: Select multiple items with checkboxes
- **Select All/Deselect All**: Convenient bulk selection options
- **Search Functionality**: Built-in search with debouncing for better performance
- **Maximum Selections**: Limit the number of items that can be selected
- **Customizable Styling**: Extensive customization options for colors, text styles, and layout
- **Accessibility**: Full accessibility support with proper semantics
- **Responsive**: Adapts to different screen sizes and orientations
- **Dark Mode Support**: Automatic theme adaptation
- **Custom Item Builder**: Support for custom item layouts
- **Empty State**: Configurable empty state when no items match search
- **Confirm/Cancel Actions**: Optional action buttons for better UX

## Usage

### Basic Usage

```dart
FCPMultiSelectDropdown(
  title: 'Select Categories',
  items: [
    FCPMultiSelectItem(label: 'Technology', value: 'tech'),
    FCPMultiSelectItem(label: 'Sports', value: 'sports'),
    FCPMultiSelectItem(label: 'Music', value: 'music'),
    FCPMultiSelectItem(label: 'Movies', value: 'movies'),
  ],
  onSelectionChanged: (selectedItems) {
    print('Selected: ${selectedItems.map((item) => item.label).toList()}');
  },
)
```

### With Select All and Search

```dart
FCPMultiSelectDropdown(
  title: 'Select Tags',
  items: [
    FCPMultiSelectItem(label: 'Flutter', value: 'flutter'),
    FCPMultiSelectItem(label: 'Dart', value: 'dart'),
    FCPMultiSelectItem(label: 'Mobile', value: 'mobile'),
    FCPMultiSelectItem(label: 'Web', value: 'web'),
    FCPMultiSelectItem(label: 'Desktop', value: 'desktop'),
  ],
  onSelectionChanged: (selectedItems) {
    print('Selected: ${selectedItems.map((item) => item.label).toList()}');
  },
  showSelectAll: true,
  isSearchEnabled: true,
  searchHintText: 'Search tags...',
)
```

### With Maximum Selections

```dart
FCPMultiSelectDropdown(
  title: 'Select Colors (Max 3)',
  items: [
    FCPMultiSelectItem(label: 'Red', value: 'red'),
    FCPMultiSelectItem(label: 'Blue', value: 'blue'),
    FCPMultiSelectItem(label: 'Green', value: 'green'),
    FCPMultiSelectItem(label: 'Yellow', value: 'yellow'),
    FCPMultiSelectItem(label: 'Purple', value: 'purple'),
  ],
  onSelectionChanged: (selectedItems) {
    print('Selected: ${selectedItems.map((item) => item.label).toList()}');
  },
  maxSelections: 3,
  showSelectAll: true,
)
```

### With Custom Styling

```dart
FCPMultiSelectDropdown(
  title: 'Select Options',
  items: [
    FCPMultiSelectItem(label: 'Option 1', value: 'opt1'),
    FCPMultiSelectItem(label: 'Option 2', value: 'opt2'),
    FCPMultiSelectItem(label: 'Option 3', value: 'opt3'),
  ],
  onSelectionChanged: (selectedItems) {
    print('Selected: ${selectedItems.map((item) => item.label).toList()}');
  },
  prefixIcon: Icons.category,
  enableBorder: true,
  titleStyle: TextStyle(fontWeight: FontWeight.bold),
  itemTextStyle: TextStyle(fontSize: 16),
  selectedItemTextStyle: TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.w600,
  ),
  selectedItemIconColor: Colors.blue,
)
```

### Using the Extension Method

```dart
// Show multi-select dropdown directly without creating a widget
context.showFCPMultiSelectDropdown(
  title: 'Select Items',
  items: [
    FCPMultiSelectItem(label: 'Item 1', value: 'item1'),
    FCPMultiSelectItem(label: 'Item 2', value: 'item2'),
    FCPMultiSelectItem(label: 'Item 3', value: 'item3'),
  ],
  onSelectionChanged: (selectedItems) {
    print('Selected: ${selectedItems.map((item) => item.label).toList()}');
  },
  showSelectAll: true,
  isSearchEnabled: true,
);
```

### With Custom Item Builder

```dart
FCPMultiSelectDropdown(
  title: 'Select Users',
  items: [
    FCPMultiSelectItem(label: 'John Doe', value: 'john'),
    FCPMultiSelectItem(label: 'Jane Smith', value: 'jane'),
    FCPMultiSelectItem(label: 'Bob Johnson', value: 'bob'),
  ],
  onSelectionChanged: (selectedItems) {
    print('Selected: ${selectedItems.map((item) => item.label).toList()}');
  },
  customItemBuilder: (item, index, isSelected, onChanged) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(item.label[0]),
      ),
      title: Text(item.label),
      trailing: Checkbox(
        value: isSelected,
        onChanged: onChanged,
      ),
    );
  },
)
```

## Properties

### Required Properties

- `title` (String): The title displayed in the dropdown trigger and bottom sheet header
- `items` (List<FCPMultiSelectItem>): List of items to display in the dropdown
- `onSelectionChanged` (Function(List<FCPMultiSelectItem>)): Callback function when selection changes

### Optional Properties

#### Appearance
- `prefixIcon` (IconData?): Optional prefix icon for the dropdown trigger
- `enableBorder` (bool): Whether to show a border around the dropdown trigger (default: false)
- `borderRadius` (double): Border radius for the bottom sheet (default: 16.0)
- `backgroundColor` (Color?): Background color for the bottom sheet

#### Behavior
- `disabled` (bool): Whether the dropdown is disabled (default: false)
- `maxSelections` (int?): Maximum number of items that can be selected (null for unlimited)
- `showSelectAll` (bool): Whether to show select all/deselect all option (default: false)
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

#### Action Buttons
- `showConfirmButton` (bool): Whether to show confirm/cancel buttons (default: true)
- `confirmText` (String): Text for confirm button (default: 'Confirm')
- `cancelText` (String): Text for cancel button (default: 'Cancel')
- `selectAllText` (String): Text for select all button (default: 'Select All')
- `deselectAllText` (String): Text for deselect all button (default: 'Deselect All')

#### Customization
- `customItemBuilder` (Widget Function(FCPMultiSelectItem item, int index, bool isSelected, Function(bool?) onChanged)?): Custom builder for items

## FCPMultiSelectItem

The `FCPMultiSelectItem` class represents a single item in the multi-select dropdown:

```dart
class FCPMultiSelectItem {
  const FCPMultiSelectItem({
    required this.label,
    this.value,
    this.isSelected = false,
    this.disabled = false,
  });

  final String label;        // Display text
  final String? value;       // Optional value
  final bool isSelected;     // Selection state
  final bool disabled;       // Disabled state
}
```

## Extension Methods

### showFCPMultiSelectDropdown

The package provides an extension method on `BuildContext` to show the multi-select dropdown bottom sheet directly:

```dart
Future<List<FCPMultiSelectItem>?> showFCPMultiSelectDropdown({
  required String title,
  required List<FCPMultiSelectItem> items,
  required Function(List<FCPMultiSelectItem>) onSelectionChanged,
  // ... all other properties from FCPMultiSelectDropdown
})
```

This method returns a `Future<List<FCPMultiSelectItem>?>` that resolves when the bottom sheet is dismissed.

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
