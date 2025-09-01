import 'package:flutter/material.dart';

import 'dart:async';
import '../../core/constants.dart';
import '../../core/theme/text_styles.dart';
import '../custom_cards/custom_cards.dart';
import '../custom_input_fields/custom_input_field.dart';

/// A data model for multi-select items
class FCPMultiInlineItem {
  /// Creates a multi-select item
  const FCPMultiInlineItem({
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
  FCPMultiInlineItem copyWith({
    String? label,
    String? value,
    bool? isSelected,
    bool? disabled,
  }) {
    return FCPMultiInlineItem(
      label: label ?? this.label,
      value: value ?? this.value,
      isSelected: isSelected ?? this.isSelected,
      disabled: disabled ?? this.disabled,
    );
  }
}

/// A professional multi-select inline dropdown component that displays a dropdown menu below the button
class FCPMultiInlineDropdown extends StatefulWidget {
  /// Creates a multi-select inline dropdown component
  const FCPMultiInlineDropdown({
    super.key,
    required this.title,
    required this.items,
    required this.onSelectionChanged,
    this.selectedItems = const [],
    this.prefixIcon,
    this.enableBorder = false,
    this.disabled = false,
    this.isSearchEnabled = false,
    this.maxHeight = 300.0,
    this.borderRadius = 8.0,
    this.itemHeight = 48.0,
    this.itemSpacing = 4.0,
    this.titleStyle,
    this.itemTextStyle,
    this.selectedItemTextStyle,
    this.selectedItemIconColor,
    this.backgroundColor,
    this.searchHintText = 'Search',
    this.emptyStateText = 'No items found',
    this.showEmptyState = true,
    this.maxSelections,
    this.showSelectAll = false,
    this.selectAllText = 'Select All',
    this.deselectAllText = 'Deselect All',
    this.customItemBuilder,
    this.onSearchChanged,
    this.searchDebounceDuration = const Duration(milliseconds: 300),
  });

  /// The title displayed in the dropdown trigger
  final String title;

  /// List of items to display in the dropdown
  final List<FCPMultiInlineItem> items;

  /// Callback function when selection changes
  final Function(List<FCPMultiInlineItem>) onSelectionChanged;

  /// Currently selected items
  final List<FCPMultiInlineItem> selectedItems;

  /// Optional prefix icon for the dropdown trigger
  final IconData? prefixIcon;

  /// Whether to show a border around the dropdown trigger
  final bool enableBorder;

  /// Whether the dropdown is disabled
  final bool disabled;

  /// Whether to enable search functionality
  final bool isSearchEnabled;

  /// Maximum height for the dropdown menu
  final double maxHeight;

  /// Border radius for the dropdown menu
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

  /// Background color for the dropdown menu
  final Color? backgroundColor;

  /// Hint text for the search field
  final String searchHintText;

  /// Text to display when no items are found
  final String emptyStateText;

  /// Whether to show empty state when no items match search
  final bool showEmptyState;

  /// Maximum number of items that can be selected (null for unlimited)
  final int? maxSelections;

  /// Whether to show select all/deselect all option
  final bool showSelectAll;

  /// Text for select all button
  final String selectAllText;

  /// Text for deselect all button
  final String deselectAllText;

  /// Custom builder for items (overrides default item appearance)
  final Widget Function(
    FCPMultiInlineItem item,
    int index,
    bool isSelected,
    Function(bool?) onChanged,
  )?
  customItemBuilder;

  /// Callback for search changes
  final Function(String)? onSearchChanged;

  /// Debounce duration for search input
  final Duration searchDebounceDuration;

  @override
  State<FCPMultiInlineDropdown> createState() => _FCPMultiInlineDropdownState();
}

class _FCPMultiInlineDropdownState extends State<FCPMultiInlineDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  List<FCPMultiInlineItem> _filteredItems = [];
  Timer? _searchTimer;
  final TextEditingController _searchController = TextEditingController();
  late List<FCPMultiInlineItem> _localItems;

  @override
  void initState() {
    super.initState();
    _localItems = List.from(widget.items);
    _filteredItems = List.from(_localItems);
  }

  @override
  void didUpdateWidget(FCPMultiInlineDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _localItems = List.from(widget.items);
      _filteredItems = List.from(_localItems);
    }
  }

  @override
  void dispose() {
    _searchTimer?.cancel();
    _searchController.dispose();
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final selectedCount = _localItems.where((item) => item.isSelected).length;

    return CompositedTransformTarget(
      link: _layerLink,
      child: FCPCard(
        border: widget.enableBorder
            ? Border.all(
                color: isDark
                    ? colorScheme.outline.withValues(alpha: 0.2)
                    : colorScheme.outline.withValues(alpha: 0.1),
              )
            : null,
        borderRadius: FCPConstants.radiusSm,
        onTap: widget.disabled ? null : _toggleDropdown,
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
                AnimatedRotation(
                  turns: _isOpen ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                    size: 20,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Get the text to display in the dropdown trigger
  String _getDisplayText(int selectedCount) {
    if (selectedCount == 0) {
      return widget.title;
    } else if (selectedCount == 1) {
      final selectedItem = _localItems.firstWhere((item) => item.isSelected);
      return selectedItem.label;
    } else {
      return '$selectedCount items selected';
    }
  }

  /// Toggle the dropdown menu
  void _toggleDropdown() {
    if (_isOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  /// Show the overlay dropdown menu
  void _showOverlay() {
    _removeOverlay();

    // Calculate smart positioning before creating the overlay
    final smartOffset = _calculateSmartOffset();

    _overlayEntry = OverlayEntry(
      builder: (context) => _MultiDropdownOverlay(
        layerLink: _layerLink,
        items: _filteredItems,
        localItems: _localItems,
        onSelectionChanged: (selectedItems) {
          setState(() {
            _localItems = selectedItems;
          });
          widget.onSelectionChanged(selectedItems);
        },
        isSearchEnabled: widget.isSearchEnabled,
        maxHeight: widget.maxHeight,
        borderRadius: widget.borderRadius,
        itemHeight: widget.itemHeight,
        itemSpacing: widget.itemSpacing,
        itemTextStyle: widget.itemTextStyle,
        selectedItemTextStyle: widget.selectedItemTextStyle,
        selectedItemIconColor: widget.selectedItemIconColor,
        backgroundColor: widget.backgroundColor,
        searchHintText: widget.searchHintText,
        emptyStateText: widget.emptyStateText,
        showEmptyState: widget.showEmptyState,
        maxSelections: widget.maxSelections,
        showSelectAll: widget.showSelectAll,
        selectAllText: widget.selectAllText,
        deselectAllText: widget.deselectAllText,
        customItemBuilder: widget.customItemBuilder,
        onSearchChanged: widget.onSearchChanged,
        searchDebounceDuration: widget.searchDebounceDuration,
        onClose: _removeOverlay,
        searchController: _searchController,
        onSearchInputChanged: _onSearchChanged,
        originalItems: widget.items,
        smartOffset: smartOffset,
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isOpen = true;
    });
  }

  /// Remove the overlay dropdown menu
  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) {
      setState(() {
        _isOpen = false;
      });
    }
  }

  /// Handle search input changes with debouncing
  void _onSearchChanged(String query) {
    widget.onSearchChanged?.call(query);

    _searchTimer?.cancel();
    _searchTimer = Timer(widget.searchDebounceDuration, () {
      if (mounted) {
        setState(() {
          if (query.isEmpty) {
            _filteredItems = List.from(_localItems);
          } else {
            _filteredItems = _localItems
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

  /// Calculate smart offset based on available space
  Offset _calculateSmartOffset() {
    try {
      // Get the screen size
      final mediaQuery = MediaQuery.of(context);
      final screenHeight = mediaQuery.size.height;

      // Estimate dropdown height
      final estimatedHeight = _estimateDropdownHeight();

      // Get the button position using the layer link
      final RenderBox? buttonBox = _getButtonRenderBox();
      if (buttonBox != null) {
        final buttonPosition = buttonBox.localToGlobal(Offset.zero);
        final buttonHeight = buttonBox.size.height;
        final buttonBottom = buttonPosition.dy + buttonHeight;

        // Calculate available space below and above
        final spaceBelow = screenHeight - buttonBottom;
        final spaceAbove = buttonPosition.dy;

        // Determine positioning
        if (spaceBelow >= estimatedHeight + 8) {
          // Enough space below - position below the button
          return const Offset(0, 8);
        } else if (spaceAbove >= estimatedHeight + 8) {
          // Not enough space below, but enough above - position above the button
          return Offset(0, -(estimatedHeight + 8));
        }
      }
    } catch (e) {
      // If we can't calculate, fall back to default positioning
    }

    // Default - position below the button
    return const Offset(0, 8);
  }

  /// Estimate the dropdown height based on content
  double _estimateDropdownHeight() {
    double height = 0;

    // Add search field height if enabled
    if (widget.isSearchEnabled) {
      height += 56; // Approximate search field height
    }

    // Add select all section height if enabled
    if (widget.showSelectAll) {
      height += 48; // Approximate select all section height
    }

    // Add items height
    final itemCount = _filteredItems.length;
    height +=
        (itemCount * widget.itemHeight) + (itemCount * widget.itemSpacing);

    // Add padding
    height += 16;

    // Ensure it doesn't exceed max height
    return height.clamp(100, widget.maxHeight);
  }

  /// Get the button's render box for positioning calculations
  RenderBox? _getButtonRenderBox() {
    try {
      // Get the current widget's render box
      final RenderBox? currentBox = context.findRenderObject() as RenderBox?;
      if (currentBox != null) {
        return currentBox;
      }
    } catch (e) {
      // If we can't get the render box, return null
    }
    return null;
  }
}

/// Overlay widget for the multi-select dropdown menu
class _MultiDropdownOverlay extends StatefulWidget {
  const _MultiDropdownOverlay({
    required this.layerLink,
    required this.items,
    required this.localItems,
    required this.onSelectionChanged,
    required this.onClose,
    this.isSearchEnabled = false,
    this.maxHeight = 300.0,
    this.borderRadius = 8.0,
    this.itemHeight = 48.0,
    this.itemSpacing = 4.0,
    this.itemTextStyle,
    this.selectedItemTextStyle,
    this.selectedItemIconColor,
    this.backgroundColor,
    this.searchHintText = 'Search',
    this.emptyStateText = 'No items found',
    this.showEmptyState = true,
    this.maxSelections,
    this.showSelectAll = false,
    this.selectAllText = 'Select All',
    this.deselectAllText = 'Deselect All',
    this.customItemBuilder,
    this.onSearchChanged,
    this.searchDebounceDuration = const Duration(milliseconds: 300),
    required this.searchController,
    required this.onSearchInputChanged,
    required this.originalItems,
    required this.smartOffset,
  });

  final LayerLink layerLink;
  final List<FCPMultiInlineItem> items;
  final List<FCPMultiInlineItem> localItems;
  final Function(List<FCPMultiInlineItem>) onSelectionChanged;
  final VoidCallback onClose;
  final bool isSearchEnabled;
  final double maxHeight;
  final double borderRadius;
  final double itemHeight;
  final double itemSpacing;
  final TextStyle? itemTextStyle;
  final TextStyle? selectedItemTextStyle;
  final Color? selectedItemIconColor;
  final Color? backgroundColor;
  final String searchHintText;
  final String emptyStateText;
  final bool showEmptyState;
  final int? maxSelections;
  final bool showSelectAll;
  final String selectAllText;
  final String deselectAllText;
  final Widget Function(
    FCPMultiInlineItem item,
    int index,
    bool isSelected,
    Function(bool?) onChanged,
  )?
  customItemBuilder;
  final Function(String)? onSearchChanged;
  final Duration searchDebounceDuration;
  final TextEditingController searchController;
  final Function(String) onSearchInputChanged;
  final List<FCPMultiInlineItem> originalItems;
  final Offset smartOffset;

  @override
  State<_MultiDropdownOverlay> createState() => _MultiDropdownOverlayState();
}

class _MultiDropdownOverlayState extends State<_MultiDropdownOverlay> {
  List<FCPMultiInlineItem> _localFilteredItems = [];
  List<FCPMultiInlineItem> _localItems = [];
  Timer? _searchTimer;

  @override
  void initState() {
    super.initState();
    _localItems = List.from(widget.localItems);
    // Start filtered list from local items to keep identity and order aligned
    _localFilteredItems = List.from(_localItems);
  }

  @override
  void dispose() {
    _searchTimer?.cancel();
    super.dispose();
  }

  /// Handle search input changes with debouncing
  void _onSearchChanged(String query) {
    widget.onSearchChanged?.call(query);

    _searchTimer?.cancel();
    _searchTimer = Timer(widget.searchDebounceDuration, () {
      if (mounted) {
        setState(() {
          if (query.isEmpty) {
            // Reset to show all local items
            _localFilteredItems = List.from(_localItems);
          } else {
            // Filter based on the current local items
            final q = query.toLowerCase();
            _localFilteredItems = _localItems
                .where((item) => item.label.toLowerCase().contains(q))
                .toList();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Positioned(
      width: 300, // Increased width for better usability
      child: CompositedTransformFollower(
        link: widget.layerLink,
        showWhenUnlinked: false,
        offset: widget.smartOffset,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: widget.backgroundColor ?? colorScheme.surface,
          child: Container(
            constraints: BoxConstraints(maxHeight: widget.maxHeight),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.showSelectAll) _buildSelectAllSection(),
                if (widget.isSearchEnabled) _buildSearchField(),
                Flexible(child: _buildItemsList()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build the select all section
  Widget _buildSelectAllSection() {
    final theme = Theme.of(context);
    final selectedCount = _localItems.where((item) => item.isSelected).length;
    final totalCount = _localItems.length;
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
                  for (int i = 0; i < _localItems.length; i++) {
                    if (!_localItems[i].disabled) {
                      _localItems[i] = _localItems[i].copyWith(
                        isSelected: true,
                      );
                    }
                  }
                } else {
                  // Deselect all
                  for (int i = 0; i < _localItems.length; i++) {
                    _localItems[i] = _localItems[i].copyWith(isSelected: false);
                  }
                }
                _updateFilteredItems();
              });
              widget.onSelectionChanged(_localItems);
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
      padding: const EdgeInsets.all(FCPConstants.spacingSm),
      child: FCPInputField(
        controller: widget.searchController,
        hint: widget.searchHintText,
        prefixIcon: const Icon(Icons.search, size: 18),
        onChanged: _onSearchChanged,
      ),
    );
  }

  /// Build the items list
  Widget _buildItemsList() {
    if (_localFilteredItems.isEmpty && widget.showEmptyState) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: FCPConstants.spacingSm),
      shrinkWrap: true,
      itemCount: _localFilteredItems.length,
      itemBuilder: (context, index) {
        final item = _localFilteredItems[index];
        // Find the index in the current local items by stable key (label)
        final originalIndex = _localItems.indexWhere(
          (it) => it.label == item.label,
        );
        if (originalIndex < 0) {
          // Item not found in local list; skip rendering to prevent RangeError
          return const SizedBox.shrink();
        }
        final isSelected = _localItems[originalIndex].isSelected;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: FCPConstants.spacingSm,
            vertical: widget.itemSpacing / 2,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(FCPConstants.radiusSm),
            onTap: () {
              _onItemChanged(originalIndex, !isSelected);
            },
            child:
                widget.customItemBuilder?.call(
                  item,
                  originalIndex,
                  isSelected,
                  (value) => _onItemChanged(originalIndex, value),
                ) ??
                _buildDefaultItem(item, originalIndex, isSelected),
          ),
        );
      },
    );
  }

  /// Build the default item widget
  Widget _buildDefaultItem(
    FCPMultiInlineItem item,
    int index,
    bool isSelected,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(FCPConstants.radiusSm),
      onTap: () {
        _onItemChanged(index, !isSelected);
      },
      child: Container(
        height: widget.itemHeight,
        padding: const EdgeInsets.symmetric(horizontal: FCPConstants.spacingMd),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(FCPConstants.radiusSm),
          color: isSelected
              ? colorScheme.primaryContainer.withValues(alpha: 0.1)
              : null,
        ),
        child: Row(
          children: [
            Checkbox(
              value: isSelected,
              onChanged: (value) => _onItemChanged(index, value),
            ),
            const SizedBox(width: FCPConstants.spacingSm),
            Expanded(
              child: Text(
                item.label,
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
          ],
        ),
      ),
    );
  }

  /// Handle item selection change
  void _onItemChanged(int index, bool? value) {
    if (value == null || _localItems[index].disabled) return;

    // Check max selections limit
    if (value && widget.maxSelections != null) {
      final selectedCount = _localItems.where((item) => item.isSelected).length;
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
      _localItems[index] = _localItems[index].copyWith(isSelected: value);
      _updateFilteredItems();
    });
    widget.onSelectionChanged(_localItems);
  }

  /// Update filtered items based on current search
  void _updateFilteredItems() {
    final term = widget.searchController.text.trim().toLowerCase();
    if (term.isEmpty) {
      _localFilteredItems = List.from(_localItems);
    } else {
      _localFilteredItems = _localItems
          .where((item) => item.label.toLowerCase().contains(term))
          .toList();
    }
  }

  /// Build empty state widget
  Widget _buildEmptyState() {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(FCPConstants.spacingLg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off,
            size: 32,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
          ),
          const SizedBox(height: FCPConstants.spacingSm),
          Text(
            widget.emptyStateText,
            style: FCPTextStyles.getBodySmall().copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Extension to show the multi-select dropdown overlay directly
extension FCPMultiDropdownOverlayExtension on BuildContext {
  /// Show a multi-select dropdown overlay with the given parameters
  Future<List<FCPMultiInlineItem>?> showFCPMultiDropdownOverlay({
    required LayerLink layerLink,
    required List<FCPMultiInlineItem> items,
    required Function(List<FCPMultiInlineItem>) onSelectionChanged,
    List<FCPMultiInlineItem> selectedItems = const [],
    bool isSearchEnabled = false,
    double maxHeight = 300.0,
    double borderRadius = 8.0,
    double itemHeight = 48.0,
    double itemSpacing = 4.0,
    TextStyle? itemTextStyle,
    TextStyle? selectedItemTextStyle,
    Color? selectedItemIconColor,
    Color? backgroundColor,
    String searchHintText = 'Search',
    String emptyStateText = 'No items found',
    bool showEmptyState = true,
    int? maxSelections,
    bool showSelectAll = false,
    String selectAllText = 'Select All',
    String deselectAllText = 'Deselect All',
    Widget Function(
      FCPMultiInlineItem item,
      int index,
      bool isSelected,
      Function(bool?) onChanged,
    )?
    customItemBuilder,
    Function(String)? onSearchChanged,
    Duration searchDebounceDuration = const Duration(milliseconds: 300),
  }) {
    final completer = Completer<List<FCPMultiInlineItem>?>();
    final searchController = TextEditingController();
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _MultiDropdownOverlay(
        layerLink: layerLink,
        items: items,
        localItems: List.from(items),
        onSelectionChanged: (selectedItems) {
          onSelectionChanged(selectedItems);
          overlayEntry.remove();
          completer.complete(selectedItems);
        },
        isSearchEnabled: isSearchEnabled,
        maxHeight: maxHeight,
        borderRadius: borderRadius,
        itemHeight: itemHeight,
        itemSpacing: itemSpacing,
        itemTextStyle: itemTextStyle,
        selectedItemTextStyle: selectedItemTextStyle,
        selectedItemIconColor: selectedItemIconColor,
        backgroundColor: backgroundColor,
        searchHintText: searchHintText,
        emptyStateText: emptyStateText,
        showEmptyState: showEmptyState,
        maxSelections: maxSelections,
        showSelectAll: showSelectAll,
        selectAllText: selectAllText,
        deselectAllText: deselectAllText,
        customItemBuilder: customItemBuilder,
        onSearchChanged: onSearchChanged,
        searchDebounceDuration: searchDebounceDuration,
        onClose: () {
          overlayEntry.remove();
          completer.complete(null);
        },
        searchController: searchController,
        onSearchInputChanged: (query) {
          // Handle search changes
        },
        originalItems: items,
        smartOffset: const Offset(0, 8), // Default for extension
      ),
    );

    Overlay.of(this).insert(overlayEntry);
    return completer.future;
  }
}
