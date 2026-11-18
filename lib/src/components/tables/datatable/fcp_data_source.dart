import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'types/table_types.dart';
import 'table_theme_config.dart';
import 'filter_state.dart';

class FCPDataSource extends DataGridSource {
  final BuildContext context;
  final DataObject dataList;
  final TableThemeConfig? themeConfig;

  final List<DataGridRow> _dataList = [];
  final List<DataGridRow> _filteredDataList = [];
  final editingController = TextEditingController();
  String _searchQuery = '';
  String? _sortField;
  String? _sortOrder;
  int _currentPage = 1;
  int _rowsPerPage = 10;
  final FilterManager _filterManager = FilterManager();
  bool Function(String columnName, dynamic value, String filterValue)?
      _customFilterFunction;

  FCPDataSource(
    this.context, {
    required this.dataList,
    this.themeConfig,
    bool Function(String columnName, dynamic value, String filterValue)?
        customFilterFunction,
  }) {
    _customFilterFunction = customFilterFunction;
    _buildDataList();
  }

  void _buildDataList() {
    _dataList.clear();
    for (final data in dataList) {
      final List<DataGridCell> cells = [];

      for (final column in data) {
        final columnName = column['columnName']?.toString() ?? 'unknown';
        final value = column['value'];

        cells.add(DataGridCell(columnName: columnName, value: value));
      }

      _dataList.add(DataGridRow(cells: cells));
    }
    _applyFilters();
  }

  void _applyFilters() {
    _filteredDataList.clear();

    // Apply search filter
    List<DataGridRow> filtered = _dataList.where((row) {
      if (_searchQuery.isEmpty) return true;

      return row.getCells().any((cell) {
        final value = cell.value?.toString().toLowerCase() ?? '';
        return value.contains(_searchQuery.toLowerCase());
      });
    }).toList();

    // Apply column-specific filters
    filtered = filtered.where((row) {
      return _filterManager.filters.values.every((filter) {
        if (filter.isEmpty) return true;

        final cell = row.getCells().firstWhere(
              (cell) => cell.columnName == filter.columnName,
              orElse: () =>
                  DataGridCell(columnName: filter.columnName, value: null),
            );

        return _applyColumnFilter(filter, cell.value);
      });
    }).toList();

    // Apply sorting
    if (_sortField != null && _sortOrder != null) {
      filtered.sort((a, b) {
        final aCell = a.getCells().firstWhere(
              (cell) => cell.columnName == _sortField,
              orElse: () => DataGridCell(columnName: _sortField!, value: ''),
            );
        final bCell = b.getCells().firstWhere(
              (cell) => cell.columnName == _sortField,
              orElse: () => DataGridCell(columnName: _sortField!, value: ''),
            );

        final aValue = aCell.value;
        final bValue = bCell.value;

        int comparison = 0;
        if (aValue is num && bValue is num) {
          comparison = aValue.compareTo(bValue);
        } else {
          comparison = aValue.toString().compareTo(bValue.toString());
        }

        return _sortOrder == 'ASC' ? comparison : -comparison;
      });
    }

    _filteredDataList.addAll(filtered);
    notifyListeners();
  }

  void updateSearch(String query) {
    _searchQuery = query;
    _currentPage = 1; // Reset to first page when searching
    _applyFilters();
  }

  void updateSort(String? field, String? order) {
    _sortField = field;
    _sortOrder = order;
    _applyFilters();
  }

  void updatePagination(int page, int rowsPerPage) {
    _currentPage = page;
    _rowsPerPage = rowsPerPage;
    notifyListeners();
  }

  void updateFilter(String columnName, FilterState? filter) {
    if (filter == null || filter.isEmpty) {
      _filterManager.removeFilter(columnName);
    } else {
      _filterManager.setFilter(columnName, filter);
    }
    _currentPage = 1; // Reset to first page when filtering
    _applyFilters();
  }

  void clearAllFilters() {
    _filterManager.clearAllFilters();
    _applyFilters();
  }

  FilterManager get filterManager => _filterManager;

  List<DataGridRow> get allData => _dataList;

  bool _applyColumnFilter(FilterState filter, dynamic value) {
    // Use custom filter function if provided
    if (_customFilterFunction != null) {
      return _customFilterFunction!(
        filter.columnName,
        value,
        filter.filterValue,
      );
    }

    // Apply built-in filter logic
    switch (filter.filterType) {
      case 'text':
        return value?.toString().toLowerCase().contains(
                  filter.filterValue.toLowerCase(),
                ) ??
            false;

      case 'select':
        if (filter.filterOptions == null) return true;
        return filter.filterOptions!.contains(value);

      case 'number':
        final numValue =
            value is num ? value : double.tryParse(value?.toString() ?? '');
        if (numValue == null) return false;

        if (filter.minValue != null && numValue < filter.minValue!) {
          return false;
        }
        if (filter.maxValue != null && numValue > filter.maxValue!) {
          return false;
        }
        return true;

      case 'date':
        if (value is! DateTime) {
          final dateStr = value?.toString();
          if (dateStr == null) return false;
          // Try to parse as DateTime
          final date = DateTime.tryParse(dateStr);
          if (date == null) return false;
          value = date;
        }

        if (filter.startDate != null && value.isBefore(filter.startDate!)) {
          return false;
        }
        if (filter.endDate != null && value.isAfter(filter.endDate!)) {
          return false;
        }
        return true;

      default:
        return true;
    }
  }

  List<DataGridRow> get paginatedData {
    final startIndex = (_currentPage - 1) * _rowsPerPage;
    final endIndex = (startIndex + _rowsPerPage).clamp(
      0,
      _filteredDataList.length,
    );
    return _filteredDataList.sublist(startIndex, endIndex);
  }

  int get totalFilteredRecords => _filteredDataList.length;

  @override
  List<DataGridRow> get rows => paginatedData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    final index = paginatedData.indexOf(row);
    final theme = Theme.of(context);
    final themeConfig = this.themeConfig ?? TableThemes.defaultTheme;

    return DataGridRowAdapter(
      color: index % 2 == 0
          ? Colors.transparent
          : themeConfig.getRowAlternateColor(theme),
      cells: row.getCells().map<Widget>((cell) {
        if (cell.value is Widget) return cell.value;
        return Padding(
          padding: const EdgeInsets.only(top: 18, left: 8),
          child: Text(
            '${cell.value ?? ''}',
            textAlign: TextAlign.justify,
            style: themeConfig.getRowTextStyle(theme),
          ),
        );
      }).toList(),
    );
  }
}
