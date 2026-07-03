import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

/// App-level table theme presets (example app owns these, not the package)
class AppTableThemes {
  /// Default: respect app ThemeData fully
  static const TableThemeConfig defaultTheme = TableThemeConfig(
    useAppTheme: true,
    useCustomColors: false,
  );

  /// Light custom theme tuned for this example app
  static const TableThemeConfig light = TableThemeConfig(
    useAppTheme: true,
    useCustomColors: true,
    headerBackgroundColor: Colors.transparent,
    rowAlternateColor: Colors.black12,
    borderColor: Color(0xFFE0E0E0),
    textColor: Colors.black87,
    iconColor: Colors.black54,
    borderRadius: 8,
    borderWidth: 1,
    headerTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    rowTextStyle: TextStyle(color: Colors.black),
    paginationTextStyle: TextStyle(color: Colors.black),
    tableBackgroundColor: Colors.white,
  );

  /// Dark custom theme tuned for this example app
  static const TableThemeConfig dark = TableThemeConfig(
    useAppTheme: false,
    useCustomColors: true,
    headerBackgroundColor: Colors.transparent,
    rowAlternateColor: Color(0xFF111827),
    borderColor: Color(0xFF374151),
    textColor: Color(0xFFE5E7EB),
    iconColor: Color(0xFF9CA3AF),
    borderRadius: 10,
    borderWidth: 1,
    headerHeight: 56,
    rowHeight: 48,
  );

  /// Material-3 flavored preset that still respects app theme colors
  static TableThemeConfig material3(BuildContext context) {
    return TableThemeConfig(
      useAppTheme: true,
      useCustomColors: false,
      borderRadius: 12,
      borderWidth: 1,
      headerHeight: 56,
      rowHeight: 48,
      // You can override colors derived from the app theme if desired
      // headerBackgroundColor: theme.colorScheme.surfaceVariant.withOpacity(0.1),
    );
  }
}
