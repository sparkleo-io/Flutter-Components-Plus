import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/// Live graph data point model
class FcpLiveGraphData {
  const FcpLiveGraphData({
    required this.x,
    required this.y,
    this.label,
    this.timestamp,
  });

  final double x;
  final double y;
  final String? label;
  final DateTime? timestamp;
}

/// Live graph series configuration
class FcpLiveGraphSeries {
  const FcpLiveGraphSeries({
    required this.data,
    this.color = const Color(0xFFFFBC00),
    this.lineWidth = 2.0,
    this.isCurved = false,
    this.showDots = false,
    this.dotColor,
    this.dotRadius = 4.0,
    this.dotStrokeWidth = 2.0,
    this.showArea = false,
    this.areaColor,
    this.areaOpacity = 0.3,
    this.name,
    this.gradient,
  });

  final List<FcpLiveGraphData> data;
  final Color color;
  final double lineWidth;
  final bool isCurved;
  final bool showDots;
  final Color? dotColor;
  final double dotRadius;
  final double dotStrokeWidth;
  final bool showArea;
  final Color? areaColor;
  final double areaOpacity;
  final String? name;
  final LinearGradient? gradient;
}

/// Live graph axis configuration
class FcpLiveGraphAxis {
  const FcpLiveGraphAxis({
    this.min,
    this.max,
    this.interval,
    this.title,
    this.unit,
    this.showGrid = true,
    this.showLabels = true,
    this.labelStyle,
    this.gridColor = const Color(0xFFE0E0E0),
    this.gridWidth = 1.0,
    this.showDashedLines = false,
    this.dashArray,
    this.formatLabel,
  });

  final double? min;
  final double? max;
  final double? interval;
  final String? title;
  final String? unit;
  final bool showGrid;
  final bool showLabels;
  final TextStyle? labelStyle;
  final Color gridColor;
  final double gridWidth;
  final bool showDashedLines;
  final List<double>? dashArray;
  final String Function(double)? formatLabel;
}

/// Live graph configuration
class FcpLiveGraphConfig {
  const FcpLiveGraphConfig({
    this.height = 250.0,
    this.width,
    this.backgroundColor,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
    this.animationDuration = const Duration(milliseconds: 250),
    this.curve = Curves.easeInOut,
    this.showBorder = true,
    this.borderColor = const Color(0xFFE0E0E0),
    this.borderWidth = 1.0,
    this.xAxis,
    this.yAxis,
    this.showTooltips = true,
    this.tooltipBackgroundColor,
    this.tooltipTextColor,
    this.tooltipBorderRadius = 8.0,
    this.maxDataPoints = 100,
    this.autoScaleY = true,
    this.autoScaleX = false,
    this.clipData = const FlClipData.all(),
    this.showLegend = false,
    this.legendPosition = FcpLiveGraphLegendPosition.bottom,
    this.legendAlignment = WrapAlignment.center,
    this.title,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    this.enableAnimations = true,
    this.throttleUpdates = true,
    this.updateThrottleMs = 16,
    this.persistentData = false,
    this.maxVisibleDataPoints = 100,
  });

  final double height;
  final double? width;
  final Color? backgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Duration animationDuration;
  final Curve curve;
  final bool showBorder;
  final Color borderColor;
  final double borderWidth;
  final FcpLiveGraphAxis? xAxis;
  final FcpLiveGraphAxis? yAxis;
  final bool showTooltips;
  final Color? tooltipBackgroundColor;
  final Color? tooltipTextColor;
  final double tooltipBorderRadius;
  final int maxDataPoints;
  final bool autoScaleY;
  final bool autoScaleX;
  final FlClipData clipData;
  final bool showLegend;
  final FcpLiveGraphLegendPosition legendPosition;
  final WrapAlignment legendAlignment;
  final String? title;
  final String? subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final bool enableAnimations;
  final bool throttleUpdates;
  final int updateThrottleMs;
  final bool persistentData;
  final int maxVisibleDataPoints;
}

/// Legend position for live graph
enum FcpLiveGraphLegendPosition { top, bottom, left, right }

/// Live graph update mode
enum FcpLiveGraphUpdateMode { append, replace, sliding }

/// Live graph data update event
class FcpLiveGraphDataUpdate {
  const FcpLiveGraphDataUpdate({
    required this.seriesIndex,
    required this.data,
    this.mode = FcpLiveGraphUpdateMode.append,
  });

  final int seriesIndex;
  final List<FcpLiveGraphData> data;
  final FcpLiveGraphUpdateMode mode;
}

/// Live graph range configuration
class FcpLiveGraphRange {
  const FcpLiveGraphRange({
    required this.minX,
    required this.maxX,
    required this.minY,
    required this.maxY,
  });

  final double minX;
  final double maxX;
  final double minY;
  final double maxY;
}

/// Live graph performance settings
class FcpLiveGraphPerformance {
  const FcpLiveGraphPerformance({
    this.enableAnimations = true,
    this.animationDuration = const Duration(milliseconds: 250),
    this.throttleUpdates = true,
    this.updateThrottleMs = 16, // ~60fps
    this.enableHardwareAcceleration = true,
    this.maxRenderPoints = 1000,
  });

  final bool enableAnimations;
  final Duration animationDuration;
  final bool throttleUpdates;
  final int updateThrottleMs;
  final bool enableHardwareAcceleration;
  final int maxRenderPoints;
}
