import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class TableHeader extends StatefulWidget {
  final Widget? suffix;
  final String title;
  final List<Widget>? actions;
  final bool search;
  final bool expandableSearch;
  final void Function(String?)? onSearch;
  final void Function()? onReload;
  final void Function()? onAddItem;
  final TableThemeConfig? themeConfig;

  const TableHeader({
    super.key,
    required this.suffix,
    required this.title,
    required this.actions,
    this.search = true,
    this.expandableSearch = true,
    this.onSearch,
    this.onAddItem,
    this.onReload,
    this.themeConfig,
  });

  @override
  State<TableHeader> createState() => _TableHeaderState();
}

class _TableHeaderState extends State<TableHeader> {
  Timer? timer;
  bool isSelected = false;
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  late StreamSubscription _subscription;

  @override
  initState() {
    super.initState();
    _subscription = FCPDataTable.stream.stream.listen((isSelected) {
      setState(() {
        this.isSelected = isSelected;
      });
    });
  }

  @override
  dispose() {
    _subscription.cancel();
    FCPDataTable.stream.close();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeConfig = widget.themeConfig ?? TableThemes.defaultTheme;

    return FCPTableCard(
      elevation: 0,
      color:
          themeConfig.headerBackgroundColor ??
          themeConfig.getTableBackgroundColor(Theme.of(context)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.suffix != null)
              Padding(
                padding: context.locale == const Locale('ar', 'SA')
                    ? const EdgeInsets.only(left: 8)
                    : const EdgeInsets.only(right: 8),
                child: widget.suffix,
              ),
            Text(
              widget.title,
              style: themeConfig.useAppTheme
                  ? (theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ) ??
                        const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ))
                  : FCPStyles.lgBoldStyle,
              overflow: TextOverflow.ellipsis,
            ),
            16.spaceY,
            Row(
              children: [
                if (widget.search)
                  widget.expandableSearch
                      ? AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          switchInCurve: Curves.easeOut,
                          switchOutCurve: Curves.easeIn,
                          transitionBuilder: (child, animation) =>
                              SizeTransition(
                                sizeFactor: animation,
                                axis: Axis.horizontal,
                                child: child,
                              ),
                          child: isSearching
                              ? SizedBox(
                                  key: const ValueKey('search_field'),
                                  width: 220,
                                  child: FCPInputField(
                                    controller: _searchController,
                                    focusNode: _searchFocusNode,
                                    hint: 'Search',
                                    onTapOutside: (event) {
                                      if (_searchController.text
                                          .trim()
                                          .isEmpty) {
                                        setState(() {
                                          isSearching = false;
                                        });
                                      }
                                    },
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: themeConfig.getIconColor(theme),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isSearching = false;
                                        });
                                        _searchController.clear();
                                        timer?.cancel();
                                        widget.onSearch?.call('');
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color:
                                            themeConfig.borderColor ??
                                            theme.dividerColor,
                                      ),
                                    ),
                                    onChanged: (query) {
                                      timer?.cancel();
                                      timer = Timer(
                                        const Duration(seconds: 1),
                                        () {
                                          widget.onSearch?.call(query);
                                        },
                                      );
                                    },
                                  ),
                                )
                              : IconButton(
                                  key: const ValueKey('search_icon'),
                                  icon: Icon(
                                    Icons.search_outlined,
                                    color: themeConfig.getIconColor(theme),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isSearching = true;
                                    });
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                          _searchFocusNode.requestFocus();
                                        });
                                  },
                                ),
                        )
                      : SizedBox(
                          width: 200,
                          child: FCPInputField(
                            hint: 'Search',
                            suffixIcon: Icon(
                              Icons.search_outlined,
                              color: themeConfig.getIconColor(theme),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color:
                                    themeConfig.borderColor ??
                                    theme.dividerColor,
                              ),
                            ),
                            onChanged: (query) {
                              timer?.cancel();
                              timer = Timer(const Duration(seconds: 1), () {
                                widget.onSearch?.call(query);
                              });
                            },
                          ),
                        ),
                const Spacer(),
                if (isSelected && widget.actions != null) ...widget.actions!,

                const SizedBox(width: 12),
                FCPButton.small.primary(
                  onPressed: widget.onReload,
                  icon: Icons.refresh,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
