import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:async';
import '../../core/constants.dart';
import '../../core/theme/text_styles.dart';
import '../custom_cards/custom_cards.dart';
import '../custom_input_fields/custom_input_field.dart';

/// A professional dropdown component that displays a dropdown menu below the button
class FCPInlineDropdown extends StatefulWidget {
  /// Creates a dropdown component
  const FCPInlineDropdown({
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
    this.customItemBuilder,
    this.onSearchChanged,
    this.searchDebounceDuration = const Duration(milliseconds: 300),
    this.dividerColor,
    this.dividerExtent = 0.9,
    this.showDivider = true,
    this.buttonWidth,
    this.dropdownWidth,
  });

  /// The title displayed in the dropdown trigger
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

  /// Custom builder for items (overrides default item appearance)
  final Widget Function(String item, int index, bool isSelected)?
  customItemBuilder;

  /// Callback for search changes
  final Function(String)? onSearchChanged;

  /// Debounce duration for search input
  final Duration searchDebounceDuration;

  /// Color for the divider between items
  final Color? dividerColor;

  /// Extent of the divider (0.0 to 1.0)
  final double dividerExtent;

  /// Whether to show dividers between items
  final bool showDivider;

  /// Width of the dropdown button (null means auto-width)
  final double? buttonWidth;

  /// Width of the dropdown menu (null means same as button width)
  final double? dropdownWidth;

  @override
  State<FCPInlineDropdown> createState() => _FCPInlineDropdownState();
}

class _FCPInlineDropdownState extends State<FCPInlineDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  List<String> _filteredItems = [];
  Timer? _searchTimer;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredItems = List.from(widget.items);
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

    return CompositedTransformTarget(
      link: _layerLink,
      child: SizedBox(
        width: widget.buttonWidth,
        child: FCPCard(
          border: widget.enableBorder
              ? Border.all(
                  color: isDark
                      ? colorScheme.outline.withOpacity(0.2)
                      : colorScheme.outline.withOpacity(0.1),
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
                    color: colorScheme.onSurface.withOpacity(0.6),
                    size: 20,
                  ),
                  const SizedBox(width: FCPConstants.spacingMd),
                ],
                Expanded(
                  child: Text(
                    _getDisplayText(),
                    style: (widget.titleStyle ?? FCPTextStyles.getBodyMedium())
                        .copyWith(
                          color: widget.selectedIndex == null
                              ? colorScheme.onSurface.withOpacity(0.6)
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
                      color: colorScheme.onSurface.withOpacity(0.6),
                      size: 20,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Get the text to display in the dropdown trigger
  String _getDisplayText() {
    if (widget.selectedIndex == null ||
        widget.selectedIndex! < 0 ||
        widget.selectedIndex! >= widget.items.length) {
      return widget.title;
    }
    return widget.items[widget.selectedIndex!];
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

    // Calculate dropdown width (use button width if dropdown width is null)
    final effectiveDropdownWidth =
        widget.dropdownWidth ?? widget.buttonWidth ?? 300.0;

    _overlayEntry = OverlayEntry(
      builder: (context) => _DropdownOverlay(
        layerLink: _layerLink,
        items: _filteredItems,
        selectedIndex: widget.selectedIndex,
        onItemSelected: (value) {
          widget.onItemSelected(value);
          _removeOverlay();
        },
        isSearchEnabled: widget.isSearchEnabled,
        indexed: widget.indexed,
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
        customItemBuilder: widget.customItemBuilder,
        onSearchChanged: widget.onSearchChanged,
        searchDebounceDuration: widget.searchDebounceDuration,
        onClose: _removeOverlay,
        searchController: _searchController,
        onSearchInputChanged: _onSearchChanged,
        originalItems: widget.items,
        smartOffset: smartOffset,
        dividerColor: widget.dividerColor,
        dividerExtent: widget.dividerExtent,
        showDivider: widget.showDivider,
        dropdownWidth: effectiveDropdownWidth,
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

        // Always try to position below first, with a small margin
        if (spaceBelow >= estimatedHeight + 16) {
          // Enough space below - position below the button
          return Offset(0, buttonHeight + 4);
        } else if (spaceAbove >= estimatedHeight + 16) {
          // Not enough space below, but enough above - position above the button
          return Offset(0, -(estimatedHeight + 4));
        } else {
          // Not enough space in either direction - position below but allow scrolling
          return Offset(0, buttonHeight + 4);
        }
      }
    } catch (e) {
      // If we can't calculate, fall back to default positioning
    }

    // Default - position below the button
    return const Offset(0, 52); // Default button height + small margin
  }

  /// Estimate the dropdown height based on content
  double _estimateDropdownHeight() {
    double height = 0;

    // Add search field height if enabled
    if (widget.isSearchEnabled) {
      height += 56; // Approximate search field height
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

/// Overlay widget for the dropdown menu
class _DropdownOverlay extends StatefulWidget {
  const _DropdownOverlay({
    required this.layerLink,
    required this.items,
    required this.onItemSelected,
    required this.onClose,
    this.selectedIndex,
    this.isSearchEnabled = false,
    this.indexed = true,
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
    this.customItemBuilder,
    this.onSearchChanged,
    this.searchDebounceDuration = const Duration(milliseconds: 300),
    required this.searchController,
    required this.onSearchInputChanged,
    required this.originalItems,
    required this.smartOffset,
    this.dividerColor,
    this.dividerExtent = 0.9,
    this.showDivider = true,
    required this.dropdownWidth,
  });

  final LayerLink layerLink;
  final List<String> items;
  final Function(dynamic) onItemSelected;
  final VoidCallback onClose;
  final int? selectedIndex;
  final bool isSearchEnabled;
  final bool indexed;
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
  final Widget Function(String item, int index, bool isSelected)?
  customItemBuilder;
  final Function(String)? onSearchChanged;
  final Duration searchDebounceDuration;
  final TextEditingController searchController;
  final Function(String) onSearchInputChanged;
  final List<String> originalItems;
  final Offset smartOffset;
  final Color? dividerColor;
  final double dividerExtent;
  final bool showDivider;
  final double dropdownWidth;

  @override
  State<_DropdownOverlay> createState() => _DropdownOverlayState();
}

class _DropdownOverlayState extends State<_DropdownOverlay> {
  List<String> _localFilteredItems = [];
  Timer? _searchTimer;

  @override
  void initState() {
    super.initState();
    _localFilteredItems = List.from(widget.originalItems);
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
            // Reset to show all original items
            _localFilteredItems = List.from(widget.originalItems);
          } else {
            // Filter based on the original items
            _localFilteredItems = widget.originalItems
                .where(
                  (item) => item.toLowerCase().contains(query.toLowerCase()),
                )
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

    return Stack(
      children: [
        // Invisible overlay to capture taps outside
        Positioned.fill(
          child: GestureDetector(
            onTap: widget.onClose,
            child: Container(color: Colors.transparent),
          ),
        ),
        // Dropdown content
        Positioned(
          width: widget.dropdownWidth,
          child: CompositedTransformFollower(
            link: widget.layerLink,
            showWhenUnlinked: false,
            offset: widget.smartOffset,
            child: GestureDetector(
              onTap: () {}, // Prevent tap from propagating to parent
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                color: widget.backgroundColor ?? colorScheme.surface,
                child: Container(
                  constraints: BoxConstraints(maxHeight: widget.maxHeight),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    border: Border.all(
                      color: colorScheme.outline.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.isSearchEnabled) _buildSearchField(),
                      Flexible(child: _buildItemsList()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
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

    if (widget.showDivider) {
      return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: FCPConstants.spacingSm),
        shrinkWrap: true,
        itemCount: _localFilteredItems.length,
        separatorBuilder: (context, index) {
          return Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: widget.dropdownWidth * widget.dividerExtent,
              child: Divider(
                color: widget.dividerColor ?? Theme.of(context).dividerColor,
                height: widget.itemSpacing,
              ),
            ),
          );
        },
        itemBuilder: (context, index) {
          final item = _localFilteredItems[index];
          final originalIndex = widget.originalItems.indexOf(item);
          final isSelected = widget.selectedIndex == originalIndex;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: FCPConstants.spacingSm),
            child: InkWell(
              borderRadius: BorderRadius.circular(FCPConstants.radiusSm),
              onTap: () {
                widget.onItemSelected(widget.indexed ? originalIndex : item);
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
    } else {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: FCPConstants.spacingSm),
        shrinkWrap: true,
        itemCount: _localFilteredItems.length,
        itemBuilder: (context, index) {
          final item = _localFilteredItems[index];
          final originalIndex = widget.originalItems.indexOf(item);
          final isSelected = widget.selectedIndex == originalIndex;

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: FCPConstants.spacingSm,
              vertical: widget.itemSpacing / 2,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(FCPConstants.radiusSm),
              onTap: () {
                widget.onItemSelected(widget.indexed ? originalIndex : item);
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
  }

  /// Build the default item widget
  Widget _buildDefaultItem(String item, int index, bool isSelected) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(FCPConstants.radiusSm),
      onTap: () {
        widget.onItemSelected(widget.indexed ? index : item);
      },
      child: Container(
        height: widget.itemHeight,
        padding: const EdgeInsets.symmetric(horizontal: FCPConstants.spacingMd),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(FCPConstants.radiusSm),
          color: isSelected
              ? colorScheme.primaryContainer.withOpacity(0.1)
              : null,
        ),
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
                size: 18,
              ),
          ],
        ),
      ),
    );
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
            color: theme.colorScheme.onSurface.withOpacity(0.4),
          ),
          const SizedBox(height: FCPConstants.spacingSm),
          Text(
            widget.emptyStateText,
            style: FCPTextStyles.getBodySmall().copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Extension to show the dropdown overlay directly
extension FCPDropdownOverlayExtension on BuildContext {
  /// Show a dropdown overlay with the given parameters
  Future<T?> showFCPDropdownOverlay<T>({
    required LayerLink layerLink,
    required List<String> items,
    required Function(dynamic) onItemSelected,
    int? selectedIndex,
    bool isSearchEnabled = false,
    bool indexed = true,
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
    Widget Function(String item, int index, bool isSelected)? customItemBuilder,
    Function(String)? onSearchChanged,
    Duration searchDebounceDuration = const Duration(milliseconds: 300),
    Color? dividerColor,
    double dividerExtent = 0.9,
    bool showDivider = true,
    double? buttonWidth,
    double? dropdownWidth,
  }) {
    final completer = Completer<T?>();
    final searchController = TextEditingController();
    late OverlayEntry overlayEntry;

    // Calculate dropdown width (use button width if dropdown width is null)
    final effectiveDropdownWidth = dropdownWidth ?? buttonWidth ?? 300.0;

    overlayEntry = OverlayEntry(
      builder: (context) => _DropdownOverlay(
        layerLink: layerLink,
        items: items,
        selectedIndex: selectedIndex,
        onItemSelected: (value) {
          onItemSelected(value);
          overlayEntry.remove();
          completer.complete(value as T?);
        },
        isSearchEnabled: isSearchEnabled,
        indexed: indexed,
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
        smartOffset: const Offset(
          0,
          52,
        ), // Default button height + small margin
        dividerColor: dividerColor,
        dividerExtent: dividerExtent,
        showDivider: showDivider,
        dropdownWidth: effectiveDropdownWidth,
      ),
    );

    Overlay.of(this).insert(overlayEntry);
    return completer.future;
  }
}
