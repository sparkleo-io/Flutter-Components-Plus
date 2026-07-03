import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Main Input Field Widget
class FCPInputField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final bool enabled;
  final String? errorText;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final EdgeInsetsGeometry? contentPadding;
  final double? borderRadius;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final double? borderWidth;
  final bool? showCursor;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Color? cursorErrorColor;
  final FocusNode? focusNode;
  final String obscuringCharacter;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function(PointerUpEvent)? onTapUpOutside;

  const FCPInputField({
    super.key,
    this.label,
    this.hint,
    this.initialValue,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.onSaved,
    this.enabled = true,
    this.errorText,
    this.labelStyle,
    this.hintStyle,
    this.border,
    this.focusedBorder,
    this.errorBorder,
    this.contentPadding,
    this.borderRadius,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.borderWidth,
    this.showCursor,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.cursorErrorColor,
    this.focusNode,
    this.obscuringCharacter = '•',
    this.onTapOutside,
    this.onTapUpOutside,
  });

  @override
  State<FCPInputField> createState() => _FCPInputFieldState();
}

class _FCPInputFieldState extends State<FCPInputField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.label!,
              style: widget.labelStyle ??
                  Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        TextFormField(
          controller: widget.controller,
          initialValue: widget.controller == null ? widget.initialValue : null,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          obscureText: _obscureText,
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          maxLines: _obscureText ? 1 : widget.maxLines,
          maxLength: widget.maxLength,
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
          enabled: widget.enabled,
          showCursor: widget.showCursor,
          cursorWidth: widget.cursorWidth,
          cursorHeight: widget.cursorHeight,
          cursorRadius: widget.cursorRadius,
          cursorColor: widget.cursorColor,
          focusNode: widget.focusNode,
          obscuringCharacter: widget.obscuringCharacter,
          onTapOutside: widget.onTapOutside ??
              (event) => FocusScope.of(context).unfocus(),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: widget.hintStyle,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : widget.suffixIcon,
            errorText: widget.errorText,
            border: widget.border ?? _getDefaultBorder(),
            focusedBorder:
                widget.focusedBorder ?? _getDefaultFocusedBorder(context),
            errorBorder: widget.errorBorder ?? _getDefaultErrorBorder(),
            contentPadding: widget.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
        ),
      ],
    );
  }

  // Helper methods for creating borders with custom parameters
  InputBorder _getDefaultBorder() {
    final radius = widget.borderRadius ?? 8.0;
    final color = widget.borderColor ?? Colors.grey;
    final width = widget.borderWidth ?? 1.0;

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  InputBorder _getDefaultFocusedBorder(BuildContext context) {
    final radius = widget.borderRadius ?? 8.0;
    final color = widget.focusedBorderColor ??
        widget.borderColor ??
        Theme.of(context).dividerColor;
    final width = widget.borderWidth ?? 2.0;

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  InputBorder _getDefaultErrorBorder() {
    final radius = widget.borderRadius ?? 8.0;
    final color = widget.errorBorderColor ?? Colors.red;
    final width = widget.borderWidth ?? 1.0;

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}

// Validation Helper Class
class FCPValidators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
      return 'Password must contain uppercase, lowercase, and number';
    }
    return null;
  }

  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? Function(String? value) minLength(int minLength) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'This field is required';
      }
      if (value.length < minLength) {
        return 'Must be at least $minLength characters';
      }
      return null;
    };
  }

  static String? Function(String? value) maxLength(int maxLength) {
    return (String? value) {
      if (value != null && value.length > maxLength) {
        return 'Must be no more than $maxLength characters';
      }
      return null;
    };
  }

  static String? numeric(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  static String? integer(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (int.tryParse(value) == null) {
      return 'Please enter a valid integer';
    }
    return null;
  }

  static String? phoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegExp = RegExp(r'^\+?[\d\s\-\(\)]+$');
    if (!phoneRegExp.hasMatch(value) || value.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
}

// Country Picker Widget (Simple implementation)
class FCPCountryPicker extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const FCPCountryPicker({
    super.key,
    this.label,
    this.hint,
    this.initialValue,
    this.onChanged,
    this.validator,
  });

  @override
  State<FCPCountryPicker> createState() => _FCPCountryPickerState();
}

class _FCPCountryPickerState extends State<FCPCountryPicker> {
  String? selectedCountry;
  final List<String> countries = [
    'Afghanistan',
    'Albania',
    'Algeria',
    'Argentina',
    'Australia',
    'Austria',
    'Bangladesh',
    'Belgium',
    'Brazil',
    'Canada',
    'China',
    'Denmark',
    'Egypt',
    'France',
    'Germany',
    'India',
    'Indonesia',
    'Italy',
    'Japan',
    'Malaysia',
    'Netherlands',
    'Norway',
    'Pakistan',
    'Philippines',
    'Russia',
    'Saudi Arabia',
    'Singapore',
    'South Africa',
    'Spain',
    'Sweden',
    'Switzerland',
    'Thailand',
    'Turkey',
    'United Kingdom',
    'United States',
    'Vietnam',
  ];

  @override
  void initState() {
    super.initState();
    selectedCountry = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.label!,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        DropdownButtonFormField<String>(
          initialValue: selectedCountry,
          hint: Text(widget.hint ?? 'Select Country'),
          validator: widget.validator,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
          ),
          items: countries.map((String country) {
            return DropdownMenuItem<String>(
              value: country,
              child: Text(country),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedCountry = newValue;
            });
            if (widget.onChanged != null && newValue != null) {
              widget.onChanged!(newValue);
            }
          },
        ),
      ],
    );
  }
}

// Main FCPInputFields class with static methods
class FCPInputFields {
  // Email Input Field
  static Widget email({
    String? label,
    String? hint,
    String? initialValue,
    TextEditingController? controller,
    String? Function(String?)? validator,
    Function(String)? onChanged,
    Function(String?)? onSaved,
    bool enabled = true,
    String? errorText,
    TextStyle? labelStyle,
    TextStyle? hintStyle,
    InputBorder? border,
    InputBorder? focusedBorder,
    InputBorder? errorBorder,
    EdgeInsetsGeometry? contentPadding,
    double? borderRadius,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    double? borderWidth,
    Widget? prefixIcon,
    Widget? suffixIcon,
    VoidCallback? onTap,
    bool readOnly = false,
    int? maxLines,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    bool? showCursor,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Color? cursorErrorColor,
    FocusNode? focusNode,
    String obscuringCharacter = '•',
    void Function(PointerDownEvent)? onTapOutside,
    void Function(PointerUpEvent)? onTapUpOutside,
  }) {
    return FCPInputField(
      label: label ?? 'Email',
      hint: hint ?? 'Enter your email address',
      initialValue: initialValue,
      controller: controller,
      validator: validator ?? FCPValidators.email,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: prefixIcon ?? const Icon(Icons.email_outlined),
      onChanged: onChanged,
      onSaved: onSaved,
      enabled: enabled,
      errorText: errorText,
      labelStyle: labelStyle,
      hintStyle: hintStyle,
      border: border,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      contentPadding: contentPadding,
      borderRadius: borderRadius,
      borderColor: borderColor,
      focusedBorderColor: focusedBorderColor,
      errorBorderColor: errorBorderColor,
      borderWidth: borderWidth,
      suffixIcon: suffixIcon,
      onTap: onTap,
      readOnly: readOnly,
      maxLines: maxLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      showCursor: showCursor,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      cursorRadius: cursorRadius,
      cursorColor: cursorColor,
      cursorErrorColor: cursorErrorColor,
      focusNode: focusNode,
      obscuringCharacter: obscuringCharacter,
      onTapOutside: onTapOutside,
      onTapUpOutside: onTapUpOutside,
    );
  }

  // Password Input Field
  static Widget password({
    String? label,
    String? hint,
    String? initialValue,
    TextEditingController? controller,
    String? Function(String?)? validator,
    Function(String)? onChanged,
    Function(String?)? onSaved,
    bool enabled = true,
    String? errorText,
    TextStyle? labelStyle,
    TextStyle? hintStyle,
    InputBorder? border,
    InputBorder? focusedBorder,
    InputBorder? errorBorder,
    EdgeInsetsGeometry? contentPadding,
    double? borderRadius,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    double? borderWidth,
    Widget? prefixIcon,
    Widget? suffixIcon,
    VoidCallback? onTap,
    bool readOnly = false,
    int? maxLines,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    bool obscureText = true,
    bool? showCursor,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Color? cursorErrorColor,
    FocusNode? focusNode,
    String obscuringCharacter = '•',
    void Function(PointerDownEvent)? onTapOutside,
    void Function(PointerUpEvent)? onTapUpOutside,
  }) {
    return FCPInputField(
      label: label ?? 'Password',
      hint: hint ?? 'Enter your password',
      initialValue: initialValue,
      controller: controller,
      validator: validator ?? FCPValidators.password,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText,
      prefixIcon: prefixIcon ?? const Icon(Icons.lock_outlined),
      onChanged: onChanged,
      onSaved: onSaved,
      enabled: enabled,
      errorText: errorText,
      labelStyle: labelStyle,
      hintStyle: hintStyle,
      border: border,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      contentPadding: contentPadding,
      borderRadius: borderRadius,
      borderColor: borderColor,
      focusedBorderColor: focusedBorderColor,
      errorBorderColor: errorBorderColor,
      borderWidth: borderWidth,
      suffixIcon: suffixIcon,
      onTap: onTap,
      readOnly: readOnly,
      maxLines: maxLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      showCursor: showCursor,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      cursorRadius: cursorRadius,
      cursorColor: cursorColor,
      cursorErrorColor: cursorErrorColor,
      focusNode: focusNode,
      obscuringCharacter: obscuringCharacter,
      onTapOutside: onTapOutside,
      onTapUpOutside: onTapUpOutside,
    );
  }

  // Text Input Field
  static Widget text({
    String? label,
    String? hint,
    String? initialValue,
    TextEditingController? controller,
    String? Function(String?)? validator,
    int? maxLines,
    int? maxLength,
    Function(String)? onChanged,
    Function(String?)? onSaved,
    bool enabled = true,
    String? errorText,
    TextStyle? labelStyle,
    TextStyle? hintStyle,
    InputBorder? border,
    InputBorder? focusedBorder,
    InputBorder? errorBorder,
    EdgeInsetsGeometry? contentPadding,
    double? borderRadius,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    double? borderWidth,
    Widget? prefixIcon,
    Widget? suffixIcon,
    VoidCallback? onTap,
    bool readOnly = false,
    List<TextInputFormatter>? inputFormatters,
    bool obscureText = false,
    bool? showCursor,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Color? cursorErrorColor,
    FocusNode? focusNode,
    String obscuringCharacter = '•',
    void Function(PointerDownEvent)? onTapOutside,
    void Function(PointerUpEvent)? onTapUpOutside,
  }) {
    return FCPInputField(
      label: label ?? 'Text',
      hint: hint ?? 'Enter text',
      initialValue: initialValue,
      controller: controller,
      validator: validator ?? FCPValidators.required,
      keyboardType: TextInputType.text,
      maxLines: maxLines,
      maxLength: maxLength,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      onChanged: onChanged,
      onSaved: onSaved,
      enabled: enabled,
      errorText: errorText,
      labelStyle: labelStyle,
      hintStyle: hintStyle,
      border: border,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      contentPadding: contentPadding,
      borderRadius: borderRadius,
      borderColor: borderColor,
      focusedBorderColor: focusedBorderColor,
      errorBorderColor: errorBorderColor,
      borderWidth: borderWidth,
      onTap: onTap,
      readOnly: readOnly,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      showCursor: showCursor,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      cursorRadius: cursorRadius,
      cursorColor: cursorColor,
      cursorErrorColor: cursorErrorColor,
      focusNode: focusNode,
      obscuringCharacter: obscuringCharacter,
      onTapOutside: onTapOutside,
      onTapUpOutside: onTapUpOutside,
    );
  }

  // Integer Input Field
  static Widget integer({
    String? label,
    String? hint,
    String? initialValue,
    TextEditingController? controller,
    String? Function(String?)? validator,
    Function(String)? onChanged,
    Function(String?)? onSaved,
    bool enabled = true,
    String? errorText,
    TextStyle? labelStyle,
    TextStyle? hintStyle,
    InputBorder? border,
    InputBorder? focusedBorder,
    InputBorder? errorBorder,
    EdgeInsetsGeometry? contentPadding,
    double? borderRadius,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    double? borderWidth,
    Widget? prefixIcon,
    Widget? suffixIcon,
    VoidCallback? onTap,
    bool readOnly = false,
    int? maxLines,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    bool obscureText = false,
    bool? showCursor,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Color? cursorErrorColor,
    FocusNode? focusNode,
    String obscuringCharacter = '•',
    void Function(PointerDownEvent)? onTapOutside,
    void Function(PointerUpEvent)? onTapUpOutside,
  }) {
    return FCPInputField(
      label: label ?? 'Number',
      hint: hint ?? 'Enter a number',
      initialValue: initialValue,
      controller: controller,
      validator: validator ?? FCPValidators.integer,
      keyboardType: TextInputType.number,
      inputFormatters:
          inputFormatters ?? [FilteringTextInputFormatter.digitsOnly],
      prefixIcon: prefixIcon ?? const Icon(Icons.numbers),
      onChanged: onChanged,
      onSaved: onSaved,
      enabled: enabled,
      errorText: errorText,
      labelStyle: labelStyle,
      hintStyle: hintStyle,
      border: border,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      contentPadding: contentPadding,
      borderRadius: borderRadius,
      borderColor: borderColor,
      focusedBorderColor: focusedBorderColor,
      errorBorderColor: errorBorderColor,
      borderWidth: borderWidth,
      suffixIcon: suffixIcon,
      onTap: onTap,
      readOnly: readOnly,
      maxLines: maxLines,
      maxLength: maxLength,
      obscureText: obscureText,
      showCursor: showCursor,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      cursorRadius: cursorRadius,
      cursorColor: cursorColor,
      cursorErrorColor: cursorErrorColor,
      focusNode: focusNode,
      obscuringCharacter: obscuringCharacter,
      onTapOutside: onTapOutside,
      onTapUpOutside: onTapUpOutside,
    );
  }

  // Float Input Field
  static Widget floatField({
    String? label,
    String? hint,
    String? initialValue,
    TextEditingController? controller,
    String? Function(String?)? validator,
    Function(String)? onChanged,
    Function(String?)? onSaved,
    bool enabled = true,
    String? errorText,
    TextStyle? labelStyle,
    TextStyle? hintStyle,
    InputBorder? border,
    InputBorder? focusedBorder,
    InputBorder? errorBorder,
    EdgeInsetsGeometry? contentPadding,
    double? borderRadius,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    double? borderWidth,
    Widget? prefixIcon,
    Widget? suffixIcon,
    VoidCallback? onTap,
    bool readOnly = false,
    int? maxLines,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    bool obscureText = false,
    bool? showCursor,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Color? cursorErrorColor,
    FocusNode? focusNode,
    String obscuringCharacter = '•',
    void Function(PointerDownEvent)? onTapOutside,
    void Function(PointerUpEvent)? onTapUpOutside,
  }) {
    return FCPInputField(
      label: label ?? 'Decimal Number',
      hint: hint ?? 'Enter a decimal number',
      initialValue: initialValue,
      controller: controller,
      validator: validator ?? FCPValidators.numeric,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: inputFormatters ??
          [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
      prefixIcon: prefixIcon ?? const Icon(Icons.calculate_outlined),
      onChanged: onChanged,
      onSaved: onSaved,
      enabled: enabled,
      errorText: errorText,
      labelStyle: labelStyle,
      hintStyle: hintStyle,
      border: border,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      contentPadding: contentPadding,
      borderRadius: borderRadius,
      borderColor: borderColor,
      focusedBorderColor: focusedBorderColor,
      errorBorderColor: errorBorderColor,
      borderWidth: borderWidth,
      suffixIcon: suffixIcon,
      onTap: onTap,
      readOnly: readOnly,
      maxLines: maxLines,
      maxLength: maxLength,
      obscureText: obscureText,
      showCursor: showCursor,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      cursorRadius: cursorRadius,
      cursorColor: cursorColor,
      cursorErrorColor: cursorErrorColor,
      focusNode: focusNode,
      obscuringCharacter: obscuringCharacter,
      onTapOutside: onTapOutside,
      onTapUpOutside: onTapUpOutside,
    );
  }

  // Phone Input Field
  static Widget phone({
    String? label,
    String? hint,
    String? initialValue,
    TextEditingController? controller,
    String? Function(String?)? validator,
    Function(String)? onChanged,
    Function(String?)? onSaved,
    bool enabled = true,
    String? errorText,
    TextStyle? labelStyle,
    TextStyle? hintStyle,
    InputBorder? border,
    InputBorder? focusedBorder,
    InputBorder? errorBorder,
    EdgeInsetsGeometry? contentPadding,
    double? borderRadius,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    double? borderWidth,
    Widget? prefixIcon,
    Widget? suffixIcon,
    VoidCallback? onTap,
    bool readOnly = false,
    int? maxLines,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    bool obscureText = false,
    bool? showCursor,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Color? cursorErrorColor,
    FocusNode? focusNode,
    String obscuringCharacter = '•',
    void Function(PointerDownEvent)? onTapOutside,
    void Function(PointerUpEvent)? onTapUpOutside,
  }) {
    return FCPInputField(
      label: label ?? 'Phone Number',
      hint: hint ?? 'Enter your phone number',
      initialValue: initialValue,
      controller: controller,
      validator: validator ?? FCPValidators.phoneNumber,
      keyboardType: TextInputType.phone,
      prefixIcon: prefixIcon ?? const Icon(Icons.phone_outlined),
      onChanged: onChanged,
      onSaved: onSaved,
      enabled: enabled,
      errorText: errorText,
      labelStyle: labelStyle,
      hintStyle: hintStyle,
      border: border,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      contentPadding: contentPadding,
      borderRadius: borderRadius,
      borderColor: borderColor,
      focusedBorderColor: focusedBorderColor,
      errorBorderColor: errorBorderColor,
      borderWidth: borderWidth,
      suffixIcon: suffixIcon,
      onTap: onTap,
      readOnly: readOnly,
      maxLines: maxLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      showCursor: showCursor,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      cursorRadius: cursorRadius,
      cursorColor: cursorColor,
      cursorErrorColor: cursorErrorColor,
      focusNode: focusNode,
      obscuringCharacter: obscuringCharacter,
      onTapOutside: onTapOutside,
      onTapUpOutside: onTapUpOutside,
    );
  }

  // Country Picker Field
  static Widget countryPicker({
    String? label,
    String? hint,
    String? initialValue,
    Function(String)? onChanged,
    String? Function(String?)? validator,
  }) {
    return FCPCountryPicker(
      label: label ?? 'Country',
      hint: hint ?? 'Select your country',
      initialValue: initialValue,
      onChanged: onChanged,
      validator: validator ?? FCPValidators.required,
    );
  }

  // Search Field
  static Widget search({
    String? label,
    String? hint,
    String? initialValue,
    TextEditingController? controller,
    Function(String)? onChanged,
    Function(String?)? onSaved,
    VoidCallback? onSearchPressed,
    bool enabled = true,
    String? errorText,
    TextStyle? labelStyle,
    TextStyle? hintStyle,
    InputBorder? border,
    InputBorder? focusedBorder,
    InputBorder? errorBorder,
    EdgeInsetsGeometry? contentPadding,
    double? borderRadius,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    double? borderWidth,
    Widget? prefixIcon,
    Widget? suffixIcon,
    VoidCallback? onTap,
    bool readOnly = false,
    int? maxLines,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    bool obscureText = false,
    String? Function(String?)? validator,
    bool? showCursor,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Color? cursorErrorColor,
    FocusNode? focusNode,
    String obscuringCharacter = '•',
    void Function(PointerDownEvent)? onTapOutside,
    void Function(PointerUpEvent)? onTapUpOutside,
  }) {
    return FCPInputField(
      label: label,
      hint: hint ?? 'Search...',
      initialValue: initialValue,
      controller: controller,
      keyboardType: TextInputType.text,
      prefixIcon: prefixIcon ?? const Icon(Icons.search),
      suffixIcon: suffixIcon ??
          (onSearchPressed != null
              ? IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: onSearchPressed,
                )
              : null),
      onChanged: onChanged,
      onSaved: onSaved,
      enabled: enabled,
      errorText: errorText,
      labelStyle: labelStyle,
      hintStyle: hintStyle,
      border: border,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      contentPadding: contentPadding,
      borderRadius: borderRadius,
      borderColor: borderColor,
      focusedBorderColor: focusedBorderColor,
      errorBorderColor: errorBorderColor,
      borderWidth: borderWidth,
      onTap: onTap,
      readOnly: readOnly,
      maxLines: maxLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      validator: validator,
      showCursor: showCursor,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      cursorRadius: cursorRadius,
      cursorColor: cursorColor,
      cursorErrorColor: cursorErrorColor,
      focusNode: focusNode,
      obscuringCharacter: obscuringCharacter,
      onTapOutside: onTapOutside,
      onTapUpOutside: onTapUpOutside,
    );
  }

  // URL Input Field
  static Widget url({
    String? label,
    String? hint,
    String? initialValue,
    TextEditingController? controller,
    String? Function(String?)? validator,
    Function(String)? onChanged,
    Function(String?)? onSaved,
    bool enabled = true,
    String? errorText,
    TextStyle? labelStyle,
    TextStyle? hintStyle,
    InputBorder? border,
    InputBorder? focusedBorder,
    InputBorder? errorBorder,
    EdgeInsetsGeometry? contentPadding,
    double? borderRadius,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    double? borderWidth,
    Widget? prefixIcon,
    Widget? suffixIcon,
    VoidCallback? onTap,
    bool readOnly = false,
    int? maxLines,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    bool obscureText = false,
    bool? showCursor,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Color? cursorErrorColor,
    FocusNode? focusNode,
    String obscuringCharacter = '•',
    void Function(PointerDownEvent)? onTapOutside,
    void Function(PointerUpEvent)? onTapUpOutside,
  }) {
    return FCPInputField(
      label: label ?? 'URL',
      hint: hint ?? 'Enter URL',
      initialValue: initialValue,
      controller: controller,
      validator: validator ??
          (String? value) {
            if (value == null || value.isEmpty) {
              return 'URL is required';
            }
            final urlRegExp = RegExp(
              r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
            );
            if (!urlRegExp.hasMatch(value)) {
              return 'Please enter a valid URL';
            }
            return null;
          },
      keyboardType: TextInputType.url,
      prefixIcon: prefixIcon ?? const Icon(Icons.link),
      onChanged: onChanged,
      onSaved: onSaved,
      enabled: enabled,
      errorText: errorText,
      labelStyle: labelStyle,
      hintStyle: hintStyle,
      border: border,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      contentPadding: contentPadding,
      borderRadius: borderRadius,
      borderColor: borderColor,
      focusedBorderColor: focusedBorderColor,
      errorBorderColor: errorBorderColor,
      borderWidth: borderWidth,
      suffixIcon: suffixIcon,
      onTap: onTap,
      readOnly: readOnly,
      maxLines: maxLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      showCursor: showCursor,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      cursorRadius: cursorRadius,
      cursorColor: cursorColor,
      cursorErrorColor: cursorErrorColor,
      focusNode: focusNode,
      obscuringCharacter: obscuringCharacter,
      onTapOutside: onTapOutside,
      onTapUpOutside: onTapUpOutside,
    );
  }

  // Date Picker Field
  static Widget datePicker({
    String? label,
    String? hint,
    String? initialValue,
    TextEditingController? controller,
    String? Function(String?)? validator,
    Function(String)? onChanged,
    DateTime? firstDate,
    DateTime? lastDate,
    bool enabled = true,
    required BuildContext context,
    String? errorText,
    TextStyle? labelStyle,
    TextStyle? hintStyle,
    InputBorder? border,
    InputBorder? focusedBorder,
    InputBorder? errorBorder,
    EdgeInsetsGeometry? contentPadding,
    double? borderRadius,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    double? borderWidth,
    Widget? prefixIcon,
    Widget? suffixIcon,
    int? maxLines,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    bool obscureText = false,
    bool? showCursor,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Color? cursorErrorColor,
    FocusNode? focusNode,
    String obscuringCharacter = '•',
    void Function(PointerDownEvent)? onTapOutside,
    void Function(PointerUpEvent)? onTapUpOutside,
  }) {
    return FCPInputField(
      label: label ?? 'Date',
      hint: hint ?? 'Select date',
      initialValue: initialValue,
      controller: controller,
      validator: validator ?? FCPValidators.required,
      readOnly: true,
      prefixIcon: prefixIcon ?? const Icon(Icons.calendar_today),
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: firstDate ?? DateTime(1900),
          lastDate: lastDate ?? DateTime(2100),
        );
        if (picked != null) {
          final formattedDate = '${picked.day}/${picked.month}/${picked.year}';
          if (controller != null) {
            controller.text = formattedDate;
          }
          if (onChanged != null) {
            onChanged(formattedDate);
          }
        }
      },
      enabled: enabled,
      errorText: errorText,
      labelStyle: labelStyle,
      hintStyle: hintStyle,
      border: border,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      contentPadding: contentPadding,
      borderRadius: borderRadius,
      borderColor: borderColor,
      focusedBorderColor: focusedBorderColor,
      errorBorderColor: errorBorderColor,
      borderWidth: borderWidth,
      suffixIcon: suffixIcon,
      maxLines: maxLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      showCursor: showCursor,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      cursorRadius: cursorRadius,
      cursorColor: cursorColor,
      cursorErrorColor: cursorErrorColor,
      focusNode: focusNode,
      obscuringCharacter: obscuringCharacter,
      onTapOutside: onTapOutside,
      onTapUpOutside: onTapUpOutside,
    );
  }
}
