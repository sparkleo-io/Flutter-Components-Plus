import 'package:flutter/material.dart';
import 'models/switch_models.dart';

/// A toggle switch component that can switch between multiple states
class FCPToggleSwitch<T> extends StatefulWidget {
  /// List of available toggle states
  final List<ToggleState<T>> states;

  /// Currently active state
  final T? activeValue;

  /// Callback when state changes
  final ValueChanged<T?> onChanged;

  /// Whether the switch is enabled
  final bool enabled;

  /// Layout direction
  final Axis direction;

  /// Spacing between toggle options
  final double spacing;

  /// Whether to show labels
  final bool showLabels;

  /// Whether to show icons
  final bool showIcons;

  /// Switch width
  final double width;

  /// Switch height
  final double height;

  /// Switch border radius
  final double borderRadius;

  /// Animation duration
  final Duration animationDuration;

  /// Active background color
  final Color activeColor;

  /// Inactive background color
  final Color inactiveColor;

  /// Active text/icon color
  final Color activeTextColor;

  /// Inactive text/icon color
  final Color inactiveTextColor;

  /// Border color
  final Color borderColor;

  /// Border width
  final double borderWidth;

  /// Whether to show border
  final bool showBorder;

  /// Whether to show shadow
  final bool showShadow;

  /// Shadow color
  final Color shadowColor;

  /// Shadow blur radius
  final double shadowBlurRadius;

  /// Shadow offset
  final Offset shadowOffset;

  /// Text style for labels
  final TextStyle? textStyle;

  /// Text style for descriptions
  final TextStyle? descriptionStyle;

  /// Optional title for the toggle group
  final String? title;

  /// Optional subtitle for the toggle group
  final String? subtitle;

  const FCPToggleSwitch({
    Key? key,
    required this.states,
    this.activeValue,
    required this.onChanged,
    this.enabled = true,
    this.direction = Axis.horizontal,
    this.spacing = 8.0,
    this.showLabels = true,
    this.showIcons = true,
    this.width = 54.0,
    this.height = 28.0,
    this.borderRadius = 16.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.activeColor = const Color(0xFF007AFF),
    this.inactiveColor = const Color(0xFFE5E5E5),
    this.activeTextColor = Colors.white,
    this.inactiveTextColor = const Color(0xFF171717),
    this.borderColor = const Color(0xFFD4D4D4),
    this.borderWidth = 1.0,
    this.showBorder = true,
    this.showShadow = false,
    this.shadowColor = Colors.black26,
    this.shadowBlurRadius = 4.0,
    this.shadowOffset = const Offset(0, 2),
    this.textStyle,
    this.descriptionStyle,
    this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  State<FCPToggleSwitch<T>> createState() => _FCPToggleSwitchState<T>();
}

class _FCPToggleSwitchState<T> extends State<FCPToggleSwitch<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null || widget.subtitle != null) ...[
          _buildHeader(),
          const SizedBox(height: 16),
        ],
        _buildToggleGroup(),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null)
          Text(
            widget.title!,
            style:
                widget.textStyle?.copyWith(
                  color: widget.enabled
                      ? widget.inactiveTextColor
                      : widget.inactiveTextColor.withOpacity(0.5),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ) ??
                TextStyle(
                  color: widget.enabled
                      ? widget.inactiveTextColor
                      : widget.inactiveTextColor.withOpacity(0.5),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
          ),
        if (widget.subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            widget.subtitle!,
            style:
                widget.descriptionStyle?.copyWith(
                  color: widget.enabled
                      ? widget.inactiveTextColor.withOpacity(0.7)
                      : widget.inactiveTextColor.withOpacity(0.5),
                  fontSize: 14,
                ) ??
                TextStyle(
                  color: widget.enabled
                      ? widget.inactiveTextColor.withOpacity(0.7)
                      : widget.inactiveTextColor.withOpacity(0.5),
                  fontSize: 14,
                ),
          ),
        ],
      ],
    );
  }

  Widget _buildToggleGroup() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: widget.showBorder
            ? Border.all(color: widget.borderColor, width: widget.borderWidth)
            : null,
        color: widget.inactiveColor,
        boxShadow: widget.showShadow
            ? [
                BoxShadow(
                  color: widget.shadowColor,
                  blurRadius: widget.shadowBlurRadius,
                  offset: widget.shadowOffset,
                ),
              ]
            : null,
      ),
      child: widget.direction == Axis.horizontal
          ? Row(mainAxisSize: MainAxisSize.min, children: _buildToggleOptions())
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: _buildToggleOptions(),
            ),
    );
  }

  List<Widget> _buildToggleOptions() {
    return widget.states.map((state) {
      final isActive = widget.activeValue == state.value;
      final isEnabled = widget.enabled && state.enabled;

      return Expanded(
        child: GestureDetector(
          onTap: isEnabled ? () => widget.onChanged(state.value) : null,
          child: AnimatedContainer(
            duration: widget.animationDuration,
            padding: EdgeInsets.symmetric(
              horizontal: widget.spacing,
              vertical: widget.height * 0.2,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                widget.borderRadius - widget.borderWidth,
              ),
              color: isActive ? widget.activeColor : Colors.transparent,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.showIcons && state.icon != null) ...[
                  Icon(
                    state.icon,
                    color: isActive
                        ? widget.activeTextColor
                        : (isEnabled
                              ? widget.inactiveTextColor
                              : widget.inactiveTextColor.withOpacity(0.5)),
                    size: 20,
                  ),
                  if (widget.showLabels && state.label.isNotEmpty)
                    const SizedBox(height: 4),
                ],
                if (widget.showLabels && state.label.isNotEmpty)
                  Text(
                    state.label,
                    style:
                        widget.textStyle?.copyWith(
                          color: isActive
                              ? widget.activeTextColor
                              : (isEnabled
                                    ? widget.inactiveTextColor
                                    : widget.inactiveTextColor.withOpacity(
                                        0.5,
                                      )),
                          fontWeight: isActive
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ) ??
                        TextStyle(
                          color: isActive
                              ? widget.activeTextColor
                              : (isEnabled
                                    ? widget.inactiveTextColor
                                    : widget.inactiveTextColor.withOpacity(
                                        0.5,
                                      )),
                          fontSize: 14,
                          fontWeight: isActive
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                    textAlign: TextAlign.center,
                  ),
                if (state.description != null && widget.showLabels) ...[
                  const SizedBox(height: 2),
                  Text(
                    state.description!,
                    style:
                        widget.descriptionStyle?.copyWith(
                          color: isActive
                              ? widget.activeTextColor.withOpacity(0.8)
                              : (isEnabled
                                    ? widget.inactiveTextColor.withOpacity(0.7)
                                    : widget.inactiveTextColor.withOpacity(
                                        0.5,
                                      )),
                        ) ??
                        TextStyle(
                          color: isActive
                              ? widget.activeTextColor.withOpacity(0.8)
                              : (isEnabled
                                    ? widget.inactiveTextColor.withOpacity(0.7)
                                    : widget.inactiveTextColor.withOpacity(
                                        0.5,
                                      )),
                          fontSize: 10,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
      );
    }).toList();
  }
}
