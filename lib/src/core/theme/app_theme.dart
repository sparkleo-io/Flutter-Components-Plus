import 'package:flutter/material.dart';
import 'color_scheme.dart';
import 'text_styles.dart';

/// App theme for the Flutter Components Plus package
class FCPAppTheme {
  FCPAppTheme._();

  /// Light theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: FCPColorScheme.primary,
        brightness: Brightness.light,
      ),
      textTheme: TextTheme(
        displayLarge: FCPTextStyles.displayLarge,
        displayMedium: FCPTextStyles.displayMedium,
        displaySmall: FCPTextStyles.displaySmall,
        headlineLarge: FCPTextStyles.headlineLarge,
        headlineMedium: FCPTextStyles.headlineMedium,
        headlineSmall: FCPTextStyles.headlineSmall,
        titleLarge: FCPTextStyles.titleLarge,
        titleMedium: FCPTextStyles.titleMedium,
        titleSmall: FCPTextStyles.titleSmall,
        bodyLarge: FCPTextStyles.bodyLarge,
        bodyMedium: FCPTextStyles.bodyMedium,
        bodySmall: FCPTextStyles.bodySmall,
        labelLarge: FCPTextStyles.labelLarge,
        labelMedium: FCPTextStyles.labelMedium,
        labelSmall: FCPTextStyles.labelSmall,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: FCPColorScheme.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: FCPColorScheme.primary,
          side: BorderSide(color: FCPColorScheme.primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: FCPColorScheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: FCPColorScheme.neutral300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: FCPColorScheme.neutral300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: FCPColorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: FCPColorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: FCPColorScheme.error, width: 2),
        ),
        filled: true,
        fillColor: FCPColorScheme.neutral50,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: FCPColorScheme.neutral200),
        ),
      ),
    );
  }

  /// Dark theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: FCPColorScheme.primaryLight,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: FCPColorScheme.darkBackground,
      textTheme: TextTheme(
        displayLarge: FCPTextStyles.displayLarge.copyWith(
          color: FCPColorScheme.darkOnBackground,
        ),
        displayMedium: FCPTextStyles.displayMedium.copyWith(
          color: FCPColorScheme.darkOnBackground,
        ),
        displaySmall: FCPTextStyles.displaySmall.copyWith(
          color: FCPColorScheme.darkOnBackground,
        ),
        headlineLarge: FCPTextStyles.headlineLarge.copyWith(
          color: FCPColorScheme.darkOnBackground,
        ),
        headlineMedium: FCPTextStyles.headlineMedium.copyWith(
          color: FCPColorScheme.darkOnBackground,
        ),
        headlineSmall: FCPTextStyles.headlineSmall.copyWith(
          color: FCPColorScheme.darkOnBackground,
        ),
        titleLarge: FCPTextStyles.titleLarge.copyWith(
          color: FCPColorScheme.darkOnBackground,
        ),
        titleMedium: FCPTextStyles.titleMedium.copyWith(
          color: FCPColorScheme.darkOnBackground,
        ),
        titleSmall: FCPTextStyles.titleSmall.copyWith(
          color: FCPColorScheme.darkOnBackground,
        ),
        bodyLarge: FCPTextStyles.bodyLarge.copyWith(
          color: FCPColorScheme.darkOnBackground,
        ),
        bodyMedium: FCPTextStyles.bodyMedium.copyWith(
          color: FCPColorScheme.darkOnBackground,
        ),
        bodySmall: FCPTextStyles.bodySmall.copyWith(
          color: FCPColorScheme.darkOnSurfaceVariant,
        ),
        labelLarge: FCPTextStyles.labelLarge.copyWith(
          color: FCPColorScheme.darkOnBackground,
        ),
        labelMedium: FCPTextStyles.labelMedium.copyWith(
          color: FCPColorScheme.darkOnSurfaceVariant,
        ),
        labelSmall: FCPTextStyles.labelSmall.copyWith(
          color: FCPColorScheme.darkOnSurfaceVariant,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: FCPColorScheme.primaryLight,
          foregroundColor: FCPColorScheme.darkBackground,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: FCPColorScheme.primaryLight,
          side: BorderSide(color: FCPColorScheme.primaryLight),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: FCPColorScheme.primaryLight,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: FCPColorScheme.neutral600),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: FCPColorScheme.neutral600),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: FCPColorScheme.primaryLight, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: FCPColorScheme.errorLight),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: FCPColorScheme.errorLight, width: 2),
        ),
        filled: true,
        fillColor: FCPColorScheme.darkSurface,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: FCPColorScheme.darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: FCPColorScheme.darkSurfaceVariant),
        ),
      ),
    );
  }
}
