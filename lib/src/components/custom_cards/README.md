# FCPCard - Unified Card Component

A comprehensive, unified card component for Flutter applications with multiple factory constructors for different card types. This single component provides various card styles with full customization options for shadows, gradients, borders, and interactions.

## Component Overview

### FCPCard
A unified card component with multiple factory constructors:

- `FCPCard()` - Basic customizable card
- `FCPCard.flat()` - Flat card without shadows
- `FCPCard.shaded()` - Card with predefined shadow styles
- `FCPCard.gradient()` - Card with gradient backgrounds
- `FCPCard.info()` - Information card with structured content
- `FCPCard.action()` - Interactive card with action buttons

## Usage

### Basic FCPCard

```dart
import 'package:flutter_components_plus/src/components/custom_cards/fcp_card.dart';

FCPCard(
  child: Text('Simple custom card'),
)
```

### Customized FCPCard

```dart
FCPCard(
  backgroundColor: Colors.blue.shade50,
  borderColor: Colors.blue.shade200,
  borderWidth: 2,
  borderRadius: 16,
  elevation: 4,
  shadowColor: Colors.blue.withOpacity(0.3),
  onTap: () => print('Card tapped!'),
  child: Padding(
    padding: EdgeInsets.all(16.0),
    child: Text('Custom styled card'),
  ),
)
```

### FCPCard.flat (No Shadows)

```dart
FCPCard.flat(
  backgroundColor: Colors.green.shade50,
  borderColor: Colors.green.shade300,
  borderWidth: 2,
  borderRadius: 16,
  onTap: () => print('Flat card tapped!'),
  child: Text('Flat card with green border'),
)
```

### FCPCard.shaded with Different Shadow Types

```dart
// Small shadow
FCPCard.shaded(
  shadowType: ShadowType.small,
  child: Text('Small shadow card'),
)

// Medium shadow (default)
FCPCard.shaded(
  shadowType: ShadowType.medium,
  child: Text('Medium shadow card'),
)

// Large shadow
FCPCard.shaded(
  shadowType: ShadowType.large,
  child: Text('Large shadow card'),
)

// Soft shadow
FCPCard.shaded(
  shadowType: ShadowType.soft,
  child: Text('Soft shadow card'),
)

// Hard shadow
FCPCard.shaded(
  shadowType: ShadowType.hard,
  child: Text('Hard shadow card'),
)

// Extra large shadow
FCPCard.shaded(
  shadowType: ShadowType.extraLarge,
  child: Text('Extra large shadow card'),
)
```

### FCPCard.gradient

```dart
// Predefined gradient types
FCPCard.gradient(
  gradientType: GradientType.sunset,
  child: Padding(
    padding: EdgeInsets.all(16.0),
    child: Text(
      'Sunset Gradient',
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  ),
)

// Custom gradient
FCPCard.gradient(
  gradientType: GradientType.linear,
  gradientColors: [Colors.purple.shade400, Colors.pink.shade400],
  child: Padding(
    padding: EdgeInsets.all(16.0),
    child: Text(
      'Custom Gradient',
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  ),
)
```

### FCPCard.info

```dart
FCPCard.info(
  icon: Icons.info,
  title: 'Information Card',
  subtitle: 'This is a subtitle',
  content: 'This is the main content of the information card.',
  trailing: Icon(Icons.arrow_forward_ios, size: 16),
)
```

### FCPCard.action

```dart
FCPCard.action(
  icon: Icons.settings,
  title: 'Settings Card',
  content: 'Configure your application settings.',
  actions: [
    TextButton(
      onPressed: () => print('Cancel pressed'),
      child: Text('Cancel'),
    ),
    ElevatedButton(
      onPressed: () => print('Save pressed'),
      child: Text('Save'),
    ),
  ],
)
```

## Available Shadow Types

- `ShadowType.none` - No shadow
- `ShadowType.small` - Small shadow
- `ShadowType.medium` - Medium shadow (default)
- `ShadowType.large` - Large shadow
- `ShadowType.extraLarge` - Extra large shadow
- `ShadowType.soft` - Soft shadow (blurred)
- `ShadowType.hard` - Hard shadow (sharp)

## Available Gradient Types

- `GradientType.linear` - Linear gradient
- `GradientType.radial` - Radial gradient
- `GradientType.sweep` - Sweep gradient
- `GradientType.primary` - Primary color gradient
- `GradientType.secondary` - Secondary color gradient
- `GradientType.success` - Success color gradient
- `GradientType.warning` - Warning color gradient
- `GradientType.error` - Error color gradient
- `GradientType.neutral` - Neutral color gradient
- `GradientType.sunset` - Sunset color gradient
- `GradientType.ocean` - Ocean color gradient
- `GradientType.forest` - Forest color gradient
- `GradientType.fire` - Fire color gradient
- `GradientType.custom` - Custom gradient

## Customization Options

All card components support the following customization options:

### Visual Properties
- `backgroundColor` - Background color
- `borderColor` - Border color
- `borderWidth` - Border width
- `borderRadius` - Border radius
- `elevation` - Material elevation
- `shadowColor` - Shadow color
- `shadowOffset` - Shadow offset
- `shadowBlurRadius` - Shadow blur radius
- `shadowSpreadRadius` - Shadow spread radius
- `gradient` - Gradient background
- `border` - Custom border
- `shape` - Custom shape

### Layout Properties
- `padding` - Internal padding
- `margin` - External margin
- `width` - Card width
- `height` - Card height
- `clipBehavior` - Clip behavior

### Interaction Properties
- `onTap` - Tap callback
- `onLongPress` - Long press callback
- `onDoubleTap` - Double tap callback
- `onHover` - Hover callback
- `onFocusChange` - Focus change callback
- `focusNode` - Focus node
- `autofocus` - Auto focus
- `statesController` - States controller
- `isSemanticButton` - Semantic button flag

### Accessibility
- `semanticContainer` - Semantic container flag

## Theme Integration

All card components automatically adapt to the current theme (light/dark mode) and use the theme's color scheme for default colors. They also respect the Material Design 3 theming system.

## Examples

See `card_examples.dart` for comprehensive examples of all card components and their various configurations.

## Best Practices

1. **Use appropriate shadow types** for your design context
2. **Consider accessibility** when choosing colors and contrasts
3. **Use semantic colors** from your theme when possible
4. **Provide meaningful interactions** with proper callbacks
5. **Test on different screen sizes** to ensure proper layout
6. **Use consistent spacing** and padding across your app

## Performance Considerations

- Cards with complex gradients or shadows may impact performance on lower-end devices
- Consider using `RepaintBoundary` for cards with complex content
- Use `const` constructors when possible for better performance
- Avoid unnecessary rebuilds by properly managing state
