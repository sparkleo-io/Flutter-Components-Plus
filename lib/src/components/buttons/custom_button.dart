import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../core/theme/color_scheme.dart';
import '../../core/theme/text_styles.dart';

/// Button variants
enum FCPButtonVariant { primary, secondary, outline, ghost, danger, floating }

/// Button sizes
enum FCPButtonSize { small, medium, large, extraLarge }

/// Button types
enum FCPButtonType {
  text,
  outlined,
  icon,
  iconWithText,
  floating,
  elevated,
  contained,
}

/// A highly customizable button widget with fluent API
class FCPButton extends StatefulWidget {
  const FCPButton._({
    super.key,
    this.text,
    this.onPressed,
    this.variant = FCPButtonVariant.primary,
    this.size = FCPButtonSize.medium,
    this.type = FCPButtonType.text,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.iconPosition = IconPosition.end,
    this.width,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderWidth = 0,
    this.textStyle,
    this.padding,
    this.margin,
    this.elevation,
    this.shadowColor,
    this.animationDuration,
    this.child,
  });

  // Fluent API constructors
  static const FCPButtonBuilder small = FCPButtonBuilder._(
    size: FCPButtonSize.small,
  );
  static const FCPButtonBuilder medium = FCPButtonBuilder._(
    size: FCPButtonSize.medium,
  );
  static const FCPButtonBuilder large = FCPButtonBuilder._(
    size: FCPButtonSize.large,
  );
  static const FCPButtonBuilder extraLarge = FCPButtonBuilder._(
    size: FCPButtonSize.extraLarge,
  );

  final String? text;
  final VoidCallback? onPressed;
  final FCPButtonVariant variant;
  final FCPButtonSize size;
  final FCPButtonType type;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;
  final IconPosition iconPosition;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double borderWidth;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  final Color? shadowColor;
  final Duration? animationDuration;
  final Widget? child;

  @override
  State<FCPButton> createState() => _FCPButtonState();
}

/// Builder class for fluent API
class FCPButtonBuilder {
  const FCPButtonBuilder._({required this.size});

  final FCPButtonSize size;

  // Primary buttons
  FCPButton primary({
    Key? key,
    String? text,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    IconData? icon,
    IconPosition iconPosition = IconPosition.end,
    double? width,
    double? height,
    double? borderRadius,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    double borderWidth = 0,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? elevation,
    Color? shadowColor,
    Duration? animationDuration,
    Widget? child,
  }) {
    return FCPButton._(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: FCPButtonVariant.primary,
      size: size,
      type: _determineType(text, icon),
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      iconPosition: iconPosition,
      width: width,
      height: height,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      textStyle: textStyle,
      padding: padding,
      margin: margin,
      elevation: elevation,
      shadowColor: shadowColor,
      animationDuration: animationDuration,
      child: child,
    );
  }

  // Secondary buttons
  FCPButton secondary({
    Key? key,
    String? text,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    IconData? icon,
    IconPosition iconPosition = IconPosition.end,
    double? width,
    double? height,
    double? borderRadius,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    double borderWidth = 0,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? elevation,
    Color? shadowColor,
    Duration? animationDuration,
    Widget? child,
  }) {
    return FCPButton._(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: FCPButtonVariant.secondary,
      size: size,
      type: _determineType(text, icon),
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      iconPosition: iconPosition,
      width: width,
      height: height,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      textStyle: textStyle,
      padding: padding,
      margin: margin,
      elevation: elevation,
      shadowColor: shadowColor,
      animationDuration: animationDuration,
      child: child,
    );
  }

  // Outlined buttons
  FCPButton outlined({
    Key? key,
    String? text,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    IconData? icon,
    IconPosition iconPosition = IconPosition.end,
    double? width,
    double? height,
    double? borderRadius,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    double borderWidth = 0,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? elevation,
    Color? shadowColor,
    Duration? animationDuration,
    Widget? child,
  }) {
    return FCPButton._(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: FCPButtonVariant.outline,
      size: size,
      type: _determineType(text, icon),
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      iconPosition: iconPosition,
      width: width,
      height: height,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      textStyle: textStyle,
      padding: padding,
      margin: margin,
      elevation: elevation,
      shadowColor: shadowColor,
      animationDuration: animationDuration,
      child: child,
    );
  }

  // Ghost buttons
  FCPButton ghost({
    Key? key,
    String? text,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    IconData? icon,
    IconPosition iconPosition = IconPosition.end,
    double? width,
    double? height,
    double? borderRadius,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    double borderWidth = 0,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? elevation,
    Color? shadowColor,
    Duration? animationDuration,
    Widget? child,
  }) {
    return FCPButton._(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: FCPButtonVariant.ghost,
      size: size,
      type: _determineType(text, icon),
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      iconPosition: iconPosition,
      width: width,
      height: height,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      textStyle: textStyle,
      padding: padding,
      margin: margin,
      elevation: elevation,
      shadowColor: shadowColor,
      animationDuration: animationDuration,
      child: child,
    );
  }

  // Danger buttons
  FCPButton danger({
    Key? key,
    String? text,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    IconData? icon,
    IconPosition iconPosition = IconPosition.end,
    double? width,
    double? height,
    double? borderRadius,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    double borderWidth = 0,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? elevation,
    Color? shadowColor,
    Duration? animationDuration,
    Widget? child,
  }) {
    return FCPButton._(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: FCPButtonVariant.danger,
      size: size,
      type: _determineType(text, icon),
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      iconPosition: iconPosition,
      width: width,
      height: height,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      textStyle: textStyle,
      padding: padding,
      margin: margin,
      elevation: elevation,
      shadowColor: shadowColor,
      animationDuration: animationDuration,
      child: child,
    );
  }

  // Icon buttons
  FCPButton iconButton({
    Key? key,
    required IconData icon,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    double? width,
    double? height,
    double? borderRadius,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    double borderWidth = 0,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? elevation,
    Color? shadowColor,
    Duration? animationDuration,
  }) {
    return FCPButton._(
      key: key,
      text: null,
      onPressed: onPressed,
      variant: FCPButtonVariant.primary,
      size: size,
      type: FCPButtonType.icon,
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      iconPosition: IconPosition.start,
      width: width,
      height: height,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      padding: padding,
      margin: margin,
      elevation: elevation,
      shadowColor: shadowColor,
      animationDuration: animationDuration,
    );
  }

  // Floating action buttons
  FCPButton floating({
    Key? key,
    String? text,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    IconData? icon,
    double? width,
    double? height,
    double? borderRadius,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    double borderWidth = 0,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? elevation,
    Color? shadowColor,
    Duration? animationDuration,
    Widget? child,
  }) {
    return FCPButton._(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: FCPButtonVariant.floating,
      size: size,
      type: FCPButtonType.floating,
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      iconPosition: IconPosition.start,
      width: width,
      height: height,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      textStyle: textStyle,
      padding: padding,
      margin: margin,
      elevation: elevation,
      shadowColor: shadowColor,
      animationDuration: animationDuration,
      child: child,
    );
  }

  // Elevated buttons
  FCPButton elevated({
    Key? key,
    String? text,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    IconData? icon,
    IconPosition iconPosition = IconPosition.end,
    double? width,
    double? height,
    double? borderRadius,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    double borderWidth = 0,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? elevation,
    Color? shadowColor,
    Duration? animationDuration,
    Widget? child,
  }) {
    return FCPButton._(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: FCPButtonVariant.primary,
      size: size,
      type: FCPButtonType.elevated,
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      iconPosition: iconPosition,
      width: width,
      height: height,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      textStyle: textStyle,
      padding: padding,
      margin: margin,
      elevation: elevation ?? 4.0,
      shadowColor: shadowColor,
      animationDuration: animationDuration,
      child: child,
    );
  }

  // Contained buttons
  FCPButton contained({
    Key? key,
    String? text,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    IconData? icon,
    IconPosition iconPosition = IconPosition.end,
    double? width,
    double? height,
    double? borderRadius,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    double borderWidth = 0,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? elevation,
    Color? shadowColor,
    Duration? animationDuration,
    Widget? child,
  }) {
    return FCPButton._(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: FCPButtonVariant.primary,
      size: size,
      type: FCPButtonType.contained,
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      iconPosition: iconPosition,
      width: width,
      height: height,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      textStyle: textStyle,
      padding: padding,
      margin: margin,
      elevation: elevation,
      shadowColor: shadowColor,
      animationDuration: animationDuration,
      child: child,
    );
  }

  FCPButtonType _determineType(String? text, IconData? icon) {
    if (text != null && icon != null) {
      return FCPButtonType.iconWithText;
    } else if (icon != null) {
      return FCPButtonType.icon;
    } else {
      return FCPButtonType.text;
    }
  }
}

class _FCPButtonState extends State<FCPButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration ?? FCPConstants.durationFast,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.isDisabled || widget.isLoading;
    final buttonSize = _getButtonSize();

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: _buildButtonContent(buttonSize, isDisabled),
        );
      },
    );
  }

  Widget _buildButtonContent(ButtonSize buttonSize, bool isDisabled) {
    switch (widget.type) {
      case FCPButtonType.floating:
        return _buildFloatingButton(buttonSize, isDisabled);
      case FCPButtonType.icon:
        return _buildIconButton(buttonSize, isDisabled);
      case FCPButtonType.iconWithText:
        return _buildIconWithTextButton(buttonSize, isDisabled);
      case FCPButtonType.text:
      case FCPButtonType.outlined:
      case FCPButtonType.elevated:
      case FCPButtonType.contained:
        return _buildStandardButton(buttonSize, isDisabled);
    }
  }

  Widget _buildStandardButton(ButtonSize buttonSize, bool isDisabled) {
    return Container(
      width: widget.width,
      height: widget.height ?? buttonSize.height,
      margin: widget.margin,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isDisabled ? null : _handleTap,
          borderRadius: BorderRadius.circular(
            widget.borderRadius ?? buttonSize.borderRadius,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: _getBackgroundColor(),
              borderRadius: BorderRadius.circular(
                widget.borderRadius ?? buttonSize.borderRadius,
              ),
              border: _getBorder(),
              boxShadow: widget.elevation != null
                  ? [
                      BoxShadow(
                        color:
                            widget.shadowColor ?? Colors.black.withValues(alpha: 0.1),
                        blurRadius: widget.elevation!,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Padding(
              padding: widget.padding ?? buttonSize.padding,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.icon != null &&
                      widget.iconPosition == IconPosition.start)
                    _buildIcon(),
                  if (widget.icon != null &&
                      widget.iconPosition == IconPosition.start)
                    const SizedBox(width: 8),
                  if (widget.isLoading)
                    _buildLoadingIndicator()
                  else if (widget.text != null)
                    _buildContent()
                  else if (widget.icon != null && widget.text == null)
                    _buildIcon(),
                  if (widget.icon != null &&
                      widget.iconPosition == IconPosition.end &&
                      widget.text != null)
                    const SizedBox(width: 8),
                  if (widget.icon != null &&
                      widget.iconPosition == IconPosition.end &&
                      widget.text != null)
                    _buildIcon(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(ButtonSize buttonSize, bool isDisabled) {
    final buttonSizeValue = widget.width ?? widget.height ?? buttonSize.height;

    return Container(
      width: buttonSizeValue,
      height: buttonSizeValue,
      margin: widget.margin,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isDisabled ? null : _handleTap,
          borderRadius: BorderRadius.circular(
            widget.borderRadius ?? buttonSize.borderRadius,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: _getBackgroundColor(),
              borderRadius: BorderRadius.circular(
                widget.borderRadius ?? buttonSize.borderRadius,
              ),
              border: _getBorder(),
              boxShadow: widget.elevation != null
                  ? [
                      BoxShadow(
                        color:
                            widget.shadowColor ?? Colors.black.withValues(alpha: 0.1),
                        blurRadius: widget.elevation!,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: widget.isLoading
                  ? _buildLoadingIndicator()
                  : (widget.icon != null ? _buildIcon() : const SizedBox()),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingButton(ButtonSize buttonSize, bool isDisabled) {
    return Container(
      width: widget.width,
      height: widget.height ?? buttonSize.height,
      margin: widget.margin,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isDisabled ? null : _handleTap,
          borderRadius: BorderRadius.circular(
            widget.borderRadius ?? buttonSize.borderRadius,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: _getBackgroundColor(),
              borderRadius: BorderRadius.circular(
                widget.borderRadius ?? buttonSize.borderRadius,
              ),
              border: _getBorder(),
              boxShadow: widget.elevation != null
                  ? [
                      BoxShadow(
                        color:
                            widget.shadowColor ??
                            Colors.black.withValues(alpha: 0.15),
                        blurRadius: widget.elevation!,
                        offset: const Offset(0, 4),
                        spreadRadius: 1,
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                        spreadRadius: 1,
                      ),
                    ],
            ),
            child: Padding(
              padding: widget.padding ?? buttonSize.padding,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.icon != null) _buildIcon(),
                  if (widget.icon != null && widget.text != null)
                    const SizedBox(width: 8),
                  if (widget.isLoading)
                    _buildLoadingIndicator()
                  else if (widget.text != null)
                    _buildContent(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconWithTextButton(ButtonSize buttonSize, bool isDisabled) {
    return _buildStandardButton(buttonSize, isDisabled);
  }

  Widget _buildContent() {
    if (widget.child != null) {
      return widget.child!;
    }

    return Text(
      widget.text ?? '',
      style: widget.textStyle ?? _getTextStyle(),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildIcon() {
    return Icon(
      widget.icon,
      size: _getIconSize(),
      color: widget.foregroundColor ?? _getForegroundColor(),
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: _getIconSize(),
      height: _getIconSize(),
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          widget.foregroundColor ?? _getForegroundColor(),
        ),
      ),
    );
  }

  void _handleTap() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
    widget.onPressed?.call();
  }

  ButtonSize _getButtonSize() {
    switch (widget.size) {
      case FCPButtonSize.small:
        return ButtonSize(
          height: FCPConstants.buttonHeightSm,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          borderRadius: FCPConstants.radiusSm,
          fontSize: FCPConstants.fontSizeSm,
        );
      case FCPButtonSize.medium:
        return ButtonSize(
          height: FCPConstants.buttonHeightMd,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          borderRadius: FCPConstants.radiusMd,
          fontSize: FCPConstants.fontSizeMd,
        );
      case FCPButtonSize.large:
        return ButtonSize(
          height: FCPConstants.buttonHeightLg,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          borderRadius: FCPConstants.radiusLg,
          fontSize: FCPConstants.fontSizeLg,
        );
      case FCPButtonSize.extraLarge:
        return ButtonSize(
          height: FCPConstants.buttonHeightXl,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          borderRadius: FCPConstants.radiusXl,
          fontSize: FCPConstants.fontSizeXl,
        );
    }
  }

  TextStyle _getTextStyle() {
    final buttonSize = _getButtonSize();
    return FCPTextStyles.getBodyMedium(
      color: widget.foregroundColor ?? _getForegroundColor(),
    ).copyWith(fontSize: buttonSize.fontSize, fontWeight: FontWeight.w600);
  }

  Color _getForegroundColor() {
    switch (widget.variant) {
      case FCPButtonVariant.primary:
      case FCPButtonVariant.secondary:
      case FCPButtonVariant.danger:
      case FCPButtonVariant.floating:
        return Colors.white;
      case FCPButtonVariant.outline:
      case FCPButtonVariant.ghost:
        return FCPColorScheme.primary;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case FCPButtonSize.small:
        return 16;
      case FCPButtonSize.medium:
        return 18;
      case FCPButtonSize.large:
        return 20;
      case FCPButtonSize.extraLarge:
        return 22;
    }
  }

  Color _getBackgroundColor() {
    final isDisabled = widget.isDisabled || widget.isLoading;
    final opacity = isDisabled ? 0.5 : 1.0;

    switch (widget.variant) {
      case FCPButtonVariant.primary:
        return (widget.backgroundColor ?? FCPColorScheme.primary).withValues(alpha: 
          opacity,
        );
      case FCPButtonVariant.secondary:
        return (widget.backgroundColor ?? FCPColorScheme.secondary).withValues(alpha: 
          opacity,
        );
      case FCPButtonVariant.outline:
      case FCPButtonVariant.ghost:
        return (widget.backgroundColor ?? Colors.transparent).withValues(alpha: 
          opacity,
        );
      case FCPButtonVariant.danger:
        return (widget.backgroundColor ?? FCPColorScheme.error).withValues(alpha: 
          opacity,
        );
      case FCPButtonVariant.floating:
        return (widget.backgroundColor ?? FCPColorScheme.primary).withValues(alpha: 
          opacity,
        );
    }
  }

  Border? _getBorder() {
    final isDisabled = widget.isDisabled || widget.isLoading;
    final opacity = isDisabled ? 0.5 : 1.0;

    switch (widget.variant) {
      case FCPButtonVariant.outline:
        // Outlined buttons should always show a border, use default width of 1 if borderWidth is 0
        final borderWidth = widget.borderWidth > 0 ? widget.borderWidth : 1.0;
        return Border.all(
          color: (widget.borderColor ?? FCPColorScheme.primary).withValues(alpha: 
            opacity,
          ),
          width: borderWidth,
        );
      case FCPButtonVariant.primary:
      case FCPButtonVariant.secondary:
      case FCPButtonVariant.ghost:
      case FCPButtonVariant.danger:
      case FCPButtonVariant.floating:
        // Other variants only show border if borderWidth is greater than 0
        if (widget.borderWidth <= 0) {
          return null;
        }
        return Border.all(
          color: (widget.borderColor ?? FCPColorScheme.primary).withValues(alpha: 
            opacity,
          ),
          width: widget.borderWidth,
        );
    }
  }
}

/// Icon position enum
enum IconPosition { start, end }

/// Button size configuration
class ButtonSize {
  const ButtonSize({
    required this.height,
    required this.padding,
    required this.borderRadius,
    required this.fontSize,
  });

  final double height;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double fontSize;
}
