/// String extensions for common operations
extension StringExtensions on String {
  /// Check if string is empty or contains only whitespace
  bool get isBlank => trim().isEmpty;

  /// Check if string is not empty and contains non-whitespace characters
  bool get isNotBlank => !isBlank;

  /// Capitalize first letter of string
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalize first letter of each word
  String get titleCase {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Convert to camelCase
  String get camelCase {
    if (isEmpty) return this;
    final words = split(RegExp(r'[\s\-_]+'));
    if (words.length == 1) return words[0].toLowerCase();
    return words[0].toLowerCase() +
        words.skip(1).map((word) => word.capitalize).join();
  }

  /// Convert to snake_case
  String get snakeCase {
    if (isEmpty) return this;
    return replaceAll(RegExp(r'[\s\-]+'), '_').toLowerCase();
  }

  /// Convert to kebab-case
  String get kebabCase {
    if (isEmpty) return this;
    return replaceAll(RegExp(r'[\s_]+'), '-').toLowerCase();
  }

  /// Convert to PascalCase
  String get pascalCase {
    if (isEmpty) return this;
    return split(RegExp(r'[\s\-_]+')).map((word) => word.capitalize).join();
  }

  /// Truncate string to specified length with ellipsis
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - suffix.length)}$suffix';
  }

  /// Remove all whitespace from string
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  /// Remove all special characters except letters and numbers
  String get removeSpecialCharacters =>
      replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '');

  /// Remove all numbers from string
  String get removeNumbers => replaceAll(RegExp(r'[0-9]'), '');

  /// Remove all letters from string
  String get removeLetters => replaceAll(RegExp(r'[a-zA-Z]'), '');

  /// Extract only numbers from string
  String get extractNumbers => replaceAll(RegExp(r'[^0-9]'), '');

  /// Extract only letters from string
  String get extractLetters => replaceAll(RegExp(r'[^a-zA-Z]'), '');

  /// Check if string contains only numbers
  bool get isNumeric => RegExp(r'^[0-9]+$').hasMatch(this);

  /// Check if string contains only letters
  bool get isAlphabetic => RegExp(r'^[a-zA-Z]+$').hasMatch(this);

  /// Check if string contains only letters and numbers
  bool get isAlphanumeric => RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);

  /// Check if string is a valid email
  bool get isEmail {
    final emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegex.hasMatch(this);
  }

  /// Check if string is a valid URL
  bool get isUrl {
    try {
      Uri.parse(this);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Check if string is a valid phone number (basic check)
  bool get isPhoneNumber {
    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]+$');
    return phoneRegex.hasMatch(removeWhitespace);
  }

  /// Reverse the string
  String get reversed => split('').reversed.join();

  /// Count occurrences of a substring
  int countOccurrences(String substring) {
    if (substring.isEmpty) return 0;
    return split(substring).length - 1;
  }

  /// Check if string starts with any of the given prefixes
  bool startsWithAny(List<String> prefixes) {
    return prefixes.any((prefix) => startsWith(prefix));
  }

  /// Check if string ends with any of the given suffixes
  bool endsWithAny(List<String> suffixes) {
    return suffixes.any((suffix) => endsWith(suffix));
  }

  /// Check if string contains any of the given substrings
  bool containsAny(List<String> substrings) {
    return substrings.any((substring) => contains(substring));
  }

  /// Replace multiple characters at once
  String replaceMultiple(Map<String, String> replacements) {
    String result = this;
    for (final entry in replacements.entries) {
      result = result.replaceAll(entry.key, entry.value);
    }
    return result;
  }

  /// Split string and trim each part
  List<String> splitAndTrim(String delimiter) {
    return split(delimiter).map((part) => part.trim()).toList();
  }

  /// Get first n characters
  String takeFirst(int n) {
    if (n >= length) return this;
    return substring(0, n);
  }

  /// Get last n characters
  String takeLast(int n) {
    if (n >= length) return this;
    return substring(length - n);
  }

  /// Remove first n characters
  String removeFirst(int n) {
    if (n >= length) return '';
    return substring(n);
  }

  /// Remove last n characters
  String removeLast(int n) {
    if (n >= length) return '';
    return substring(0, length - n);
  }

  /// Pad string to specified length with character
  String padLeft(int length, {String padding = ' '}) {
    if (this.length >= length) return this;
    return padding * (length - this.length) + this;
  }

  /// Pad string to specified length with character
  String padRight(int length, {String padding = ' '}) {
    if (this.length >= length) return this;
    return this + padding * (length - this.length);
  }

  /// Center string to specified length with character
  String padCenter(int length, {String padding = ' '}) {
    if (this.length >= length) return this;
    final totalPadding = length - this.length;
    final leftPadding = totalPadding ~/ 2;
    final rightPadding = totalPadding - leftPadding;
    return padding * leftPadding + this + padding * rightPadding;
  }
}
