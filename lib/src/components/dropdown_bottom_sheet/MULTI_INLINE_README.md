# FCPMultiInlineDropdown

A professional multi-select inline dropdown component that displays a dropdown menu below the button, allowing users to select multiple options.

## Features

- **Multi-Selection**: Choose multiple items from the dropdown
- **Inline Display**: Dropdown appears below the button (not as a bottom sheet)
- **Smart Positioning**: Automatically positions above or below based on available space
- **Search Functionality**: Optional search to filter items
- **Select All/Deselect All**: Bulk selection options
- **Maximum Selections**: Limit the number of items that can be selected
- **Custom Item Builder**: Customize the appearance of individual items
- **Responsive Design**: Adapts to different screen sizes
- **Accessibility**: Proper keyboard navigation and screen reader support

## Usage

### Basic Multi-Select Inline Dropdown

```dart
FCPMultiInlineDropdown(
  title: 'Select Fruits',
  items: [
    const FCPMultiInlineItem(label: 'Apple', value: 'apple'),
    const FCPMultiInlineItem(label: 'Banana', value: 'banana'),
    const FCPMultiInlineItem(label: 'Cherry', value: 'cherry'),
  ],
  onSelectionChanged: (selectedItems) {
    // Handle selection changes
    print('Selected: ${selectedItems.where((item) => item.isSelected).map((item) => item.label).join(', ')}');
  },
)
```

### With Search and Select All

```dart
FCPMultiInlineDropdown(
  title: 'Select Frameworks',
  items: frameworkItems,
  onSelectionChanged: (selectedItems) {
    // Handle selection changes
  },
  isSearchEnabled: true,
  showSelectAll: true,
  enableBorder: true,
)
```

### With Maximum Selections

```dart
FCPMultiInlineDropdown(
  title: 'Select Colors (Max 3)',
  items: colorItems,
  onSelectionChanged: (selectedItems) {
    // Handle selection changes
  },
  maxSelections: 3,
  showSelectAll: true,
)
```

### Custom Item Builder

```dart
FCPMultiInlineDropdown(
  title: 'Select Departments',
  items: departmentItems,
  onSelectionChanged: (selectedItems) {
    // Handle selection changes
  },
  customItemBuilder: (item, index, isSelected, onChanged) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isSelected 
            ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2)
            : null,
        border: isSelected
            ? Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              )
            : null,
      ),
      child: Row(
        children: [
          Checkbox(
            value: isSelected,
            onChanged: onChanged,
            activeColor: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item.label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected 
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
            ),
          ),
          if (isSelected)
            Icon(
              Icons.star,
              color: Theme.of(context).colorScheme.primary,
              size: 16,
            ),
        ],
      ),
    );
  },
)
```

## Properties

### Required Properties

- `title`: The title displayed in the dropdown trigger
- `items`: List of `FCPMultiInlineItem` objects to display
- `onSelectionChanged`: Callback function when selection changes

### Optional Properties

- `selectedItems`: Currently selected items (default: empty list)
- `prefixIcon`: Optional prefix icon for the dropdown trigger
- `enableBorder`: Whether to show a border around the dropdown trigger (default: false)
- `disabled`: Whether the dropdown is disabled (default: false)
- `isSearchEnabled`: Whether to enable search functionality (default: false)
- `maxHeight`: Maximum height for the dropdown menu (default: 300.0)
- `borderRadius`: Border radius for the dropdown menu (default: 8.0)
- `itemHeight`: Height of each item in the list (default: 48.0)
- `itemSpacing`: Spacing between items (default: 4.0)
- `titleStyle`: Custom text style for the title
- `itemTextStyle`: Custom text style for items
- `selectedItemTextStyle`: Custom text style for selected items
- `selectedItemIconColor`: Color for the selected item check icon
- `backgroundColor`: Background color for the dropdown menu
- `searchHintText`: Hint text for the search field (default: 'Search')
- `emptyStateText`: Text to display when no items are found (default: 'No items found')
- `showEmptyState`: Whether to show empty state when no items match search (default: true)
- `maxSelections`: Maximum number of items that can be selected (null for unlimited)
- `showSelectAll`: Whether to show select all/deselect all option (default: false)
- `selectAllText`: Text for select all button (default: 'Select All')
- `deselectAllText`: Text for deselect all button (default: 'Deselect All')
- `customItemBuilder`: Custom builder for items (overrides default item appearance)
- `onSearchChanged`: Callback for search changes
- `searchDebounceDuration`: Debounce duration for search input (default: 300ms)

## FCPMultiInlineItem

The data model for multi-select items:

```dart
class FCPMultiInlineItem {
  const FCPMultiInlineItem({
    required this.label,
    this.value,
    this.isSelected = false,
    this.disabled = false,
  });

  final String label;        // Display label for the item
  final String? value;       // Optional value associated with the item
  final bool isSelected;     // Whether the item is currently selected
  final bool disabled;       // Whether the item is disabled
}
```

## Smart Positioning

The component automatically calculates the best position for the dropdown:
- If there's enough space below the button, it positions below
- If there's not enough space below but enough above, it positions above
- Falls back to below positioning if calculations fail

## Search Functionality

When `isSearchEnabled` is true:
- A search field appears at the top of the dropdown
- Items are filtered in real-time as you type
- Search is debounced to improve performance
- Original item order is preserved when search is cleared

## Select All/Deselect All

When `showSelectAll` is true:
- A checkbox appears at the top of the dropdown
- Shows the count of selected items
- Supports tristate (all, some, none selected)
- Only affects non-disabled items

## Maximum Selections

When `maxSelections` is set:
- Users cannot select more than the specified number of items
- A snackbar message is shown when the limit is reached
- The limit applies to both individual selections and select all

## Custom Item Builder

Use `customItemBuilder` to completely customize the appearance of items:
- Overrides the default item appearance
- Provides access to the item, index, selection state, and change callback
- Allows for complex layouts and styling

## Accessibility

The component includes:
- Proper ARIA labels and roles
- Keyboard navigation support
- Screen reader compatibility
- Focus management
- High contrast support

## Examples

See `flutter_component_plus_example/lib/multi_inline_dropdown_examples.dart` for complete usage examples including:
- Basic multi-select
- Searchable dropdown
- Custom item appearance
- Limited selections
- Disabled state
- Real-time selection display
