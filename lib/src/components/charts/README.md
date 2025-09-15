# FCPChart Component

A highly customizable and time-saving chart component built on top of fl_chart, providing a fluent API for creating beautiful charts with minimal code.

## Features

- 🎨 **Multiple Chart Types**: Area, Bar, Line, and Histogram charts
- 🚀 **Fluent API**: Easy-to-use builder pattern for quick chart creation
- 🎯 **Fully Customizable**: Extensive configuration options for styling
- 📱 **Responsive**: Adapts to different screen sizes
- 🎭 **Themes**: Predefined themes for quick styling
- 📊 **Interactive**: Built-in tooltips and touch interactions
- 🎪 **Animations**: Smooth animations for better user experience
- 🏷️ **Legends**: Support for custom legends with different shapes

## Quick Start

### Basic Usage

```dart
import 'package:flutter_components_plus/flutter_components_plus.dart';

// Simple area chart
FCPChart.area.withData(
  data: [
    FCPChartData(x: 0, y: 10),
    FCPChartData(x: 1, y: 25),
    FCPChartData(x: 2, y: 15),
    FCPChartData(x: 3, y: 40),
  ],
  title: 'Sales Performance',
)

// Simple bar chart
FCPChart.bar.withData(
  data: [
    FCPChartData(x: 0, y: 20, label: 'Jan'),
    FCPChartData(x: 1, y: 35, label: 'Feb'),
    FCPChartData(x: 2, y: 15, label: 'Mar'),
  ],
  title: 'Monthly Revenue',
)

// Simple line chart
FCPChart.line.withData(
  data: [
    FCPChartData(x: 0, y: 100),
    FCPChartData(x: 1, y: 120),
    FCPChartData(x: 2, y: 110),
  ],
  title: 'Stock Price Trend',
)

// Simple histogram
FCPChart.histogram.withData(
  data: [
    FCPChartData(x: 0, y: 5, label: '0-10'),
    FCPChartData(x: 1, y: 12, label: '10-20'),
    FCPChartData(x: 2, y: 8, label: '20-30'),
  ],
  title: 'Age Distribution',
)
```

## Chart Types

### 1. Area Chart
Perfect for showing trends over time with filled areas.

```dart
FCPChart.area.withData(
  data: data,
  title: 'Sales Performance',
  customConfig: FCPAreaChartConfig(
    showDots: true,
    areaOpacity: 0.3,
    isCurved: true,
    lineWidth: 3,
  ),
)
```

### 2. Bar Chart
Great for comparing different categories.

```dart
FCPChart.bar.withData(
  data: data,
  title: 'Monthly Revenue',
  customConfig: FCPBarChartConfig(
    barWidth: 25,
    barBorderRadius: 6,
    showBackground: true,
  ),
)
```

### 3. Line Chart
Ideal for showing continuous data trends.

```dart
FCPChart.line.withData(
  data: data,
  title: 'Stock Price Trend',
  customConfig: FCPLineChartConfig(
    showDots: true,
    isCurved: false,
    lineWidth: 3,
  ),
)
```

### 4. Histogram Chart
Perfect for showing frequency distributions.

```dart
FCPChart.histogram.withData(
  data: data,
  title: 'Age Distribution',
  customConfig: FCPHistogramChartConfig(
    barWidth: 35,
  ),
)
```

## Customization Options

### Chart Configuration

Each chart type has its own configuration class:

- `FCPAreaChartConfig`: Area chart specific options
- `FCPBarChartConfig`: Bar chart specific options
- `FCPLineChartConfig`: Line chart specific options
- `FCPHistogramChartConfig`: Histogram specific options

### Common Properties

```dart
FCPChart.area.withData(
  data: data,
  title: 'Chart Title',
  subtitle: 'Chart subtitle',
  width: 400,
  height: 300,
  backgroundColor: Colors.white,
  borderRadius: 12,
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.all(8),
  showGrid: true,
  showBorder: false,
  showTitles: true,
  showTooltips: true,
  animationDuration: Duration(milliseconds: 1500),
  curve: Curves.easeInOut,
)
```

### Legends

Add legends to your charts:

```dart
final legend = FCPChartLegend(
  items: [
    FCPLegendItem(
      label: 'Sales',
      color: FCPColorScheme.primary,
      shape: FCPLegendShape.circle,
    ),
    FCPLegendItem(
      label: 'Target',
      color: FCPColorScheme.secondary,
      shape: FCPLegendShape.rectangle,
    ),
  ],
);

FCPChart.line.withData(
  data: data,
  title: 'Sales vs Target',
  legend: legend,
)
```

## Predefined Themes

Use predefined themes for quick styling:

```dart
// Minimal theme
FCPChart.area.withData(
  data: data,
  customConfig: FCPChartThemes.minimalArea,
)

// Bold theme
FCPChart.bar.withData(
  data: data,
  customConfig: FCPChartThemes.boldBar,
)

// Default theme
FCPChart.line.withData(
  data: data,
  customConfig: FCPChartThemes.defaultLine,
)
```

## Data Model

### FCPChartData

```dart
class FCPChartData {
  const FCPChartData({
    required this.x,        // X-axis value
    required this.y,        // Y-axis value
    this.label,             // Optional label for display
    this.color,             // Optional color for this data point
  });

  final double x;
  final double y;
  final String? label;
  final Color? color;
}
```

## Advanced Examples

### Multi-series Chart with Legend

```dart
final legend = FCPChartLegend(
  items: [
    FCPLegendItem(label: 'Series 1', color: Colors.blue),
    FCPLegendItem(label: 'Series 2', color: Colors.red),
    FCPLegendItem(label: 'Series 3', color: Colors.green),
  ],
);

FCPChart.line.withData(
  data: series1Data,
  title: 'Multi-series Chart',
  legend: legend,
  customConfig: FCPLineChartConfig(
    showDots: true,
    lineWidth: 3,
  ),
)
```

### Custom Styled Chart

```dart
FCPChart.area.withData(
  data: data,
  title: 'Custom Styled Chart',
  backgroundColor: Colors.grey[50],
  borderRadius: 16,
  customConfig: FCPAreaChartConfig(
    showDots: true,
    areaOpacity: 0.4,
    lineWidth: 4,
    dotRadius: 6,
    lineColor: Colors.purple,
    areaColor: Colors.purple,
  ),
)
```

## Best Practices

1. **Data Preparation**: Ensure your data is properly formatted and sorted
2. **Performance**: For large datasets, consider data sampling or pagination
3. **Accessibility**: Always provide meaningful titles and labels
4. **Responsive Design**: Use flexible dimensions for different screen sizes
5. **Color Consistency**: Use your app's color scheme for consistency

## Troubleshooting

### Common Issues

1. **Empty Chart**: Check if data is properly formatted and not empty
2. **Overlapping Labels**: Adjust intervals or reduce label frequency
3. **Performance Issues**: Reduce data points or use simpler configurations
4. **Animation Issues**: Ensure animation duration is reasonable

### Tips

- Use `showTitles: false` for cleaner look when space is limited
- Adjust `barWidth` for bar charts to prevent overlapping
- Use `isCurved: true` for smoother area and line charts
- Set appropriate `maxY` values to control chart scale

## Examples

See `chart_examples.dart` for comprehensive examples of all chart types and configurations.
