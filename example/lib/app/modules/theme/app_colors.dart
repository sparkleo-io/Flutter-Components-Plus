import 'package:flutter/material.dart';

/// Example app color tokens for light and dark themes.
abstract final class AppColors {
  static const ColorScheme light = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF4F46E5),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFE0E7FF),
    onPrimaryContainer: Color(0xFF312E81),
    secondary: Color(0xFF0EA5E9),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFE0F2FE),
    onSecondaryContainer: Color(0xFF0C4A6E),
    tertiary: Color(0xFF8B5CF6),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFEDE9FE),
    onTertiaryContainer: Color(0xFF4C1D95),
    error: Color(0xFFDC2626),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFEE2E2),
    onErrorContainer: Color(0xFF7F1D1D),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF0F172A),
    surfaceContainerHighest: Color(0xFFF1F5F9),
    onSurfaceVariant: Color(0xFF64748B),
    outline: Color(0xFFCBD5E1),
    outlineVariant: Color(0xFFE2E8F0),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFF1E293B),
    onInverseSurface: Color(0xFFF8FAFC),
    inversePrimary: Color(0xFFA5B4FC),
    surfaceTint: Color(0xFF4F46E5),
  );

  static const ColorScheme dark = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF818CF8),
    onPrimary: Color(0xFF1E1B4B),
    primaryContainer: Color(0xFF3730A3),
    onPrimaryContainer: Color(0xFFE0E7FF),
    secondary: Color(0xFF38BDF8),
    onSecondary: Color(0xFF082F49),
    secondaryContainer: Color(0xFF0C4A6E),
    onSecondaryContainer: Color(0xFFE0F2FE),
    tertiary: Color(0xFFA78BFA),
    onTertiary: Color(0xFF2E1065),
    tertiaryContainer: Color(0xFF4C1D95),
    onTertiaryContainer: Color(0xFFEDE9FE),
    error: Color(0xFFF87171),
    onError: Color(0xFF450A0A),
    errorContainer: Color(0xFF7F1D1D),
    onErrorContainer: Color(0xFFFEE2E2),
    surface: Color(0xFF1E293B),
    onSurface: Color(0xFFF1F5F9),
    surfaceContainerHighest: Color(0xFF334155),
    onSurfaceVariant: Color(0xFF94A3B8),
    outline: Color(0xFF475569),
    outlineVariant: Color(0xFF334155),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFFF8FAFC),
    onInverseSurface: Color(0xFF0F172A),
    inversePrimary: Color(0xFF4F46E5),
    surfaceTint: Color(0xFF818CF8),
  );

  static const Color lightScaffold = Color(0xFFF8FAFC);
  static const Color darkScaffold = Color(0xFF0F172A);

  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
}
