import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';
import 'app/controllers/table_examples_controller.dart';
import 'app/modules/theme/table_theme.dart';

/// Comprehensive examples of CHIDataTable usage with GetX controller and theme support
class TableExamples extends GetView<TableExamplesController> {
  const TableExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildThemeSelector(context),
            const SizedBox(height: 24),
            _buildSection('Basic Data Table', [_buildBasicTable()]),
            const SizedBox(height: 32),
            _buildSection('Advanced Data Table with Actions', [
              _buildAdvancedTable(),
            ]),
            const SizedBox(height: 32),
            _buildSection('Themed Data Table', [_buildThemedTable()]),
            const SizedBox(height: 32),
            _buildSection('Selectable Data Table', [_buildSelectableTable()]),
            const SizedBox(height: 32),
            _buildSection('Compact Data Table', [_buildCompactTable()]),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSelector(BuildContext context) {
    return Obx(
      () => Container(
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
            Row(
              children: [
                Text(
                  'Current Theme: ',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
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
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                _buildThemeButton('App Default', AppTableThemes.defaultTheme),
                _buildThemeButton('App Light', AppTableThemes.light),
                _buildThemeButton('App Dark', AppTableThemes.dark),
                ElevatedButton(
                  onPressed: () => controller.setAppMaterial3Theme(context),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeButton(String label, TableThemeConfig theme) {
    return Obx(
      () => ElevatedButton(
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
        child: Text(label, style: const TextStyle(fontSize: 12)),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
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

  Widget _buildBasicTable() {
    return Obx(
      () => Container(
        height: 600,

        child: CHIDataTable(
          key: ValueKey(
            'basic_table_${controller.selectedTheme.hashCode}',
          ), // Force rebuild on theme change
          dataList: controller.filteredData,
          columns: controller.columns,
          title: 'Employee Directory',
          page: controller.currentPage,
          totalRecords: controller.filteredTotalRecords,
          rowsPerPage: controller.rowsPerPage,
          fitToScreen: true,
          availableRowsPerPage: [5, 10, 15, 20],
          themeConfig: controller.selectedTheme, // Add theme configuration
          onPageChanged: controller.onPageChanged,
          onRowsPageChanged: controller.onRowsPageChanged,
          onSearch: controller.onSearch,
          onSort: controller.onSort,
          onReload: controller.onReload,
        ),
      ),
    );
  }

  Widget _buildAdvancedTable() {
    return Obx(
      () => Container(
        height: 400,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: CHIDataTable(
          key: ValueKey(
            'advanced_table_${controller.selectedTheme.hashCode}',
          ), // Force rebuild on theme change
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
          themeConfig: controller.selectedTheme, // Add theme configuration
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
        ),
      ),
    );
  }

  Widget _buildThemedTable() {
    return Obx(
      () => Container(
        height: 400,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: CHIDataTable(
          key: ValueKey(
            'themed_table_${controller.selectedTheme.hashCode}',
          ), // Force rebuild on theme change
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
        ),
      ),
    );
  }

  Widget _buildSelectableTable() {
    return Obx(
      () => Container(
        height: 400,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: CHIDataTable(
          key: ValueKey(
            'selectable_table_${controller.selectedTheme.hashCode}',
          ), // Force rebuild on theme change
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
          themeConfig: controller.selectedTheme, // Add theme configuration
          onItemSelect: controller.onItemSelect,
          onPageChanged: controller.onPageChanged,
          onRowsPageChanged: controller.onRowsPageChanged,
          onSearch: controller.onSearch,
          onSort: controller.onSort,
          onReload: controller.onReload,
        ),
      ),
    );
  }

  Widget _buildCompactTable() {
    return Obx(
      () => Container(
        height: 300,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: CHIDataTable(
          key: ValueKey(
            'compact_table_${controller.selectedTheme.hashCode}',
          ), // Force rebuild on theme change
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
          themeConfig: controller.selectedTheme, // Add theme configuration
          onPageChanged: controller.onPageChanged,
          onRowsPageChanged: controller.onRowsPageChanged,
          onSearch: controller.onSearch,
          onSort: controller.onSort,
          onReload: controller.onReload,
        ),
      ),
    );
  }
}
