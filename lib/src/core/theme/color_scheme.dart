import 'package:flutter/material.dart';

/// Custom color scheme for the Flutter Components Plus package
class FCPColorScheme {
  FCPColorScheme._();

  // Primary Colors
  static const Color primary = Color(0xFF007AFF);
  static const Color primaryLight = Color(0xFF4DA3FF);
  static const Color primaryDark = Color(0xFF0056B3);

  // Secondary Colors
  static const Color secondary = Color(0xFF5856D6);
  static const Color secondaryLight = Color(0xFF8A88E8);
  static const Color secondaryDark = Color(0xFF3D3B9E);

  // Success Colors
  static const Color success = Color(0xFF34C759);
  static const Color successLight = Color(0xFF6DD983);
  static const Color successDark = Color(0xFF2A9F47);

  // Warning Colors
  static const Color warning = Color(0xFFFF9500);
  static const Color warningLight = Color(0xFFFFB340);
  static const Color warningDark = Color(0xFFCC7700);

  // Error Colors
  static const Color error = Color(0xFFFF3B30);
  static const Color errorLight = Color(0xFFFF6B61);
  static const Color errorDark = Color(0xFFCC2E26);

  // Neutral Colors
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFE5E5E5);
  static const Color neutral300 = Color(0xFFD4D4D4);
  static const Color neutral400 = Color(0xFFA3A3A3);
  static const Color neutral500 = Color(0xFF737373);
  static const Color neutral600 = Color(0xFF525252);
  static const Color neutral700 = Color(0xFF404040);
  static const Color neutral800 = Color(0xFF262626);
  static const Color neutral900 = Color(0xFF171717);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkSurfaceVariant = Color(0xFF2D2D2D);
  static const Color darkOnBackground = Color(0xFFE1E1E1);
  static const Color darkOnSurface = Color(0xFFE1E1E1);
  static const Color darkOnSurfaceVariant = Color(0xFFB3B3B3);

  /// Get light theme colors
  static Map<String, Color> get lightColors => {
    'primary': primary,
    'primaryLight': primaryLight,
    'primaryDark': primaryDark,
    'secondary': secondary,
    'secondaryLight': secondaryLight,
    'secondaryDark': secondaryDark,
    'success': success,
    'successLight': successLight,
    'successDark': successDark,
    'warning': warning,
    'warningLight': warningLight,
    'warningDark': warningDark,
    'error': error,
    'errorLight': errorLight,
    'errorDark': errorDark,
    'background': Colors.white,
    'surface': Colors.white,
    'surfaceVariant': neutral100,
    'onBackground': neutral900,
    'onSurface': neutral900,
    'onSurfaceVariant': neutral600,
  };

  /// Get dark theme colors
  static Map<String, Color> get darkColors => {
    'primary': primaryLight,
    'primaryLight': primary,
    'primaryDark': primaryDark,
    'secondary': secondaryLight,
    'secondaryLight': secondary,
    'secondaryDark': secondaryDark,
    'success': successLight,
    'successLight': success,
    'successDark': successDark,
    'warning': warningLight,
    'warningLight': warning,
    'warningDark': warningDark,
    'error': errorLight,
    'errorLight': error,
    'errorDark': errorDark,
    'background': darkBackground,
    'surface': darkSurface,
    'surfaceVariant': darkSurfaceVariant,
    'onBackground': darkOnBackground,
    'onSurface': darkOnSurface,
    'onSurfaceVariant': darkOnSurfaceVariant,
  };
}
