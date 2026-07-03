# Table Examples

This file contains comprehensive examples of how to use the `CHIDataTable` component from the Flutter Components Plus package with GetX architecture and advanced theme support.

## Features Demonstrated

### 1. Basic Data Table
- Simple table with pagination
- Search functionality
- Sorting capabilities
- Loading states

### 2. Advanced Data Table with Actions
- Custom actions (Add, Refresh buttons)
- Custom suffix widgets
- Enhanced functionality with action buttons
- Professional appearance

### 3. Themed Data Table
- **Dynamic Theme Switching**: Toggle between different table themes
- **Predefined Themes**: Default, Light, Dark, and Material 3 themes
- **Custom Theme Configuration**: Using `TableThemeConfig` and `TableThemes`
- **App Theme Integration**: Automatic theme adaptation
- **Real-time Theme Updates**: Live theme switching with visual feedback

### 4. Selectable Data Table
- Row selection functionality
- Single selection mode
- Selection callbacks
- Visual feedback for selected rows

### 5. Compact Data Table
- Optimized for space efficiency
- Custom row and header heights
- Custom column widths
- Compact layout for dense data

## Architecture

### GetX Controller Pattern
The table examples now use a dedicated `TableExamplesController` that provides:

- **State Management**: Observable variables for all table states
- **Data Processing**: Search, sorting, and filtering logic
- **Theme Management**: Dynamic theme switching and configuration
- **Event Handling**: Centralized callback management
- **Reactive Updates**: Automatic UI updates using GetX observables

### Theme System
The package provides comprehensive theme support through:

```dart
// Predefined themes
TableThemes.defaultTheme    // Respects app theme
TableThemes.lightTheme      // Custom light theme
TableThemes.darkTheme       // Custom dark theme
TableThemes.material3Theme  // Material 3 enhanced theme

// Custom theme configuration
TableThemeConfig(
  headerBackgroundColor: Colors.blue,
  rowAlternateColor: Colors.grey.shade50,
  borderColor: Colors.grey.shade300,
  useAppTheme: true,
  useCustomColors: false,
)
```

## Usage Examples

### Basic Table with Controller
```dart
class TableExamples extends GetView<TableExamplesController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => CHIDataTable(
      dataList: controller.filteredData,
      columns: controller.columns,
      title: 'Employee Directory',
      page: controller.currentPage,
      totalRecords: controller.filteredTotalRecords,
      rowsPerPage: controller.rowsPerPage,
      onPageChanged: controller.onPageChanged,
      onSearch: controller.onSearch,
      onSort: controller.onSort,
    ));
  }
}
```

### Themed Table with Dynamic Switching
```dart
Widget _buildThemedTable() {
  return Obx(() => CHIDataTable(
    dataList: controller.filteredData,
    columns: controller.columns,
    title: 'Themed Employee Directory',
    themeConfig: controller.selectedTheme, // Dynamic theme
    // ... other properties
  ));
}
```

### Theme Selector Widget
```dart
Widget _buildThemeSelector() {
  return Obx(() => Container(
    child: Column(
      children: [
        Text('Current Theme: ${controller.getCurrentThemeName()}'),
        ElevatedButton(
          onPressed: controller.toggleTheme,
          child: Text('Toggle Theme'),
        ),
        Wrap(
          children: [
            _buildThemeButton('Default', TableThemes.defaultTheme),
            _buildThemeButton('Light', TableThemes.lightTheme),
            _buildThemeButton('Dark', TableThemes.darkTheme),
            _buildThemeButton('Material 3', TableThemes.material3Theme),
          ],
        ),
      ],
    ),
  ));
}
```

## Data Structure

The table expects data in the following format:

```dart
List<List<Map<String, dynamic>>> dataList = [
  [
    {'columnName': 'id', 'value': 1},
    {'columnName': 'name', 'value': 'John Doe'},
    {'columnName': 'email', 'value': 'john.doe@example.com'},
    // ... more columns
  ],
  // ... more rows
];
```

## Column Definitions

```dart
List<Map<String, dynamic>> columns = [
  {
    'columnName': 'ID',
    'key': 'id',
    'sort': true,
  },
  {
    'columnName': 'Name',
    'key': 'name',
    'sort': true,
  },
  {
    'columnName': 'Department',
    'key': 'department',
    'sort': true,
    'filter': {
      'data': [
        {'displayName': 'Engineering', 'value': 'engineering'},
        {'displayName': 'Marketing', 'value': 'marketing'},
        // ... more filter options
      ]
    }
  },
];
```

## Key Properties

- `dataList`: The data to display in the table
- `columns`: Column definitions with sorting and filtering options
- `title`: Table title displayed in the header
- `page`: Current page number
- `totalRecords`: Total number of records for pagination
- `rowsPerPage`: Number of rows to display per page
- `themeConfig`: Theme configuration for customizing appearance
- `onPageChanged`: Callback when page changes
- `onRowsPageChanged`: Callback when rows per page changes
- `onSearch`: Callback for search functionality
- `onSort`: Callback for sorting functionality
- `onItemSelect`: Callback for row selection
- `allowSorting`: Enable/disable sorting
- `allowFiltering`: Enable/disable filtering
- `isBusy`: Loading state indicator
- `fitToScreen`: Whether to fit columns to screen width
- `rowHeight`: Custom row height
- `headerRowHeight`: Custom header row height
- `defaultColumnWidth`: Default width for columns

## Theme Configuration Properties

### TableThemeConfig
- `headerBackgroundColor`: Custom header background color
- `rowAlternateColor`: Custom alternate row color
- `borderColor`: Custom border color
- `textColor`: Custom text color
- `iconColor`: Custom icon color
- `headerTextStyle`: Custom header text style
- `rowTextStyle`: Custom row text style
- `paginationTextStyle`: Custom pagination text style
- `headerHeight`: Custom header height
- `rowHeight`: Custom row height
- `borderWidth`: Custom border width
- `borderRadius`: Custom border radius
- `useAppTheme`: Whether to use app theme (default: true)
- `useCustomColors`: Whether to use custom colors (default: false)

## Benefits of the New Architecture

1. **Separation of Concerns**: Business logic separated from UI
2. **Reactive Updates**: Automatic UI updates with GetX observables
3. **Theme Flexibility**: Dynamic theme switching without rebuilding
4. **Maintainability**: Centralized state and logic management
5. **Reusability**: Controller can be used across different views
6. **Testing**: Easier to unit test business logic separately
7. **Performance**: Optimized updates using GetX reactive system

## Getting Started

1. **Create Controller**: Extend `GetxController` for table logic
2. **Use GetView**: Extend `GetView<YourController>` in your widget
3. **Wrap with Obx**: Use `Obx(() => Widget)` for reactive updates
4. **Configure Themes**: Use predefined themes or create custom ones
5. **Handle Events**: Connect controller methods to table callbacks

## Example Controller Setup

```dart
class TableExamplesController extends GetxController {
  final _currentPage = 1.obs;
  final _selectedTheme = TableThemes.defaultTheme.obs;
  
  int get currentPage => _currentPage.value;
  TableThemeConfig get selectedTheme => _selectedTheme.value;
  
  void onPageChanged(int page) => _currentPage.value = page;
  void toggleTheme() => _selectedTheme.value = getNextTheme();
}
```

This architecture provides a robust, maintainable, and feature-rich foundation for building complex data tables with advanced theming capabilities.

