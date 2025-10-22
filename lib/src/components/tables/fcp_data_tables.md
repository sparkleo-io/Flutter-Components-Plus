# FCPDataTable Component

A powerful data table component with advanced features like sorting, filtering, pagination, and custom styling.

## Features

- **Data Display**: Efficient rendering of large datasets
- **Sorting**: Column-based sorting with multiple sort criteria
- **Filtering**: Advanced filtering with multiple filter types
- **Pagination**: Built-in pagination with customizable page sizes
- **Selection**: Single and multiple row selection
- **Customization**: Full control over styling and appearance
- **Responsive**: Automatic sizing and responsive design
- **Accessibility**: Screen reader support and keyboard navigation

## Basic Usage

### Simple Data Table
```dart
FCPDataTable(
  columns: [
    FCPDataColumn(
      label: Text('Name'),
      onSort: (ascending) => print('Sort by name: $ascending'),
    ),
    FCPDataColumn(
      label: Text('Age'),
      onSort: (ascending) => print('Sort by age: $ascending'),
    ),
    FCPDataColumn(
      label: Text('Email'),
    ),
  ],
  rows: [
    FCPDataRow(
      cells: [
        FCPDataCell(Text('John Doe')),
        FCPDataCell(Text('25')),
        FCPDataCell(Text('john@example.com')),
      ],
    ),
    FCPDataRow(
      cells: [
        FCPDataCell(Text('Jane Smith')),
        FCPDataCell(Text('30')),
        FCPDataCell(Text('jane@example.com')),
      ],
    ),
  ],
)
```

### Data Table with Selection
```dart
FCPDataTable(
  columns: [
    FCPDataColumn(
      label: Text('Name'),
    ),
    FCPDataColumn(
      label: Text('Age'),
    ),
    FCPDataColumn(
      label: Text('Email'),
    ),
  ],
  rows: [
    FCPDataRow(
      selected: true,
      onSelectChanged: (selected) {
        print('Row selected: $selected');
      },
      cells: [
        FCPDataCell(Text('John Doe')),
        FCPDataCell(Text('25')),
        FCPDataCell(Text('john@example.com')),
      ],
    ),
    FCPDataRow(
      selected: false,
      onSelectChanged: (selected) {
        print('Row selected: $selected');
      },
      cells: [
        FCPDataCell(Text('Jane Smith')),
        FCPDataCell(Text('30')),
        FCPDataCell(Text('jane@example.com')),
      ],
    ),
  ],
)
```

### Data Table with Pagination
```dart
FCPDataTable(
  columns: [
    FCPDataColumn(label: Text('Name')),
    FCPDataColumn(label: Text('Age')),
    FCPDataColumn(label: Text('Email')),
  ],
  rows: dataRows,
  pagination: FCPPagination(
    currentPage: 1,
    totalPages: 10,
    pageSize: 20,
    onPageChanged: (page) {
      print('Page changed to: $page');
    },
    onPageSizeChanged: (pageSize) {
      print('Page size changed to: $pageSize');
    },
  ),
)
```

## Advanced Usage

### Data Table with Filtering
```dart
FCPDataTable(
  columns: [
    FCPDataColumn(
      label: Text('Name'),
      filter: FCPColumnFilter(
        type: FCPFilterType.text,
        onFilterChanged: (value) {
          print('Name filter: $value');
        },
      ),
    ),
    FCPDataColumn(
      label: Text('Age'),
      filter: FCPColumnFilter(
        type: FCPFilterType.number,
        onFilterChanged: (value) {
          print('Age filter: $value');
        },
      ),
    ),
    FCPDataColumn(
      label: Text('Status'),
      filter: FCPColumnFilter(
        type: FCPFilterType.select,
        options: ['Active', 'Inactive', 'Pending'],
        onFilterChanged: (value) {
          print('Status filter: $value');
        },
      ),
    ),
  ],
  rows: dataRows,
  showFilters: true,
  filterChips: true,
)
```

### Data Table with Custom Styling
```dart
FCPDataTable(
  columns: [
    FCPDataColumn(
      label: Text('Name'),
      style: FCPDataColumnStyle(
        backgroundColor: Colors.blue[50],
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue[800],
        ),
      ),
    ),
    FCPDataColumn(
      label: Text('Age'),
      style: FCPDataColumnStyle(
        backgroundColor: Colors.green[50],
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green[800],
        ),
      ),
    ),
  ],
  rows: dataRows,
  theme: FCPDataTableTheme(
    headerBackgroundColor: Colors.grey[100],
    rowBackgroundColor: Colors.white,
    alternateRowBackgroundColor: Colors.grey[50],
    borderColor: Colors.grey[300],
    headerTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    cellTextStyle: TextStyle(fontSize: 13),
  ),
)
```

### Data Table with Actions
```dart
FCPDataTable(
  columns: [
    FCPDataColumn(label: Text('Name')),
    FCPDataColumn(label: Text('Age')),
    FCPDataColumn(label: Text('Email')),
    FCPDataColumn(label: Text('Actions')),
  ],
  rows: dataRows.map((row) => FCPDataRow(
    cells: [
      ...row.cells,
      FCPDataCell(
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => print('Edit ${row.cells[0].child}'),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => print('Delete ${row.cells[0].child}'),
            ),
          ],
        ),
      ),
    ],
  )).toList(),
)
```

### Data Table with Loading State
```dart
FCPDataTable(
  columns: columns,
  rows: dataRows,
  loading: true,
  loadingWidget: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 16),
        Text('Loading data...'),
      ],
    ),
  ),
)
```

### Data Table with Empty State
```dart
FCPDataTable(
  columns: columns,
  rows: [],
  emptyState: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.inbox, size: 64, color: Colors.grey),
        SizedBox(height: 16),
        Text('No data available'),
        SizedBox(height: 8),
        Text('Try adjusting your filters or search criteria'),
      ],
    ),
  ),
)
```

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class DataTableExample extends StatefulWidget {
  @override
  _DataTableExampleState createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<DataTableExample> {
  List<Map<String, dynamic>> _data = [
    {'name': 'John Doe', 'age': 25, 'email': 'john@example.com', 'status': 'Active'},
    {'name': 'Jane Smith', 'age': 30, 'email': 'jane@example.com', 'status': 'Inactive'},
    {'name': 'Bob Johnson', 'age': 35, 'email': 'bob@example.com', 'status': 'Active'},
    {'name': 'Alice Brown', 'age': 28, 'email': 'alice@example.com', 'status': 'Pending'},
  ];

  List<Map<String, dynamic>> _filteredData = [];
  Map<String, dynamic> _filters = {};
  bool _loading = false;
  int _currentPage = 1;
  int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _filteredData = List.from(_data);
  }

  void _applyFilters() {
    setState(() {
      _loading = true;
    });

    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _filteredData = _data.where((item) {
          bool matches = true;
          
          if (_filters['name'] != null && _filters['name'].isNotEmpty) {
            matches = matches && item['name'].toString().toLowerCase().contains(_filters['name'].toLowerCase());
          }
          
          if (_filters['status'] != null && _filters['status'].isNotEmpty) {
            matches = matches && item['status'] == _filters['status'];
          }
          
          return matches;
        }).toList();
        
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Table Example'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _applyFilters,
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Section
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Search by name',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _filters['name'] = value;
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(),
                    ),
                    items: ['Active', 'Inactive', 'Pending'].map((status) {
                      return DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                    onChanged: (value) {
                      _filters['status'] = value;
                    },
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _applyFilters,
                  child: Text('Apply Filters'),
                ),
              ],
            ),
          ),
          
          // Data Table
          Expanded(
            child: FCPDataTable(
              columns: [
                FCPDataColumn(
                  label: Text('Name'),
                  onSort: (ascending) {
                    setState(() {
                      _filteredData.sort((a, b) {
                        int result = a['name'].compareTo(b['name']);
                        return ascending ? result : -result;
                      });
                    });
                  },
                ),
                FCPDataColumn(
                  label: Text('Age'),
                  onSort: (ascending) {
                    setState(() {
                      _filteredData.sort((a, b) {
                        int result = a['age'].compareTo(b['age']);
                        return ascending ? result : -result;
                      });
                    });
                  },
                ),
                FCPDataColumn(
                  label: Text('Email'),
                ),
                FCPDataColumn(
                  label: Text('Status'),
                ),
                FCPDataColumn(
                  label: Text('Actions'),
                ),
              ],
              rows: _filteredData.map((item) {
                return FCPDataRow(
                  cells: [
                    FCPDataCell(Text(item['name'])),
                    FCPDataCell(Text(item['age'].toString())),
                    FCPDataCell(Text(item['email'])),
                    FCPDataCell(
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: item['status'] == 'Active' 
                              ? Colors.green[100] 
                              : item['status'] == 'Inactive'
                                  ? Colors.red[100]
                                  : Colors.orange[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item['status'],
                          style: TextStyle(
                            color: item['status'] == 'Active' 
                                ? Colors.green[800] 
                                : item['status'] == 'Inactive'
                                    ? Colors.red[800]
                                    : Colors.orange[800],
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    FCPDataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, size: 20),
                            onPressed: () => print('Edit ${item['name']}'),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, size: 20),
                            onPressed: () => print('Delete ${item['name']}'),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
              loading: _loading,
              theme: FCPDataTableTheme(
                headerBackgroundColor: Colors.blue[50],
                rowBackgroundColor: Colors.white,
                alternateRowBackgroundColor: Colors.grey[50],
                borderColor: Colors.grey[300],
                headerTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.blue[800],
                ),
                cellTextStyle: TextStyle(fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

## API Reference

### FCPDataTable Properties

| Property | Type | Description |
|----------|--------|-------------|
| `columns` | `List<FCPDataColumn>` | Table columns |
| `rows` | `List<FCPDataRow>` | Table rows |
| `loading` | `bool` | Loading state |
| `loadingWidget` | `Widget?` | Loading widget |
| `emptyState` | `Widget?` | Empty state widget |
| `theme` | `FCPDataTableTheme?` | Custom theme |
| `pagination` | `FCPPagination?` | Pagination settings |
| `showFilters` | `bool` | Show filters |
| `filterChips` | `bool` | Show filter chips |
| `onRowTap` | `Function(FCPDataRow)?` | Row tap callback |
| `onRowDoubleTap` | `Function(FCPDataRow)?` | Row double tap callback |

### FCPDataColumn Properties

| Property | Type | Description |
|----------|--------|-------------|
| `label` | `Widget` | Column header |
| `onSort` | `Function(bool)?` | Sort callback |
| `filter` | `FCPColumnFilter?` | Column filter |
| `style` | `FCPDataColumnStyle?` | Column style |
| `width` | `double?` | Column width |
| `flex` | `int?` | Column flex |

### FCPDataRow Properties

| Property | Type | Description |
|----------|--------|-------------|
| `cells` | `List<FCPDataCell>` | Row cells |
| `selected` | `bool?` | Selected state |
| `onSelectChanged` | `Function(bool)?` | Selection callback |
| `style` | `FCPDataRowStyle?` | Row style |

### FCPDataCell Properties

| Property | Type | Description |
|----------|--------|-------------|
| `child` | `Widget` | Cell content |
| `onTap` | `VoidCallback?` | Tap callback |
| `style` | `FCPDataCellStyle?` | Cell style |

### FCPDataTableTheme Properties

| Property | Type | Description |
|----------|--------|-------------|
| `headerBackgroundColor` | `Color?` | Header background color |
| `rowBackgroundColor` | `Color?` | Row background color |
| `alternateRowBackgroundColor` | `Color?` | Alternate row background color |
| `borderColor` | `Color?` | Border color |
| `headerTextStyle` | `TextStyle?` | Header text style |
| `cellTextStyle` | `TextStyle?` | Cell text style |
| `elevation` | `double?` | Table elevation |
| `borderRadius` | `double?` | Border radius |

### FCPPagination Properties

| Property | Type | Description |
|----------|--------|-------------|
| `currentPage` | `int` | Current page |
| `totalPages` | `int` | Total pages |
| `pageSize` | `int` | Page size |
| `onPageChanged` | `Function(int)?` | Page change callback |
| `onPageSizeChanged` | `Function(int)?` | Page size change callback |
| `showPageSizeSelector` | `bool` | Show page size selector |
| `pageSizeOptions` | `List<int>?` | Page size options |

### FCPColumnFilter Properties

| Property | Type | Description |
|----------|--------|-------------|
| `type` | `FCPFilterType` | Filter type |
| `options` | `List<String>?` | Filter options |
| `onFilterChanged` | `Function(dynamic)?` | Filter change callback |
| `placeholder` | `String?` | Filter placeholder |

### FCPFilterType

| Type | Description |
|------|-------------|
| `text` | Text input filter |
| `number` | Number input filter |
| `select` | Dropdown filter |
| `date` | Date picker filter |
| `range` | Range filter |

## Best Practices

1. **Data Management**: Use efficient data structures and pagination
2. **Performance**: Implement virtual scrolling for large datasets
3. **User Experience**: Provide clear loading states and error handling
4. **Accessibility**: Ensure proper labels and keyboard navigation
5. **Responsive Design**: Test on different screen sizes
6. **Filtering**: Implement efficient filtering algorithms
7. **Sorting**: Use stable sorting algorithms

## Accessibility

- All table elements support proper touch targets
- Screen reader support for table content and navigation
- Keyboard navigation support
- High contrast mode support
- Proper semantic structure for assistive technologies
