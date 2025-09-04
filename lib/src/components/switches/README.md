# Switch Components

A comprehensive collection of customizable switch components for Flutter applications.

## Components

### 1. FCPSwitch
A highly customizable toggle switch with full control over appearance and behavior.

**Features:**
- Fully customizable colors, sizes, and animations
- Support for labels, descriptions, and icons
- Multiple predefined configurations (iOS, Material, Compact, Large, etc.)
- Custom thumb widgets and background widgets
- Shadow and border customization

**Example:**
```dart
FCPSwitch(
  value: isEnabled,
  onChanged: (value) => setState(() => isEnabled = value),
  label: 'Enable Feature',
  description: 'Turn this feature on or off',
  config: SwitchConfigs.iosStyle,
)
```

### 2. FCPSingleSelectSwitch
A single-selection switch component for choosing one option from multiple choices.

**Features:**
- Radio button-like behavior
- Horizontal, vertical, or wrapped layouts
- Support for icons and descriptions
- Customizable spacing and alignment
- Optional titles and subtitles

**Example:**
```dart
FCPSingleSelectSwitch<String>(
  title: 'Choose Theme',
  options: [
    SwitchOption(value: 'light', label: 'Light', icon: Icons.light_mode),
    SwitchOption(value: 'dark', label: 'Dark', icon: Icons.dark_mode),
  ],
  selectedValue: selectedTheme,
  onChanged: (value) => setState(() => selectedTheme = value),
)
```

### 3. FCPMultiSelectSwitch
A multi-selection switch component for choosing multiple options.

**Features:**
- Checkbox-like behavior
- Select All and Clear All functionality
- Minimum and maximum selection limits
- Selection count display
- Flexible layouts

**Example:**
```dart
FCPMultiSelectSwitch<String>(
  title: 'Select Features',
  options: [
    SwitchOption(value: 'notifications', label: 'Notifications'),
    SwitchOption(value: 'location', label: 'Location'),
    SwitchOption(value: 'camera', label: 'Camera'),
  ],
  selectedValues: selectedFeatures,
  onChanged: (values) => setState(() => selectedFeatures = values),
  maxSelections: 2,
  showSelectAll: true,
)
```

### 4. FCPToggleSwitch
A toggle switch for switching between multiple states.

**Features:**
- Segmented control-like behavior
- Predefined state configurations
- Support for icons and descriptions
- Horizontal and vertical layouts

**Example:**
```dart
FCPToggleSwitch<String>(
  title: 'Signal Intensity',
  states: [
    ToggleState(value: 'low', label: 'Low', icon: Icons.signal_cellular_1_bar),
    ToggleState(value: 'medium', label: 'Medium', icon: Icons.signal_cellular_2_bar),
    ToggleState(value: 'high', label: 'High', icon: Icons.signal_cellular_4_bar),
  ],
  activeValue: intensity,
  onChanged: (value) => setState(() => intensity = value),
)
```

### 5. FCPSwitchGroup
A container for grouping multiple switches with consistent styling.

**Features:**
- Form-like layouts
- Customizable backgrounds and borders
- Flexible spacing and alignment
- Support for titles and subtitles

**Example:**
```dart
FCPSwitchGroup(
  title: 'App Settings',
  switches: [
    FCPSwitch(value: notifications, onChanged: (v) => setState(() => notifications = v)),
    FCPSwitch(value: darkMode, onChanged: (v) => setState(() => darkMode = v)),
  ],
  config: FCPSwitchGroupConfigs.formLayout,
)
```

## Configuration Classes

### SwitchConfig
Controls the appearance and behavior of individual switches.

```dart
const SwitchConfig(
  width: 54.0,
  height: 28.0,
  borderRadius: 16.0,
  animationDuration: Duration(milliseconds: 300),
  activeColor: Color(0xFF007AFF),
  inactiveColor: Color(0xFFE5E5E5),
  activeThumbColor: Colors.white,
  inactiveThumbColor: Color(0xFF007AFF),
  borderColor: Color(0xFFD4D4D4),
  borderWidth: 1.0,
  thumbSize: 20.0,
  thumbPadding: 4.0,
  showBorder: true,
  showShadow: false,
)
```

### SwitchLabelStyle
Controls the appearance of labels and descriptions.

```dart
const SwitchLabelStyle(
  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  descriptionStyle: TextStyle(fontSize: 12),
  enabledColor: Color(0xFF171717),
  disabledColor: Color(0xFFA3A3A3),
  spacing: 12.0,
  labelOnLeft: true,
)
```

### SwitchGroupConfig
Controls the layout and appearance of switch groups.

```dart
const SwitchGroupConfig(
  spacing: 16.0,
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.center,
  wrap: false,
  backgroundColor: Color(0xFFFAFAFA),
  borderRadius: 8.0,
  padding: EdgeInsets.all(16.0),
)
```

## Predefined Configurations

### SwitchConfigs
- `defaultConfig` - Standard configuration
- `iosStyle` - iOS-style switches
- `materialStyle` - Material Design switches
- `compact` - Smaller switches
- `large` - Larger switches
- `success` - Success-themed (green)
- `warning` - Warning-themed (orange)
- `error` - Error-themed (red)

### SwitchGroupConfigs
- `formLayout` - Form-style layout
- `horizontalCompact` - Compact horizontal layout
- `wrapped` - Wrapped layout for many switches
- `cardStyle` - Card-style layout
- `minimal` - Minimal layout without background

### ToggleSwitchConfigs
- `onOffStates` - On/Off toggle states
- `lowMediumHighStates` - Low/Medium/High intensity states
- `sizeStates` - Small/Medium/Large size states
- `themeStates` - Light/Dark theme states

## Data Models

### SwitchOption<T>
Represents an option in single or multi-select switches.

```dart
SwitchOption<String>(
  value: 'option1',
  label: 'Option 1',
  description: 'Description of option 1',
  enabled: true,
  icon: Icons.star,
)
```

### ToggleState<T>
Represents a state in toggle switches.

```dart
ToggleState<String>(
  value: 'active',
  label: 'Active',
  description: 'Active state',
  enabled: true,
  icon: Icons.check,
)
```

### FormSwitchItem
Represents an item in form switch groups.

```dart
FormSwitchItem(
  value: true,
  onChanged: (value) => setState(() => enabled = value),
  label: 'Enable Feature',
  description: 'Turn this feature on or off',
  enabled: true,
)
```

## Usage Tips

1. **Performance**: Use `const` constructors where possible to improve performance.
2. **Accessibility**: Always provide meaningful labels and descriptions for screen readers.
3. **Consistency**: Use predefined configurations to maintain consistent styling across your app.
4. **Responsive Design**: Use wrapped layouts for switches that need to adapt to different screen sizes.
5. **State Management**: Consider using state management solutions for complex switch interactions.

## Examples

See the Flutter Components Plus example app for comprehensive examples of all switch components and their configurations. The examples are integrated into the home view and components view of the example app.
