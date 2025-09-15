import 'package:flutter/material.dart';

/// Data model for toggle switch states
class ToggleState<T> {
  /// Value of this state
  final T value;

  /// Display label
  final String label;

  /// Optional description
  final String? description;

  /// Whether this state is enabled
  final bool enabled;

  /// Optional icon for this state
  final IconData? icon;

  /// Optional custom widget for this state
  final Widget? customWidget;

  const ToggleState({
    required this.value,
    required this.label,
    this.description,
    this.enabled = true,
    this.icon,
    this.customWidget,
  });

  /// Create a copy with modified properties
  ToggleState<T> copyWith({
    T? value,
    String? label,
    String? description,
    bool? enabled,
    IconData? icon,
    Widget? customWidget,
  }) {
    return ToggleState<T>(
      value: value ?? this.value,
      label: label ?? this.label,
      description: description ?? this.description,
      enabled: enabled ?? this.enabled,
      icon: icon ?? this.icon,
      customWidget: customWidget ?? this.customWidget,
    );
  }
}
