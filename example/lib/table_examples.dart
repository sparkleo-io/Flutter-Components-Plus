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
          _buildSection(
              'Basic Data Table',
              [
                _buildBasicTable(context, controller),
              ],
              controller),
          const SizedBox(height: 32),
          _buildSection(
              'Data Table with Advanced Filtering',
              [
                _buildFilteringTable(context, controller),
                const SizedBox(height: 16),
              ],
              controller),
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
      () => SizedBox(
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
      () => SizedBox(
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
              // Use exact matching instead of contains to avoid partial matches
              return filterValues.any((filter) => status == filter);
            }

            // Custom filter for salary column - supports range filtering
            if (columnName == 'salary' && value is String) {
              final salaryStr =
                  value.toString().replaceAll('\$', '').replaceAll(',', '');
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
              if (filter == 'eng') return department == 'engineering';
              if (filter == 'mkt') return department == 'marketing';
              if (filter == 'hr') return department == 'hr';
              if (filter == 'fin') return department == 'finance';
              if (filter == 'sal') return department == 'sales';

              // Default exact matching for full department names
              return department == filter;
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
}
