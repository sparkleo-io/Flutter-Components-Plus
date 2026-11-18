import 'package:flutter/material.dart';
import 'dart:async';
import '../../core/constants.dart';
import '../../core/theme/text_styles.dart';
import '../custom_cards/custom_cards.dart';

/// A data model for multi-select items
class FCPMultiSelectItem {
  /// Creates a multi-select item
  const FCPMultiSelectItem({
    required this.label,
    this.value,
    this.isSelected = false,
    this.disabled = false,
  });

  /// The display label for the item
  final String label;

  /// Optional value associated with the item
  final String? value;

  /// Whether the item is currently selected
  final bool isSelected;

  /// Whether the item is disabled
  final bool disabled;

  /// Creates a copy of this item with updated properties
  FCPMultiSelectItem copyWith({
    String? label,
    String? value,
    bool? isSelected,
    bool? disabled,
  }) {
    return FCPMultiSelectItem(
      label: label ?? this.label,
      value: value ?? this.value,
      isSelected: isSelected ?? this.isSelected,
      disabled: disabled ?? this.disabled,
    );
  }
}

/// A professional multi-select dropdown component that displays a bottom sheet with selectable items
class FCPMultiSelectDropdown extends StatefulWidget {
  /// Creates a multi-select dropdown component
  const FCPMultiSelectDropdown({
    super.key,
    required this.title,
    required this.items,
    required this.onSelectionChanged,
    this.disabled = false,
    this.prefixIcon,
    this.enableBorder = false,
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
    this.isSearchEnabled = false,
    this.maxSelections,
    this.showSelectAll = false,
    this.selectAllText = 'Select All',
    this.deselectAllText = 'Deselect All',
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.showConfirmButton = true,
    this.onSearchChanged,
    this.searchDebounceDuration = const Duration(milliseconds: 300),
    this.customItemBuilder,
  });

  /// The title displayed in the dropdown trigger and bottom sheet header
  final String title;

  /// List of items to display in the dropdown
  final List<FCPMultiSelectItem> items;

  /// Callback function when selection changes
  final Function(List<FCPMultiSelectItem>) onSelectionChanged;

  /// Whether the dropdown is disabled
  final bool disabled;

  /// Optional prefix icon for the dropdown trigger
  final IconData? prefixIcon;

  /// Whether to show a border around the dropdown trigger
  final bool enableBorder;

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

  /// Whether to enable search functionality
  final bool isSearchEnabled;

  /// Maximum number of items that can be selected (null for unlimited)
  final int? maxSelections;

  /// Whether to show select all/deselect all option
  final bool showSelectAll;

  /// Text for select all button
  final String selectAllText;

  /// Text for deselect all button
  final String deselectAllText;

  /// Text for confirm button
  final String confirmText;

  /// Text for cancel button
  final String cancelText;

  /// Whether to show confirm button
  final bool showConfirmButton;

  /// Callback for search changes
  final Function(String)? onSearchChanged;

  /// Debounce duration for search input
  final Duration searchDebounceDuration;

  /// Custom builder for items (overrides default item appearance)
  final Widget Function(
    FCPMultiSelectItem item,
    int index,
    bool isSelected,
    Function(bool?) onChanged,
  )? customItemBuilder;

  @override
  State<FCPMultiSelectDropdown> createState() => _FCPMultiSelectDropdownState();
}

class _FCPMultiSelectDropdownState extends State<FCPMultiSelectDropdown> {
  late List<FCPMultiSelectItem> _items;
  Timer? _searchTimer;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.items);
  }

  @override
  void dispose() {
    _searchTimer?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(FCPMultiSelectDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _items = List.from(widget.items);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final selectedCount = _items.where((item) => item.isSelected).length;

    return FCPCard(
      border: widget.enableBorder
          ? Border.all(
              color: isDark
                  ? colorScheme.outline.withValues(alpha: 0.2)
                  : colorScheme.outline.withValues(alpha: 0.1),
            )
          : null,
      borderRadius: FCPConstants.radiusSm,
      onTap: widget.disabled ? null : () => _showBottomSheet(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: FCPConstants.spacingSm,
          vertical: FCPConstants.spacingMd,
        ),
        child: Row(
          children: [
            if (widget.prefixIcon != null) ...[
              Icon(
                widget.prefixIcon,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
                size: 20,
              ),
              const SizedBox(width: FCPConstants.spacingMd),
            ],
            Expanded(
              child: Text(
                _getDisplayText(selectedCount),
                style: (widget.titleStyle ?? FCPTextStyles.getBodyMedium())
                    .copyWith(
                  color: selectedCount == 0
                      ? colorScheme.onSurface.withValues(alpha: 0.6)
                      : null,
                ),
              ),
            ),
            if (!widget.disabled)
              Icon(
                Icons.keyboard_arrow_down,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  /// Get the text to display in the dropdown trigger
  String _getDisplayText(int selectedCount) {
    if (selectedCount == 0) {
      return widget.title;
    } else if (selectedCount == 1) {
      final selectedItem = _items.firstWhere((item) => item.isSelected);
      return selectedItem.label;
    } else {
      return '$selectedCount items selected';
    }
  }

  /// Show the bottom sheet with items
  void _showBottomSheet(BuildContext context) {
    FocusScope.of(context).unfocus();
    showModalBottomSheet<List<FCPMultiSelectItem>>(
      isScrollControlled: true,
      context: context,
      backgroundColor:
          widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(widget.borderRadius),
          topRight: Radius.circular(widget.borderRadius),
        ),
      ),
      builder: (context) => _MultiSelectBottomSheetContent(
        title: widget.title,
        items: _items,
        onSelectionChanged: (selectedItems) {
          // Update local state during selection
          setState(() {
            _items = selectedItems;
          });
        },
        heightFactor: widget.heightFactor,
        itemHeight: widget.itemHeight,
        itemSpacing: widget.itemSpacing,
        titleStyle: widget.titleStyle,
        itemTextStyle: widget.itemTextStyle,
        selectedItemTextStyle: widget.selectedItemTextStyle,
        selectedItemIconColor: widget.selectedItemIconColor,
        searchHintText: widget.searchHintText,
        emptyStateText: widget.emptyStateText,
        showEmptyState: widget.showEmptyState,
        isSearchEnabled: widget.isSearchEnabled,
        maxSelections: widget.maxSelections,
        showSelectAll: widget.showSelectAll,
        selectAllText: widget.selectAllText,
        deselectAllText: widget.deselectAllText,
        confirmText: widget.confirmText,
        cancelText: widget.cancelText,
        showConfirmButton: widget.showConfirmButton,
        onSearchChanged: widget.onSearchChanged,
        searchDebounceDuration: widget.searchDebounceDuration,
        customItemBuilder: widget.customItemBuilder,
      ),
    ).then((result) {
      // Handle the result when bottom sheet is closed
      if (result != null) {
        // Update the main component's state with the confirmed selection
        setState(() {
          _items = result;
        });
        // Call the parent's callback with the confirmed selection
        widget.onSelectionChanged(result);
      }
    });
  }
}

/// Internal widget for the multi-select bottom sheet content
class _MultiSelectBottomSheetContent extends StatefulWidget {
  const _MultiSelectBottomSheetContent({
    required this.title,
    required this.items,
    required this.onSelectionChanged,
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
    this.isSearchEnabled = false,
    this.maxSelections,
    this.showSelectAll = false,
    this.selectAllText = 'Select All',
    this.deselectAllText = 'Deselect All',
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.showConfirmButton = true,
    this.onSearchChanged,
    this.searchDebounceDuration = const Duration(milliseconds: 300),
    this.customItemBuilder,
  });

  final String title;
  final List<FCPMultiSelectItem> items;
  final Function(List<FCPMultiSelectItem>) onSelectionChanged;
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
  final bool isSearchEnabled;
  final int? maxSelections;
  final bool showSelectAll;
  final String selectAllText;
  final String deselectAllText;
  final String confirmText;
  final String cancelText;
  final bool showConfirmButton;
  final Function(String)? onSearchChanged;
  final Duration searchDebounceDuration;
  final Widget Function(
    FCPMultiSelectItem item,
    int index,
    bool isSelected,
    Function(bool?) onChanged,
  )? customItemBuilder;

  @override
  State<_MultiSelectBottomSheetContent> createState() =>
      _MultiSelectBottomSheetContentState();
}

class _MultiSelectBottomSheetContentState
    extends State<_MultiSelectBottomSheetContent> {
  late List<FCPMultiSelectItem> _items;
  List<FCPMultiSelectItem> _filteredItems = [];
  String _searchQuery = '';
  Timer? _searchTimer;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.items);
    _filteredItems = List.from(_items);
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
          if (widget.showSelectAll) _buildSelectAllSection(),
          if (widget.isSearchEnabled) _buildSearchField(),
          Flexible(child: _buildItemsList()),
          if (widget.showConfirmButton) _buildActionButtons(),
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
            color: theme.dividerColor.withValues(alpha: 0.1),
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

  /// Build the select all section
  Widget _buildSelectAllSection() {
    final theme = Theme.of(context);
    final selectedCount = _items.where((item) => item.isSelected).length;
    final totalCount = _items.length;
    final allSelected = selectedCount == totalCount;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: FCPConstants.spacingMd,
        vertical: FCPConstants.spacingSm,
      ),
      child: Row(
        children: [
          Checkbox(
            value: allSelected,
            tristate: selectedCount > 0 && selectedCount < totalCount,
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  // Select all
                  for (int i = 0; i < _items.length; i++) {
                    if (!_items[i].disabled) {
                      _items[i] = _items[i].copyWith(isSelected: true);
                    }
                  }
                } else {
                  // Deselect all
                  for (int i = 0; i < _items.length; i++) {
                    _items[i] = _items[i].copyWith(isSelected: false);
                  }
                }
                _updateFilteredItems();
              });
              // Don't call onSelectionChanged here - only call it when confirm is pressed
            },
          ),
          const SizedBox(width: FCPConstants.spacingSm),
          Text(
            allSelected ? widget.deselectAllText : widget.selectAllText,
            style: FCPTextStyles.getBodyMedium(),
          ),
          const Spacer(),
          Text(
            '$selectedCount/$totalCount',
            style: FCPTextStyles.getBodySmall().copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  /// Build the search field
  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(FCPConstants.spacingMd),
      child: TextField(
        decoration: InputDecoration(
          hintText: widget.searchHintText,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(FCPConstants.radiusMd),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: FCPConstants.spacingMd,
            vertical: FCPConstants.spacingSm,
          ),
        ),
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
            _filteredItems = List.from(_items);
          } else {
            _filteredItems = _items
                .where(
                  (item) =>
                      item.label.toLowerCase().contains(query.toLowerCase()),
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
        final originalIndex = _items.indexOf(item);

        return Padding(
          padding: EdgeInsets.only(bottom: widget.itemSpacing),
          child: widget.customItemBuilder?.call(
                item,
                originalIndex,
                item.isSelected,
                (value) => _onItemChanged(originalIndex, value),
              ) ??
              _buildDefaultItem(item, originalIndex),
        );
      },
    );
  }

  /// Build the default item widget
  Widget _buildDefaultItem(FCPMultiSelectItem item, int index) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return FCPCard(
      height: widget.itemHeight,
      padding: const EdgeInsets.symmetric(horizontal: FCPConstants.spacingMd),
      backgroundColor: item.isSelected
          ? colorScheme.primaryContainer.withValues(alpha: 0.1)
          : null,
      border: item.isSelected
          ? Border.all(
              color: colorScheme.primary.withValues(alpha: 0.3),
              width: 1,
            )
          : null,
      onTap:
          item.disabled ? null : () => _onItemChanged(index, !item.isSelected),
      child: Row(
        children: [
          Checkbox(
            value: item.isSelected,
            onChanged:
                item.disabled ? null : (value) => _onItemChanged(index, value),
          ),
          const SizedBox(width: FCPConstants.spacingSm),
          Expanded(
            child: Text(
              item.label,
              style: (item.isSelected
                      ? widget.selectedItemTextStyle
                      : widget.itemTextStyle) ??
                  FCPTextStyles.getBodyMedium().copyWith(
                    color: item.disabled
                        ? theme.colorScheme.onSurface.withValues(alpha: 0.38)
                        : (item.isSelected ? colorScheme.primary : null),
                    fontWeight: item.isSelected ? FontWeight.w600 : null,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  /// Handle item selection change
  void _onItemChanged(int index, bool? value) {
    if (value == null || _items[index].disabled) return;

    // Check max selections limit
    if (value && widget.maxSelections != null) {
      final selectedCount = _items.where((item) => item.isSelected).length;
      if (selectedCount >= widget.maxSelections!) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Maximum ${widget.maxSelections} items can be selected',
            ),
            duration: const Duration(seconds: 2),
          ),
        );
        return;
      }
    }

    setState(() {
      _items[index] = _items[index].copyWith(isSelected: value);
      _updateFilteredItems();
    });
    // Don't call onSelectionChanged here - only call it when confirm is pressed
  }

  /// Update filtered items based on current search
  void _updateFilteredItems() {
    if (_searchQuery.isEmpty) {
      _filteredItems = List.from(_items);
    } else {
      _filteredItems = _items
          .where(
            (item) =>
                item.label.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    }
  }

  /// Build action buttons
  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(FCPConstants.spacingMd),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(widget.cancelText),
            ),
          ),
          const SizedBox(width: FCPConstants.spacingMd),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Return all items with their current selection state when confirming
                Navigator.of(context).pop(_items);
              },
              child: Text(widget.confirmText),
            ),
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
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
            const SizedBox(height: FCPConstants.spacingMd),
            Text(
              widget.emptyStateText,
              style: FCPTextStyles.getBodyMedium().copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Extension to show the multi-select dropdown bottom sheet directly
extension FCPMultiSelectDropdownExtension on BuildContext {
  /// Show a multi-select dropdown bottom sheet with the given parameters
  Future<List<FCPMultiSelectItem>?> showFCPMultiSelectDropdown({
    required String title,
    required List<FCPMultiSelectItem> items,
    required Function(List<FCPMultiSelectItem>) onSelectionChanged,
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
    bool isSearchEnabled = false,
    int? maxSelections,
    bool showSelectAll = false,
    String selectAllText = 'Select All',
    String deselectAllText = 'Deselect All',
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool showConfirmButton = true,
    Function(String)? onSearchChanged,
    Duration searchDebounceDuration = const Duration(milliseconds: 300),
    Widget Function(
      FCPMultiSelectItem item,
      int index,
      bool isSelected,
      Function(bool?) onChanged,
    )? customItemBuilder,
  }) {
    return showModalBottomSheet<List<FCPMultiSelectItem>>(
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
      builder: (context) => _MultiSelectBottomSheetContent(
        title: title,
        items: items,
        onSelectionChanged: onSelectionChanged,
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
        isSearchEnabled: isSearchEnabled,
        maxSelections: maxSelections,
        showSelectAll: showSelectAll,
        selectAllText: selectAllText,
        deselectAllText: deselectAllText,
        confirmText: confirmText,
        cancelText: cancelText,
        showConfirmButton: showConfirmButton,
        onSearchChanged: onSearchChanged,
        searchDebounceDuration: searchDebounceDuration,
        customItemBuilder: customItemBuilder,
      ),
    );
  }
}
