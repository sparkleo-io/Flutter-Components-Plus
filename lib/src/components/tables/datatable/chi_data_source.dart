import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'dart:async';
import 'types/table_types.dart';
import 'table_theme_config.dart';

class CHIDataSource extends DataGridSource {
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

  CHIDataSource(this.context, {required this.dataList, this.themeConfig}) {
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
