import 'package:flutter/material.dart';

/// Configuration class for customizing table appearance
/// while respecting the app's theme
class TableThemeConfig {
  /// Custom colors for table elements
  final Color? headerBackgroundColor;
  final Color? rowAlternateColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? iconColor;
  final Color? tableBackgroundColor; // Overall table background color

  /// Custom styles for table elements
  final TextStyle? headerTextStyle;
  final TextStyle? rowTextStyle;
  final TextStyle? paginationTextStyle;

  /// Custom dimensions
  final double? headerHeight;
  final double? rowHeight;
  final double? borderWidth;
  final double? borderRadius;

  /// Whether to use app theme (default: true)
  final bool useAppTheme;

  /// Whether to use custom colors (default: false)
  final bool useCustomColors;

  const TableThemeConfig({
    this.headerBackgroundColor,
    this.rowAlternateColor,
    this.borderColor,
    this.textColor,
    this.iconColor,
    this.tableBackgroundColor,
    this.headerTextStyle,
    this.rowTextStyle,
    this.paginationTextStyle,
    this.headerHeight,
    this.rowHeight,
    this.borderWidth,
    this.borderRadius,
    this.useAppTheme = true,
    this.useCustomColors = false,
  });

  /// Get table background color based on configuration
  Color getTableBackgroundColor(ThemeData theme) {
    if (useCustomColors && tableBackgroundColor != null) {
      return tableBackgroundColor!;
    }

    if (useAppTheme) {
      return theme.colorScheme.surface;
    }

    return Colors.transparent;
  }

  /// Get header background color based on configuration
  Color getHeaderBackgroundColor(ThemeData theme) {
    if (useCustomColors && headerBackgroundColor != null) {
      return headerBackgroundColor!;
    }

    if (useAppTheme) {
      final isDark = theme.brightness == Brightness.dark;
      return isDark
          ? theme.colorScheme.surfaceVariant.withOpacity(0.3)
          : theme.colorScheme.surfaceVariant.withOpacity(0.1);
    }

    return Colors.grey[300]!;
  }

  /// Get row alternate color based on configuration
  Color getRowAlternateColor(ThemeData theme) {
    if (useCustomColors && rowAlternateColor != null) {
      return rowAlternateColor!;
    }

    if (useAppTheme) {
      final isDark = theme.brightness == Brightness.dark;
      return isDark
          ? theme.colorScheme.surfaceVariant.withOpacity(0.1)
          : theme.colorScheme.surfaceVariant.withOpacity(0.05);
    }

    return Colors.grey[100]!;
  }

  /// Get text color based on configuration
  Color getTextColor(ThemeData theme) {
    if (useCustomColors && textColor != null) {
      return textColor!;
    }

    if (useAppTheme) {
      return theme.colorScheme.onSurface;
    }

    return Colors.black87;
  }

  /// Get icon color based on configuration
  Color getIconColor(ThemeData theme) {
    if (useCustomColors && iconColor != null) {
      return iconColor!;
    }

    if (useAppTheme) {
      return theme.colorScheme.onSurfaceVariant;
    }

    return Colors.grey;
  }

  /// Get header text style based on configuration
  TextStyle getHeaderTextStyle(ThemeData theme) {
    if (headerTextStyle != null) {
      return headerTextStyle!;
    }

    if (useAppTheme) {
      return theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ) ??
          const TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
    }

    return const TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
  }

  /// Get row text style based on configuration
  TextStyle getRowTextStyle(ThemeData theme) {
    if (rowTextStyle != null) {
      return rowTextStyle!;
    }

    if (useAppTheme) {
      return theme.textTheme.bodyMedium ?? const TextStyle();
    }

    return const TextStyle();
  }

  /// Get pagination text style based on configuration
  TextStyle getPaginationTextStyle(ThemeData theme) {
    if (paginationTextStyle != null) {
      return paginationTextStyle!;
    }

    if (useAppTheme) {
      return theme.textTheme.bodyMedium ?? const TextStyle();
    }

    return const TextStyle();
  }

  /// Copy with method for easy modification
  TableThemeConfig copyWith({
    Color? headerBackgroundColor,
    Color? rowAlternateColor,
    Color? borderColor,
    Color? textColor,
    Color? iconColor,
    Color? tableBackgroundColor,
    TextStyle? headerTextStyle,
    TextStyle? rowTextStyle,
    TextStyle? paginationTextStyle,
    double? headerHeight,
    double? rowHeight,
    double? borderWidth,
    double? borderRadius,
    bool? useAppTheme,
    bool? useCustomColors,
  }) {
    return TableThemeConfig(
      headerBackgroundColor:
          headerBackgroundColor ?? this.headerBackgroundColor,
      rowAlternateColor: rowAlternateColor ?? this.rowAlternateColor,
      borderColor: borderColor ?? this.borderColor,
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
      tableBackgroundColor: tableBackgroundColor ?? this.tableBackgroundColor,
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
      rowTextStyle: rowTextStyle ?? this.rowTextStyle,
      paginationTextStyle: paginationTextStyle ?? this.paginationTextStyle,
      headerHeight: headerHeight ?? this.headerHeight,
      rowHeight: rowHeight ?? this.rowHeight,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      useAppTheme: useAppTheme ?? this.useAppTheme,
      useCustomColors: useCustomColors ?? this.useCustomColors,
    );
  }
}

/// Predefined table theme configurations
class TableThemes {
  /// Default theme that respects app theme
  static const TableThemeConfig defaultTheme = TableThemeConfig(
    useAppTheme: true,
    useCustomColors: false,
  );

  /// Light theme with custom colors
  static const TableThemeConfig lightTheme = TableThemeConfig(
    useAppTheme: false,
    useCustomColors: true,
    headerBackgroundColor: Color(0xFFF5F5F5),
    rowAlternateColor: Color(0xFFFAFAFA),
    borderColor: Color(0xFFE0E0E0),
    textColor: Color(0xFF212121),
    iconColor: Color(0xFF757575),
    tableBackgroundColor: Color(0xFFFFFFFF),
  );

  /// Dark theme with custom colors
  static const TableThemeConfig darkTheme = TableThemeConfig(
    useAppTheme: false,
    useCustomColors: true,
    headerBackgroundColor: Color(0xFF424242),
    rowAlternateColor: Color(0xFF303030),
    borderColor: Color(0xFF616161),
    textColor: Color(0xFFE0E0E0),
    iconColor: Color(0xFFBDBDBD),
    tableBackgroundColor: Color(0xFF121212),
  );

  /// Material 3 theme that enhances app theme
  static const TableThemeConfig material3Theme = TableThemeConfig(
    useAppTheme: true,
    useCustomColors: false,
    borderRadius: 12.0,
    borderWidth: 1.0,
  );
}
