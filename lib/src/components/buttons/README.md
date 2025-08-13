# FCPButton - Fluent API Button Component

A highly customizable button widget with an intuitive fluent API that allows you to chain button types, sizes, and variants.

## Features

- **Fluent API**: Chain methods like `FCPButton.small.primary()` or `FCPButton.large.outlined()`
- **Multiple Variants**: Primary, Secondary, Outlined, Ghost, Danger, Floating
- **Multiple Sizes**: Small, Medium, Large, Extra Large
- **Multiple Types**: Text, Icon, Icon with Text, Floating, Elevated, Contained
- **Loading States**: Built-in loading indicators
- **Disabled States**: Easy disabled state management
- **Customizable**: Full control over colors, borders, padding, elevation, etc.
- **Animations**: Smooth press animations

## Quick Start

```dart
import 'package:flutter_components_plus/flutter_components_plus.dart';

// Basic usage
FCPButton.medium.primary(text: 'Click me')

// With icon
FCPButton.large.outlined(
  text: 'Download',
  icon: Icons.download,
  iconPosition: IconPosition.start,
)

// Icon button
FCPButton.small.iconButton(icon: Icons.add)

// Floating button
FCPButton.medium.floating(
  text: 'Add Item',
  icon: Icons.add,
)
```

## API Reference

### Size Constructors

```dart
FCPButton.small    // Small size buttons
FCPButton.medium   // Medium size buttons (default)
FCPButton.large    // Large size buttons
FCPButton.extraLarge // Extra large size buttons
```

### Button Variants

Each size constructor provides these button variants:

#### Primary Buttons
```dart
FCPButton.small.primary(text: 'Primary Button')
FCPButton.medium.primary(text: 'Primary Button')
FCPButton.large.primary(text: 'Primary Button')
```

#### Secondary Buttons
```dart
FCPButton.small.secondary(text: 'Secondary Button')
FCPButton.medium.secondary(text: 'Secondary Button')
FCPButton.large.secondary(text: 'Secondary Button')
```

#### Outlined Buttons
```dart
FCPButton.small.outlined(text: 'Outlined Button')
FCPButton.medium.outlined(text: 'Outlined Button')
FCPButton.large.outlined(text: 'Outlined Button')
```

#### Ghost Buttons
```dart
FCPButton.small.ghost(text: 'Ghost Button')
FCPButton.medium.ghost(text: 'Ghost Button')
FCPButton.large.ghost(text: 'Ghost Button')
```

#### Danger Buttons
```dart
FCPButton.small.danger(text: 'Danger Button')
FCPButton.medium.danger(text: 'Danger Button')
FCPButton.large.danger(text: 'Danger Button')
```

#### Icon Buttons
```dart
FCPButton.small.iconButton(icon: Icons.add)
FCPButton.medium.iconButton(icon: Icons.edit)
FCPButton.large.iconButton(icon: Icons.delete)
```

#### Floating Buttons
```dart
FCPButton.small.floating(icon: Icons.add)
FCPButton.medium.floating(
  text: 'Add',
  icon: Icons.add,
)
FCPButton.large.floating(
  text: 'Create New',
  icon: Icons.create,
)
```

#### Elevated Buttons
```dart
FCPButton.small.elevated(text: 'Elevated Button')
FCPButton.medium.elevated(text: 'Elevated Button')
FCPButton.large.elevated(text: 'Elevated Button')
```

#### Contained Buttons
```dart
FCPButton.small.contained(text: 'Contained Button')
FCPButton.medium.contained(text: 'Contained Button')
FCPButton.large.contained(text: 'Contained Button')
```

## Parameters

All button variants support these common parameters:

### Basic Parameters
- `text` - Button text
- `onPressed` - Callback function when button is pressed
- `isLoading` - Shows loading indicator when true
- `isDisabled` - Disables the button when true

### Icon Parameters
- `icon` - Icon to display
- `iconPosition` - Position of icon (start or end)

### Styling Parameters
- `width` - Button width
- `height` - Button height
- `borderRadius` - Border radius
- `backgroundColor` - Background color
- `foregroundColor` - Text/icon color
- `borderColor` - Border color
- `textStyle` - Custom text style
- `padding` - Internal padding
- `margin` - External margin
- `elevation` - Shadow elevation
- `shadowColor` - Shadow color
- `animationDuration` - Animation duration

## Examples

### Basic Buttons
```dart
// Simple primary button
FCPButton.medium.primary(
  text: 'Submit',
  onPressed: () => print('Button pressed'),
)

// Outlined button with icon
FCPButton.large.outlined(
  text: 'Download File',
  icon: Icons.download,
  iconPosition: IconPosition.start,
  onPressed: () => downloadFile(),
)
```

### Icon Buttons
```dart
// Simple icon button
FCPButton.small.iconButton(
  icon: Icons.add,
  onPressed: () => addItem(),
)

// Large icon button with custom styling
FCPButton.large.iconButton(
  icon: Icons.favorite,
  backgroundColor: Colors.red,
  foregroundColor: Colors.white,
  borderRadius: 50,
  onPressed: () => toggleFavorite(),
)
```

### Floating Buttons
```dart
// Floating action button
FCPButton.medium.floating(
  text: 'Add Item',
  icon: Icons.add,
  onPressed: () => showAddDialog(),
)

// Floating icon button
FCPButton.large.floating(
  icon: Icons.create,
  backgroundColor: Colors.green,
  onPressed: () => createNew(),
)
```

### Loading States
```dart
// Loading primary button
FCPButton.medium.primary(
  text: 'Processing...',
  isLoading: true,
  onPressed: () => processData(),
)

// Loading icon button
FCPButton.small.iconButton(
  icon: Icons.refresh,
  isLoading: true,
  onPressed: () => refreshData(),
)
```

### Disabled States
```dart
// Disabled button
FCPButton.medium.outlined(
  text: 'Unavailable',
  isDisabled: true,
  onPressed: () => unavailableAction(),
)
```

### Custom Styling
```dart
// Custom colors and styling
FCPButton.large.primary(
  text: 'Custom Button',
  backgroundColor: Colors.purple,
  foregroundColor: Colors.yellow,
  borderRadius: 25,
  elevation: 8,
  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
  onPressed: () => customAction(),
)

// Full width button
FCPButton.medium.contained(
  text: 'Sign In',
  width: double.infinity,
  onPressed: () => signIn(),
)
```

### Advanced Examples
```dart
// Button with custom child widget
FCPButton.medium.primary(
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.star, color: Colors.yellow),
      SizedBox(width: 8),
      Text('Rate App'),
    ],
  ),
  onPressed: () => rateApp(),
)

// Button with custom animation duration
FCPButton.small.outlined(
  text: 'Quick Action',
  animationDuration: Duration(milliseconds: 100),
  onPressed: () => quickAction(),
)
```

## Button Types

The component automatically determines the button type based on the provided parameters:

- **Text Button**: Only text provided
- **Icon Button**: Only icon provided
- **Icon with Text**: Both text and icon provided
- **Floating**: Floating variant with enhanced shadows
- **Elevated**: Primary variant with default elevation
- **Contained**: Primary variant with solid background

## Best Practices

1. **Use appropriate sizes**: Small for compact spaces, Large for prominent actions
2. **Choose variants wisely**: Primary for main actions, Outlined for secondary actions
3. **Include icons**: Use icons to make buttons more intuitive
4. **Handle loading states**: Show loading indicators for async operations
5. **Provide feedback**: Use onPressed callbacks to handle user interactions
6. **Maintain consistency**: Use consistent button styles throughout your app

## Migration from Old API

If you were using the old constructor-based API:

```dart
// Old way
FCPButton(
  text: 'Click me',
  variant: FCPButtonVariant.primary,
  size: FCPButtonSize.medium,
)

// New fluent API
FCPButton.medium.primary(text: 'Click me')
```

The new API is more intuitive and provides better type safety and autocomplete support.
