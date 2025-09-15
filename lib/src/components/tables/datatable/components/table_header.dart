import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class TableHeader extends StatefulWidget {
  final Widget? suffix;
  final String title;
  final List<Widget>? actions;
  final bool search;
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
                  SizedBox(
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
                          color: themeConfig.borderColor ?? theme.dividerColor,
                        ),
                      ),
                      onChanged: (query) {
                        timer?.cancel();
                        timer = Timer(const Duration(seconds: 1), () {
                          if (widget.onSearch != null) {
                            widget.onSearch!(query);
                          }
                        });
                      },
                    ),
                  ),
                const Spacer(),
                if (isSelected && widget.actions != null) ...widget.actions!,
                // const SizedBox(width: 12),
                // FCPButton.small.outlined(
                //   onPressed: widget.onAddItem,
                //   icon: Icons.add,
                // ),
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
