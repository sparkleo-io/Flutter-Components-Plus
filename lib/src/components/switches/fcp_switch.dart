import 'package:flutter/material.dart';

/// A pure toggle switch widget without labels or text
class FCPSwitch extends StatefulWidget {
  /// Current value of the switch
  final bool value;

  /// Callback when the switch value changes
  final ValueChanged<bool> onChanged;

  /// Whether the switch is enabled
  final bool enabled;

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

  /// Thumb color when active
  final Color activeThumbColor;

  /// Thumb color when inactive
  final Color inactiveThumbColor;

  /// Border color
  final Color borderColor;

  /// Border width
  final double borderWidth;

  /// Thumb size
  final double thumbSize;

  /// Padding around the thumb
  final double thumbPadding;

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

  /// Custom widget to display instead of default thumb
  final Widget? customThumb;

  /// Custom widget to display when switch is active
  final Widget? activeWidget;

  /// Custom widget to display when switch is inactive
  final Widget? inactiveWidget;

  const FCPSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.width = 54.0,
    this.height = 28.0,
    this.borderRadius = 16.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.activeColor = const Color(0xFF007AFF),
    this.inactiveColor = const Color(0xFFE5E5E5),
    this.activeThumbColor = Colors.white,
    this.inactiveThumbColor = const Color(0xFF007AFF),
    this.borderColor = const Color(0xFFD4D4D4),
    this.borderWidth = 1.0,
    this.thumbSize = 20.0,
    this.thumbPadding = 4.0,
    this.showBorder = true,
    this.showShadow = false,
    this.shadowColor = Colors.black26,
    this.shadowBlurRadius = 4.0,
    this.shadowOffset = const Offset(0, 2),
    this.customThumb,
    this.activeWidget,
    this.inactiveWidget,
  });

  @override
  State<FCPSwitch> createState() => _FCPSwitchState();
}

class _FCPSwitchState extends State<FCPSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    if (widget.value) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(FCPSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (widget.value) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.enabled) {
      widget.onChanged(!widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: _handleTap, child: _buildSwitch());
  }

  Widget _buildSwitch() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: widget.height,
          width: widget.width,
          padding: EdgeInsets.all(widget.thumbPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: Color.lerp(
              widget.inactiveColor,
              widget.activeColor,
              _animation.value,
            ),
            border: widget.showBorder
                ? Border.all(
                    color: widget.borderColor,
                    width: widget.borderWidth,
                  )
                : null,
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
          child: Stack(
            children: [
              // Background widgets
              if (widget.activeWidget != null || widget.inactiveWidget != null)
                Positioned.fill(
                  child: AnimatedSwitcher(
                    duration: widget.animationDuration,
                    child: widget.value
                        ? (widget.activeWidget ?? const SizedBox.shrink())
                        : (widget.inactiveWidget ?? const SizedBox.shrink()),
                  ),
                ),
              // Thumb
              AnimatedAlign(
                duration: widget.animationDuration,
                alignment:
                    widget.value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  height: widget.thumbSize,
                  width: widget.thumbSize,
                  decoration: BoxDecoration(
                    color: Color.lerp(
                      widget.inactiveThumbColor,
                      widget.activeThumbColor,
                      _animation.value,
                    ),
                    shape: BoxShape.circle,
                    border: widget.showBorder
                        ? Border.all(
                            color: widget.borderColor,
                            width: widget.borderWidth,
                          )
                        : null,
                    boxShadow: widget.showShadow
                        ? [
                            BoxShadow(
                              color: widget.shadowColor.withValues(alpha: 0.3),
                              blurRadius: widget.shadowBlurRadius / 2,
                              offset: widget.shadowOffset,
                            ),
                          ]
                        : null,
                  ),
                  child: widget.customThumb,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
