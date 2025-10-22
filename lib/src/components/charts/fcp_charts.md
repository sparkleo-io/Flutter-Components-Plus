# FCPChart Component

A highly customizable chart component with fluent API design, supporting multiple chart types with extensive customization options and animations.

## Features

- **Fluent API Design**: Easy-to-use builder pattern for creating charts
- **Multiple Chart Types**: Area, bar, line, and histogram charts
- **Animations**: Smooth chart animations with customizable duration and curves
- **Customization**: Full control over colors, styling, and appearance
- **Multiple Data Series**: Support for multiple data series in a single chart
- **Interactive**: Built-in tooltips and touch interactions
- **Responsive**: Automatic sizing and responsive design
- **Accessibility**: Proper labeling and screen reader support

## Chart Types

### Area Chart
Filled area under the line with customizable colors and opacity.

```dart
FCPChart.area.withData(
  data: [
    FCPChartData(x: 0, y: 10, label: 'Jan'),
    FCPChartData(x: 1, y: 20, label: 'Feb'),
    FCPChartData(x: 2, y: 15, label: 'Mar'),
  ],
  title: 'Sales Data',
  subtitle: 'Monthly sales performance',
)
```

### Bar Chart
Vertical bars representing data values.

```dart
FCPChart.bar.withData(
  data: [
    FCPChartData(x: 0, y: 10, label: 'Product A'),
    FCPChartData(x: 1, y: 20, label: 'Product B'),
    FCPChartData(x: 2, y: 15, label: 'Product C'),
  ],
  title: 'Product Sales',
)
```

### Line Chart
Connected points showing trends over time.

```dart
FCPChart.line.withData(
  data: [
    FCPChartData(x: 0, y: 10, label: 'Week 1'),
    FCPChartData(x: 1, y: 20, label: 'Week 2'),
    FCPChartData(x: 2, y: 15, label: 'Week 3'),
  ],
  title: 'Weekly Trends',
)
```

### Histogram Chart
Bars without gaps, typically for distribution data.

```dart
FCPChart.histogram.withData(
  data: [
    FCPChartData(x: 0, y: 5, label: '0-10'),
    FCPChartData(x: 1, y: 8, label: '10-20'),
    FCPChartData(x: 2, y: 12, label: '20-30'),
  ],
  title: 'Data Distribution',
)
```

## Basic Usage

### Simple Chart
```dart
FCPChart.line.withData(
  data: chartData,
  title: 'Simple Line Chart',
  height: 300,
)
```

### Chart with Subtitle
```dart
FCPChart.bar.withData(
  data: chartData,
  title: 'Monthly Revenue',
  subtitle: 'Q1 2024 Performance',
  height: 300,
)
```

### Chart with Custom Colors
```dart
FCPChart.area.withData(
  data: chartData.map((d) => FCPChartData(
    x: d.x,
    y: d.y,
    color: Colors.blue,
    areaColor: Colors.blue.withOpacity(0.3),
  )).toList(),
  title: 'Custom Colors',
)
```

## Advanced Usage

### Multiple Data Series
```dart
FCPChart.line.withData(
  multipleDataSeries: [
    // Series 1
    [
      FCPChartData(x: 0, y: 10, color: Colors.blue),
      FCPChartData(x: 1, y: 20, color: Colors.blue),
      FCPChartData(x: 2, y: 15, color: Colors.blue),
    ],
    // Series 2
    [
      FCPChartData(x: 0, y: 5, color: Colors.red),
      FCPChartData(x: 1, y: 15, color: Colors.red),
      FCPChartData(x: 2, y: 25, color: Colors.red),
    ],
  ],
  title: 'Multiple Series',
)
```

### Custom Configuration
```dart
FCPChart.area.withData(
  data: chartData,
  customConfig: FCPAreaChartConfig(
    isCurved: true,
    lineColor: Colors.purple,
    areaColor: Colors.purple,
    areaOpacity: 0.4,
    showDots: true,
    dotColor: Colors.purple,
    dotRadius: 6,
    lineWidth: 4,
  ),
  title: 'Custom Area Chart',
)
```

### Custom Grid and Titles
```dart
FCPChart.line.withData(
  data: chartData,
  customGridData: FCPGridData(
    show: true,
    drawVerticalLine: true,
    drawHorizontalLine: true,
    horizontalInterval: 5,
    verticalInterval: 1,
  ),
  customTitlesData: FCPTitlesData(
    show: true,
    bottomTitles: FCPAxisTitles(
      sideTitles: FCPSideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: (value, meta) => Text('${value.toInt()}'),
      ),
    ),
  ),
  title: 'Custom Grid & Titles',
)
```

### Animation Configuration
```dart
FCPChart.bar.withData(
  data: chartData,
  animationDuration: Duration(milliseconds: 2000),
  curve: Curves.easeInOutCubic,
  title: 'Animated Chart',
)
```

### Interactive Features
```dart
FCPChart.line.withData(
  data: chartData,
  showTooltips: true,
  customLineTouchData: LineTouchData(
    enabled: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipRoundedRadius: 8,
      tooltipPadding: EdgeInsets.all(8),
      getTooltipItems: (touchedSpots) {
        return touchedSpots.map((touchedSpot) {
          return LineTooltipItem(
            'Value: ${touchedSpot.y.toStringAsFixed(1)}',
            TextStyle(color: Colors.white),
          );
        }).toList();
      },
    ),
  ),
  title: 'Interactive Chart',
)
```

### Legend Support
```dart
FCPChart.line.withData(
  data: chartData,
  legend: FCPChartLegend(
    items: [
      FCPLegendItem(
        label: 'Series 1',
        color: Colors.blue,
        shape: FCPLegendShape.circle,
      ),
      FCPLegendItem(
        label: 'Series 2',
        color: Colors.red,
        shape: FCPLegendShape.rectangle,
      ),
    ],
  ),
  title: 'Chart with Legend',
)
```

## Chart Data Models

### FCPChartData
```dart
FCPChartData(
  x: 0.0,                    // X-axis value
  y: 10.0,                   // Y-axis value
  label: 'January',          // Optional label
  color: Colors.blue,         // Optional color
  areaColor: Colors.blue,    // Area color (for area charts)
  dotColor: Colors.blue,     // Dot color (for line charts)
)
```

### Multiple Data Series
```dart
List<List<FCPChartData>> multipleDataSeries = [
  // First series
  [
    FCPChartData(x: 0, y: 10, color: Colors.blue),
    FCPChartData(x: 1, y: 20, color: Colors.blue),
  ],
  // Second series
  [
    FCPChartData(x: 0, y: 5, color: Colors.red),
    FCPChartData(x: 1, y: 15, color: Colors.red),
  ],
];
```

## Configuration Classes

### FCPAreaChartConfig
```dart
FCPAreaChartConfig(
  isCurved: true,                    // Curved lines
  lineColor: Colors.blue,            // Line color
  areaColor: Colors.blue,            // Area fill color
  areaOpacity: 0.3,                  // Area opacity
  showDots: true,                    // Show data points
  dotColor: Colors.blue,             // Dot color
  dotRadius: 4,                      // Dot radius
  dotStrokeWidth: 2,                 // Dot stroke width
  lineWidth: 3,                      // Line width
  horizontalInterval: 5,             // Grid horizontal interval
  verticalInterval: 1,               // Grid vertical interval
  bottomInterval: 1,                 // Bottom axis interval
  leftInterval: 5,                  // Left axis interval
  minX: 0,                          // Minimum X value
  maxX: 10,                         // Maximum X value
  minY: 0,                          // Minimum Y value
  maxY: 100,                        // Maximum Y value
)
```

### FCPBarChartConfig
```dart
FCPBarChartConfig(
  barWidth: 20,                      // Bar width
  barBorderRadius: 4,                // Bar border radius
  showBackground: false,             // Show background bars
  alignment: BarChartAlignment.spaceAround, // Bar alignment
  groupsSpace: 4,                    // Space between groups
  maxY: 100,                        // Maximum Y value
  minY: 0,                          // Minimum Y value
  leftInterval: 10,                  // Left axis interval
)
```

### FCPLineChartConfig
```dart
FCPLineChartConfig(
  isCurved: false,                  // Curved lines
  lineColor: Colors.blue,            // Line color
  showDots: true,                   // Show data points
  dotColor: Colors.blue,             // Dot color
  dotRadius: 4,                      // Dot radius
  dotStrokeWidth: 2,                 // Dot stroke width
  lineWidth: 3,                      // Line width
  horizontalInterval: 5,             // Grid horizontal interval
  verticalInterval: 1,                // Grid vertical interval
  bottomInterval: 1,                 // Bottom axis interval
  leftInterval: 5,                  // Left axis interval
  minX: 0,                          // Minimum X value
  maxX: 10,                         // Maximum X value
  minY: 0,                          // Minimum Y value
  maxY: 100,                        // Maximum Y value
)
```

### FCPHistogramChartConfig
```dart
FCPHistogramChartConfig(
  barWidth: 30,                      // Bar width
  alignment: BarChartAlignment.spaceBetween, // Bar alignment
  groupsSpace: 0,                    // Space between groups
  maxY: 100,                        // Maximum Y value
  minY: 0,                          // Minimum Y value
  leftInterval: 10,                 // Left axis interval
)
```

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class ChartExample extends StatefulWidget {
  @override
  _ChartExampleState createState() => _ChartExampleState();
}

class _ChartExampleState extends State<ChartExample> {
  List<FCPChartData> _salesData = [
    FCPChartData(x: 0, y: 10, label: 'Jan'),
    FCPChartData(x: 1, y: 20, label: 'Feb'),
    FCPChartData(x: 2, y: 15, label: 'Mar'),
    FCPChartData(x: 3, y: 25, label: 'Apr'),
    FCPChartData(x: 4, y: 30, label: 'May'),
    FCPChartData(x: 5, y: 22, label: 'Jun'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chart Examples')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Area Chart
            FCPChart.area.withData(
              data: _salesData,
              title: 'Sales Performance',
              subtitle: 'Monthly revenue data',
              height: 300,
              customConfig: FCPAreaChartConfig(
                isCurved: true,
                showDots: true,
                areaOpacity: 0.3,
              ),
            ),
            SizedBox(height: 24),
            
            // Bar Chart
            FCPChart.bar.withData(
              data: _salesData,
              title: 'Sales by Month',
              height: 300,
              customConfig: FCPBarChartConfig(
                barWidth: 20,
                barBorderRadius: 4,
                showBackground: true,
              ),
            ),
            SizedBox(height: 24),
            
            // Line Chart
            FCPChart.line.withData(
              data: _salesData,
              title: 'Sales Trend',
              height: 300,
              customConfig: FCPLineChartConfig(
                isCurved: false,
                showDots: true,
                lineWidth: 3,
              ),
            ),
            SizedBox(height: 24),
            
            // Multiple Series Chart
            FCPChart.line.withData(
              multipleDataSeries: [
                _salesData.map((d) => FCPChartData(
                  x: d.x,
                  y: d.y,
                  color: Colors.blue,
                )).toList(),
                _salesData.map((d) => FCPChartData(
                  x: d.x,
                  y: d.y * 0.7,
                  color: Colors.red,
                )).toList(),
              ],
              title: 'Multiple Series',
              height: 300,
              legend: FCPChartLegend(
                items: [
                  FCPLegendItem(
                    label: 'Actual',
                    color: Colors.blue,
                    shape: FCPLegendShape.circle,
                  ),
                  FCPLegendItem(
                    label: 'Target',
                    color: Colors.red,
                    shape: FCPLegendShape.circle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

## API Reference

### FCPChartBuilder

| Method | Description |
|--------|-------------|
| `area` | Creates an area chart builder |
| `bar` | Creates a bar chart builder |
| `line` | Creates a line chart builder |
| `histogram` | Creates a histogram chart builder |

### Properties

| Property | Type | Description |
|----------|--------|-------------|
| `data` | `List<FCPChartData>` | Chart data points |
| `multipleDataSeries` | `List<List<FCPChartData>>?` | Multiple data series |
| `title` | `String?` | Chart title |
| `subtitle` | `String?` | Chart subtitle |
| `width` | `double?` | Chart width |
| `height` | `double?` | Chart height |
| `backgroundColor` | `Color?` | Background color |
| `borderRadius` | `double?` | Border radius |
| `padding` | `EdgeInsetsGeometry?` | Chart padding |
| `margin` | `EdgeInsetsGeometry?` | Chart margin |
| `showGrid` | `bool?` | Show grid lines |
| `showBorder` | `bool?` | Show chart border |
| `showTitles` | `bool?` | Show axis titles |
| `showTooltips` | `bool?` | Show tooltips |
| `animationDuration` | `Duration?` | Animation duration |
| `curve` | `Curve?` | Animation curve |
| `legend` | `FCPChartLegend?` | Chart legend |
| `customConfig` | `FCPChartConfig?` | Custom configuration |

## Best Practices

1. **Data Preparation**: Ensure your data is properly formatted and sorted
2. **Performance**: Use appropriate data limits for smooth animations
3. **Accessibility**: Provide meaningful titles and labels
4. **Color Usage**: Use consistent colors and ensure good contrast
5. **Responsive Design**: Test charts on different screen sizes
6. **Loading States**: Show loading indicators for data fetching
7. **Error Handling**: Handle empty or invalid data gracefully

## Accessibility

- All charts support proper labeling for screen readers
- High contrast mode support
- Keyboard navigation for interactive elements
- Proper semantic structure for assistive technologies
