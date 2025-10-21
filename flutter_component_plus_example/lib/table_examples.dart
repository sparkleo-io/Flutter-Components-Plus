import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';
import 'app/controllers/table_examples_controller.dart';
import 'app/modules/theme/table_theme.dart';

/// Comprehensive examples of CHIDataTable usage with GetX controller and theme support
class TableExamples extends StatelessWidget {
  const TableExamples({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TableExamplesController>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildThemeSelector(context, controller),
          const SizedBox(height: 24),
          _buildSection('Basic Data Table', [
            _buildBasicTable(context, controller),
          ], controller),
          const SizedBox(height: 32),
          _buildSection('Data Table with Advanced Filtering', [
            _buildFilteringTable(context, controller),
            const SizedBox(height: 16),
            _buildFilteringInstructions(),
          ], controller),
          // const SizedBox(height: 32),
          // _buildSection('Advanced Data Table with Actions', [
          //   _buildAdvancedTable(),
          // ]),
          // const SizedBox(height: 32),
          // _buildSection('Themed Data Table', [_buildThemedTable()]),
          // const SizedBox(height: 32),
          // _buildSection('Selectable Data Table', [_buildSelectableTable()]),
          // const SizedBox(height: 32),
          // _buildSection('Compact Data Table', [_buildCompactTable()]),
        ],
      ),
    );
  }

  Widget _buildThemeSelector(
    BuildContext context,
    TableExamplesController controller,
  ) {
    return Obx(() {
      controller.currentTheme.value = controller.getCurrentThemeName();
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Table Theme Configuration (App-defined)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 12),
            // Responsive layout for current theme and toggle button
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  // Mobile layout - stack vertically
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Current Theme: ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                controller.getCurrentThemeName(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue.shade800,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: controller.toggleTheme,
                          icon: const Icon(Icons.palette, size: 18),
                          label: const Text('Toggle Theme'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade600,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  // Desktop layout - horizontal row
                  return Row(
                    children: [
                      Text(
                        'Current Theme: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          controller.getCurrentThemeName(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue.shade800,
                          ),
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: controller.toggleTheme,
                        icon: const Icon(Icons.palette, size: 18),
                        label: const Text('Toggle Theme'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade600,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 12),
            // Responsive theme buttons
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 500) {
                  // Very small screens - stack buttons vertically
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildThemeButton(
                        'App Default',
                        AppTableThemes.defaultTheme,
                      ),
                      const SizedBox(height: 8),
                      _buildThemeButton('App Light', AppTableThemes.light),
                      const SizedBox(height: 8),
                      _buildThemeButton('App Dark', AppTableThemes.dark),
                    ],
                  );
                } else {
                  // Larger screens - use Wrap for horizontal layout
                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildThemeButton(
                        'App Default',
                        AppTableThemes.defaultTheme,
                      ),
                      _buildThemeButton('App Light', AppTableThemes.light),
                      _buildThemeButton('App Dark', AppTableThemes.dark),
                      ElevatedButton(
                        onPressed: () =>
                            controller.setAppMaterial3Theme(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade200,
                          foregroundColor: Colors.grey.shade700,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'App Material 3',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildThemeButton(String label, TableThemeConfig theme) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final controller = Get.find<TableExamplesController>();
        return SizedBox(
          width: constraints.maxWidth < 500 ? double.infinity : null,
          child: ElevatedButton(
            onPressed: () => controller.setTheme(theme),
            style: ElevatedButton.styleFrom(
              backgroundColor: controller.selectedTheme == theme
                  ? Colors.blue.shade600
                  : Colors.grey.shade200,
              foregroundColor: controller.selectedTheme == theme
                  ? Colors.white
                  : Colors.grey.shade700,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              elevation: controller.selectedTheme == theme ? 2 : 0,
            ),
            child: Text(
              label,
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }

  Widget _buildSection(
    String title,
    List<Widget> children,
    TableExamplesController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildBasicTable(
    BuildContext context,
    TableExamplesController controller,
  ) {
    return Obx(
      () => Container(
        height: 600, // Fixed height for consistency
        width: double.infinity,
        child: FCPDataTable(
          key: ValueKey('basic_table_${controller.selectedTheme.hashCode}'),
          dataList: controller.filteredData,
          columns: controller.columns,
          page: controller.currentPage,
          totalRecords: controller.filteredTotalRecords,
          rowsPerPage: controller.rowsPerPage,
          fitToScreen: false,
          availableRowsPerPage: [5, 10, 15],
          themeConfig: controller.selectedTheme,
          onPageChanged: controller.onPageChanged,
          onRowsPageChanged: controller.onRowsPageChanged,
          onSearch: controller.onSearch,
          onSort: controller.onSort,
          onReload: controller.onReload,
          title: 'Employee Directory', // Required parameter
          // customHeader: _buildCustomHeader(controller, context),
          // Let the package handle responsiveness automatically
          columnWidthMode: ColumnWidthMode.fitByColumnName,
          // Mobile-optimized settings
          shrinkWrapColumns: false,
          // defaultColumnWidth:
          //     double.nan, // Let the package determine optimal width
        ),
      ),
    );
  }

  Widget _buildFilteringTable(
    BuildContext context,
    TableExamplesController controller,
  ) {
    return Obx(
      () => Container(
        height: 600, // Fixed height for consistency
        width: double.infinity,
        child: FCPDataTable(
          key: ValueKey('filtering_table_${controller.selectedTheme.hashCode}'),
          dataList: controller.filteredData,
          columns: controller.columns,
          page: controller.currentPage,
          totalRecords: controller.filteredTotalRecords,
          rowsPerPage: controller.rowsPerPage,
          fitToScreen: false,
          availableRowsPerPage: [5, 10, 15],
          themeConfig: controller.selectedTheme,
          onPageChanged: controller.onPageChanged,
          onRowsPageChanged: controller.onRowsPageChanged,
          onSearch: controller.onSearch,
          onSort: controller.onSort,
          onReload: controller.onReload,
          title: 'Employee Directory with Filters',
          // Enable filtering features
          showFiltersInHeader: false, // Show filters in column headers
          filterableColumns: [
            'name',
            'department',
            'salary',
            'status',
            'joinDate',
          ], // Specify which columns can be filtered
          // Custom filter function for advanced filtering
          customFilterFunction: (columnName, value, filterValue) {
            // Custom filter for status column - supports multiple status values
            if (columnName == 'status') {
              final status = value?.toString().toLowerCase();
              final filterValues = filterValue
                  .toLowerCase()
                  .split(',')
                  .map((s) => s.trim())
                  .toList();

              // Support filtering by multiple status values (comma-separated)
              // Examples: "active", "inactive", "active,inactive"
              return filterValues.any(
                (filter) => status?.contains(filter) ?? false,
              );
            }

            // Custom filter for salary column - supports range filtering
            if (columnName == 'salary' && value is String) {
              final salaryStr = value
                  .toString()
                  .replaceAll('\$', '')
                  .replaceAll(',', '');
              final salary = double.tryParse(salaryStr);
              if (salary != null) {
                // Support range filtering like "60000-80000" or single value "70000"
                if (filterValue.contains('-')) {
                  final parts = filterValue.split('-');
                  final min = double.tryParse(parts[0]);
                  final max = double.tryParse(parts[1]);
                  if (min != null && max != null) {
                    return salary >= min && salary <= max;
                  }
                } else {
                  // Single value filtering with tolerance
                  final targetSalary = double.tryParse(filterValue);
                  if (targetSalary != null) {
                    return (salary - targetSalary).abs() <=
                        5000; // Within $5000 tolerance
                  }
                }
              }
            }

            // Custom filter for department - supports partial matching
            if (columnName == 'department') {
              final department = value?.toString().toLowerCase();
              final filter = filterValue.toLowerCase();

              // Support abbreviations: "eng" matches "Engineering"
              if (filter == 'eng')
                return department?.contains('engineering') ?? false;
              if (filter == 'mkt')
                return department?.contains('marketing') ?? false;
              if (filter == 'hr') return department?.contains('hr') ?? false;
              if (filter == 'fin')
                return department?.contains('finance') ?? false;
              if (filter == 'sal')
                return department?.contains('sales') ?? false;

              // Default partial matching
              return department?.contains(filter) ?? false;
            }

            // Default text contains filter for other columns
            return value?.toString().toLowerCase().contains(
                  filterValue.toLowerCase(),
                ) ??
                false;
          },
          columnWidthMode: ColumnWidthMode.fitByColumnName,
          shrinkWrapColumns: false,
        ),
      ),
    );
  }

  Widget _buildFilteringInstructions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue.shade700),
              const SizedBox(width: 8),
              Text(
                'Custom Filter Examples',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildFilterExample('Status Column:', [
            '• "active" - Shows only active employees',
            '• "inactive" - Shows only inactive employees',
            '• "active,inactive" - Shows both active and inactive employees',
          ]),
          const SizedBox(height: 8),
          _buildFilterExample('Salary Column:', [
            '• "70000" - Shows salaries within \$5000 of \$70,000',
            '• "60000-80000" - Shows salaries between \$60,000 and \$80,000',
          ]),
          const SizedBox(height: 8),
          _buildFilterExample('Department Column:', [
            '• "eng" - Matches "Engineering"',
            '• "mkt" - Matches "Marketing"',
            '• "hr" - Matches "HR"',
            '• "fin" - Matches "Finance"',
            '• "sal" - Matches "Sales"',
          ]),
        ],
      ),
    );
  }

  Widget _buildFilterExample(String title, List<String> examples) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(height: 4),
        ...examples.map(
          (example) => Padding(
            padding: const EdgeInsets.only(left: 8, top: 2),
            child: Text(
              example,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomHeader(
    TableExamplesController controller,
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    final themeConfig = controller.selectedTheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: themeConfig.getTableBackgroundColor(theme),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        border: Border(
          bottom: BorderSide(
            color: themeConfig.borderColor ?? Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header title with icon
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.people_outline,
                  color: Colors.blue.shade700,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Employee Directory',
                      style: themeConfig.useAppTheme
                          ? (theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ) ??
                                const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ))
                          : const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${controller.filteredTotalRecords} employees',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Search and actions row
          Container(
            width: 250,
            child: FCPInputFields.search(
              onChanged: (query) {
                controller.onSearch(query);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedTable(TableExamplesController controller) {
    return Obx(
      () => Container(
        height: 400, // Fixed height for consistency
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: FCPDataTable(
          key: ValueKey('advanced_table_${controller.selectedTheme.hashCode}'),
          dataList: controller.filteredData,
          columns: controller.columns,
          title: 'Advanced Employee Directory',
          page: controller.currentPage,
          totalRecords: controller.filteredTotalRecords,
          rowsPerPage: controller.rowsPerPage,
          fitToScreen: true,
          availableRowsPerPage: [5, 10, 15, 20],
          allowSorting: true,
          allowFiltering: true,
          themeConfig: controller.selectedTheme,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: controller.onAddItem,
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: controller.onRefreshData,
            ),
          ],
          suffix: Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.info_outline, color: Colors.blue.shade600),
                const SizedBox(width: 4),
                Text(
                  '${controller.filteredTotalRecords} employees',
                  style: TextStyle(
                    color: Colors.blue.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          onPageChanged: controller.onPageChanged,
          onRowsPageChanged: controller.onRowsPageChanged,
          onSearch: controller.onSearch,
          onSort: controller.onSort,
          onReload: controller.onReload,
          // Let the package handle responsiveness automatically
          columnWidthMode: ColumnWidthMode.fitByColumnName,
          gridLinesVisibility: GridLinesVisibility.none,
          allowColumnsDragging: false, // Better for mobile UX
          allowColumnsResizing: true,
          columnResizeMode: ColumnResizeMode.onResize,
          defaultColumnWidth: double.nan,
          shrinkWrapColumns: true,
        ),
      ),
    );
  }

  Widget _buildThemedTable(TableExamplesController controller) {
    return Obx(
      () => Container(
        height: 400,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: FCPDataTable(
          key: ValueKey('themed_table_${controller.selectedTheme.hashCode}'),
          dataList: controller.filteredData,
          columns: controller.columns,
          title: 'Themed Employee Directory',
          page: controller.currentPage,
          totalRecords: controller.filteredTotalRecords,
          rowsPerPage: controller.rowsPerPage,
          fitToScreen: true,
          availableRowsPerPage: [5, 10, 15, 20],
          allowSorting: true,
          allowFiltering: true,
          themeConfig: controller.selectedTheme,
          onPageChanged: controller.onPageChanged,
          onRowsPageChanged: controller.onRowsPageChanged,
          onSearch: controller.onSearch,
          onSort: controller.onSort,
          onReload: controller.onReload,
          // Let the package handle responsiveness automatically
          columnWidthMode: ColumnWidthMode.fitByColumnName,
          gridLinesVisibility: GridLinesVisibility.none,
          allowColumnsDragging: false, // Better for mobile UX
          allowColumnsResizing: true,
          columnResizeMode: ColumnResizeMode.onResize,
          defaultColumnWidth: double.nan,
          shrinkWrapColumns: true,
        ),
      ),
    );
  }

  Widget _buildSelectableTable(TableExamplesController controller) {
    return Obx(
      () => Container(
        height: 400,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: FCPDataTable(
          key: ValueKey(
            'selectable_table_${controller.selectedTheme.hashCode}',
          ),
          dataList: controller.filteredData,
          columns: controller.columns,
          title: 'Selectable Employee Directory',
          page: controller.currentPage,
          totalRecords: controller.filteredTotalRecords,
          rowsPerPage: controller.rowsPerPage,
          fitToScreen: true,
          availableRowsPerPage: [5, 10, 15, 20],
          allowSorting: true,
          allowFiltering: true,
          themeConfig: controller.selectedTheme,
          onItemSelect: controller.onItemSelect,
          onPageChanged: controller.onPageChanged,
          onRowsPageChanged: controller.onRowsPageChanged,
          onSearch: controller.onSearch,
          onSort: controller.onSort,
          onReload: controller.onReload,
          // Let the package handle responsiveness automatically
          columnWidthMode: ColumnWidthMode.fitByColumnName,
          gridLinesVisibility: GridLinesVisibility.none,
          allowColumnsDragging: false, // Better for mobile UX
          allowColumnsResizing: true,
          columnResizeMode: ColumnResizeMode.onResize,
          defaultColumnWidth: double.nan,
          shrinkWrapColumns: true,
        ),
      ),
    );
  }

  Widget _buildCompactTable(TableExamplesController controller) {
    return Obx(
      () => Container(
        height: 300,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: FCPDataTable(
          key: ValueKey('compact_table_${controller.selectedTheme.hashCode}'),
          dataList: controller.filteredData,
          columns: controller.columns,
          title: 'Compact Employee Directory',
          page: controller.currentPage,
          totalRecords: controller.filteredTotalRecords,
          rowsPerPage: controller.rowsPerPage,
          fitToScreen: true,
          availableRowsPerPage: [5, 10, 15, 20],
          allowSorting: true,
          allowFiltering: true,
          rowHeight: 40,
          headerRowHeight: 48,
          defaultColumnWidth: 120,
          themeConfig: controller.selectedTheme,
          onPageChanged: controller.onPageChanged,
          onRowsPageChanged: controller.onRowsPageChanged,
          onSearch: controller.onSearch,
          onSort: controller.onSort,
          onReload: controller.onReload,
          // Let the package handle responsiveness automatically
          columnWidthMode: ColumnWidthMode.fitByColumnName,
          gridLinesVisibility: GridLinesVisibility.none,
          allowColumnsDragging: false, // Better for mobile UX
          allowColumnsResizing: true,
          columnResizeMode: ColumnResizeMode.onResize,
          shrinkWrapColumns: true,
        ),
      ),
    );
  }
}
