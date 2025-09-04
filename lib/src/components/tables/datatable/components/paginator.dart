import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';
import '../table_theme_config.dart';

class Paginator extends StatelessWidget {
  const Paginator({
    super.key,
    required this.rowsPerPage,
    required this.availableRowsPerPage,
    required this.onRowsPageChanged,
    required this.page,
    required this.totalRecords,
    required this.onPageChanged,
    this.themeConfig,
  });

  final int rowsPerPage;
  final List<int> availableRowsPerPage;
  final void Function(int?)? onRowsPageChanged;
  final int page;
  final int totalRecords;
  final void Function(int)? onPageChanged;
  final TableThemeConfig? themeConfig;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeConfig = this.themeConfig ?? TableThemes.defaultTheme;

    return ColoredBox(
      color: themeConfig.getTableBackgroundColor(theme),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    'items per page:',
                    style: themeConfig.getPaginationTextStyle(theme),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '${((rowsPerPage * page) - rowsPerPage) + 1} - ${rowsPerPage * page >= totalRecords ? totalRecords : rowsPerPage * page} of $totalRecords',
                    style: themeConfig.getPaginationTextStyle(theme),
                  ),
                ],
              ),
              // 16.spaceY,
              Row(
                children: [
                  DropdownButton(
                    elevation: 0,
                    focusColor: Colors.transparent,
                    hint: Text(
                      '$rowsPerPage',
                      style: themeConfig.getPaginationTextStyle(theme),
                    ),
                    underline: const SizedBox(),
                    items: availableRowsPerPage
                        .map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: Text(
                              '$item',
                              style: themeConfig.getPaginationTextStyle(theme),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (onRowsPageChanged != null) {
                        onRowsPageChanged!(value);
                      }
                    },
                  ),
                  IconButton(
                    onPressed: page < 2
                        ? null
                        : () {
                            if (onPageChanged != null) {
                              onPageChanged!(1);
                            }
                          },
                    icon: Icon(
                      Icons.first_page,
                      color: themeConfig.getIconColor(theme),
                    ),
                  ),
                  IconButton(
                    onPressed: page < 2
                        ? null
                        : () {
                            if (onPageChanged != null) {
                              final decPage = page - 1;
                              onPageChanged!(decPage);
                            }
                          },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 18,
                      color: themeConfig.getIconColor(theme),
                    ),
                  ),
                  IconButton(
                    onPressed: rowsPerPage * page >= totalRecords
                        ? null
                        : () {
                            if (onPageChanged != null) {
                              final incPage = page + 1;
                              onPageChanged!(incPage);
                            }
                          },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: themeConfig.getIconColor(theme),
                    ),
                  ),
                  IconButton(
                    onPressed: rowsPerPage * page >= totalRecords
                        ? null
                        : () {
                            if (onPageChanged != null) {
                              final lastPage = (totalRecords / rowsPerPage)
                                  .ceil();
                              onPageChanged!(lastPage);
                            }
                          },
                    icon: Icon(
                      Icons.last_page,
                      color: themeConfig.getIconColor(theme),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
