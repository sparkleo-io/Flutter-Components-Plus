# FcpLiveGraph Component

A professional live graph component with real-time data updates and proper label management to prevent overflow.

## Features

- 🔴 **Real-time Data Updates**: Live data visualization with smooth animations
- 🎨 **Fully Customizable**: Extensive configuration options for styling
- 📊 **Multi-Series Support**: Display multiple data series simultaneously
- 🏷️ **Smart Label Management**: Automatic label spacing to prevent overlap
- 📱 **Responsive**: Adapts to different screen sizes
- ⚡ **Performance Optimized**: Throttling and animation controls
- 🎯 **Professional Styling**: Beautiful default themes with customization options
- 📈 **Auto-Scaling**: Automatic Y-axis scaling based on data

## Quick Start

### Basic Usage

```dart
import 'package:flutter_components_plus/flutter_components_plus.dart';

// Simple single series live graph
FcpLiveGraph.single(
  data: [
    FcpLiveGraphData(x: 0, y: 2.0),
    FcpLiveGraphData(x: 1, y: 1.8),
    FcpLiveGraphData(x: 2, y: 1.5),
  ],
  color: Color(0xFFFFBC00),
  name: 'Current',
  config: FcpLiveGraphConfig(
    title: 'Live Current Measurement',
    subtitle: 'Real-time current monitoring',
    height: 250,
    showLegend: true,
    yAxis: FcpLiveGraphAxis(
      title: 'Current',
      unit: ' A',
      interval: 0.5,
    ),
    xAxis: FcpLiveGraphAxis(
      title: 'Time',
      unit: 's',
      interval: 1,
    ),
  ),
)
```

### Multi-Series Live Graph

```dart
FcpLiveGraph.multi(
  series: [
    FcpLiveGraphSeries(
      data: currentData,
      color: Color(0xFFFFBC00),
      name: 'Current',
      lineWidth: 2.0,
      showDots: false,
    ),
    FcpLiveGraphSeries(
      data: voltageData,
      color: Color(0xFF01B2A8),
      name: 'Voltage',
      lineWidth: 2.0,
      showDots: false,
    ),
  ],
  config: FcpLiveGraphConfig(
    title: 'Live Current & Voltage',
    subtitle: 'Dual parameter monitoring',
    height: 250,
    showLegend: true,
  ),
)
```

## Configuration

### FcpLiveGraphConfig

Main configuration for the live graph:

```dart
FcpLiveGraphConfig(
  // Layout
  height: 250.0,
  width: null, // Full width by default
  padding: EdgeInsets.all(16.0),
  margin: null,
  
  // Styling
  backgroundColor: null, // Uses theme card color
  borderRadius: 12.0,
  showBorder: true,
  borderColor: Color(0xFFE0E0E0),
  borderWidth: 1.0,
  
  // Title & Subtitle
  title: 'Live Graph',
  subtitle: 'Real-time monitoring',
  titleStyle: null, // Uses theme
  subtitleStyle: null, // Uses theme
  
  // Axes
  xAxis: FcpLiveGraphAxis(...),
  yAxis: FcpLiveGraphAxis(...),
  
  // Tooltips
  showTooltips: true,
  tooltipBackgroundColor: null,
  tooltipTextColor: null,
  tooltipBorderRadius: 8.0,
  
  // Legend
  showLegend: false,
  legendPosition: FcpLiveGraphLegendPosition.bottom,
  legendAlignment: WrapAlignment.center,
  
  // Performance
  enableAnimations: true,
  animationDuration: Duration(milliseconds: 250),
  curve: Curves.easeInOut,
  throttleUpdates: true,
  updateThrottleMs: 16, // ~60fps
  
  // Data Management
  maxDataPoints: 100,
  autoScaleY: true,
  autoScaleX: false,
  clipData: FlClipData.all(),
  persistentData: false,
  maxVisibleDataPoints: 100,
)
```

### FcpLiveGraphAxis

Axis configuration with smart label management:

```dart
FcpLiveGraphAxis(
  // Range
  min: 0.0,
  max: 10.0,
  interval: 1.0, // Label interval
  
  // Labels
  title: 'Time',
  unit: 's',
  showLabels: true,
  labelStyle: TextStyle(fontSize: 10),
  formatLabel: (value) => '${value.toInt()}s', // Custom formatter
  
  // Grid
  showGrid: true,
  gridColor: Color(0xFFE0E0E0),
  gridWidth: 1.0,
  showDashedLines: false,
  dashArray: [5, 5],
)
```

### FcpLiveGraphSeries

Series configuration for multi-series graphs:

```dart
FcpLiveGraphSeries(
  data: dataPoints,
  
  // Line styling
  color: Color(0xFFFFBC00),
  lineWidth: 2.0,
  isCurved: false,
  
  // Dots
  showDots: false,
  dotColor: null, // Uses line color
  dotRadius: 4.0,
  dotStrokeWidth: 2.0,
  
  // Area under line
  showArea: false,
  areaColor: null, // Uses line color
  areaOpacity: 0.3,
  
  // Gradient
  gradient: LinearGradient(...),
  
  // Legend
  name: 'Series 1',
)
```

## Professional Examples

### Battery Current Monitoring

```dart
FcpLiveGraph.single(
  data: currentData,
  color: Color(0xFF2E7D32),
  name: 'Battery Current',
  config: FcpLiveGraphConfig(
    title: 'Battery Current Monitoring',
    subtitle: 'Professional monitoring dashboard',
    height: 300,
    backgroundColor: Color(0xFFF5F5F5),
    borderRadius: 16,
    showBorder: true,
    borderColor: Color(0xFFE0E0E0),
    borderWidth: 2,
    showLegend: true,
    showTooltips: true,
    tooltipBackgroundColor: Color(0xFF424242),
    tooltipTextColor: Colors.white,
    yAxis: FcpLiveGraphAxis(
      title: 'Current',
      unit: ' A',
      interval: 0.5,
      showGrid: true,
      gridColor: Color(0xFFE0E0E0),
      gridWidth: 1,
      showDashedLines: true,
      dashArray: [5, 5],
    ),
    xAxis: FcpLiveGraphAxis(
      title: 'Time',
      unit: 's',
      interval: 1,
      showGrid: true,
      gridColor: Color(0xFFE0E0E0),
      gridWidth: 1,
      showDashedLines: true,
      dashArray: [5, 5],
    ),
  ),
)
```

### Real-time Sensor Data

```dart
FcpLiveGraph.multi(
  series: [
    FcpLiveGraphSeries(
      data: temperatureData,
      color: Colors.red,
      name: 'Temperature',
      showArea: true,
      areaOpacity: 0.2,
    ),
    FcpLiveGraphSeries(
      data: humidityData,
      color: Colors.blue,
      name: 'Humidity',
      showArea: true,
      areaOpacity: 0.2,
    ),
  ],
  config: FcpLiveGraphConfig(
    title: 'Environmental Monitoring',
    height: 300,
    showLegend: true,
    yAxis: FcpLiveGraphAxis(
      interval: 10,
      showGrid: true,
    ),
  ),
)
```

## Advanced Features

### Smart Label Management

The component automatically manages label spacing to prevent overlap and ensure labels stay within graph boundaries:

- Automatic interval calculation based on data range
- Reserved space for labels to prevent clipping
- Custom label formatters for precise control
- Support for units and custom styling

### Performance Optimization

Built-in performance features for smooth real-time updates:

```dart
FcpLiveGraphConfig(
  enableAnimations: true,
  animationDuration: Duration(milliseconds: 250),
  throttleUpdates: true,
  updateThrottleMs: 16, // Limits to ~60fps
  maxDataPoints: 100, // Auto-trim old data
)
```

### Dynamic Updates

Update data programmatically using the widget's state:

```dart
final GlobalKey<_FcpLiveGraphState> graphKey = GlobalKey();

// Later, update the data
graphKey.currentState?.updateSeriesData(
  0, // Series index
  newDataPoints,
);
```

## Data Models

### FcpLiveGraphData

```dart
FcpLiveGraphData(
  x: 1.0,
  y: 2.5,
  label: 'Point 1', // Optional
  timestamp: DateTime.now(), // Optional
)
```

## Data Management Parameters

### Persistent Data vs. Sliding Window

The FcpLiveGraph supports two data management modes:

#### 1. **Sliding Window Mode** (Default)
```dart
FcpLiveGraphConfig(
  persistentData: false,        // Remove old data points
  maxDataPoints: 100,           // Maximum data points to store
  maxVisibleDataPoints: 50,     // Points shown in graph
)
```
- **Behavior**: Automatically removes old data points beyond `maxDataPoints`
- **Use Case**: Real-time monitoring with memory efficiency
- **Performance**: Better for long-running applications

#### 2. **Persistent Data Mode**
```dart
FcpLiveGraphConfig(
  persistentData: true,          // Keep all data points
  maxDataPoints: 1000,          // Maximum data points to store
  maxVisibleDataPoints: 50,     // Points shown in graph (sliding window)
)
```
- **Behavior**: Keeps all data points, but only shows recent `maxVisibleDataPoints`
- **Use Case**: Historical data analysis with zoom/pan capabilities
- **Performance**: Uses more memory but preserves complete history

### Configuration Examples

#### Real-time Monitoring (Sliding Window)
```dart
FcpLiveGraphConfig(
  persistentData: false,
  maxDataPoints: 50,           // Keep only last 50 points
  maxVisibleDataPoints: 50,    // Show all 50 points
)
```

#### Historical Analysis (Persistent Data)
```dart
FcpLiveGraphConfig(
  persistentData: true,
  maxDataPoints: 1000,         // Store up to 1000 points
  maxVisibleDataPoints: 100,   // Show only last 100 points
)
```

#### Memory-Efficient Display
```dart
FcpLiveGraphConfig(
  persistentData: false,
  maxDataPoints: 200,          // Store 200 points
  maxVisibleDataPoints: 50,    // Show only 50 points (sliding window)
)
```

## Best Practices

1. **Label Management**: Use appropriate intervals to prevent label overlap
2. **Performance**: Enable throttling for high-frequency updates
3. **Data Points**: Limit data points using `maxDataPoints` for better performance
4. **Colors**: Use contrasting colors for multi-series graphs
5. **Units**: Always specify units for better user understanding
6. **Tooltips**: Enable tooltips for interactive data exploration
7. **Data Management**: Choose between persistent and sliding window based on use case
8. **Memory Usage**: Use `maxVisibleDataPoints` to control display without affecting storage

## Live Data Updates

### Real-time Data Updates

Here's how to implement live data updates with the FcpLiveGraph:

```dart
class LiveGraphExample extends StatefulWidget {
  const LiveGraphExample({super.key});

  @override
  State<LiveGraphExample> createState() => _LiveGraphExampleState();
}

class _LiveGraphExampleState extends State<LiveGraphExample> {
  final List<FcpLiveGraphData> _liveData = [];
  final Random _random = Random();
  Timer? _timer;
  double _xValue = 0;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    // Add initial value
    _liveData.add(FcpLiveGraphData(x: _xValue, y: _randomY()));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startLiveUpdates() {
    if (_isRunning) return;
    
    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _xValue++;
        _liveData.add(FcpLiveGraphData(x: _xValue, y: _randomY()));

        // Optional: Limit list size to keep recent 50 values
        if (_liveData.length > 50) {
          _liveData.removeAt(0);
        }
      });
    });
  }

  void _stopLiveUpdates() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetData() {
    _timer?.cancel();
    setState(() {
      _liveData.clear();
      _xValue = 0;
      _isRunning = false;
      // Add initial value
      _liveData.add(FcpLiveGraphData(x: _xValue, y: _randomY()));
    });
  }

  double _randomY() {
    return double.parse((_random.nextDouble() * 2).toStringAsFixed(2)); // Range 0.0 → 2.0
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Control buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isRunning ? _stopLiveUpdates : _startLiveUpdates,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isRunning ? Colors.red : Colors.green,
                foregroundColor: Colors.white,
              ),
              child: Text(_isRunning ? 'Stop' : 'Start'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: _resetData,
              child: const Text('Reset'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Live graph
        FcpLiveGraph.single(
          data: _liveData,
          color: const Color(0xFFFFBC00),
          name: 'Current',
          config: FcpLiveGraphConfig(
            title: 'Live Current Measurement',
            subtitle: _isRunning 
                ? 'Real-time current monitoring (${_liveData.length} points)'
                : 'Click Start to begin live updates',
            height: 250,
            showLegend: true,
            yAxis: const FcpLiveGraphAxis(
              title: 'Current',
              unit: ' A',
              interval: 0.5,
              min: 0,
              max: 2.5,
            ),
            xAxis: FcpLiveGraphAxis(
              title: 'Time',
              unit: 's',
              interval: 5,
              min: _liveData.isNotEmpty ? _liveData.first.x : 0,
              max: _liveData.isNotEmpty ? _liveData.last.x + 5 : 10,
            ),
          ),
        ),
      ],
    );
  }
}
```

### Multi-Series Live Updates

For multiple data series updating simultaneously:

```dart
class MultiSeriesLiveGraphExample extends StatefulWidget {
  const MultiSeriesLiveGraphExample({super.key});

  @override
  State<MultiSeriesLiveGraphExample> createState() => _MultiSeriesLiveGraphExampleState();
}

class _MultiSeriesLiveGraphExampleState extends State<MultiSeriesLiveGraphExample> {
  final List<FcpLiveGraphData> _currentData = [];
  final List<FcpLiveGraphData> _voltageData = [];
  final Random _random = Random();
  Timer? _timer;
  double _xValue = 0;
  bool _isRunning = false;

  void _startLiveUpdates() {
    if (_isRunning) return;
    
    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _xValue++;
        _currentData.add(FcpLiveGraphData(x: _xValue, y: _randomCurrent()));
        _voltageData.add(FcpLiveGraphData(x: _xValue, y: _randomVoltage()));

        // Limit list size to keep recent 30 values
        if (_currentData.length > 30) {
          _currentData.removeAt(0);
          _voltageData.removeAt(0);
        }
      });
    });
  }

  double _randomCurrent() {
    return double.parse((_random.nextDouble() * 2).toStringAsFixed(2)); // Range 0.0 → 2.0
  }

  double _randomVoltage() {
    return double.parse((_random.nextDouble() * 4 + 1).toStringAsFixed(2)); // Range 1.0 → 5.0
  }

  @override
  Widget build(BuildContext context) {
    return FcpLiveGraph.multi(
      series: [
        FcpLiveGraphSeries(
          data: _currentData,
          color: const Color(0xFFFFBC00),
          name: 'Current',
          lineWidth: 2.0,
          showDots: false,
        ),
        FcpLiveGraphSeries(
          data: _voltageData,
          color: const Color(0xFF01B2A8),
          name: 'Voltage',
          lineWidth: 2.0,
          showDots: false,
        ),
      ],
      config: FcpLiveGraphConfig(
        title: 'Live Current & Voltage',
        subtitle: _isRunning 
            ? 'Dual parameter monitoring (${_currentData.length} points)'
            : 'Click Start to begin live updates',
        height: 250,
        showLegend: true,
        yAxis: const FcpLiveGraphAxis(
          title: 'Value',
          unit: '',
          interval: 1,
          min: 0,
          max: 6,
        ),
        xAxis: FcpLiveGraphAxis(
          title: 'Time',
          unit: 's',
          interval: 5,
          min: _currentData.isNotEmpty ? _currentData.first.x : 0,
          max: _currentData.isNotEmpty ? _currentData.last.x + 5 : 10,
        ),
      ),
    );
  }
}
```

## Integration Example

Here's a complete example based on your original code:

```dart
class ChargeGraphWidget extends StatelessWidget {
  final List<FcpLiveGraphData> data;
  final String title;
  final double height;

  const ChargeGraphWidget({
    Key? key,
    required this.data,
    this.title = 'Current (in Ampere)',
    this.height = 250,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FcpLiveGraph.single(
      data: data,
      color: const Color(0xFFFFBC00),
      name: 'Current',
      config: FcpLiveGraphConfig(
        title: title,
        height: height,
        showBorder: true,
        borderColor: const Color(0xFF000000).withValues(alpha: 0.12),
        animationDuration: const Duration(milliseconds: 250),
        yAxis: const FcpLiveGraphAxis(
          unit: ' A',
          interval: 0.5,
          showGrid: true,
          gridColor: Color(0xFF000000),
          gridWidth: 1,
        ),
        xAxis: const FcpLiveGraphAxis(
          interval: 1,
          showGrid: false,
        ),
      ),
    );
  }
}
```

## Migration from Custom Implementation

If you're migrating from a custom LineChart implementation:

1. Replace `FlSpot` with `FcpLiveGraphData`
2. Use `FcpLiveGraphConfig` instead of `LineChartData`
3. Configure axes using `FcpLiveGraphAxis`
4. Remove manual grid and title configuration (handled automatically)
5. Enjoy automatic label management and performance optimization

## Notes

- Labels are automatically spaced to prevent overlap
- Graph boundaries are respected (labels won't overflow)
- Animations are smooth and can be customized
- Multi-series graphs share the same axes
- All parameters are exposed for maximum customization
- Built on top of fl_chart for robust charting capabilities

