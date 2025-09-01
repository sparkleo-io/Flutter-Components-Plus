import 'package:flutter/material.dart';
import 'dart:async';
import '../../core/constants.dart';
import '../../core/theme/text_styles.dart';
import '../custom_cards/custom_cards.dart';
import '../custom_input_fields/custom_input_field.dart';

/// A professional dropdown component that displays a bottom sheet with selectable items
class FCPDropdownBottomSheet extends StatelessWidget {
  /// Creates a dropdown bottom sheet component
  const FCPDropdownBottomSheet({
    super.key,
    required this.title,
    required this.items,
    required this.onItemSelected,
    this.selectedIndex,
    this.prefixIcon,
    this.enableBorder = false,
    this.disabled = false,
    this.isSearchEnabled = false,
    this.indexed = true,
    this.heightFactor = 0.64,
    this.borderRadius = 16.0,
    this.itemHeight = 56.0,
    this.itemSpacing = 8.0,
    this.titleStyle,
    this.itemTextStyle,
    this.selectedItemTextStyle,
    this.selectedItemIconColor,
    this.backgroundColor,
    this.searchHintText = 'Search',
    this.emptyStateText = 'No items found',
    this.showEmptyState = true,
    this.customItemBuilder,
    this.onSearchChanged,
    this.searchDebounceDuration = const Duration(milliseconds: 300),
  });

  /// The title displayed in the dropdown trigger and bottom sheet header
  final String title;

  /// List of items to display in the dropdown
  final List<String> items;

  /// Callback function when an item is selected
  final Function(dynamic) onItemSelected;

  /// Currently selected item index
  final int? selectedIndex;

  /// Optional prefix icon for the dropdown trigger
  final IconData? prefixIcon;

  /// Whether to show a border around the dropdown trigger
  final bool enableBorder;

  /// Whether the dropdown is disabled
  final bool disabled;

  /// Whether to enable search functionality
  final bool isSearchEnabled;

  /// Whether to pass index or value to onItemSelected callback
  final bool indexed;

  /// Height factor for the bottom sheet (0.0 to 1.0)
  final double heightFactor;

  /// Border radius for the bottom sheet
  final double borderRadius;

  /// Height of each item in the list
  final double itemHeight;

  /// Spacing between items
  final double itemSpacing;

  /// Custom text style for the title
  final TextStyle? titleStyle;

  /// Custom text style for items
  final TextStyle? itemTextStyle;

  /// Custom text style for selected item
  final TextStyle? selectedItemTextStyle;

  /// Color for the selected item check icon
  final Color? selectedItemIconColor;

  /// Background color for the bottom sheet
  final Color? backgroundColor;

  /// Hint text for the search field
  final String searchHintText;

  /// Text to display when no items are found
  final String emptyStateText;

  /// Whether to show empty state when no items match search
  final bool showEmptyState;

  /// Custom builder for items (overrides default item appearance)
  final Widget Function(String item, int index, bool isSelected)?
  customItemBuilder;

  /// Callback for search changes
  final Function(String)? onSearchChanged;

  /// Debounce duration for search input
  final Duration searchDebounceDuration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return FCPCard(
      border: enableBorder
          ? Border.all(
              color: isDark
                  ? colorScheme.outline.withOpacity(0.2)
                  : colorScheme.outline.withOpacity(0.1),
            )
          : null,
      borderRadius: FCPConstants.radiusSm,
      onTap: disabled ? null : () => _showBottomSheet(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: FCPConstants.spacingSm,
          vertical: FCPConstants.spacingMd,
        ),
        child: Row(
          children: [
            if (prefixIcon != null) ...[
              Icon(
                prefixIcon,
                color: colorScheme.onSurface.withOpacity(0.6),
                size: 20,
              ),
              const SizedBox(width: FCPConstants.spacingMd),
            ],
            Expanded(
              child: Text(
                _getDisplayText(),
                style: (titleStyle ?? FCPTextStyles.getBodyMedium()).copyWith(
                  color: selectedIndex == null
                      ? colorScheme.onSurface.withOpacity(0.6)
                      : null,
                ),
              ),
            ),
            if (!disabled)
              Icon(
                Icons.keyboard_arrow_down,
                color: colorScheme.onSurface.withOpacity(0.6),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  /// Get the text to display in the dropdown trigger
  String _getDisplayText() {
    if (selectedIndex == null ||
        selectedIndex! < 0 ||
        selectedIndex! >= items.length) {
      return title;
    }
    return items[selectedIndex!];
  }

  /// Show the bottom sheet with items
  void _showBottomSheet(BuildContext context) {
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      builder: (context) => _BottomSheetContent(
        title: title,
        items: items,
        selectedIndex: selectedIndex,
        onItemSelected: onItemSelected,
        isSearchEnabled: isSearchEnabled,
        indexed: indexed,
        heightFactor: heightFactor,
        itemHeight: itemHeight,
        itemSpacing: itemSpacing,
        titleStyle: titleStyle,
        itemTextStyle: itemTextStyle,
        selectedItemTextStyle: selectedItemTextStyle,
        selectedItemIconColor: selectedItemIconColor,
        searchHintText: searchHintText,
        emptyStateText: emptyStateText,
        showEmptyState: showEmptyState,
        customItemBuilder: customItemBuilder,
        onSearchChanged: onSearchChanged,
        searchDebounceDuration: searchDebounceDuration,
      ),
    );
  }
}

/// Internal widget for the bottom sheet content
class _BottomSheetContent extends StatefulWidget {
  const _BottomSheetContent({
    required this.title,
    required this.items,
    required this.onItemSelected,
    this.selectedIndex,
    this.isSearchEnabled = false,
    this.indexed = true,
    this.heightFactor = 0.64,
    this.itemHeight = 56.0,
    this.itemSpacing = 8.0,
    this.titleStyle,
    this.itemTextStyle,
    this.selectedItemTextStyle,
    this.selectedItemIconColor,
    this.searchHintText = 'Search',
    this.emptyStateText = 'No items found',
    this.showEmptyState = true,
    this.customItemBuilder,
    this.onSearchChanged,
    this.searchDebounceDuration = const Duration(milliseconds: 300),
  });

  final String title;
  final List<String> items;
  final Function(dynamic) onItemSelected;
  final int? selectedIndex;
  final bool isSearchEnabled;
  final bool indexed;
  final double heightFactor;
  final double itemHeight;
  final double itemSpacing;
  final TextStyle? titleStyle;
  final TextStyle? itemTextStyle;
  final TextStyle? selectedItemTextStyle;
  final Color? selectedItemIconColor;
  final String searchHintText;
  final String emptyStateText;
  final bool showEmptyState;
  final Widget Function(String item, int index, bool isSelected)?
  customItemBuilder;
  final Function(String)? onSearchChanged;
  final Duration searchDebounceDuration;

  @override
  State<_BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<_BottomSheetContent> {
  List<String> _filteredItems = [];
  String _searchQuery = '';
  Timer? _searchTimer;

  @override
  void initState() {
    super.initState();
    _filteredItems = List.from(widget.items);
  }

  @override
  void dispose() {
    _searchTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: widget.heightFactor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          if (widget.isSearchEnabled) _buildSearchField(),
          Flexible(child: _buildItemsList()),
        ],
      ),
    );
  }

  /// Build the header section
  Widget _buildHeader() {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: FCPConstants.spacingMd,
        horizontal: FCPConstants.spacingLg,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.dividerColor.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.title,
              style: widget.titleStyle ?? FCPTextStyles.getTitleMedium(),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
            iconSize: 20,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }

  /// Build the search field
  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(FCPConstants.spacingMd),
      child: FCPInputField(
        hint: widget.searchHintText,
        prefixIcon: const Icon(Icons.search),
        onChanged: _onSearchChanged,
      ),
    );
  }

  /// Handle search input changes with debouncing
  void _onSearchChanged(String query) {
    _searchQuery = query;
    widget.onSearchChanged?.call(query);

    _searchTimer?.cancel();
    _searchTimer = Timer(widget.searchDebounceDuration, () {
      if (mounted) {
        setState(() {
          if (query.isEmpty) {
            _filteredItems = List.from(widget.items);
          } else {
            _filteredItems = widget.items
                .where(
                  (item) => item.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
          }
        });
      }
    });
  }

  /// Build the items list
  Widget _buildItemsList() {
    if (_filteredItems.isEmpty && widget.showEmptyState) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: FCPConstants.spacingMd),
      shrinkWrap: true,
      itemCount: _filteredItems.length,
      itemBuilder: (context, index) {
        final item = _filteredItems[index];
        final originalIndex = widget.items.indexOf(item);
        final isSelected = widget.selectedIndex == originalIndex;

        return Padding(
          padding: EdgeInsets.only(bottom: widget.itemSpacing),
          child: FCPCard(
            height: widget.itemHeight,
            onTap: () {
              widget.onItemSelected(widget.indexed ? originalIndex : item);
              Navigator.of(context).pop();
            },
            child:
                widget.customItemBuilder?.call(
                  item,
                  originalIndex,
                  isSelected,
                ) ??
                _buildDefaultItem(item, originalIndex, isSelected),
          ),
        );
      },
    );
  }

  /// Build the default item widget
  Widget _buildDefaultItem(String item, int index, bool isSelected) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return FCPCard(
      height: widget.itemHeight,
      padding: const EdgeInsets.symmetric(horizontal: FCPConstants.spacingMd),
      backgroundColor: isSelected
          ? colorScheme.primaryContainer.withOpacity(0.1)
          : null,
      border: isSelected
          ? Border.all(color: colorScheme.primary.withOpacity(0.3), width: 1)
          : null,
      onTap: () {
        widget.onItemSelected(widget.indexed ? index : item);
        Navigator.of(context).pop();
      },
      child: Row(
        children: [
          Expanded(
            child: Text(
              item,
              style:
                  (isSelected
                      ? widget.selectedItemTextStyle
                      : widget.itemTextStyle) ??
                  FCPTextStyles.getBodyMedium().copyWith(
                    color: isSelected ? colorScheme.primary : null,
                    fontWeight: isSelected ? FontWeight.w600 : null,
                  ),
            ),
          ),
          if (isSelected)
            Icon(
              Icons.check,
              color: widget.selectedItemIconColor ?? colorScheme.primary,
              size: 20,
            ),
        ],
      ),
    );
  }

  /// Build empty state widget
  Widget _buildEmptyState() {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(FCPConstants.spacingXl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off,
              size: 48,
              color: theme.colorScheme.onSurface.withOpacity(0.4),
            ),
            const SizedBox(height: FCPConstants.spacingMd),
            Text(
              widget.emptyStateText,
              style: FCPTextStyles.getBodyMedium().copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Extension to show the dropdown bottom sheet directly
extension FCPDropdownBottomSheetExtension on BuildContext {
  /// Show a dropdown bottom sheet with the given parameters
  Future<T?> showFCPDropdownBottomSheet<T>({
    required String title,
    required List<String> items,
    required Function(dynamic) onItemSelected,
    int? selectedIndex,
    bool isSearchEnabled = false,
    bool indexed = true,
    double heightFactor = 0.64,
    double borderRadius = 16.0,
    double itemHeight = 56.0,
    double itemSpacing = 8.0,
    TextStyle? titleStyle,
    TextStyle? itemTextStyle,
    TextStyle? selectedItemTextStyle,
    Color? selectedItemIconColor,
    Color? backgroundColor,
    String searchHintText = 'Search',
    String emptyStateText = 'No items found',
    bool showEmptyState = true,
    Widget Function(String item, int index, bool isSelected)? customItemBuilder,
    Function(String)? onSearchChanged,
    Duration searchDebounceDuration = const Duration(milliseconds: 300),
  }) {
    return showModalBottomSheet<T>(
      isScrollControlled: true,
      context: this,
      backgroundColor:
          backgroundColor ?? Theme.of(this).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      builder: (context) => _BottomSheetContent(
        title: title,
        items: items,
        selectedIndex: selectedIndex,
        onItemSelected: onItemSelected,
        isSearchEnabled: isSearchEnabled,
        indexed: indexed,
        heightFactor: heightFactor,
        itemHeight: itemHeight,
        itemSpacing: itemSpacing,
        titleStyle: titleStyle,
        itemTextStyle: itemTextStyle,
        selectedItemTextStyle: selectedItemTextStyle,
        selectedItemIconColor: selectedItemIconColor,
        searchHintText: searchHintText,
        emptyStateText: emptyStateText,
        showEmptyState: showEmptyState,
        customItemBuilder: customItemBuilder,
        onSearchChanged: onSearchChanged,
        searchDebounceDuration: searchDebounceDuration,
      ),
    );
  }
}
