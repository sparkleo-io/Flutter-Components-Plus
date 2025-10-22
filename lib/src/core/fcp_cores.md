# FCP Core

Core functionality and utilities for the Flutter Components Plus package, including constants, themes, and color schemes.

## Features

- **Constants**: Application-wide constants and configuration
- **Theme System**: Comprehensive theme management
- **Color Schemes**: Predefined color palettes and schemes
- **Text Styles**: Typography system with consistent text styles
- **Responsive Design**: Breakpoints and responsive utilities

## Constants

### Application Constants
```dart
// Spacing constants
FCPConstants.spacingXs    // 4.0
FCPConstants.spacingSm    // 8.0
FCPConstants.spacingMd    // 16.0
FCPConstants.spacingLg    // 24.0
FCPConstants.spacingXl    // 32.0
FCPConstants.spacingXxl   // 48.0

// Border radius constants
FCPConstants.radiusXs     // 2.0
FCPConstants.radiusSm     // 4.0
FCPConstants.radiusMd     // 8.0
FCPConstants.radiusLg     // 12.0
FCPConstants.radiusXl     // 16.0
FCPConstants.radiusXxl    // 24.0

// Font size constants
FCPConstants.fontSizeXs   // 10.0
FCPConstants.fontSizeSm   // 12.0
FCPConstants.fontSizeMd   // 14.0
FCPConstants.fontSizeLg   // 16.0
FCPConstants.fontSizeXl   // 18.0
FCPConstants.fontSizeXxl  // 20.0
FCPConstants.fontSizeXxxl // 24.0

// Animation duration constants
FCPConstants.durationFast   // 150ms
FCPConstants.durationNormal // 300ms
FCPConstants.durationSlow   // 500ms

// Button height constants
FCPConstants.buttonHeightSm  // 32.0
FCPConstants.buttonHeightMd  // 40.0
FCPConstants.buttonHeightLg  // 48.0
FCPConstants.buttonHeightXl  // 56.0

// Input height constants
FCPConstants.inputHeightSm   // 32.0
FCPConstants.inputHeightMd  // 40.0
FCPConstants.inputHeightLg  // 48.0
```

### Usage Examples
```dart
// Using spacing constants
Container(
  padding: EdgeInsets.all(FCPConstants.spacingMd),
  margin: EdgeInsets.symmetric(vertical: FCPConstants.spacingLg),
  child: Text('Content'),
)

// Using border radius constants
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(FCPConstants.radiusLg),
    color: Colors.blue,
  ),
  child: Text('Rounded Container'),
)

// Using font size constants
Text(
  'Title',
  style: TextStyle(fontSize: FCPConstants.fontSizeXl),
)

// Using animation duration constants
AnimatedContainer(
  duration: FCPConstants.durationNormal,
  child: Text('Animated Content'),
)
```

## Color Scheme

### Predefined Color Schemes
```dart
// Primary colors
FCPColorScheme.primary           // Main brand color
FCPColorScheme.primaryContainer  // Primary container color
FCPColorScheme.onPrimary         // Text on primary color
FCPColorScheme.onPrimaryContainer // Text on primary container

// Secondary colors
FCPColorScheme.secondary         // Secondary brand color
FCPColorScheme.secondaryContainer // Secondary container color
FCPColorScheme.onSecondary       // Text on secondary color
FCPColorScheme.onSecondaryContainer // Text on secondary container

// Neutral colors
FCPColorScheme.neutral50         // Lightest neutral
FCPColorScheme.neutral100        // Very light neutral
FCPColorScheme.neutral200        // Light neutral
FCPColorScheme.neutral300        // Medium light neutral
FCPColorScheme.neutral400        // Medium neutral
FCPColorScheme.neutral500        // Base neutral
FCPColorScheme.neutral600        // Medium dark neutral
FCPColorScheme.neutral700        // Dark neutral
FCPColorScheme.neutral800        // Very dark neutral
FCPColorScheme.neutral900        // Darkest neutral

// Semantic colors
FCPColorScheme.success           // Success color
FCPColorScheme.successContainer  // Success container color
FCPColorScheme.warning           // Warning color
FCPColorScheme.warningContainer // Warning container color
FCPColorScheme.error             // Error color
FCPColorScheme.errorContainer    // Error container color
FCPColorScheme.info              // Info color
FCPColorScheme.infoContainer     // Info container color
```

### Usage Examples
```dart
// Using primary colors
Container(
  color: FCPColorScheme.primary,
  child: Text(
    'Primary Text',
    style: TextStyle(color: FCPColorScheme.onPrimary),
  ),
)

// Using neutral colors
Container(
  color: FCPColorScheme.neutral100,
  child: Text(
    'Neutral Text',
    style: TextStyle(color: FCPColorScheme.neutral800),
  ),
)

// Using semantic colors
Container(
  color: FCPColorScheme.success,
  child: Text(
    'Success Message',
    style: TextStyle(color: Colors.white),
  ),
)
```

## Text Styles

### Typography System
```dart
// Display styles
FCPTextStyles.getDisplayLarge()    // Large display text
FCPTextStyles.getDisplayMedium()   // Medium display text
FCPTextStyles.getDisplaySmall()    // Small display text

// Headline styles
FCPTextStyles.getHeadlineLarge()   // Large headline
FCPTextStyles.getHeadlineMedium()  // Medium headline
FCPTextStyles.getHeadlineSmall()   // Small headline

// Title styles
FCPTextStyles.getTitleLarge()      // Large title
FCPTextStyles.getTitleMedium()     // Medium title
FCPTextStyles.getTitleSmall()      // Small title

// Body styles
FCPTextStyles.getBodyLarge()       // Large body text
FCPTextStyles.getBodyMedium()      // Medium body text
FCPTextStyles.getBodySmall()       // Small body text

// Label styles
FCPTextStyles.getLabelLarge()      // Large label
FCPTextStyles.getLabelMedium()     // Medium label
FCPTextStyles.getLabelSmall()      // Small label
```

### Custom Text Styles
```dart
// Custom color
FCPTextStyles.getBodyMedium(
  color: FCPColorScheme.primary,
)

// Custom font weight
FCPTextStyles.getTitleLarge(
  fontWeight: FontWeight.bold,
)

// Custom font size
FCPTextStyles.getBodyMedium(
  fontSize: 16,
)

// Custom line height
FCPTextStyles.getBodyMedium(
  height: 1.5,
)

// Custom letter spacing
FCPTextStyles.getBodyMedium(
  letterSpacing: 0.5,
)
```

### Usage Examples
```dart
// Display text
Text(
  'Welcome',
  style: FCPTextStyles.getDisplayLarge(),
)

// Headline text
Text(
  'Section Title',
  style: FCPTextStyles.getHeadlineMedium(),
)

// Body text
Text(
  'This is body text content that provides information to the user.',
  style: FCPTextStyles.getBodyMedium(),
)

// Label text
Text(
  'Label',
  style: FCPTextStyles.getLabelMedium(),
)

// Custom styled text
Text(
  'Custom Text',
  style: FCPTextStyles.getBodyMedium(
    color: FCPColorScheme.primary,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  ),
)
```

## Theme System

### App Theme
```dart
// Light theme
final lightTheme = FCPAppTheme.light();

// Dark theme
final darkTheme = FCPAppTheme.dark();

// Custom theme
final customTheme = FCPAppTheme.custom(
  primaryColor: Colors.blue,
  secondaryColor: Colors.green,
  brightness: Brightness.light,
);
```

### Theme Usage
```dart
// In MaterialApp
MaterialApp(
  theme: FCPAppTheme.light(),
  darkTheme: FCPAppTheme.dark(),
  themeMode: ThemeMode.system,
  home: MyHomePage(),
)

// Accessing theme in widgets
Widget build(BuildContext context) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  
  return Container(
    color: colorScheme.primary,
    child: Text(
      'Themed Text',
      style: theme.textTheme.headlineMedium,
    ),
  );
}
```

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class CoreExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Core Example'),
        backgroundColor: FCPColorScheme.primary,
        foregroundColor: FCPColorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(FCPConstants.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display text
            Text(
              'Display Text',
              style: FCPTextStyles.getDisplayLarge(
                color: FCPColorScheme.primary,
              ),
            ),
            SizedBox(height: FCPConstants.spacingLg),
            
            // Headline text
            Text(
              'Headline Text',
              style: FCPTextStyles.getHeadlineMedium(
                color: FCPColorScheme.secondary,
              ),
            ),
            SizedBox(height: FCPConstants.spacingMd),
            
            // Body text
            Text(
              'This is body text content that demonstrates the typography system. '
              'It provides consistent styling across the application.',
              style: FCPTextStyles.getBodyMedium(),
            ),
            SizedBox(height: FCPConstants.spacingLg),
            
            // Color examples
            Text(
              'Color Examples',
              style: FCPTextStyles.getTitleLarge(),
            ),
            SizedBox(height: FCPConstants.spacingMd),
            
            // Primary color
            Container(
              padding: EdgeInsets.all(FCPConstants.spacingMd),
              decoration: BoxDecoration(
                color: FCPColorScheme.primary,
                borderRadius: BorderRadius.circular(FCPConstants.radiusMd),
              ),
              child: Text(
                'Primary Color',
                style: FCPTextStyles.getBodyMedium(
                  color: FCPColorScheme.onPrimary,
                ),
              ),
            ),
            SizedBox(height: FCPConstants.spacingSm),
            
            // Secondary color
            Container(
              padding: EdgeInsets.all(FCPConstants.spacingMd),
              decoration: BoxDecoration(
                color: FCPColorScheme.secondary,
                borderRadius: BorderRadius.circular(FCPConstants.radiusMd),
              ),
              child: Text(
                'Secondary Color',
                style: FCPTextStyles.getBodyMedium(
                  color: FCPColorScheme.onSecondary,
                ),
              ),
            ),
            SizedBox(height: FCPConstants.spacingSm),
            
            // Success color
            Container(
              padding: EdgeInsets.all(FCPConstants.spacingMd),
              decoration: BoxDecoration(
                color: FCPColorScheme.success,
                borderRadius: BorderRadius.circular(FCPConstants.radiusMd),
              ),
              child: Text(
                'Success Color',
                style: FCPTextStyles.getBodyMedium(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: FCPConstants.spacingSm),
            
            // Warning color
            Container(
              padding: EdgeInsets.all(FCPConstants.spacingMd),
              decoration: BoxDecoration(
                color: FCPColorScheme.warning,
                borderRadius: BorderRadius.circular(FCPConstants.radiusMd),
              ),
              child: Text(
                'Warning Color',
                style: FCPTextStyles.getBodyMedium(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: FCPConstants.spacingSm),
            
            // Error color
            Container(
              padding: EdgeInsets.all(FCPConstants.spacingMd),
              decoration: BoxDecoration(
                color: FCPColorScheme.error,
                borderRadius: BorderRadius.circular(FCPConstants.radiusMd),
              ),
              child: Text(
                'Error Color',
                style: FCPTextStyles.getBodyMedium(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: FCPConstants.spacingLg),
            
            // Typography examples
            Text(
              'Typography Examples',
              style: FCPTextStyles.getTitleLarge(),
            ),
            SizedBox(height: FCPConstants.spacingMd),
            
            // Display styles
            Text(
              'Display Large',
              style: FCPTextStyles.getDisplayLarge(),
            ),
            Text(
              'Display Medium',
              style: FCPTextStyles.getDisplayMedium(),
            ),
            Text(
              'Display Small',
              style: FCPTextStyles.getDisplaySmall(),
            ),
            SizedBox(height: FCPConstants.spacingMd),
            
            // Headline styles
            Text(
              'Headline Large',
              style: FCPTextStyles.getHeadlineLarge(),
            ),
            Text(
              'Headline Medium',
              style: FCPTextStyles.getHeadlineMedium(),
            ),
            Text(
              'Headline Small',
              style: FCPTextStyles.getHeadlineSmall(),
            ),
            SizedBox(height: FCPConstants.spacingMd),
            
            // Title styles
            Text(
              'Title Large',
              style: FCPTextStyles.getTitleLarge(),
            ),
            Text(
              'Title Medium',
              style: FCPTextStyles.getTitleMedium(),
            ),
            Text(
              'Title Small',
              style: FCPTextStyles.getTitleSmall(),
            ),
            SizedBox(height: FCPConstants.spacingMd),
            
            // Body styles
            Text(
              'Body Large',
              style: FCPTextStyles.getBodyLarge(),
            ),
            Text(
              'Body Medium',
              style: FCPTextStyles.getBodyMedium(),
            ),
            Text(
              'Body Small',
              style: FCPTextStyles.getBodySmall(),
            ),
            SizedBox(height: FCPConstants.spacingMd),
            
            // Label styles
            Text(
              'Label Large',
              style: FCPTextStyles.getLabelLarge(),
            ),
            Text(
              'Label Medium',
              style: FCPTextStyles.getLabelMedium(),
            ),
            Text(
              'Label Small',
              style: FCPTextStyles.getLabelSmall(),
            ),
            SizedBox(height: FCPConstants.spacingLg),
            
            // Spacing examples
            Text(
              'Spacing Examples',
              style: FCPTextStyles.getTitleLarge(),
            ),
            SizedBox(height: FCPConstants.spacingMd),
            
            // Different spacing sizes
            Container(
              padding: EdgeInsets.all(FCPConstants.spacingXs),
              color: FCPColorScheme.neutral200,
              child: Text('Extra Small Spacing'),
            ),
            SizedBox(height: FCPConstants.spacingSm),
            
            Container(
              padding: EdgeInsets.all(FCPConstants.spacingSm),
              color: FCPColorScheme.neutral300,
              child: Text('Small Spacing'),
            ),
            SizedBox(height: FCPConstants.spacingMd),
            
            Container(
              padding: EdgeInsets.all(FCPConstants.spacingMd),
              color: FCPColorScheme.neutral400,
              child: Text('Medium Spacing'),
            ),
            SizedBox(height: FCPConstants.spacingLg),
            
            Container(
              padding: EdgeInsets.all(FCPConstants.spacingLg),
              color: FCPColorScheme.neutral500,
              child: Text('Large Spacing'),
            ),
            SizedBox(height: FCPConstants.spacingXl),
            
            Container(
              padding: EdgeInsets.all(FCPConstants.spacingXl),
              color: FCPColorScheme.neutral600,
              child: Text('Extra Large Spacing'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## API Reference

### FCPConstants

| Constant | Type | Value | Description |
|----------|------|-------|-------------|
| `spacingXs` | `double` | 4.0 | Extra small spacing |
| `spacingSm` | `double` | 8.0 | Small spacing |
| `spacingMd` | `double` | 16.0 | Medium spacing |
| `spacingLg` | `double` | 24.0 | Large spacing |
| `spacingXl` | `double` | 32.0 | Extra large spacing |
| `spacingXxl` | `double` | 48.0 | Extra extra large spacing |
| `radiusXs` | `double` | 2.0 | Extra small border radius |
| `radiusSm` | `double` | 4.0 | Small border radius |
| `radiusMd` | `double` | 8.0 | Medium border radius |
| `radiusLg` | `double` | 12.0 | Large border radius |
| `radiusXl` | `double` | 16.0 | Extra large border radius |
| `radiusXxl` | `double` | 24.0 | Extra extra large border radius |
| `fontSizeXs` | `double` | 10.0 | Extra small font size |
| `fontSizeSm` | `double` | 12.0 | Small font size |
| `fontSizeMd` | `double` | 14.0 | Medium font size |
| `fontSizeLg` | `double` | 16.0 | Large font size |
| `fontSizeXl` | `double` | 18.0 | Extra large font size |
| `fontSizeXxl` | `double` | 20.0 | Extra extra large font size |
| `fontSizeXxxl` | `double` | 24.0 | Extra extra extra large font size |
| `durationFast` | `Duration` | 150ms | Fast animation duration |
| `durationNormal` | `Duration` | 300ms | Normal animation duration |
| `durationSlow` | `Duration` | 500ms | Slow animation duration |
| `buttonHeightSm` | `double` | 32.0 | Small button height |
| `buttonHeightMd` | `double` | 40.0 | Medium button height |
| `buttonHeightLg` | `double` | 48.0 | Large button height |
| `buttonHeightXl` | `double` | 56.0 | Extra large button height |
| `inputHeightSm` | `double` | 32.0 | Small input height |
| `inputHeightMd` | `double` | 40.0 | Medium input height |
| `inputHeightLg` | `double` | 48.0 | Large input height |

### FCPColorScheme

| Color | Type | Description |
|-------|------|-------------|
| `primary` | `Color` | Main brand color |
| `primaryContainer` | `Color` | Primary container color |
| `onPrimary` | `Color` | Text on primary color |
| `onPrimaryContainer` | `Color` | Text on primary container |
| `secondary` | `Color` | Secondary brand color |
| `secondaryContainer` | `Color` | Secondary container color |
| `onSecondary` | `Color` | Text on secondary color |
| `onSecondaryContainer` | `Color` | Text on secondary container |
| `neutral50` | `Color` | Lightest neutral |
| `neutral100` | `Color` | Very light neutral |
| `neutral200` | `Color` | Light neutral |
| `neutral300` | `Color` | Medium light neutral |
| `neutral400` | `Color` | Medium neutral |
| `neutral500` | `Color` | Base neutral |
| `neutral600` | `Color` | Medium dark neutral |
| `neutral700` | `Color` | Dark neutral |
| `neutral800` | `Color` | Very dark neutral |
| `neutral900` | `Color` | Darkest neutral |
| `success` | `Color` | Success color |
| `successContainer` | `Color` | Success container color |
| `warning` | `Color` | Warning color |
| `warningContainer` | `Color` | Warning container color |
| `error` | `Color` | Error color |
| `errorContainer` | `Color` | Error container color |
| `info` | `Color` | Info color |
| `infoContainer` | `Color` | Info container color |

### FCPTextStyles

| Method | Description |
|--------|-------------|
| `getDisplayLarge()` | Large display text style |
| `getDisplayMedium()` | Medium display text style |
| `getDisplaySmall()` | Small display text style |
| `getHeadlineLarge()` | Large headline text style |
| `getHeadlineMedium()` | Medium headline text style |
| `getHeadlineSmall()` | Small headline text style |
| `getTitleLarge()` | Large title text style |
| `getTitleMedium()` | Medium title text style |
| `getTitleSmall()` | Small title text style |
| `getBodyLarge()` | Large body text style |
| `getBodyMedium()` | Medium body text style |
| `getBodySmall()` | Small body text style |
| `getLabelLarge()` | Large label text style |
| `getLabelMedium()` | Medium label text style |
| `getLabelSmall()` | Small label text style |

## Best Practices

1. **Consistency**: Use constants consistently throughout your app
2. **Theme Management**: Use the theme system for consistent styling
3. **Color Usage**: Use semantic colors for better accessibility
4. **Typography**: Use the typography system for consistent text styling
5. **Spacing**: Use spacing constants for consistent layout
6. **Responsive Design**: Consider different screen sizes when using constants
7. **Accessibility**: Ensure proper color contrast and text readability

## Accessibility

- All color schemes support proper contrast ratios
- Text styles provide consistent typography hierarchy
- Constants ensure consistent spacing and sizing
- Theme system supports both light and dark modes
- Color schemes include semantic colors for better user understanding
