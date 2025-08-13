import 'package:flutter/material.dart';

/// A unified card component with various factory constructors for different card types
class FCPCard extends StatelessWidget {
  /// Creates a basic customizable card
  const FCPCard({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.borderRadius = 12.0,
    this.elevation = 0.0,
    this.shadowColor,
    this.shadowOffset,
    this.shadowBlurRadius,
    this.shadowSpreadRadius,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
    this.width,
    this.height,
    this.gradient,
    this.border,
    this.shape,
    this.clipBehavior = Clip.none,
    this.semanticContainer = true,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.onHover,
    this.onFocusChange,
    this.focusNode,
    this.autofocus = false,
    this.statesController,
    this.isSemanticButton = false,
  }) : shadowType = null,
       gradientType = null,
       gradientColors = null,
       gradientStops = null,
       gradientBegin = Alignment.topLeft,
       gradientEnd = Alignment.bottomRight,
       gradientCenter = null,
       gradientRadius = 0.5,
       gradientTileMode = TileMode.clamp,
       gradientTransform = null,
       title = null,
       subtitle = null,
       content = null,
       leading = null,
       trailing = null,
       icon = null,
       iconColor = null,
       iconSize = 24.0,
       titleStyle = null,
       subtitleStyle = null,
       contentStyle = null,
       showDivider = true,
       dividerColor = null,
       dividerHeight = 1.0,
       spacing = 8.0,
       actions = null,
       actionAlignment = MainAxisAlignment.end,
       actionSpacing = 8.0,
       contentPadding = const EdgeInsets.only(bottom: 16.0);

  /// Creates a flat card without shadows
  const FCPCard.flat({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
    this.width,
    this.height,
    this.gradient,
    this.border,
    this.shape,
    this.clipBehavior = Clip.none,
    this.semanticContainer = true,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.onHover,
    this.onFocusChange,
    this.focusNode,
    this.autofocus = false,
    this.statesController,
    this.isSemanticButton = false,
  }) : elevation = 0.0,
       shadowColor = Colors.transparent,
       shadowOffset = null,
       shadowBlurRadius = null,
       shadowSpreadRadius = null,
       shadowType = null,
       gradientType = null,
       gradientColors = null,
       gradientStops = null,
       gradientBegin = Alignment.topLeft,
       gradientEnd = Alignment.bottomRight,
       gradientCenter = null,
       gradientRadius = 0.5,
       gradientTileMode = TileMode.clamp,
       gradientTransform = null,
       title = null,
       subtitle = null,
       content = null,
       leading = null,
       trailing = null,
       icon = null,
       iconColor = null,
       iconSize = 24.0,
       titleStyle = null,
       subtitleStyle = null,
       contentStyle = null,
       showDivider = true,
       dividerColor = null,
       dividerHeight = 1.0,
       spacing = 8.0,
       actions = null,
       actionAlignment = MainAxisAlignment.end,
       actionSpacing = 8.0,
       contentPadding = const EdgeInsets.only(bottom: 16.0);

  /// Creates a shaded card with predefined shadow styles
  const FCPCard.shaded({
    super.key,
    required this.child,
    this.shadowType = ShadowType.medium,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.borderRadius = 12.0,
    this.shadowColor,
    this.shadowOffset,
    this.shadowBlurRadius,
    this.shadowSpreadRadius,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
    this.width,
    this.height,
    this.gradient,
    this.border,
    this.shape,
    this.clipBehavior = Clip.none,
    this.semanticContainer = true,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.onHover,
    this.onFocusChange,
    this.focusNode,
    this.autofocus = false,
    this.statesController,
    this.isSemanticButton = false,
  }) : elevation = 0.0,
       gradientType = null,
       gradientColors = null,
       gradientStops = null,
       gradientBegin = Alignment.topLeft,
       gradientEnd = Alignment.bottomRight,
       gradientCenter = null,
       gradientRadius = 0.5,
       gradientTileMode = TileMode.clamp,
       gradientTransform = null,
       title = null,
       subtitle = null,
       content = null,
       leading = null,
       trailing = null,
       icon = null,
       iconColor = null,
       iconSize = 24.0,
       titleStyle = null,
       subtitleStyle = null,
       contentStyle = null,
       showDivider = true,
       dividerColor = null,
       dividerHeight = 1.0,
       spacing = 8.0,
       actions = null,
       actionAlignment = MainAxisAlignment.end,
       actionSpacing = 8.0,
       contentPadding = const EdgeInsets.only(bottom: 16.0);

  /// Creates a gradient card with various gradient styles
  const FCPCard.gradient({
    super.key,
    required this.child,
    this.gradientType = GradientType.linear,
    this.gradientColors,
    this.gradientStops,
    this.gradientBegin = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
    this.gradientCenter,
    this.gradientRadius = 0.5,
    this.gradientTileMode = TileMode.clamp,
    this.gradientTransform,
    this.borderColor,
    this.borderWidth = 1.0,
    this.borderRadius = 12.0,
    this.elevation = 0.0,
    this.shadowColor,
    this.shadowOffset,
    this.shadowBlurRadius,
    this.shadowSpreadRadius,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
    this.width,
    this.height,
    this.border,
    this.shape,
    this.clipBehavior = Clip.none,
    this.semanticContainer = true,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.onHover,
    this.onFocusChange,
    this.focusNode,
    this.autofocus = false,
    this.statesController,
    this.isSemanticButton = false,
  }) : backgroundColor = null,
       gradient = null,
       shadowType = null,
       title = null,
       subtitle = null,
       content = null,
       leading = null,
       trailing = null,
       icon = null,
       iconColor = null,
       iconSize = 24.0,
       titleStyle = null,
       subtitleStyle = null,
       contentStyle = null,
       showDivider = true,
       dividerColor = null,
       dividerHeight = 1.0,
       spacing = 8.0,
       actions = null,
       actionAlignment = MainAxisAlignment.end,
       actionSpacing = 8.0,
       contentPadding = const EdgeInsets.only(bottom: 16.0);

  /// Creates an info card for displaying structured information
  const FCPCard.info({
    super.key,
    this.title,
    this.subtitle,
    this.content,
    this.leading,
    this.trailing,
    this.icon,
    this.iconColor,
    this.iconSize = 24.0,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.borderRadius = 12.0,
    this.elevation = 0.0,
    this.shadowColor,
    this.shadowOffset,
    this.shadowBlurRadius,
    this.shadowSpreadRadius,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
    this.width,
    this.height,
    this.gradient,
    this.border,
    this.shape,
    this.clipBehavior = Clip.none,
    this.semanticContainer = true,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.onHover,
    this.onFocusChange,
    this.focusNode,
    this.autofocus = false,
    this.statesController,
    this.isSemanticButton = false,
    this.titleStyle,
    this.subtitleStyle,
    this.contentStyle,
    this.showDivider = true,
    this.dividerColor,
    this.dividerHeight = 1.0,
    this.spacing = 8.0,
  }) : child = null,
       shadowType = null,
       gradientType = null,
       gradientColors = null,
       gradientStops = null,
       gradientBegin = Alignment.topLeft,
       gradientEnd = Alignment.bottomRight,
       gradientCenter = null,
       gradientRadius = 0.5,
       gradientTileMode = TileMode.clamp,
       gradientTransform = null,
       actions = null,
       actionAlignment = MainAxisAlignment.end,
       actionSpacing = 8.0,
       contentPadding = const EdgeInsets.only(bottom: 16.0);

  /// Creates an action card for interactive actions
  const FCPCard.action({
    super.key,
    this.title,
    this.subtitle,
    this.content,
    this.leading,
    this.trailing,
    this.icon,
    this.iconColor,
    this.iconSize = 24.0,
    this.actions,
    this.actionAlignment = MainAxisAlignment.end,
    this.actionSpacing = 8.0,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.borderRadius = 12.0,
    this.elevation = 0.0,
    this.shadowColor,
    this.shadowOffset,
    this.shadowBlurRadius,
    this.shadowSpreadRadius,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
    this.width,
    this.height,
    this.gradient,
    this.border,
    this.shape,
    this.clipBehavior = Clip.none,
    this.semanticContainer = true,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.onHover,
    this.onFocusChange,
    this.focusNode,
    this.autofocus = false,
    this.statesController,
    this.isSemanticButton = false,
    this.titleStyle,
    this.subtitleStyle,
    this.contentStyle,
    this.showDivider = true,
    this.dividerColor,
    this.dividerHeight = 1.0,
    this.spacing = 8.0,
    this.contentPadding = const EdgeInsets.only(bottom: 16.0),
  }) : child = null,
       shadowType = null,
       gradientType = null,
       gradientColors = null,
       gradientStops = null,
       gradientBegin = Alignment.topLeft,
       gradientEnd = Alignment.bottomRight,
       gradientCenter = null,
       gradientRadius = 0.5,
       gradientTileMode = TileMode.clamp,
       gradientTransform = null;

  // Common properties
  final Widget? child;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final double borderRadius;
  final double elevation;
  final Color? shadowColor;
  final Offset? shadowOffset;
  final double? shadowBlurRadius;
  final double? shadowSpreadRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final Gradient? gradient;
  final BoxBorder? border;
  final OutlinedBorder? shape;
  final Clip clipBehavior;
  final bool semanticContainer;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDoubleTap;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final FocusNode? focusNode;
  final bool autofocus;
  final MaterialStatesController? statesController;
  final bool isSemanticButton;

  // Shaded card properties
  final ShadowType? shadowType;

  // Gradient card properties
  final GradientType? gradientType;
  final List<Color>? gradientColors;
  final List<double>? gradientStops;
  final AlignmentGeometry gradientBegin;
  final AlignmentGeometry gradientEnd;
  final AlignmentGeometry? gradientCenter;
  final double gradientRadius;
  final TileMode gradientTileMode;
  final GradientTransform? gradientTransform;

  // Info card properties
  final String? title;
  final String? subtitle;
  final String? content;
  final Widget? leading;
  final Widget? trailing;
  final IconData? icon;
  final Color? iconColor;
  final double iconSize;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final TextStyle? contentStyle;
  final bool showDivider;
  final Color? dividerColor;
  final double dividerHeight;
  final double spacing;

  // Action card properties
  final List<Widget>? actions;
  final MainAxisAlignment actionAlignment;
  final double actionSpacing;
  final EdgeInsetsGeometry contentPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Determine effective properties based on card type
    final effectiveProperties = _getEffectiveProperties(context, theme);

    // Build the appropriate content
    final contentWidget = _buildContent(context, theme);

    // Create the card container
    Widget cardWidget = Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: effectiveProperties.backgroundColor,
        gradient: effectiveProperties.gradient,
        borderRadius: shape == null
            ? BorderRadius.circular(borderRadius)
            : null,
        border: effectiveProperties.border,
        boxShadow: effectiveProperties.boxShadow,
      ),
      child: ClipRRect(
        borderRadius: shape == null
            ? BorderRadius.circular(borderRadius)
            : BorderRadius.zero,
        child: Padding(padding: padding, child: contentWidget),
      ),
    );

    // Wrap with Material if needed for interactions
    if (onTap != null ||
        onLongPress != null ||
        onDoubleTap != null ||
        onHover != null ||
        onFocusChange != null ||
        focusNode != null) {
      cardWidget = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          onDoubleTap: onDoubleTap,
          onHover: onHover,
          onFocusChange: onFocusChange,
          focusNode: focusNode,
          autofocus: autofocus,
          statesController: statesController,
          borderRadius: shape == null
              ? BorderRadius.circular(borderRadius)
              : null,
          child: cardWidget,
        ),
      );
    }

    // Wrap with Semantics if needed
    if (isSemanticButton) {
      cardWidget = Semantics(button: true, child: cardWidget);
    }

    return cardWidget;
  }

  /// Get effective properties based on card type and theme
  _CardProperties _getEffectiveProperties(
    BuildContext context,
    ThemeData theme,
  ) {
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // Determine background color
    Color? effectiveBackgroundColor = backgroundColor;
    if (effectiveBackgroundColor == null &&
        gradient == null &&
        gradientType == null) {
      effectiveBackgroundColor = isDark
          ? colorScheme.surface
          : colorScheme.surface;
    }

    // Determine border
    BoxBorder? effectiveBorder = border;
    if (effectiveBorder == null && (borderColor != null || borderWidth > 0)) {
      final effectiveBorderColor =
          borderColor ??
          (isDark
              ? colorScheme.outline.withOpacity(0.2)
              : colorScheme.outline.withOpacity(0.1));
      effectiveBorder = Border.all(
        color: effectiveBorderColor,
        width: borderWidth,
      );
    }

    // Determine gradient
    Gradient? effectiveGradient = gradient;
    if (effectiveGradient == null && gradientType != null) {
      final colors =
          gradientColors ?? _getDefaultGradientColors(gradientType!, theme);
      effectiveGradient = _createGradient(colors);
    }

    // Determine shadow properties
    List<BoxShadow>? effectiveBoxShadow;
    if (shadowType != null) {
      final shadowProps = _getShadowProperties(shadowType!, isDark);
      effectiveBoxShadow = [
        BoxShadow(
          color: shadowColor ?? shadowProps.shadowColor,
          offset: shadowOffset ?? shadowProps.shadowOffset,
          blurRadius: shadowBlurRadius ?? shadowProps.shadowBlurRadius,
          spreadRadius: shadowSpreadRadius ?? shadowProps.shadowSpreadRadius,
        ),
      ];
    } else if (elevation > 0 || shadowBlurRadius != null) {
      final effectiveShadowColor =
          shadowColor ??
          (isDark
              ? Colors.black.withOpacity(0.3)
              : Colors.black.withOpacity(0.1));
      effectiveBoxShadow = [
        BoxShadow(
          color: effectiveShadowColor,
          offset: shadowOffset ?? Offset(0, elevation),
          blurRadius: shadowBlurRadius ?? elevation * 2,
          spreadRadius: shadowSpreadRadius ?? 0,
        ),
      ];
    }

    return _CardProperties(
      backgroundColor: effectiveBackgroundColor,
      gradient: effectiveGradient,
      border: effectiveBorder,
      boxShadow: effectiveBoxShadow,
    );
  }

  /// Build the appropriate content based on card type
  Widget _buildContent(BuildContext context, ThemeData theme) {
    if (child != null) {
      return child!;
    }

    if (title != null ||
        subtitle != null ||
        content != null ||
        icon != null ||
        leading != null ||
        trailing != null) {
      return _buildInfoContent(context, theme);
    }

    if (actions != null && actions!.isNotEmpty) {
      return _buildActionContent(context, theme);
    }

    return const SizedBox.shrink();
  }

  /// Build info card content
  Widget _buildInfoContent(BuildContext context, ThemeData theme) {
    final colorScheme = theme.colorScheme;
    final effectiveIconColor = iconColor ?? colorScheme.primary;
    final children = <Widget>[];

    // Add leading widget if provided
    if (leading != null) {
      children.add(leading!);
      children.add(SizedBox(width: spacing));
    }

    // Add icon if provided
    if (icon != null) {
      children.add(Icon(icon, color: effectiveIconColor, size: iconSize));
      children.add(SizedBox(width: spacing));
    }

    // Add text content
    final textContent = <Widget>[];

    // Add title if provided
    if (title != null) {
      textContent.add(
        Text(
          title!,
          style:
              titleStyle ??
              theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      );
      if (subtitle != null || content != null) {
        textContent.add(SizedBox(height: spacing / 2));
      }
    }

    // Add subtitle if provided
    if (subtitle != null) {
      textContent.add(
        Text(
          subtitle!,
          style:
              subtitleStyle ??
              theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodySmall?.color,
              ),
        ),
      );
      if (content != null) {
        textContent.add(SizedBox(height: spacing / 2));
      }
    }

    // Add content if provided
    if (content != null) {
      textContent.add(
        Text(content!, style: contentStyle ?? theme.textTheme.bodyMedium),
      );
    }

    // Add text content to children
    if (textContent.isNotEmpty) {
      children.add(
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: textContent,
          ),
        ),
      );
    }

    // Add trailing widget if provided
    if (trailing != null) {
      children.add(SizedBox(width: spacing));
      children.add(trailing!);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  /// Build action card content
  Widget _buildActionContent(BuildContext context, ThemeData theme) {
    final children = <Widget>[];

    // Build the main content section
    final mainContent = _buildInfoContent(context, theme);
    if (title != null ||
        subtitle != null ||
        content != null ||
        icon != null ||
        leading != null ||
        trailing != null) {
      children.add(Padding(padding: contentPadding, child: mainContent));
    }

    // Add divider if needed
    if (showDivider &&
        actions != null &&
        actions!.isNotEmpty &&
        (title != null ||
            subtitle != null ||
            content != null ||
            icon != null ||
            leading != null ||
            trailing != null)) {
      final colorScheme = theme.colorScheme;
      final effectiveDividerColor =
          dividerColor ??
          (theme.brightness == Brightness.dark
              ? colorScheme.outline.withOpacity(0.2)
              : colorScheme.outline.withOpacity(0.1));
      children.add(
        Divider(
          color: effectiveDividerColor,
          height: dividerHeight,
          thickness: dividerHeight,
        ),
      );
    }

    // Add actions if provided
    if (actions != null && actions!.isNotEmpty) {
      children.add(
        Row(
          mainAxisAlignment: actionAlignment,
          children: _buildActionsWithSpacing(),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  /// Build actions with spacing
  List<Widget> _buildActionsWithSpacing() {
    if (actions == null || actions!.isEmpty) {
      return [];
    }

    final widgets = <Widget>[];
    for (int i = 0; i < actions!.length; i++) {
      widgets.add(actions![i]);
      if (i < actions!.length - 1) {
        widgets.add(SizedBox(width: actionSpacing));
      }
    }
    return widgets;
  }

  /// Get default gradient colors based on type and theme
  List<Color> _getDefaultGradientColors(GradientType type, ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;

    switch (type) {
      case GradientType.linear:
      case GradientType.radial:
      case GradientType.sweep:
        return [colorScheme.primary, colorScheme.secondary];
      case GradientType.primary:
        return [colorScheme.primary, colorScheme.primaryContainer];
      case GradientType.secondary:
        return [colorScheme.secondary, colorScheme.secondaryContainer];
      case GradientType.success:
        return isDark
            ? [const Color(0xFF34C759), const Color(0xFF2A9F47)]
            : [const Color(0xFF34C759), const Color(0xFF6DD983)];
      case GradientType.warning:
        return isDark
            ? [const Color(0xFFFF9500), const Color(0xFFCC7700)]
            : [const Color(0xFFFF9500), const Color(0xFFFFB340)];
      case GradientType.error:
        return isDark
            ? [const Color(0xFFFF3B30), const Color(0xFFCC2E26)]
            : [const Color(0xFFFF3B30), const Color(0xFFFF6B61)];
      case GradientType.neutral:
        return isDark
            ? [const Color(0xFF404040), const Color(0xFF262626)]
            : [const Color(0xFFF5F5F5), const Color(0xFFE5E5E5)];
      case GradientType.sunset:
        return [
          const Color(0xFFFF6B6B),
          const Color(0xFFFFE66D),
          const Color(0xFFFF8E53),
        ];
      case GradientType.ocean:
        return [const Color(0xFF667eea), const Color(0xFF764ba2)];
      case GradientType.forest:
        return [const Color(0xFF11998e), const Color(0xFF38ef7d)];
      case GradientType.fire:
        return [const Color(0xFFf093fb), const Color(0xFFf5576c)];
      case GradientType.custom:
        return [colorScheme.primary, colorScheme.secondary];
    }
  }

  /// Create gradient based on type
  Gradient _createGradient(List<Color> colors) {
    switch (gradientType!) {
      case GradientType.linear:
        return LinearGradient(
          colors: colors,
          stops: gradientStops,
          begin: gradientBegin,
          end: gradientEnd,
          tileMode: gradientTileMode,
          transform: gradientTransform,
        );
      case GradientType.radial:
        return RadialGradient(
          colors: colors,
          stops: gradientStops,
          center: gradientCenter ?? Alignment.center,
          radius: gradientRadius,
          tileMode: gradientTileMode,
          transform: gradientTransform,
        );
      case GradientType.sweep:
        return SweepGradient(
          colors: colors,
          stops: gradientStops,
          center: gradientCenter ?? Alignment.center,
          startAngle: 0.0,
          endAngle: 2 * 3.14159,
          tileMode: gradientTileMode,
          transform: gradientTransform,
        );
      default:
        return LinearGradient(
          colors: colors,
          stops: gradientStops,
          begin: gradientBegin,
          end: gradientEnd,
          tileMode: gradientTileMode,
          transform: gradientTransform,
        );
    }
  }

  /// Get shadow properties based on shadow type and theme
  _ShadowProperties _getShadowProperties(ShadowType type, bool isDark) {
    switch (type) {
      case ShadowType.none:
        return _ShadowProperties(
          elevation: 0,
          shadowColor: Colors.transparent,
          shadowOffset: Offset.zero,
          shadowBlurRadius: 0,
          shadowSpreadRadius: 0,
        );
      case ShadowType.small:
        return _ShadowProperties(
          elevation: 2,
          shadowColor: isDark
              ? Colors.black.withOpacity(0.4)
              : Colors.black.withOpacity(0.1),
          shadowOffset: const Offset(0, 1),
          shadowBlurRadius: 3,
          shadowSpreadRadius: 0,
        );
      case ShadowType.medium:
        return _ShadowProperties(
          elevation: 4,
          shadowColor: isDark
              ? Colors.black.withOpacity(0.5)
              : Colors.black.withOpacity(0.15),
          shadowOffset: const Offset(0, 2),
          shadowBlurRadius: 8,
          shadowSpreadRadius: 0,
        );
      case ShadowType.large:
        return _ShadowProperties(
          elevation: 8,
          shadowColor: isDark
              ? Colors.black.withOpacity(0.6)
              : Colors.black.withOpacity(0.2),
          shadowOffset: const Offset(0, 4),
          shadowBlurRadius: 16,
          shadowSpreadRadius: 0,
        );
      case ShadowType.extraLarge:
        return _ShadowProperties(
          elevation: 16,
          shadowColor: isDark
              ? Colors.black.withOpacity(0.7)
              : Colors.black.withOpacity(0.25),
          shadowOffset: const Offset(0, 8),
          shadowBlurRadius: 24,
          shadowSpreadRadius: 0,
        );
      case ShadowType.soft:
        return _ShadowProperties(
          elevation: 0,
          shadowColor: isDark
              ? Colors.black.withOpacity(0.3)
              : Colors.black.withOpacity(0.08),
          shadowOffset: const Offset(0, 1),
          shadowBlurRadius: 12,
          shadowSpreadRadius: 0,
        );
      case ShadowType.hard:
        return _ShadowProperties(
          elevation: 0,
          shadowColor: isDark
              ? Colors.black.withOpacity(0.8)
              : Colors.black.withOpacity(0.3),
          shadowOffset: const Offset(0, 2),
          shadowBlurRadius: 4,
          shadowSpreadRadius: 0,
        );
    }
  }
}

/// Shadow types for the FCPCard
enum ShadowType {
  /// No shadow
  none,

  /// Small shadow
  small,

  /// Medium shadow
  medium,

  /// Large shadow
  large,

  /// Extra large shadow
  extraLarge,

  /// Soft shadow (blurred)
  soft,

  /// Hard shadow (sharp)
  hard,
}

/// Gradient types for the FCPCard
enum GradientType {
  /// Linear gradient
  linear,

  /// Radial gradient
  radial,

  /// Sweep gradient
  sweep,

  /// Primary color gradient
  primary,

  /// Secondary color gradient
  secondary,

  /// Success color gradient
  success,

  /// Warning color gradient
  warning,

  /// Error color gradient
  error,

  /// Neutral color gradient
  neutral,

  /// Sunset color gradient
  sunset,

  /// Ocean color gradient
  ocean,

  /// Forest color gradient
  forest,

  /// Fire color gradient
  fire,

  /// Custom gradient
  custom,
}

/// Internal class for card properties
class _CardProperties {
  const _CardProperties({
    this.backgroundColor,
    this.gradient,
    this.border,
    this.boxShadow,
  });

  final Color? backgroundColor;
  final Gradient? gradient;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
}

/// Internal class for shadow properties
class _ShadowProperties {
  const _ShadowProperties({
    required this.elevation,
    required this.shadowColor,
    required this.shadowOffset,
    required this.shadowBlurRadius,
    required this.shadowSpreadRadius,
  });

  final double elevation;
  final Color shadowColor;
  final Offset shadowOffset;
  final double shadowBlurRadius;
  final double shadowSpreadRadius;
}
