import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';
import '../chi_data_table.dart';
import '../extensions/table_extensions.dart';
import '../table_theme_config.dart';

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
    _subscription = CHIDataTable.stream.stream.listen((isSelected) {
      setState(() {
        this.isSelected = isSelected;
      });
    });
  }

  @override
  dispose() {
    _subscription.cancel();
    CHIDataTable.stream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeConfig = widget.themeConfig ?? TableThemes.defaultTheme;

    return CHICard(
      elevation: 0,
      color:
          themeConfig.headerBackgroundColor ??
          themeConfig.getTableBackgroundColor(Theme.of(context)),
      // Colors.transparent,
      child: Row(
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
                : CHIStyles.lgBoldStyle,
          ),
          16.spaceX,
          if (widget.search)
            SizedBox(
              width: context.kWidth / 4,
              child: FCPInputField(
                hint: 'Search',
                // enableBorder: true,
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
          12.spaceX,
          FCPButton.small.outlined(
            onPressed: widget.onAddItem,
            icon: Icons.add,
          ),
          12.spaceX,
          FCPButton.small.primary(
            onPressed: widget.onReload,
            icon: Icons.refresh,
          ),
          // CHIActionButton(
          //   onTap: widget.onReload,
          //   child: const Icon(Icons.refresh),
          // ),
        ],
      ),
    );
  }
}
