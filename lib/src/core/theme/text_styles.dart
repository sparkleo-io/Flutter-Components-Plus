import 'package:flutter/material.dart';
import '../constants.dart';
import 'color_scheme.dart';

/// Text styles for the Flutter Components Plus package
class FCPTextStyles {
  FCPTextStyles._();

  // Display Styles
  static TextStyle displayLarge = TextStyle(
    fontSize: FCPConstants.fontSizeXxxl + 8,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );

  static TextStyle displayMedium = TextStyle(
    fontSize: FCPConstants.fontSizeXxxl + 4,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.25,
  );

  static TextStyle displaySmall = TextStyle(
    fontSize: FCPConstants.fontSizeXxxl,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  // Headline Styles
  static TextStyle headlineLarge = TextStyle(
    fontSize: FCPConstants.fontSizeXxl + 2,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.25,
  );

  static TextStyle headlineMedium = TextStyle(
    fontSize: FCPConstants.fontSizeXxl,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  static TextStyle headlineSmall = TextStyle(
    fontSize: FCPConstants.fontSizeXl,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  // Title Styles
  static TextStyle titleLarge = TextStyle(
    fontSize: FCPConstants.fontSizeLg,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  static TextStyle titleMedium = TextStyle(
    fontSize: FCPConstants.fontSizeMd,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
  );

  static TextStyle titleSmall = TextStyle(
    fontSize: FCPConstants.fontSizeSm,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  // Body Styles
  static TextStyle bodyLarge = TextStyle(
    fontSize: FCPConstants.fontSizeLg,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.5,
  );

  static TextStyle bodyMedium = TextStyle(
    fontSize: FCPConstants.fontSizeMd,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.25,
  );

  static TextStyle bodySmall = TextStyle(
    fontSize: FCPConstants.fontSizeSm,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.4,
  );

  // Label Styles
  static TextStyle labelLarge = TextStyle(
    fontSize: FCPConstants.fontSizeMd,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static TextStyle labelMedium = TextStyle(
    fontSize: FCPConstants.fontSizeSm,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static TextStyle labelSmall = TextStyle(
    fontSize: FCPConstants.fontSizeXs,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  /// Get text styles with color
  static TextStyle getDisplayLarge({Color? color}) =>
      displayLarge.copyWith(color: color);

  static TextStyle getDisplayMedium({Color? color}) =>
      displayMedium.copyWith(color: color);

  static TextStyle getDisplaySmall({Color? color}) =>
      displaySmall.copyWith(color: color);

  static TextStyle getHeadlineLarge({Color? color}) =>
      headlineLarge.copyWith(color: color);

  static TextStyle getHeadlineMedium({Color? color}) =>
      headlineMedium.copyWith(color: color);

  static TextStyle getHeadlineSmall({Color? color}) =>
      headlineSmall.copyWith(color: color);

  static TextStyle getTitleLarge({Color? color}) =>
      titleLarge.copyWith(color: color);

  static TextStyle getTitleMedium({Color? color}) =>
      titleMedium.copyWith(color: color);

  static TextStyle getTitleSmall({Color? color}) =>
      titleSmall.copyWith(color: color);

  static TextStyle getBodyLarge({Color? color}) =>
      bodyLarge.copyWith(color: color);

  static TextStyle getBodyMedium({Color? color}) =>
      bodyMedium.copyWith(color: color);

  static TextStyle getBodySmall({Color? color}) =>
      bodySmall.copyWith(color: color);

  static TextStyle getLabelLarge({Color? color}) =>
      labelLarge.copyWith(color: color);

  static TextStyle getLabelMedium({Color? color}) =>
      labelMedium.copyWith(color: color);

  static TextStyle getLabelSmall({Color? color}) =>
      labelSmall.copyWith(color: color);
}
