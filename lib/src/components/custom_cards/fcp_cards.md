# FCPCard Component

A highly customizable card component with multiple variants, gradient support, shadow options, and interactive features.

## Features

- **Multiple Variants**: Basic, flat, shaded, gradient, info, and action cards
- **Gradient Support**: Linear, radial, sweep gradients with predefined color schemes
- **Shadow Options**: Multiple shadow types from none to extra large
- **Interactive**: Support for tap, long press, and hover interactions
- **Customizable**: Full control over colors, borders, padding, and styling
- **Accessibility**: Proper semantic structure and screen reader support
- **Responsive**: Automatic sizing and responsive design

## Card Variants

### Basic Card
A standard card with customizable background, border, and shadow.

```dart
FCPCard(
  child: Text('Basic Card Content'),
  backgroundColor: Colors.white,
  borderColor: Colors.grey,
  borderRadius: 12,
  elevation: 4,
)
```

### Flat Card
A card without shadows, perfect for subtle content separation.

```dart
FCPCard.flat(
  child: Text('Flat Card Content'),
  backgroundColor: Colors.grey[100],
  borderColor: Colors.grey[300],
  borderRadius: 8,
)
```

### Shaded Card
A card with predefined shadow styles.

```dart
FCPCard.shaded(
  child: Text('Shaded Card Content'),
  shadowType: ShadowType.medium,
  backgroundColor: Colors.white,
)
```

### Gradient Card
A card with gradient background.

```dart
FCPCard.gradient(
  child: Text('Gradient Card Content'),
  gradientType: GradientType.linear,
  gradientColors: [Colors.blue, Colors.purple],
)
```

### Info Card
A structured card for displaying information with title, subtitle, and content.

```dart
FCPCard.info(
  title: 'Card Title',
  subtitle: 'Card Subtitle',
  content: 'Card content goes here',
  icon: Icons.info,
  leading: CircleAvatar(child: Text('A')),
)
```

### Action Card
A card with action buttons.

```dart
FCPCard.action(
  title: 'Action Card',
  content: 'This card has actions',
  actions: [
    FCPButton.small.outlined(text: 'Cancel'),
    FCPButton.small.primary(text: 'Save'),
  ],
)
```

## Basic Usage

### Simple Card
```dart
FCPCard(
  child: Column(
    children: [
      Text('Card Title', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Card content goes here'),
    ],
  ),
)
```

### Card with Custom Styling
```dart
FCPCard(
  child: Text('Custom Styled Card'),
  backgroundColor: Colors.blue[50],
  borderColor: Colors.blue,
  borderWidth: 2,
  borderRadius: 16,
  elevation: 8,
  shadowColor: Colors.blue.withOpacity(0.3),
  padding: EdgeInsets.all(24),
  margin: EdgeInsets.all(8),
)
```

### Interactive Card
```dart
FCPCard(
  child: Text('Tap me!'),
  onTap: () => print('Card tapped'),
  onLongPress: () => print('Card long pressed'),
  backgroundColor: Colors.green[50],
  borderRadius: 12,
)
```

## Advanced Usage

### Gradient Cards
```dart
// Linear gradient
FCPCard.gradient(
  child: Text('Linear Gradient'),
  gradientType: GradientType.linear,
  gradientColors: [Colors.blue, Colors.purple],
  gradientBegin: Alignment.topLeft,
  gradientEnd: Alignment.bottomRight,
)

// Radial gradient
FCPCard.gradient(
  child: Text('Radial Gradient'),
  gradientType: GradientType.radial,
  gradientColors: [Colors.red, Colors.orange],
  gradientCenter: Alignment.center,
  gradientRadius: 0.8,
)

// Predefined gradient
FCPCard.gradient(
  child: Text('Sunset Gradient'),
  gradientType: GradientType.sunset,
)
```

### Shadow Types
```dart
// No shadow
FCPCard.shaded(
  child: Text('No Shadow'),
  shadowType: ShadowType.none,
)

// Small shadow
FCPCard.shaded(
  child: Text('Small Shadow'),
  shadowType: ShadowType.small,
)

// Medium shadow
FCPCard.shaded(
  child: Text('Medium Shadow'),
  shadowType: ShadowType.medium,
)

// Large shadow
FCPCard.shaded(
  child: Text('Large Shadow'),
  shadowType: ShadowType.large,
)

// Soft shadow
FCPCard.shaded(
  child: Text('Soft Shadow'),
  shadowType: ShadowType.soft,
)
```

### Info Cards with Icons
```dart
FCPCard.info(
  title: 'User Profile',
  subtitle: 'John Doe',
  content: 'Software Developer with 5 years of experience',
  icon: Icons.person,
  iconColor: Colors.blue,
  leading: CircleAvatar(
    backgroundImage: NetworkImage('https://example.com/avatar.jpg'),
  ),
  trailing: Icon(Icons.arrow_forward_ios),
)
```

### Action Cards
```dart
FCPCard.action(
  title: 'Settings',
  subtitle: 'Manage your preferences',
  content: 'Configure app settings and preferences',
  icon: Icons.settings,
  actions: [
    FCPButton.small.outlined(
      text: 'Reset',
      onPressed: () => print('Reset pressed'),
    ),
    FCPButton.small.primary(
      text: 'Save',
      onPressed: () => print('Save pressed'),
    ),
  ],
  actionAlignment: MainAxisAlignment.spaceBetween,
)
```

### Custom Gradient Colors
```dart
FCPCard.gradient(
  child: Text('Custom Gradient'),
  gradientType: GradientType.linear,
  gradientColors: [
    Color(0xFF667eea),
    Color(0xFF764ba2),
    Color(0xFFf093fb),
  ],
  gradientStops: [0.0, 0.5, 1.0],
  gradientBegin: Alignment.topLeft,
  gradientEnd: Alignment.bottomRight,
)
```

### Custom Shadow
```dart
FCPCard(
  child: Text('Custom Shadow'),
  elevation: 12,
  shadowColor: Colors.purple.withOpacity(0.3),
  shadowOffset: Offset(0, 6),
  shadowBlurRadius: 20,
  shadowSpreadRadius: 2,
)
```

### Custom Border
```dart
FCPCard(
  child: Text('Custom Border'),
  border: Border.all(
    color: Colors.orange,
    width: 3,
    style: BorderStyle.solid,
  ),
  borderRadius: 20,
)
```

### Custom Shape
```dart
FCPCard(
  child: Text('Custom Shape'),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
    side: BorderSide(color: Colors.blue, width: 2),
  ),
)
```

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class CardExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Card Examples')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Basic Card
            FCPCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Basic Card', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('This is a basic card with default styling.'),
                ],
              ),
            ),
            SizedBox(height: 16),
            
            // Flat Card
            FCPCard.flat(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Flat Card', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('This card has no shadow and a subtle border.'),
                ],
              ),
            ),
            SizedBox(height: 16),
            
            // Shaded Card
            FCPCard.shaded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Shaded Card', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('This card has a predefined shadow style.'),
                ],
              ),
              shadowType: ShadowType.medium,
            ),
            SizedBox(height: 16),
            
            // Gradient Card
            FCPCard.gradient(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gradient Card', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 8),
                  Text('This card has a beautiful gradient background.', style: TextStyle(color: Colors.white)),
                ],
              ),
              gradientType: GradientType.ocean,
            ),
            SizedBox(height: 16),
            
            // Info Card
            FCPCard.info(
              title: 'User Profile',
              subtitle: 'John Doe',
              content: 'Software Developer with 5 years of experience in Flutter and mobile development.',
              icon: Icons.person,
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text('JD', style: TextStyle(color: Colors.white)),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            SizedBox(height: 16),
            
            // Action Card
            FCPCard.action(
              title: 'Settings',
              subtitle: 'Manage your preferences',
              content: 'Configure app settings and preferences to customize your experience.',
              icon: Icons.settings,
              actions: [
                FCPButton.small.outlined(
                  text: 'Reset',
                  onPressed: () => print('Reset pressed'),
                ),
                FCPButton.small.primary(
                  text: 'Save',
                  onPressed: () => print('Save pressed'),
                ),
              ],
            ),
            SizedBox(height: 16),
            
            // Interactive Card
            FCPCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Interactive Card', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Tap me to see the interaction!'),
                ],
              ),
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Card tapped!')),
              ),
              backgroundColor: Colors.green[50],
              borderColor: Colors.green,
            ),
            SizedBox(height: 16),
            
            // Custom Styled Card
            FCPCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Custom Styled Card', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('This card has custom colors, border, and shadow.'),
                ],
              ),
              backgroundColor: Colors.purple[50],
              borderColor: Colors.purple,
              borderWidth: 2,
              borderRadius: 20,
              elevation: 12,
              shadowColor: Colors.purple.withOpacity(0.3),
              padding: EdgeInsets.all(24),
            ),
          ],
        ),
      ),
    );
  }
}
```

## API Reference

### FCPCard Constructors

| Constructor | Description |
|----------|-------------|
| `FCPCard()` | Basic card with full customization |
| `FCPCard.flat()` | Flat card without shadows |
| `FCPCard.shaded()` | Card with predefined shadow styles |
| `FCPCard.gradient()` | Card with gradient background |
| `FCPCard.info()` | Structured info card |
| `FCPCard.action()` | Card with action buttons |

### Properties

| Property | Type | Description |
|----------|--------|-------------|
| `child` | `Widget?` | Card content |
| `backgroundColor` | `Color?` | Background color |
| `borderColor` | `Color?` | Border color |
| `borderWidth` | `double` | Border width |
| `borderRadius` | `double` | Border radius |
| `elevation` | `double` | Shadow elevation |
| `shadowColor` | `Color?` | Shadow color |
| `shadowOffset` | `Offset?` | Shadow offset |
| `shadowBlurRadius` | `double?` | Shadow blur radius |
| `shadowSpreadRadius` | `double?` | Shadow spread radius |
| `padding` | `EdgeInsetsGeometry` | Card padding |
| `margin` | `EdgeInsetsGeometry?` | Card margin |
| `width` | `double?` | Card width |
| `height` | `double?` | Card height |
| `gradient` | `Gradient?` | Custom gradient |
| `border` | `BoxBorder?` | Custom border |
| `shape` | `OutlinedBorder?` | Custom shape |
| `clipBehavior` | `Clip` | Clip behavior |
| `semanticContainer` | `bool` | Semantic container |
| `onTap` | `VoidCallback?` | Tap callback |
| `onLongPress` | `VoidCallback?` | Long press callback |
| `onDoubleTap` | `VoidCallback?` | Double tap callback |
| `onHover` | `ValueChanged<bool>?` | Hover callback |
| `onFocusChange` | `ValueChanged<bool>?` | Focus change callback |
| `focusNode` | `FocusNode?` | Focus node |
| `autofocus` | `bool` | Auto focus |
| `statesController` | `MaterialStatesController?` | States controller |
| `isSemanticButton` | `bool` | Semantic button |

### Shadow Types

| Type | Description |
|------|-------------|
| `ShadowType.none` | No shadow |
| `ShadowType.small` | Small shadow |
| `ShadowType.medium` | Medium shadow |
| `ShadowType.large` | Large shadow |
| `ShadowType.extraLarge` | Extra large shadow |
| `ShadowType.soft` | Soft shadow (blurred) |
| `ShadowType.hard` | Hard shadow (sharp) |

### Gradient Types

| Type | Description |
|------|-------------|
| `GradientType.linear` | Linear gradient |
| `GradientType.radial` | Radial gradient |
| `GradientType.sweep` | Sweep gradient |
| `GradientType.primary` | Primary color gradient |
| `GradientType.secondary` | Secondary color gradient |
| `GradientType.success` | Success color gradient |
| `GradientType.warning` | Warning color gradient |
| `GradientType.error` | Error color gradient |
| `GradientType.neutral` | Neutral color gradient |
| `GradientType.sunset` | Sunset color gradient |
| `GradientType.ocean` | Ocean color gradient |
| `GradientType.forest` | Forest color gradient |
| `GradientType.fire` | Fire color gradient |
| `GradientType.custom` | Custom gradient |

## Best Practices

1. **Consistent Styling**: Use consistent card styles throughout your app
2. **Shadow Usage**: Use appropriate shadow levels for content hierarchy
3. **Color Contrast**: Ensure sufficient contrast between text and background
4. **Touch Targets**: Ensure interactive cards have proper touch targets
5. **Content Organization**: Use info and action cards for structured content
6. **Performance**: Avoid excessive nesting and complex gradients
7. **Accessibility**: Provide meaningful content and proper semantic structure

## Accessibility

- All cards support proper semantic structure
- Screen reader support for card content
- High contrast mode support
- Keyboard navigation support
- Proper focus management for interactive cards
