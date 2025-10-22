# FCPButton Component

A highly customizable button component with fluent API design, supporting multiple variants, sizes, and types with extensive customization options.

## Features

- **Fluent API Design**: Easy-to-use builder pattern for creating buttons
- **Multiple Variants**: Primary, secondary, outline, ghost, danger, and floating buttons
- **Size Options**: Small, medium, large, and extra-large sizes
- **Button Types**: Text, outlined, icon, icon with text, floating, elevated, and contained
- **Loading States**: Built-in loading indicator support
- **Animations**: Smooth press animations and transitions
- **Customization**: Full control over colors, borders, shadows, and styling
- **Accessibility**: Proper touch targets and disabled states

## Variants

### Primary Button
The main action button with solid background color.

```dart
FCPButton.medium.primary(
  text: 'Primary Button',
  onPressed: () => print('Primary button pressed'),
)
```

### Secondary Button
Secondary action button with different background color.

```dart
FCPButton.medium.secondary(
  text: 'Secondary Button',
  onPressed: () => print('Secondary button pressed'),
)
```

### Outline Button
Button with border and transparent background.

```dart
FCPButton.medium.outlined(
  text: 'Outline Button',
  onPressed: () => print('Outline button pressed'),
)
```

### Ghost Button
Transparent button with no background or border.

```dart
FCPButton.medium.ghost(
  text: 'Ghost Button',
  onPressed: () => print('Ghost button pressed'),
)
```

### Danger Button
Button for destructive actions with error color scheme.

```dart
FCPButton.medium.danger(
  text: 'Delete',
  onPressed: () => print('Danger button pressed'),
)
```

### Floating Button
Elevated button with shadow, typically for primary actions.

```dart
FCPButton.medium.floating(
  text: 'Floating Button',
  icon: Icons.add,
  onPressed: () => print('Floating button pressed'),
)
```

## Sizes

### Small Button
```dart
FCPButton.small.primary(
  text: 'Small',
  onPressed: () {},
)
```

### Medium Button (Default)
```dart
FCPButton.medium.primary(
  text: 'Medium',
  onPressed: () {},
)
```

### Large Button
```dart
FCPButton.large.primary(
  text: 'Large',
  onPressed: () {},
)
```

### Extra Large Button
```dart
FCPButton.extraLarge.primary(
  text: 'Extra Large',
  onPressed: () {},
)
```

## Button Types

### Text Button
Simple text-only button.

```dart
FCPButton.medium.primary(
  text: 'Text Button',
  onPressed: () {},
)
```

### Icon Button
Button with icon only.

```dart
FCPButton.medium.iconButton(
  icon: Icons.favorite,
  onPressed: () {},
)
```

### Icon with Text Button
Button with both icon and text.

```dart
FCPButton.medium.primary(
  text: 'Save',
  icon: Icons.save,
  iconPosition: IconPosition.start,
  onPressed: () {},
)
```

### Elevated Button
Button with elevation/shadow.

```dart
FCPButton.medium.elevated(
  text: 'Elevated',
  onPressed: () {},
)
```

### Contained Button
Button with solid background.

```dart
FCPButton.medium.contained(
  text: 'Contained',
  onPressed: () {},
)
```

## Advanced Usage

### Loading State
```dart
FCPButton.medium.primary(
  text: 'Loading...',
  isLoading: true,
  onPressed: () {},
)
```

### Disabled State
```dart
FCPButton.medium.primary(
  text: 'Disabled',
  isDisabled: true,
  onPressed: () {},
)
```

### Custom Styling
```dart
FCPButton.medium.primary(
  text: 'Custom',
  backgroundColor: Colors.purple,
  foregroundColor: Colors.white,
  borderRadius: 20,
  borderColor: Colors.purple,
  borderWidth: 2,
  elevation: 8,
  shadowColor: Colors.purple.withOpacity(0.3),
  onPressed: () {},
)
```

### Custom Padding and Margins
```dart
FCPButton.medium.primary(
  text: 'Custom Spacing',
  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
  margin: EdgeInsets.all(8),
  onPressed: () {},
)
```

### Custom Animation
```dart
FCPButton.medium.primary(
  text: 'Animated',
  animationDuration: Duration(milliseconds: 500),
  onPressed: () {},
)
```

### Custom Child Widget
```dart
FCPButton.medium.primary(
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.star, size: 16),
      SizedBox(width: 8),
      Text('Custom Child'),
    ],
  ),
  onPressed: () {},
)
```

## Icon Positions

### Icon at Start
```dart
FCPButton.medium.primary(
  text: 'Start Icon',
  icon: Icons.arrow_forward,
  iconPosition: IconPosition.start,
  onPressed: () {},
)
```

### Icon at End (Default)
```dart
FCPButton.medium.primary(
  text: 'End Icon',
  icon: Icons.arrow_forward,
  iconPosition: IconPosition.end,
  onPressed: () {},
)
```

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class ButtonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Button Examples')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Primary buttons
            FCPButton.medium.primary(
              text: 'Primary Button',
              onPressed: () => _showSnackBar(context, 'Primary pressed'),
            ),
            SizedBox(height: 16),
            
            // Secondary button
            FCPButton.medium.secondary(
              text: 'Secondary Button',
              onPressed: () => _showSnackBar(context, 'Secondary pressed'),
            ),
            SizedBox(height: 16),
            
            // Outline button
            FCPButton.medium.outlined(
              text: 'Outline Button',
              onPressed: () => _showSnackBar(context, 'Outline pressed'),
            ),
            SizedBox(height: 16),
            
            // Ghost button
            FCPButton.medium.ghost(
              text: 'Ghost Button',
              onPressed: () => _showSnackBar(context, 'Ghost pressed'),
            ),
            SizedBox(height: 16),
            
            // Danger button
            FCPButton.medium.danger(
              text: 'Delete Item',
              onPressed: () => _showSnackBar(context, 'Delete pressed'),
            ),
            SizedBox(height: 16),
            
            // Floating button
            FCPButton.medium.floating(
              text: 'Floating Action',
              icon: Icons.add,
              onPressed: () => _showSnackBar(context, 'Floating pressed'),
            ),
            SizedBox(height: 16),
            
            // Icon button
            FCPButton.medium.iconButton(
              icon: Icons.favorite,
              onPressed: () => _showSnackBar(context, 'Icon pressed'),
            ),
            SizedBox(height: 16),
            
            // Loading button
            FCPButton.medium.primary(
              text: 'Loading...',
              isLoading: true,
              onPressed: () {},
            ),
            SizedBox(height: 16),
            
            // Disabled button
            FCPButton.medium.primary(
              text: 'Disabled',
              isDisabled: true,
              onPressed: () {},
            ),
            SizedBox(height: 16),
            
            // Different sizes
            Row(
              children: [
                Expanded(
                  child: FCPButton.small.primary(
                    text: 'Small',
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: FCPButton.medium.primary(
                    text: 'Medium',
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: FCPButton.large.primary(
                    text: 'Large',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
```

## API Reference

### FCPButtonBuilder

| Method | Description |
|--------|-------------|
| `primary()` | Creates a primary button |
| `secondary()` | Creates a secondary button |
| `outlined()` | Creates an outlined button |
| `ghost()` | Creates a ghost button |
| `danger()` | Creates a danger button |
| `floating()` | Creates a floating button |
| `elevated()` | Creates an elevated button |
| `contained()` | Creates a contained button |
| `iconButton()` | Creates an icon-only button |

### Properties

| Property | Type | Description |
|----------|--------|-------------|
| `text` | `String?` | Button text |
| `onPressed` | `VoidCallback?` | Press callback |
| `isLoading` | `bool` | Loading state |
| `isDisabled` | `bool` | Disabled state |
| `icon` | `IconData?` | Button icon |
| `iconPosition` | `IconPosition` | Icon position |
| `width` | `double?` | Button width |
| `height` | `double?` | Button height |
| `borderRadius` | `double?` | Border radius |
| `backgroundColor` | `Color?` | Background color |
| `foregroundColor` | `Color?` | Text/icon color |
| `borderColor` | `Color?` | Border color |
| `borderWidth` | `double` | Border width |
| `textStyle` | `TextStyle?` | Text style |
| `padding` | `EdgeInsetsGeometry?` | Button padding |
| `margin` | `EdgeInsetsGeometry?` | Button margin |
| `elevation` | `double?` | Shadow elevation |
| `shadowColor` | `Color?` | Shadow color |
| `animationDuration` | `Duration?` | Animation duration |
| `child` | `Widget?` | Custom child widget |

## Best Practices

1. **Use appropriate variants**: Choose the right variant for the action importance
2. **Consistent sizing**: Use consistent button sizes throughout your app
3. **Loading states**: Always show loading indicators for async operations
4. **Accessibility**: Ensure buttons have proper touch targets (minimum 44x44)
5. **Color contrast**: Ensure sufficient contrast between text and background
6. **Icon usage**: Use meaningful icons that enhance understanding
7. **Disabled states**: Clearly indicate when actions are not available

## Accessibility

- All buttons support proper touch targets
- Loading and disabled states are properly handled
- Screen reader support for button text and states
- High contrast mode support
- Keyboard navigation support
