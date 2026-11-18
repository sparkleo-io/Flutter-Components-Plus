import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/theme/text_styles.dart';
import 'models/live_graph_models.dart';

/// A professional live graph component with real-time data updates
/// and proper label management to prevent overflow
class FcpLiveGraph extends StatefulWidget {
  const FcpLiveGraph({
    super.key,
    required this.series,
    this.config = const FcpLiveGraphConfig(),
    this.onDataUpdate,
    this.onRangeChanged,
  });

  /// Create a live graph with a single series
  factory FcpLiveGraph.single({
    Key? key,
    required List<FcpLiveGraphData> data,
    Color color = const Color(0xFFFFBC00),
    String? name,
    FcpLiveGraphConfig config = const FcpLiveGraphConfig(),
    Function(List<FcpLiveGraphData>)? onDataUpdate,
    Function(FcpLiveGraphRange)? onRangeChanged,
  }) {
    return FcpLiveGraph(
      key: key,
      series: [FcpLiveGraphSeries(data: data, color: color, name: name)],
      config: config,
      onDataUpdate: onDataUpdate != null
          ? (index, newData) => onDataUpdate(newData)
          : null,
      onRangeChanged: onRangeChanged,
    );
  }

  /// Create a live graph with multiple series
  factory FcpLiveGraph.multi({
    Key? key,
    required List<FcpLiveGraphSeries> series,
    FcpLiveGraphConfig config = const FcpLiveGraphConfig(),
    Function(int, List<FcpLiveGraphData>)? onDataUpdate,
    Function(FcpLiveGraphRange)? onRangeChanged,
  }) {
    return FcpLiveGraph(
      key: key,
      series: series,
      config: config,
      onDataUpdate: onDataUpdate,
      onRangeChanged: onRangeChanged,
    );
  }

  final List<FcpLiveGraphSeries> series;
  final FcpLiveGraphConfig config;
  final Function(int seriesIndex, List<FcpLiveGraphData> newData)? onDataUpdate;
  final Function(FcpLiveGraphRange range)? onRangeChanged;

  @override
  State<FcpLiveGraph> createState() => _FcpLiveGraphState();
}

class _FcpLiveGraphState extends State<FcpLiveGraph>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  Timer? _updateThrottleTimer;
  DateTime? _lastUpdateTime;

  // Data management
  late List<FcpLiveGraphSeries> _currentSeries;
  FcpLiveGraphRange? _currentRange;

  @override
  void initState() {
    super.initState();
    _currentSeries = List.from(widget.series);
    _initializeAnimation();
    _calculateInitialRange();
  }

  @override
  void didUpdateWidget(FcpLiveGraph oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.series != widget.series) {
      _currentSeries = List.from(widget.series);
      _calculateInitialRange();
    }
  }

  void _initializeAnimation() {
    _animationController = AnimationController(
      duration: widget.config.animationDuration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: widget.config.curve),
    );
  }

  void _calculateInitialRange() {
    if (_currentSeries.isEmpty) return;

    double minX = double.infinity;
    double maxX = double.negativeInfinity;
    double minY = double.infinity;
    double maxY = double.negativeInfinity;

    for (final series in _currentSeries) {
      if (series.data.isEmpty) continue;

      for (final point in series.data) {
        minX = math.min(minX, point.x);
        maxX = math.max(maxX, point.x);
        minY = math.min(minY, point.y);
        maxY = math.max(maxY, point.y);
      }
    }

    // Apply axis constraints from config
    final xAxis = widget.config.xAxis;
    final yAxis = widget.config.yAxis;

    if (xAxis != null) {
      minX = xAxis.min ?? minX;
      maxX = xAxis.max ?? maxX;
    }

    if (yAxis != null) {
      minY = yAxis.min ?? minY;
      maxY = yAxis.max ?? maxY;
    }

    // Ensure valid range
    if (minX == double.infinity) minX = 0;
    if (maxX == double.negativeInfinity) maxX = 10;
    if (minY == double.infinity) minY = 0;
    if (maxY == double.negativeInfinity) maxY = 10;

    _currentRange = FcpLiveGraphRange(
      minX: minX,
      maxX: maxX,
      minY: minY,
      maxY: maxY,
    );
  }

  /// Update data for a specific series
  void updateSeriesData(int seriesIndex, List<FcpLiveGraphData> newData) {
    if (seriesIndex < 0 || seriesIndex >= _currentSeries.length) return;

    if (widget.config.throttleUpdates && _shouldThrottleUpdate()) {
      return;
    }

    setState(() {
      // Apply data limiting based on configuration
      List<FcpLiveGraphData> processedData = _processDataForDisplay(newData);

      _currentSeries[seriesIndex] = FcpLiveGraphSeries(
        data: processedData,
        color: _currentSeries[seriesIndex].color,
        lineWidth: _currentSeries[seriesIndex].lineWidth,
        isCurved: _currentSeries[seriesIndex].isCurved,
        showDots: _currentSeries[seriesIndex].showDots,
        dotColor: _currentSeries[seriesIndex].dotColor,
        dotRadius: _currentSeries[seriesIndex].dotRadius,
        dotStrokeWidth: _currentSeries[seriesIndex].dotStrokeWidth,
        showArea: _currentSeries[seriesIndex].showArea,
        areaColor: _currentSeries[seriesIndex].areaColor,
        areaOpacity: _currentSeries[seriesIndex].areaOpacity,
        name: _currentSeries[seriesIndex].name,
        gradient: _currentSeries[seriesIndex].gradient,
      );

      _calculateInitialRange();
    });

    if (widget.config.enableAnimations) {
      _animationController.forward(from: 0);
    }

    widget.onDataUpdate?.call(seriesIndex, newData);
    _lastUpdateTime = DateTime.now();
  }

  /// Process data based on persistentData and maxVisibleDataPoints settings
  List<FcpLiveGraphData> _processDataForDisplay(List<FcpLiveGraphData> data) {
    if (widget.config.persistentData) {
      // Keep all data, but limit what's displayed
      if (data.length > widget.config.maxVisibleDataPoints) {
        return data.sublist(data.length - widget.config.maxVisibleDataPoints);
      }
      return data;
    } else {
      // Remove old data points beyond maxDataPoints
      if (data.length > widget.config.maxDataPoints) {
        return data.sublist(data.length - widget.config.maxDataPoints);
      }
      return data;
    }
  }

  bool _shouldThrottleUpdate() {
    if (_lastUpdateTime == null) return false;
    final now = DateTime.now();
    final timeSinceLastUpdate = now.difference(_lastUpdateTime!).inMilliseconds;
    return timeSinceLastUpdate < widget.config.updateThrottleMs;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.config.width,
      height: widget.config.height,
      margin: widget.config.margin,
      padding: widget.config.padding,
      decoration: BoxDecoration(
        color: widget.config.backgroundColor ?? Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(widget.config.borderRadius),
        border: widget.config.showBorder
            ? Border.all(
                color: widget.config.borderColor,
                width: widget.config.borderWidth,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.config.title != null || widget.config.subtitle != null)
            _buildHeader(),
          if (widget.config.title != null || widget.config.subtitle != null)
            const SizedBox(height: 16),
          Expanded(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return _buildChart();
              },
            ),
          ),
          if (widget.config.showLegend && _currentSeries.length > 1)
            _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.config.title != null)
          Text(
            widget.config.title!,
            style:
                widget.config.titleStyle ??
                FCPTextStyles.getTitleMedium(
                  color: Theme.of(context).textTheme.titleMedium?.color,
                ),
          ),
        if (widget.config.subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            widget.config.subtitle!,
            style:
                widget.config.subtitleStyle ??
                FCPTextStyles.getBodySmall(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
          ),
        ],
      ],
    );
  }

  Widget _buildChart() {
    if (_currentSeries.isEmpty || _currentRange == null) {
      return const Center(child: Text('No data available'));
    }

    return LineChart(
      _buildLineChartData(),
      duration: widget.config.animationDuration,
    );
  }

  LineChartData _buildLineChartData() {
    return LineChartData(
      lineTouchData: _buildLineTouchData(),
      gridData: _buildGridData(),
      titlesData: _buildTitlesData(),
      borderData: _buildBorderData(),
      lineBarsData: _buildLineBarsData(),
      minX: _currentRange!.minX,
      maxX: _currentRange!.maxX,
      minY: _currentRange!.minY,
      maxY: _currentRange!.maxY,
      clipData: widget.config.clipData,
    );
  }

  LineTouchData _buildLineTouchData() {
    return LineTouchData(
      handleBuiltInTouches: true,
      enabled: widget.config.showTooltips,
      touchTooltipData: LineTouchTooltipData(
        tooltipBorderRadius:
            BorderRadius.circular(widget.config.tooltipBorderRadius),
        tooltipPadding: const EdgeInsets.all(8),
        getTooltipItems: (touchedSpots) {
          return touchedSpots.map((touchedSpot) {
            return LineTooltipItem(
              '${touchedSpot.x.toStringAsFixed(1)}, ${touchedSpot.y.toStringAsFixed(1)}',
              TextStyle(
                color: widget.config.tooltipTextColor ?? Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            );
          }).toList();
        },
      ),
    );
  }

  FlGridData _buildGridData() {
    final xAxis = widget.config.xAxis;
    final yAxis = widget.config.yAxis;

    return FlGridData(
      show: (xAxis?.showGrid ?? true) || (yAxis?.showGrid ?? true),
      drawHorizontalLine: yAxis?.showGrid ?? true,
      drawVerticalLine: xAxis?.showGrid ?? true,
      horizontalInterval: yAxis?.interval,
      verticalInterval: xAxis?.interval,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: yAxis?.gridColor ?? const Color(0xFFE0E0E0),
          strokeWidth: yAxis?.gridWidth ?? 1.0,
          dashArray: (yAxis?.showDashedLines ?? false)
              ? yAxis?.dashArray?.map((e) => e.toInt()).toList()
              : null,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: xAxis?.gridColor ?? const Color(0xFFE0E0E0),
          strokeWidth: xAxis?.gridWidth ?? 1.0,
          dashArray: (xAxis?.showDashedLines ?? false)
              ? xAxis?.dashArray?.map((e) => e.toInt()).toList()
              : null,
        );
      },
    );
  }

  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      bottomTitles: AxisTitles(sideTitles: _buildBottomTitles()),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(sideTitles: _buildLeftTitles()),
    );
  }

  SideTitles _buildBottomTitles() {
    final xAxis = widget.config.xAxis;

    return SideTitles(
      showTitles: xAxis?.showLabels ?? true,
      reservedSize: 32,
      interval: xAxis?.interval ?? 1,
      getTitlesWidget: (value, meta) {
        final text = xAxis?.formatLabel?.call(value) ?? value.toString();
        return SideTitleWidget(
          meta: meta,
          space: 10,
          child: Text(
            text,
            style:
                xAxis?.labelStyle ??
                const TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
          ),
        );
      },
    );
  }

  SideTitles _buildLeftTitles() {
    final yAxis = widget.config.yAxis;

    return SideTitles(
      showTitles: yAxis?.showLabels ?? true,
      reservedSize: 40,
      interval: yAxis?.interval ?? 1,
      getTitlesWidget: (value, meta) {
        final text = yAxis?.formatLabel?.call(value) ?? value.toString();
        final unit = yAxis?.unit ?? '';
        return SideTitleWidget(
          meta: meta,
          space: 10,
          child: Text(
            '$text$unit',
            style:
                yAxis?.labelStyle ??
                const TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  FlBorderData _buildBorderData() {
    return FlBorderData(
      show: widget.config.showBorder,
      border: Border.all(
        color: widget.config.borderColor,
        width: widget.config.borderWidth,
      ),
    );
  }

  List<LineChartBarData> _buildLineBarsData() {
    return _currentSeries.map((series) {
      return LineChartBarData(
        spots: series.data.map((point) => FlSpot(point.x, point.y)).toList(),
        isCurved: series.isCurved,
        color: series.color,
        barWidth: series.lineWidth,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: series.showDots,
          getDotPainter: (spot, percent, barData, index) {
            return FlDotCirclePainter(
              radius: series.dotRadius,
              color: series.dotColor ?? series.color,
              strokeWidth: series.dotStrokeWidth,
              strokeColor: series.color,
            );
          },
        ),
        belowBarData: BarAreaData(
          show: series.showArea,
          color: (series.areaColor ?? series.color).withValues(
            alpha: series.areaOpacity,
          ),
        ),
        gradient: series.gradient,
      );
    }).toList();
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Wrap(
        alignment: widget.config.legendAlignment,
        spacing: 16,
        runSpacing: 8,
        children: _currentSeries.map((series) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12,
                height: 2,
                decoration: BoxDecoration(
                  color: series.color,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                series.name ?? 'Series ${_currentSeries.indexOf(series) + 1}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _updateThrottleTimer?.cancel();
    super.dispose();
  }
}
