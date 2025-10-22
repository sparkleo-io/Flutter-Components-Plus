# FCPSwitch Component

A highly customizable toggle switch component with smooth animations, multiple variants, and extensive customization options.

## Features

- **Smooth Animations**: Fluid toggle animations with customizable duration
- **Multiple Variants**: Standard switch and toggle switch variants
- **Customization**: Full control over colors, sizes, and styling
- **Accessibility**: Proper touch targets and screen reader support
- **Loading States**: Built-in loading indicator support
- **Custom Widgets**: Support for custom thumb and background widgets
- **Animations**: Smooth press animations and state transitions

## Variants

### Standard Switch (FCPSwitch)
A pure toggle switch without labels or text.

```dart
FCPSwitch(
  value: isEnabled,
  onChanged: (value) => setState(() => isEnabled = value),
)
```

### Toggle Switch (FCPToggleSwitch)
A switch with optional labels and text.

```dart
FCPToggleSwitch(
  value: isEnabled,
  onChanged: (value) => setState(() => isEnabled = value),
  leftLabel: 'Off',
  rightLabel: 'On',
)
```

## Basic Usage

### Simple Switch
```dart
bool _isEnabled = false;

FCPSwitch(
  value: _isEnabled,
  onChanged: (value) => setState(() => _isEnabled = value),
)
```

### Switch with Labels
```dart
bool _notifications = true;

FCPToggleSwitch(
  value: _notifications,
  onChanged: (value) => setState(() => _notifications = value),
  leftLabel: 'Disabled',
  rightLabel: 'Enabled',
)
```

### Switch with Custom Text
```dart
bool _darkMode = false;

FCPToggleSwitch(
  value: _darkMode,
  onChanged: (value) => setState(() => _darkMode = value),
  leftLabel: 'Light',
  rightLabel: 'Dark',
  textStyle: TextStyle(fontWeight: FontWeight.bold),
)
```

## Advanced Usage

### Custom Colors
```dart
FCPSwitch(
  value: _isEnabled,
  onChanged: (value) => setState(() => _isEnabled = value),
  activeColor: Colors.green,
  inactiveColor: Colors.grey,
  activeThumbColor: Colors.white,
  inactiveThumbColor: Colors.green,
  borderColor: Colors.grey,
)
```

### Custom Size
```dart
FCPSwitch(
  value: _isEnabled,
  onChanged: (value) => setState(() => _isEnabled = value),
  width: 80,
  height: 40,
  thumbSize: 32,
  thumbPadding: 4,
)
```

### Custom Animation
```dart
FCPSwitch(
  value: _isEnabled,
  onChanged: (value) => setState(() => _isEnabled = value),
  animationDuration: Duration(milliseconds: 500),
)
```

### Custom Border and Shadow
```dart
FCPSwitch(
  value: _isEnabled,
  onChanged: (value) => setState(() => _isEnabled = value),
  showBorder: true,
  borderColor: Colors.blue,
  borderWidth: 2,
  showShadow: true,
  shadowColor: Colors.black26,
  shadowBlurRadius: 8,
  shadowOffset: Offset(0, 4),
)
```

### Custom Thumb Widget
```dart
FCPSwitch(
  value: _isEnabled,
  onChanged: (value) => setState(() => _isEnabled = value),
  customThumb: Icon(
    _isEnabled ? Icons.check : Icons.close,
    color: _isEnabled ? Colors.green : Colors.red,
    size: 16,
  ),
)
```

### Custom Background Widgets
```dart
FCPSwitch(
  value: _isEnabled,
  onChanged: (value) => setState(() => _isEnabled = value),
  activeWidget: Icon(Icons.wifi, color: Colors.white, size: 16),
  inactiveWidget: Icon(Icons.wifi_off, color: Colors.grey, size: 16),
)
```

### Disabled State
```dart
FCPSwitch(
  value: _isEnabled,
  onChanged: null, // Disabled when onChanged is null
  enabled: false,  // Or use enabled property
)
```

### Loading State
```dart
FCPSwitch(
  value: _isEnabled,
  onChanged: _isLoading ? null : (value) => setState(() => _isEnabled = value),
  customThumb: _isLoading 
    ? SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(strokeWidth: 2),
      )
    : null,
)
```

## Toggle Switch Variants

### With Labels
```dart
FCPToggleSwitch(
  value: _isEnabled,
  onChanged: (value) => setState(() => _isEnabled = value),
  leftLabel: 'Off',
  rightLabel: 'On',
)
```

### With Custom Styling
```dart
FCPToggleSwitch(
  value: _isEnabled,
  onChanged: (value) => setState(() => _isEnabled = value),
  leftLabel: 'Disabled',
  rightLabel: 'Enabled',
  labelStyle: TextStyle(
    color: Colors.grey,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  ),
  activeLabelStyle: TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  ),
)
```

### With Icons
```dart
FCPToggleSwitch(
  value: _isEnabled,
  onChanged: (value) => setState(() => _isEnabled = value),
  leftLabel: 'Light',
  rightLabel: 'Dark',
  leftIcon: Icons.light_mode,
  rightIcon: Icons.dark_mode,
)
```

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class SwitchExample extends StatefulWidget {
  @override
  _SwitchExampleState createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool _notifications = true;
  bool _darkMode = false;
  bool _wifi = true;
  bool _bluetooth = false;
  bool _airplaneMode = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Switch Examples')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 24),
            
            // Basic Switch
            _buildSwitchTile(
              title: 'Notifications',
              subtitle: 'Receive push notifications',
              value: _notifications,
              onChanged: (value) => setState(() => _notifications = value),
            ),
            
            // Toggle Switch with Labels
            _buildToggleSwitchTile(
              title: 'Dark Mode',
              subtitle: 'Use dark theme',
              value: _darkMode,
              onChanged: (value) => setState(() => _darkMode = value),
              leftLabel: 'Light',
              rightLabel: 'Dark',
            ),
            
            // Custom Colors
            _buildSwitchTile(
              title: 'WiFi',
              subtitle: 'Connect to wireless networks',
              value: _wifi,
              onChanged: (value) => setState(() => _wifi = value),
              activeColor: Colors.green,
              inactiveColor: Colors.grey,
            ),
            
            // Custom Size
            _buildSwitchTile(
              title: 'Bluetooth',
              subtitle: 'Connect to Bluetooth devices',
              value: _bluetooth,
              onChanged: (value) => setState(() => _bluetooth = value),
              width: 60,
              height: 32,
              thumbSize: 24,
            ),
            
            // With Icons
            _buildToggleSwitchTile(
              title: 'Airplane Mode',
              subtitle: 'Disable all wireless connections',
              value: _airplaneMode,
              onChanged: (value) => setState(() => _airplaneMode = value),
              leftLabel: 'Off',
              rightLabel: 'On',
              leftIcon: Icons.flight,
              rightIcon: Icons.flight_takeoff,
            ),
            
            // Loading State
            _buildSwitchTile(
              title: 'Sync',
              subtitle: 'Synchronize data',
              value: _isLoading,
              onChanged: _isLoading ? null : (value) async {
                setState(() => _isLoading = true);
                await Future.delayed(Duration(seconds: 2));
                setState(() => _isLoading = false);
              },
              customThumb: _isLoading 
                ? SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : null,
            ),
            
            // Disabled State
            _buildSwitchTile(
              title: 'Premium Feature',
              subtitle: 'Requires premium subscription',
              value: false,
              onChanged: null,
              enabled: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool>? onChanged,
    Color? activeColor,
    Color? inactiveColor,
    double? width,
    double? height,
    double? thumbSize,
    Widget? customThumb,
    bool enabled = true,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: FCPSwitch(
        value: value,
        onChanged: onChanged,
        enabled: enabled,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        width: width,
        height: height,
        thumbSize: thumbSize,
        customThumb: customThumb,
      ),
    );
  }

  Widget _buildToggleSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool>? onChanged,
    String? leftLabel,
    String? rightLabel,
    IconData? leftIcon,
    IconData? rightIcon,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: FCPToggleSwitch(
        value: value,
        onChanged: onChanged,
        leftLabel: leftLabel,
        rightLabel: rightLabel,
        leftIcon: leftIcon,
        rightIcon: rightIcon,
      ),
    );
  }
}
```

## API Reference

### FCPSwitch Properties

| Property | Type | Description |
|----------|--------|-------------|
| `value` | `bool` | Current switch value |
| `onChanged` | `ValueChanged<bool>?` | Callback when value changes |
| `enabled` | `bool` | Whether switch is enabled |
| `width` | `double` | Switch width |
| `height` | `double` | Switch height |
| `borderRadius` | `double` | Border radius |
| `animationDuration` | `Duration` | Animation duration |
| `activeColor` | `Color` | Active background color |
| `inactiveColor` | `Color` | Inactive background color |
| `activeThumbColor` | `Color` | Active thumb color |
| `inactiveThumbColor` | `Color` | Inactive thumb color |
| `borderColor` | `Color` | Border color |
| `borderWidth` | `double` | Border width |
| `thumbSize` | `double` | Thumb size |
| `thumbPadding` | `double` | Thumb padding |
| `showBorder` | `bool` | Show border |
| `showShadow` | `bool` | Show shadow |
| `shadowColor` | `Color` | Shadow color |
| `shadowBlurRadius` | `double` | Shadow blur radius |
| `shadowOffset` | `Offset` | Shadow offset |
| `customThumb` | `Widget?` | Custom thumb widget |
| `activeWidget` | `Widget?` | Custom active background widget |
| `inactiveWidget` | `Widget?` | Custom inactive background widget |

### FCPToggleSwitch Properties

| Property | Type | Description |
|----------|--------|-------------|
| `value` | `bool` | Current switch value |
| `onChanged` | `ValueChanged<bool>?` | Callback when value changes |
| `leftLabel` | `String?` | Left side label |
| `rightLabel` | `String?` | Right side label |
| `leftIcon` | `IconData?` | Left side icon |
| `rightIcon` | `IconData?` | Right side icon |
| `labelStyle` | `TextStyle?` | Label text style |
| `activeLabelStyle` | `TextStyle?` | Active label text style |
| `iconSize` | `double` | Icon size |
| `iconColor` | `Color?` | Icon color |
| `activeIconColor` | `Color?` | Active icon color |
| All FCPSwitch properties | | Inherits all FCPSwitch properties |

## Best Practices

1. **Clear Labels**: Use descriptive labels that clearly indicate the switch function
2. **Consistent Sizing**: Use consistent switch sizes throughout your app
3. **Color Usage**: Use colors that match your app's theme and provide good contrast
4. **Loading States**: Show loading indicators for async operations
5. **Accessibility**: Ensure switches have proper touch targets and labels
6. **Animation**: Use smooth animations that enhance the user experience
7. **State Management**: Properly manage switch states and handle edge cases

## Accessibility

- All switches support proper touch targets (minimum 44x44)
- Screen reader support for switch labels and states
- High contrast mode support
- Keyboard navigation support
- Proper semantic structure for assistive technologies
