import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

extension TableExtensions on int {
  Widget get spaceX => SizedBox(width: toDouble());
  Widget get spaceY => SizedBox(height: toDouble());
}

extension TableContextExtensions on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  double get kWidth => MediaQuery.of(this).size.width;

  Locale get locale => Localizations.localeOf(this);

  ThemeData get appTheme => Theme.of(this);
}

// Simple theme extension for table styling
class FCPTheme extends ThemeExtension<FCPTheme> {
  final Color? cardColor;
  final Color? primaryColor;
  final Color? secondaryColor;

  const FCPTheme({this.cardColor, this.primaryColor, this.secondaryColor});

  @override
  FCPTheme copyWith({
    Color? cardColor,
    Color? primaryColor,
    Color? secondaryColor,
  }) {
    return FCPTheme(
      cardColor: cardColor ?? this.cardColor,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
    );
  }

  @override
  FCPTheme lerp(ThemeExtension<FCPTheme>? other, double t) {
    if (other is! FCPTheme) {
      return this;
    }
    return FCPTheme(
      cardColor: Color.lerp(cardColor, other.cardColor, t),
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t),
    );
  }
}

// Simple text styles
class FCPStyles {
  static const TextStyle lgBoldStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}

// Simple progress indicator
class FCPProgressIndicator extends StatelessWidget {
  final bool isBusy;
  final LoaderType? loaderType;

  const FCPProgressIndicator(this.isBusy, {this.loaderType, super.key});

  @override
  Widget build(BuildContext context) {
    if (!isBusy) return const SizedBox.shrink();

    return const Center(child: CircularProgressIndicator());
  }
}

enum LoaderType { circular, linear }

// Simple card widget
class FCPTableCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double? elevation;

  const FCPTableCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: margin,
      elevation: elevation ?? theme.cardTheme.elevation ?? 2,
      color: color ?? theme.cardTheme.color,
      shape: theme.cardTheme.shape,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}

// Simple text field
class FCPTextField extends StatelessWidget {
  final String? hintText;
  final bool enableBorder;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  const FCPTextField({
    super.key,
    this.hintText,
    this.enableBorder = false,
    this.suffixIcon,
    this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        border: enableBorder ? const OutlineInputBorder() : null,
        enabledBorder: enableBorder ? const OutlineInputBorder() : null,
        focusedBorder: enableBorder ? const OutlineInputBorder() : null,
      ),
    );
  }
}

// Simple action button
class FCPActionButton extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const FCPActionButton({
    super.key,
    required this.child,
    this.onTap,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: child,
      style: IconButton.styleFrom(
        backgroundColor: backgroundColor ?? FCPColorScheme.primary,
        foregroundColor: foregroundColor ?? Colors.white,
      ),
    );
  }
}
