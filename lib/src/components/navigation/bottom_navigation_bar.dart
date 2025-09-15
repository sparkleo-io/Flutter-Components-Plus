import 'package:flutter/material.dart';
import '../../core/theme/color_scheme.dart';

/// Custom Bottom Navigation Bar for Flutter Components Plus.
class FCPBottomNavigationBar extends StatelessWidget {
  /// Current index of the bottom navigation bar.
  final int currentIndex;

  /// Children of the navigation bar.
  final List<Widget> widgets;

  /// Icons of the navigation bar (asset paths).
  final List<String> icons;

  /// Active icons of the navigation bar (asset paths).
  final List<String> activeIcons;

  /// Labels of the navigation bar.
  final List<String> labels;

  /// Callback [onItemChanged] to be called when the item is changed.
  final void Function(int)? onItemChanged;

  /// Background color of the navigation bar.
  final Color? backgroundColor;

  /// Selected item color.
  final Color? selectedItemColor;

  /// Unselected item color.
  final Color? unselectedItemColor;

  /// Elevation of the navigation bar.
  final double elevation;

  /// Custom Bottom Navigation Bar for Flutter Components Plus.
  const FCPBottomNavigationBar({
    super.key,
    required this.currentIndex,
    this.onItemChanged,
    required this.widgets,
    required this.icons,
    required this.activeIcons,
    required this.labels,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.elevation = 6,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BottomNavigationBar(
      elevation: elevation,
      backgroundColor: backgroundColor ?? colorScheme.surface,
      selectedItemColor: selectedItemColor ?? FCPColorScheme.primary,
      unselectedItemColor: unselectedItemColor ?? FCPColorScheme.neutral500,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onItemChanged,
      selectedLabelStyle: theme.textTheme.labelSmall?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: theme.textTheme.labelSmall?.copyWith(
        fontWeight: FontWeight.w400,
      ),
      items: [
        for (int item = 0; item < widgets.length; item++) ...{
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 24,
              child: Image.asset(
                icons[item],
                color: unselectedItemColor ?? FCPColorScheme.neutral500,
              ),
            ),
            label: labels[item],
            activeIcon: SizedBox(
              height: 24,
              child: Image.asset(
                activeIcons[item],
                color: selectedItemColor ?? FCPColorScheme.primary,
              ),
            ),
          ),
        },
      ],
    );
  }
}
