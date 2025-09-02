import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';
import '../modules/theme/table_theme.dart';

class TableExamplesController extends GetxController {
  // Observable variables
  final _currentPage = 1.obs;
  final _rowsPerPage = 5.obs;
  final _isLoading = false.obs;
  final _searchQuery = ''.obs;
  final _sortField = Rxn<String>();
  final _sortOrder = Rxn<String>();
  final _selectedRowIndex = Rxn<int>();
  final _selectedTheme = AppTableThemes.defaultTheme.obs;

  // Getters
  int get currentPage => _currentPage.value;
  int get rowsPerPage => _rowsPerPage.value;
  bool get isLoading => _isLoading.value;
  String get searchQuery => _searchQuery.value;
  String? get sortField => _sortField.value;
  String? get sortOrder => _sortOrder.value;
  int? get selectedRowIndex => _selectedRowIndex.value;
  TableThemeConfig get selectedTheme => _selectedTheme.value;

  // Filtered and processed data
  final _filteredData = <List<Map<String, dynamic>>>[].obs;
  final _filteredTotalRecords = 0.obs;

  List<List<Map<String, dynamic>>> get filteredData => _filteredData;
  int get filteredTotalRecords => _filteredTotalRecords.value;

  // Sample data for the table
  final List<List<Map<String, dynamic>>> _sampleData = [
    [
      {'columnName': 'id', 'value': 1},
      {'columnName': 'name', 'value': 'John Doe'},
      {'columnName': 'email', 'value': 'john.doe@example.com'},
      {'columnName': 'department', 'value': 'Engineering'},
      {'columnName': 'salary', 'value': '\$75,000'},
      {'columnName': 'status', 'value': 'Active'},
      {'columnName': 'joinDate', 'value': '2023-01-15'},
    ],
    [
      {'columnName': 'id', 'value': 2},
      {'columnName': 'name', 'value': 'Jane Smith'},
      {'columnName': 'email', 'value': 'jane.smith@example.com'},
      {'columnName': 'department', 'value': 'Marketing'},
      {'columnName': 'salary', 'value': '\$65,000'},
      {'columnName': 'status', 'value': 'Active'},
      {'columnName': 'joinDate', 'value': '2023-02-20'},
    ],
    [
      {'columnName': 'id', 'value': 3},
      {'columnName': 'name', 'value': 'Mike Johnson'},
      {'columnName': 'email', 'value': 'mike.johnson@example.com'},
      {'columnName': 'department', 'value': 'Sales'},
      {'columnName': 'salary', 'value': '\$70,000'},
      {'columnName': 'status', 'value': 'Inactive'},
      {'columnName': 'joinDate', 'value': '2022-11-10'},
    ],
    [
      {'columnName': 'id', 'value': 4},
      {'columnName': 'name', 'value': 'Sarah Wilson'},
      {'columnName': 'email', 'value': 'sarah.wilson@example.com'},
      {'columnName': 'department', 'value': 'HR'},
      {'columnName': 'salary', 'value': '\$60,000'},
      {'columnName': 'status', 'value': 'Active'},
      {'columnName': 'joinDate', 'value': '2023-03-05'},
    ],
    [
      {'columnName': 'id', 'value': 5},
      {'columnName': 'name', 'value': 'David Brown'},
      {'columnName': 'email', 'value': 'david.brown@example.com'},
      {'columnName': 'department', 'value': 'Engineering'},
      {'columnName': 'salary', 'value': '\$80,000'},
      {'columnName': 'status', 'value': 'Active'},
      {'columnName': 'joinDate', 'value': '2022-09-12'},
    ],
    [
      {'columnName': 'id', 'value': 6},
      {'columnName': 'name', 'value': 'Lisa Davis'},
      {'columnName': 'email', 'value': 'lisa.davis@example.com'},
      {'columnName': 'department', 'value': 'Finance'},
      {'columnName': 'salary', 'value': '\$72,000'},
      {'columnName': 'status', 'value': 'Active'},
      {'columnName': 'joinDate', 'value': '2023-01-30'},
    ],
    [
      {'columnName': 'id', 'value': 7},
      {'columnName': 'name', 'value': 'Tom Anderson'},
      {'columnName': 'email', 'value': 'tom.anderson@example.com'},
      {'columnName': 'department', 'value': 'Marketing'},
      {'columnName': 'salary', 'value': '\$68,000'},
      {'columnName': 'status', 'value': 'Active'},
      {'columnName': 'joinDate', 'value': '2023-04-18'},
    ],
    [
      {'columnName': 'id', 'value': 8},
      {'columnName': 'name', 'value': 'Emily Taylor'},
      {'columnName': 'email', 'value': 'emily.taylor@example.com'},
      {'columnName': 'department', 'value': 'Engineering'},
      {'columnName': 'salary', 'value': '\$85,000'},
      {'columnName': 'status', 'value': 'Active'},
      {'columnName': 'joinDate', 'value': '2022-12-03'},
    ],
    [
      {'columnName': 'id', 'value': 9},
      {'columnName': 'name', 'value': 'Chris Miller'},
      {'columnName': 'email', 'value': 'chris.miller@example.com'},
      {'columnName': 'department', 'value': 'Sales'},
      {'columnName': 'salary', 'value': '\$73,000'},
      {'columnName': 'status', 'value': 'Inactive'},
      {'columnName': 'joinDate', 'value': '2023-02-14'},
    ],
    [
      {'columnName': 'id', 'value': 10},
      {'columnName': 'name', 'value': 'Anna Garcia'},
      {'columnName': 'email', 'value': 'anna.garcia@example.com'},
      {'columnName': 'department', 'value': 'HR'},
      {'columnName': 'salary', 'value': '\$62,000'},
      {'columnName': 'status', 'value': 'Active'},
      {'columnName': 'joinDate', 'value': '2023-05-22'},
    ],
    [
      {'columnName': 'id', 'value': 11},
      {'columnName': 'name', 'value': 'John Wilson'},
      {'columnName': 'email', 'value': 'john.wilson@example.com'},
      {'columnName': 'department', 'value': 'Engineering'},
      {'columnName': 'salary', 'value': '\$78,000'},
      {'columnName': 'status', 'value': 'Active'},
      {'columnName': 'joinDate', 'value': '2023-06-10'},
    ],
    [
      {'columnName': 'id', 'value': 12},
      {'columnName': 'name', 'value': 'Sarah Johnson'},
      {'columnName': 'email', 'value': 'sarah.johnson@example.com'},
      {'columnName': 'department', 'value': 'Marketing'},
      {'columnName': 'salary', 'value': '\$67,000'},
      {'columnName': 'status', 'value': 'Active'},
      {'columnName': 'joinDate', 'value': '2023-07-15'},
    ],
    [
      {'columnName': 'id', 'value': 13},
      {'columnName': 'name', 'value': 'Michael Brown'},
      {'columnName': 'email', 'value': 'michael.brown@example.com'},
      {'columnName': 'department', 'value': 'Sales'},
      {'columnName': 'salary', 'value': '\$74,000'},
      {'columnName': 'status', 'value': 'Inactive'},
      {'columnName': 'joinDate', 'value': '2022-08-20'},
    ],
    [
      {'columnName': 'id', 'value': 14},
      {'columnName': 'name', 'value': 'Lisa Anderson'},
      {'columnName': 'email', 'value': 'lisa.anderson@example.com'},
      {'columnName': 'department', 'value': 'Finance'},
      {'columnName': 'salary', 'value': '\$71,000'},
      {'columnName': 'status', 'value': 'Active'},
      {'columnName': 'joinDate', 'value': '2023-08-05'},
    ],
    [
      {'columnName': 'id', 'value': 15},
      {'columnName': 'name', 'value': 'David Miller'},
      {'columnName': 'email', 'value': 'david.miller@example.com'},
      {'columnName': 'department', 'value': 'Engineering'},
      {'columnName': 'salary', 'value': '\$82,000'},
      {'columnName': 'status', 'value': 'Active'},
      {'columnName': 'joinDate', 'value': '2022-10-12'},
    ],
  ];

  // Column definitions
  final List<Map<String, dynamic>> _columns = [
    {'columnName': 'ID', 'key': 'id', 'sort': true},
    {'columnName': 'Name', 'key': 'name', 'sort': true},
    {'columnName': 'Email', 'key': 'email', 'sort': true},
    {
      'columnName': 'Department',
      'key': 'department',
      'sort': true,
      'filter': {
        'data': [
          {'displayName': 'Engineering', 'value': 'engineering'},
          {'displayName': 'Marketing', 'value': 'marketing'},
          {'displayName': 'Sales', 'value': 'sales'},
          {'displayName': 'HR', 'value': 'hr'},
          {'displayName': 'Finance', 'value': 'finance'},
        ],
      },
    },
    {'columnName': 'Salary', 'key': 'salary', 'sort': true},
    {
      'columnName': 'Status',
      'key': 'status',
      'sort': true,
      'filter': {
        'data': [
          {'displayName': 'Active', 'value': 'active'},
          {'displayName': 'Inactive', 'value': 'inactive'},
        ],
      },
    },
    {'columnName': 'Join Date', 'key': 'joinDate', 'sort': true},
  ];

  List<Map<String, dynamic>> get columns => _columns;

  @override
  void onInit() {
    super.onInit();
    _filteredData.value = List.from(_sampleData);
    _filteredTotalRecords.value = _sampleData.length;
  }

  void processData() {
    List<List<Map<String, dynamic>>> processed = List.from(_sampleData);

    // Apply search filter
    if (_searchQuery.value.isNotEmpty) {
      processed = processed.where((row) {
        return row.any((cell) {
          final value = cell['value']?.toString().toLowerCase() ?? '';
          return value.contains(_searchQuery.value.toLowerCase());
        });
      }).toList();
    }

    // Apply sorting
    if (_sortField.value != null && _sortOrder.value != null) {
      processed.sort((a, b) {
        final aCell = a.firstWhere(
          (cell) => cell['columnName'] == _sortField.value,
          orElse: () => {'value': ''},
        );
        final bCell = b.firstWhere(
          (cell) => cell['columnName'] == _sortField.value,
          orElse: () => {'value': ''},
        );

        final aValue = aCell['value'];
        final bValue = bCell['value'];

        int comparison = 0;
        if (aValue is num && bValue is num) {
          comparison = aValue.compareTo(bValue);
        } else {
          comparison = aValue.toString().compareTo(bValue.toString());
        }

        return _sortOrder.value == 'ASC' ? comparison : -comparison;
      });
    }

    _filteredData.value = processed;
    _filteredTotalRecords.value = processed.length;
    _currentPage.value = 1; // Reset to first page when data changes
  }

  // Actions
  void onPageChanged(int page) {
    _currentPage.value = page;
  }

  void onRowsPageChanged(int? rowsPerPage) {
    _rowsPerPage.value = rowsPerPage ?? 10;
  }

  void onSearch(String? query) {
    _searchQuery.value = query ?? '';
    processData();
  }

  void onSort(String field, String? order) {
    _sortField.value = field;
    _sortOrder.value = order;
    processData();
  }

  void onReload() {
    _isLoading.value = true;
    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      _isLoading.value = false;
    });
  }

  void onItemSelect(int? selectedIndex, int? deselectedIndex) {
    _selectedRowIndex.value = selectedIndex;
    if (selectedIndex != null) {
      print('Selected row: $selectedIndex');
    }
  }

  void onAddItem() {
    print('Add new employee');
  }

  void onRefreshData() {
    print('Refresh data');
  }

  // Theme management using app-level themes
  void setTheme(TableThemeConfig theme) {
    print('Setting theme to: ${theme.runtimeType}');
    print('Theme useAppTheme: ${theme.useAppTheme}');
    print('Theme useCustomColors: ${theme.useCustomColors}');
    _selectedTheme.value = theme;
    print('Theme updated in controller');
  }

  void setAppDefaultTheme() {
    _selectedTheme.value = AppTableThemes.defaultTheme;
  }

  void setAppLightTheme() {
    _selectedTheme.value = AppTableThemes.light;
  }

  void setAppDarkTheme() {
    _selectedTheme.value = AppTableThemes.dark;
  }

  void setAppMaterial3Theme(BuildContext context) {
    _selectedTheme.value = AppTableThemes.material3(context);
  }

  void toggleTheme() {
    print('Current theme before toggle: ${_selectedTheme.value.runtimeType}');
    if (_selectedTheme.value == AppTableThemes.defaultTheme) {
      _selectedTheme.value = AppTableThemes.light;
      print('Switched to Light theme');
    } else if (_selectedTheme.value == AppTableThemes.light) {
      _selectedTheme.value = AppTableThemes.dark;
      print('Switched to Dark theme');
    } else {
      _selectedTheme.value = AppTableThemes.defaultTheme;
      print('Switched to Default theme');
    }
    print('New theme: ${_selectedTheme.value.runtimeType}');
  }

  String getCurrentThemeName() {
    if (_selectedTheme.value == AppTableThemes.defaultTheme) {
      return 'App Default';
    }
    if (_selectedTheme.value == AppTableThemes.light) return 'App Light';
    if (_selectedTheme.value == AppTableThemes.dark) return 'App Dark';
    return 'Custom';
  }
}
