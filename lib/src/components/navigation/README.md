# Navigation Components

This directory contains navigation-related components for the Flutter Components Plus package.

## Components

### FCPBottomNavigationBar

A customizable bottom navigation bar component that provides a modern and accessible navigation experience.

#### Features

- **Customizable Colors**: Support for custom background, selected, and unselected item colors
- **Asset-based Icons**: Support for both regular and active icon states using asset images
- **Theme Integration**: Automatically integrates with the app's theme system
- **Accessibility**: Built-in accessibility support with proper labels and semantics
- **Flexible Layout**: Fixed type navigation bar with customizable elevation

#### Usage

```dart
import 'package:flutter_components_plus/flutter_components_plus.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    ProfilePage(),
    SettingsPage(),
  ];

  final List<String> _icons = [
    'assets/icons/home.png',
    'assets/icons/search.png',
    'assets/icons/profile.png',
    'assets/icons/settings.png',
  ];

  final List<String> _activeIcons = [
    'assets/icons/home_active.png',
    'assets/icons/search_active.png',
    'assets/icons/profile_active.png',
    'assets/icons/settings_active.png',
  ];

  final List<String> _labels = [
    'Home',
    'Search',
    'Profile',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: FCPBottomNavigationBar(
        currentIndex: _currentIndex,
        onItemChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        widgets: _pages,
        icons: _icons,
        activeIcons: _activeIcons,
        labels: _labels,
        // Optional customizations
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        elevation: 8,
      ),
    );
  }
}
```

#### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `currentIndex` | `int` | Yes | The currently selected tab index |
| `widgets` | `List<Widget>` | Yes | List of widgets to display for each tab |
| `icons` | `List<String>` | Yes | Asset paths for unselected tab icons |
| `activeIcons` | `List<String>` | Yes | Asset paths for selected tab icons |
| `labels` | `List<String>` | Yes | Labels for each tab |
| `onItemChanged` | `void Function(int)?` | No | Callback when tab selection changes |
| `backgroundColor` | `Color?` | No | Background color of the navigation bar |
| `selectedItemColor` | `Color?` | No | Color for selected tab items |
| `unselectedItemColor` | `Color?` | No | Color for unselected tab items |
| `elevation` | `double` | No | Elevation of the navigation bar (default: 6) |

#### Asset Requirements

- Icons should be PNG or JPG format
- Recommended size: 24x24 pixels
- Icons should be designed to work with color tinting
- Active icons should have the same dimensions as regular icons

#### Theme Integration

The component automatically uses colors from the app's theme:
- `selectedItemColor` defaults to `FCPColorScheme.primary`
- `unselectedItemColor` defaults to `FCPColorScheme.neutral500`
- `backgroundColor` defaults to the theme's surface color

#### Best Practices

1. **Consistent Iconography**: Use consistent icon styles across your app
2. **Clear Labels**: Use short, descriptive labels for each tab
3. **Accessibility**: Ensure icons have proper semantic meaning
4. **Performance**: Pre-load assets to avoid loading delays
5. **Responsive Design**: Test on different screen sizes and orientations
