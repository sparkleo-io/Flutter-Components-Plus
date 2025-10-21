import 'package:flutter/material.dart';

class FilterState {
  final String columnName;
  final String filterType; // 'text', 'select', 'date', 'number'
  final String filterValue;
  final List<dynamic>? filterOptions; // For select type filters
  final DateTime? startDate;
  final DateTime? endDate;
  final double? minValue;
  final double? maxValue;

  FilterState({
    required this.columnName,
    required this.filterType,
    this.filterValue = '',
    this.filterOptions,
    this.startDate,
    this.endDate,
    this.minValue,
    this.maxValue,
  });

  FilterState copyWith({
    String? columnName,
    String? filterType,
    String? filterValue,
    List<dynamic>? filterOptions,
    DateTime? startDate,
    DateTime? endDate,
    double? minValue,
    double? maxValue,
  }) {
    return FilterState(
      columnName: columnName ?? this.columnName,
      filterType: filterType ?? this.filterType,
      filterValue: filterValue ?? this.filterValue,
      filterOptions: filterOptions ?? this.filterOptions,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      minValue: minValue ?? this.minValue,
      maxValue: maxValue ?? this.maxValue,
    );
  }

  bool get isEmpty {
    return filterValue.isEmpty &&
        startDate == null &&
        endDate == null &&
        minValue == null &&
        maxValue == null;
  }

  bool get isNotEmpty => !isEmpty;
}

class FilterManager extends ChangeNotifier {
  final Map<String, FilterState> _filters = {};

  Map<String, FilterState> get filters => Map.unmodifiable(_filters);

  void setFilter(String columnName, FilterState filter) {
    _filters[columnName] = filter;
    notifyListeners();
  }

  void removeFilter(String columnName) {
    _filters.remove(columnName);
    notifyListeners();
  }

  void clearAllFilters() {
    _filters.clear();
    notifyListeners();
  }

  FilterState? getFilter(String columnName) {
    return _filters[columnName];
  }

  bool hasActiveFilters() {
    return _filters.values.any((filter) => filter.isNotEmpty);
  }

  List<String> getActiveFilterColumns() {
    return _filters.entries
        .where((entry) => entry.value.isNotEmpty)
        .map((entry) => entry.key)
        .toList();
  }
}
