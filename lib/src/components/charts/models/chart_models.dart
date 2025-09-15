import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/// Chart types supported by FCPChart
enum FCPChartType { area, bar, line, histogram }

/// Chart data model with comprehensive fl_chart support
class FCPChartData {
  const FCPChartData({
    required this.x,
    required this.y,
    this.label,
    this.color,
    this.gradient,
    this.strokeColor,
    this.strokeWidth,
    this.dotData,
    this.belowBarData,
    this.aboveBarData,
    this.shadow,
    this.preventCurveOverShooting,
    this.preventCurveOvershootingThreshold,
    this.isStrokeCapRound,
    this.isCurved,
    this.curveSmoothness,
    this.barWidth,
    this.isStepLineChart,
    this.stepDirection,
    this.spotColor,
    this.show,
    this.meta,
    this.dotColor,
    this.areaColor,
  });

  final double x;
  final double y;
  final String? label;
  final Color? color;
  final LinearGradient? gradient;
  final Color? strokeColor;
  final double? strokeWidth;
  final FlDotData? dotData;
  final BarAreaData? belowBarData;
  final BarAreaData? aboveBarData;
  final dynamic shadow;
  final bool? preventCurveOverShooting;
  final double? preventCurveOvershootingThreshold;
  final bool? isStrokeCapRound;
  final bool? isCurved;
  final double? curveSmoothness;
  final double? barWidth;
  final bool? isStepLineChart;
  final dynamic stepDirection;
  final Color? spotColor;
  final bool? show;
  final dynamic meta;
  final Color? dotColor;
  final Color? areaColor;
}

/// Base chart configuration
abstract class FCPChartConfig {}

/// Comprehensive grid data configuration
class FCPGridData {
  const FCPGridData({
    this.show = true,
    this.drawVerticalLine = true,
    this.drawHorizontalLine = true,
    this.horizontalInterval,
    this.verticalInterval,
    this.getDrawingHorizontalLine,
    this.getDrawingVerticalLine,
    this.checkToShowHorizontalLine,
    this.checkToShowVerticalLine,
  });

  final bool show;
  final bool drawVerticalLine;
  final bool drawHorizontalLine;
  final double? horizontalInterval;
  final double? verticalInterval;
  final FCPLine Function(double)? getDrawingHorizontalLine;
  final FCPLine Function(double)? getDrawingVerticalLine;
  final bool Function(double)? checkToShowHorizontalLine;
  final bool Function(double)? checkToShowVerticalLine;
}

/// Comprehensive titles data configuration
class FCPTitlesData {
  const FCPTitlesData({
    this.show = true,
    this.rightTitles,
    this.topTitles,
    this.bottomTitles,
    this.leftTitles,
  });

  final bool show;
  final FCPAxisTitles? rightTitles;
  final FCPAxisTitles? topTitles;
  final FCPAxisTitles? bottomTitles;
  final FCPAxisTitles? leftTitles;
}

/// Comprehensive border data configuration
class FCPBorderData {
  const FCPBorderData({this.show = false, this.border});

  final bool show;
  final Border? border;
}

/// Comprehensive touch data configuration
class FCPTouchData {
  const FCPTouchData({
    this.enabled = true,
    this.touchCallback,
    this.touchSpotThreshold,
    this.getTouchedSpotIndicator,
    this.touchTooltipData,
    this.handleBuiltInTouches = true,
    this.mouseCursorResolver,
  });

  final bool enabled;
  final dynamic touchCallback;
  final double? touchSpotThreshold;
  final dynamic getTouchedSpotIndicator;
  final LineTouchTooltipData? touchTooltipData;
  final bool handleBuiltInTouches;
  final MouseCursor Function(FlTouchEvent, LineTouchResponse)?
  mouseCursorResolver;
}

/// Area chart specific configuration with full fl_chart support
class FCPAreaChartConfig extends FCPChartConfig {
  FCPAreaChartConfig({
    this.minX,
    this.maxX,
    this.minY,
    this.maxY,
    this.isCurved = true,
    this.lineColor,
    this.lineWidth = 3,
    this.areaColor,
    this.areaOpacity = 0.3,
    this.showDots = false,
    this.dotColor,
    this.dotRadius = 4,
    this.dotStrokeWidth = 2,
    this.horizontalInterval,
    this.verticalInterval,
    this.bottomInterval,
    this.leftInterval,
    this.gridData,
    this.titlesData,
    this.borderData,
    this.touchData,
    this.lineBarsData,
    this.clipData,
    this.rangeAnnotations,
    this.betweenBarsData,
    this.extraLinesData,
    this.showingTooltipIndicators,
    this.lineTouchData,
  });

  final double? minX;
  final double? maxX;
  final double? minY;
  final double? maxY;
  final bool isCurved;
  final Color? lineColor;
  final double lineWidth;
  final Color? areaColor;
  final double areaOpacity;
  final bool showDots;
  final Color? dotColor;
  final double dotRadius;
  final double dotStrokeWidth;
  final double? horizontalInterval;
  final double? verticalInterval;
  final double? bottomInterval;
  final double? leftInterval;
  final FCPGridData? gridData;
  final FCPTitlesData? titlesData;
  final FCPBorderData? borderData;
  final FCPTouchData? touchData;
  final List<LineChartBarData>? lineBarsData;
  final FlClipData? clipData;
  final RangeAnnotations? rangeAnnotations;
  final List<BetweenBarsData>? betweenBarsData;
  final ExtraLinesData? extraLinesData;
  final List<int>? showingTooltipIndicators;
  final LineTouchData? lineTouchData;
}

/// Bar chart specific configuration with full fl_chart support
class FCPBarChartConfig extends FCPChartConfig {
  FCPBarChartConfig({
    this.maxY,
    this.barWidth = 20,
    this.barBorderRadius = 4,
    this.showBackground = false,
    this.horizontalInterval,
    this.leftInterval,
    this.alignment = BarChartAlignment.spaceAround,
    this.groupsSpace = 4,
    this.barTouchData,
    this.titlesData,
    this.borderData,
    this.barGroups,
    this.gridData,
    this.clipData,
    this.rangeAnnotations,
    this.barRods,
    this.axisTitleData,
    this.backgroundBarChartRodData,
    this.centerSpaceWidth,
    this.minY,
    this.barGroupsSpace,
    this.barRodsSpace,
    this.barRodsWidth,
    this.barRodsRadius,
    this.barRodsColor,
    this.barRodsGradient,
    this.barRodsStrokeColor,
    this.barRodsStrokeWidth,
    this.barRodsShadow,
    this.barRodsBackDrawRodData,
    this.barRodsBelowBarData,
    this.barRodsAboveBarData,
    this.barRodsTouchData,
    this.barRodsDotData,
    this.barRodsPreventCurveOverShooting,
    this.barRodsPreventCurveOvershootingThreshold,
    this.barRodsIsStrokeCapRound,
    this.barRodsIsCurved,
    this.barRodsCurveSmoothness,
    this.barRodsBarWidth,
    this.barRodsIsStepLineChart,
    this.barRodsStepDirection,
    this.barRodsSpotColor,
    this.barRodsShow,
    this.barRodsMeta,
  });

  final double? maxY;
  final double barWidth;
  final double barBorderRadius;
  final bool showBackground;
  final double? horizontalInterval;
  final double? leftInterval;
  final BarChartAlignment alignment;
  final double groupsSpace;
  final BarTouchData? barTouchData;
  final FlTitlesData? titlesData;
  final FlBorderData? borderData;
  final List<BarChartGroupData>? barGroups;
  final FlGridData? gridData;
  final FlClipData? clipData;
  final RangeAnnotations? rangeAnnotations;
  final List<BarChartRodData>? barRods;
  final dynamic axisTitleData;
  final BackgroundBarChartRodData? backgroundBarChartRodData;
  final double? centerSpaceWidth;
  final double? minY;
  final double? barGroupsSpace;
  final double? barRodsSpace;
  final double? barRodsWidth;
  final BorderRadius? barRodsRadius;
  final Color? barRodsColor;
  final LinearGradient? barRodsGradient;
  final Color? barRodsStrokeColor;
  final double? barRodsStrokeWidth;
  final dynamic barRodsShadow;
  final BackgroundBarChartRodData? barRodsBackDrawRodData;
  final BarAreaData? barRodsBelowBarData;
  final BarAreaData? barRodsAboveBarData;
  final BarTouchData? barRodsTouchData;
  final FlDotData? barRodsDotData;
  final bool? barRodsPreventCurveOverShooting;
  final double? barRodsPreventCurveOvershootingThreshold;
  final bool? barRodsIsStrokeCapRound;
  final bool? barRodsIsCurved;
  final double? barRodsCurveSmoothness;
  final double? barRodsBarWidth;
  final bool? barRodsIsStepLineChart;
  final dynamic barRodsStepDirection;
  final Color? barRodsSpotColor;
  final bool? barRodsShow;
  final dynamic barRodsMeta;
}

/// Line chart specific configuration with full fl_chart support
class FCPLineChartConfig extends FCPChartConfig {
  FCPLineChartConfig({
    this.minX,
    this.maxX,
    this.minY,
    this.maxY,
    this.isCurved = false,
    this.lineColor,
    this.lineWidth = 3,
    this.showDots = true,
    this.dotColor,
    this.dotRadius = 4,
    this.dotStrokeWidth = 2,
    this.horizontalInterval,
    this.verticalInterval,
    this.bottomInterval,
    this.leftInterval,
    this.gridData,
    this.titlesData,
    this.borderData,
    this.touchData,
    this.lineBarsData,
    this.clipData,
    this.rangeAnnotations,
    this.betweenBarsData,
    this.extraLinesData,
    this.showingTooltipIndicators,
    this.lineTouchData,
  });

  final double? minX;
  final double? maxX;
  final double? minY;
  final double? maxY;
  final bool isCurved;
  final Color? lineColor;
  final double lineWidth;
  final bool showDots;
  final Color? dotColor;
  final double dotRadius;
  final double dotStrokeWidth;
  final double? horizontalInterval;
  final double? verticalInterval;
  final double? bottomInterval;
  final double? leftInterval;
  final FCPGridData? gridData;
  final FCPTitlesData? titlesData;
  final FCPBorderData? borderData;
  final FCPTouchData? touchData;
  final List<LineChartBarData>? lineBarsData;
  final FlClipData? clipData;
  final RangeAnnotations? rangeAnnotations;
  final List<BetweenBarsData>? betweenBarsData;
  final ExtraLinesData? extraLinesData;
  final List<int>? showingTooltipIndicators;
  final LineTouchData? lineTouchData;
}

/// Histogram chart specific configuration with full fl_chart support
class FCPHistogramChartConfig extends FCPChartConfig {
  FCPHistogramChartConfig({
    this.maxY,
    this.barWidth = 30,
    this.horizontalInterval,
    this.leftInterval,
    this.alignment = BarChartAlignment.spaceBetween,
    this.groupsSpace = 0,
    this.barTouchData,
    this.titlesData,
    this.borderData,
    this.barGroups,
    this.gridData,
    this.clipData,
    this.rangeAnnotations,
    this.barRods,
    this.axisTitleData,
    this.backgroundBarChartRodData,
    this.centerSpaceWidth,
    this.minY,
    this.barGroupsSpace,
    this.barRodsSpace,
    this.barRodsWidth,
    this.barRodsRadius,
    this.barRodsColor,
    this.barRodsGradient,
    this.barRodsStrokeColor,
    this.barRodsStrokeWidth,
    this.barRodsShadow,
    this.barRodsBackDrawRodData,
    this.barRodsBelowBarData,
    this.barRodsAboveBarData,
    this.barRodsTouchData,
    this.barRodsDotData,
    this.barRodsPreventCurveOverShooting,
    this.barRodsPreventCurveOvershootingThreshold,
    this.barRodsIsStrokeCapRound,
    this.barRodsIsCurved,
    this.barRodsCurveSmoothness,
    this.barRodsBarWidth,
    this.barRodsIsStepLineChart,
    this.barRodsStepDirection,
    this.barRodsSpotColor,
    this.barRodsShow,
    this.barRodsMeta,
  });

  final double? maxY;
  final double barWidth;
  final double? horizontalInterval;
  final double? leftInterval;
  final BarChartAlignment alignment;
  final double groupsSpace;
  final BarTouchData? barTouchData;
  final FlTitlesData? titlesData;
  final FlBorderData? borderData;
  final List<BarChartGroupData>? barGroups;
  final FlGridData? gridData;
  final FlClipData? clipData;
  final RangeAnnotations? rangeAnnotations;
  final List<BarChartRodData>? barRods;
  final dynamic axisTitleData;
  final BackgroundBarChartRodData? backgroundBarChartRodData;
  final double? centerSpaceWidth;
  final double? minY;
  final double? barGroupsSpace;
  final double? barRodsSpace;
  final double? barRodsWidth;
  final BorderRadius? barRodsRadius;
  final Color? barRodsColor;
  final LinearGradient? barRodsGradient;
  final Color? barRodsStrokeColor;
  final double? barRodsStrokeWidth;
  final dynamic barRodsShadow;
  final BackgroundBarChartRodData? barRodsBackDrawRodData;
  final BarAreaData? barRodsBelowBarData;
  final BarAreaData? barRodsAboveBarData;
  final BarTouchData? barRodsTouchData;
  final FlDotData? barRodsDotData;
  final bool? barRodsPreventCurveOverShooting;
  final double? barRodsPreventCurveOvershootingThreshold;
  final bool? barRodsIsStrokeCapRound;
  final bool? barRodsIsCurved;
  final double? barRodsCurveSmoothness;
  final double? barRodsBarWidth;
  final bool? barRodsIsStepLineChart;
  final dynamic barRodsStepDirection;
  final Color? barRodsSpotColor;
  final bool? barRodsShow;
  final dynamic barRodsMeta;
}

/// Chart legend configuration
class FCPChartLegend {
  const FCPChartLegend({
    required this.items,
    this.position = FCPLegendPosition.bottom,
    this.alignment = FCPLegendAlignment.center,
  });

  final List<FCPLegendItem> items;
  final FCPLegendPosition position;
  final FCPLegendAlignment alignment;
}

/// Legend item
class FCPLegendItem {
  const FCPLegendItem({
    required this.label,
    required this.color,
    this.shape = FCPLegendShape.circle,
  });

  final String label;
  final Color color;
  final FCPLegendShape shape;
}

/// Legend position
enum FCPLegendPosition { top, bottom, left, right }

/// Legend alignment
enum FCPLegendAlignment { start, center, end }

/// Legend shape
enum FCPLegendShape { circle, rectangle }

/// FCPChart's own FlLine equivalent
class FCPLine {
  const FCPLine({
    this.color = Colors.grey,
    this.strokeWidth = 1.0,
    this.dashArray,
  });

  final Color color;
  final double strokeWidth;
  final List<int>? dashArray;
}

/// FCPChart's own SideTitles equivalent
class FCPSideTitles {
  const FCPSideTitles({
    this.showTitles = true,
    this.reservedSize = 40,
    this.interval,
    this.getTitlesWidget,
  });

  final bool showTitles;
  final double reservedSize;
  final double? interval;
  final Widget Function(double value, FCPTitleMeta meta)? getTitlesWidget;
}

/// FCPChart's own AxisTitles equivalent
class FCPAxisTitles {
  const FCPAxisTitles({
    this.sideTitles,
    this.axisNameWidget,
    this.axisNameSize = 16,
  });

  final FCPSideTitles? sideTitles;
  final Widget? axisNameWidget;
  final double axisNameSize;
}

/// FCPChart's own TitleMeta equivalent
class FCPTitleMeta {
  const FCPTitleMeta({
    required this.min,
    required this.max,
    required this.axisSide,
  });

  final double min;
  final double max;
  final FCPAxisSide axisSide;
}

/// FCPChart's own AxisSide equivalent
enum FCPAxisSide { left, top, right, bottom }

/// Predefined chart themes
class FCPChartThemes {
  FCPChartThemes._();

  /// Default theme
  static FCPAreaChartConfig get defaultArea => FCPAreaChartConfig();
  static FCPBarChartConfig get defaultBar => FCPBarChartConfig();
  static FCPLineChartConfig get defaultLine => FCPLineChartConfig();
  static FCPHistogramChartConfig get defaultHistogram =>
      FCPHistogramChartConfig();

  /// Minimal theme
  static FCPAreaChartConfig get minimalArea =>
      FCPAreaChartConfig(showDots: false, areaOpacity: 0.1, lineWidth: 2);
  static FCPBarChartConfig get minimalBar =>
      FCPBarChartConfig(barWidth: 16, barBorderRadius: 2);
  static FCPLineChartConfig get minimalLine =>
      FCPLineChartConfig(showDots: false, lineWidth: 2);
  static FCPHistogramChartConfig get minimalHistogram =>
      FCPHistogramChartConfig(barWidth: 20);

  /// Bold theme
  static FCPAreaChartConfig get boldArea => FCPAreaChartConfig(
    showDots: true,
    areaOpacity: 0.5,
    lineWidth: 4,
    dotRadius: 6,
  );
  static FCPBarChartConfig get boldBar =>
      FCPBarChartConfig(barWidth: 28, barBorderRadius: 8);
  static FCPLineChartConfig get boldLine =>
      FCPLineChartConfig(showDots: true, lineWidth: 4, dotRadius: 6);
  static FCPHistogramChartConfig get boldHistogram =>
      FCPHistogramChartConfig(barWidth: 40);
}
