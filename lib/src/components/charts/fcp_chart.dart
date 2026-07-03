import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/theme/color_scheme.dart';
import '../../core/theme/text_styles.dart';
import 'models/chart_models.dart';

/// A highly customizable chart component with fluent API
class FCPChart extends StatefulWidget {
  const FCPChart._({
    super.key,
    required this.chartType,
    required this.data,
    this.title,
    this.subtitle,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.margin,
    this.showGrid,
    this.showBorder,
    this.showTitles,
    this.showTooltips,
    this.animationDuration,
    this.curve,
    this.legend,
    this.customConfig,
    this.multipleDataSeries,
    this.customGridData,
    this.customTitlesData,
    this.customBorderData,
    this.customTouchData,
    this.customLineBarsData,
    this.customBarGroups,
    this.customClipData,
    this.customRangeAnnotations,
    this.customBetweenBarsData,
    this.customExtraLinesData,
    this.showingTooltipIndicators,
    this.customLineTouchData,
    this.customBarTouchData,
    this.customAxisTitleData,
    this.customBackgroundBarChartRodData,
    this.centerSpaceWidth,
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

  // Fluent API constructors
  static const FCPChartBuilder area = FCPChartBuilder._(
    chartType: FCPChartType.area,
  );
  static const FCPChartBuilder bar = FCPChartBuilder._(
    chartType: FCPChartType.bar,
  );
  static const FCPChartBuilder line = FCPChartBuilder._(
    chartType: FCPChartType.line,
  );
  static const FCPChartBuilder histogram = FCPChartBuilder._(
    chartType: FCPChartType.histogram,
  );

  final FCPChartType chartType;
  final List<FCPChartData> data;
  final String? title;
  final String? subtitle;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool? showGrid;
  final bool? showBorder;
  final bool? showTitles;
  final bool? showTooltips;
  final Duration? animationDuration;
  final Curve? curve;
  final FCPChartLegend? legend;
  final FCPChartConfig? customConfig;

  // Multiple data series support
  final List<List<FCPChartData>>? multipleDataSeries;

  // Custom fl_chart properties
  final FCPGridData? customGridData;
  final FCPTitlesData? customTitlesData;
  final FCPBorderData? customBorderData;
  final FCPTouchData? customTouchData;
  final List<LineChartBarData>? customLineBarsData;
  final List<BarChartGroupData>? customBarGroups;
  final FlClipData? customClipData;
  final RangeAnnotations? customRangeAnnotations;
  final List<BetweenBarsData>? customBetweenBarsData;
  final ExtraLinesData? customExtraLinesData;
  final List<int>? showingTooltipIndicators;
  final LineTouchData? customLineTouchData;
  final BarTouchData? customBarTouchData;
  final dynamic customAxisTitleData;
  final BackgroundBarChartRodData? customBackgroundBarChartRodData;
  final double? centerSpaceWidth;
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

  @override
  State<FCPChart> createState() => _FCPChartState();
}

/// Builder class for fluent API
class FCPChartBuilder {
  const FCPChartBuilder._({required this.chartType});

  final FCPChartType chartType;

  /// Create a chart with data
  FCPChart withData({
    Key? key,
    required List<FCPChartData> data,
    String? title,
    String? subtitle,
    double? width,
    double? height,
    Color? backgroundColor,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    bool? showGrid,
    bool? showBorder,
    bool? showTitles,
    bool? showTooltips,
    Duration? animationDuration,
    Curve? curve,
    FCPChartLegend? legend,
    FCPChartConfig? customConfig,
    List<List<FCPChartData>>? multipleDataSeries,
    FCPGridData? customGridData,
    FCPTitlesData? customTitlesData,
    FCPBorderData? customBorderData,
    FCPTouchData? customTouchData,
    List<LineChartBarData>? customLineBarsData,
    List<BarChartGroupData>? customBarGroups,
    FlClipData? customClipData,
    RangeAnnotations? customRangeAnnotations,
    List<BetweenBarsData>? customBetweenBarsData,
    ExtraLinesData? customExtraLinesData,
    List<int>? showingTooltipIndicators,
    LineTouchData? customLineTouchData,
    BarTouchData? customBarTouchData,
    dynamic customAxisTitleData,
    BackgroundBarChartRodData? customBackgroundBarChartRodData,
    double? centerSpaceWidth,
    double? barGroupsSpace,
    double? barRodsSpace,
    double? barRodsWidth,
    BorderRadius? barRodsRadius,
    Color? barRodsColor,
    LinearGradient? barRodsGradient,
    Color? barRodsStrokeColor,
    double? barRodsStrokeWidth,
    dynamic barRodsShadow,
    BackgroundBarChartRodData? barRodsBackDrawRodData,
    BarAreaData? barRodsBelowBarData,
    BarAreaData? barRodsAboveBarData,
    BarTouchData? barRodsTouchData,
    FlDotData? barRodsDotData,
    bool? barRodsPreventCurveOverShooting,
    double? barRodsPreventCurveOvershootingThreshold,
    bool? barRodsIsStrokeCapRound,
    bool? barRodsIsCurved,
    double? barRodsCurveSmoothness,
    double? barRodsBarWidth,
    bool? barRodsIsStepLineChart,
    dynamic barRodsStepDirection,
    Color? barRodsSpotColor,
    bool? barRodsShow,
    dynamic barRodsMeta,
  }) {
    return FCPChart._(
      key: key,
      chartType: chartType,
      data: data,
      title: title,
      subtitle: subtitle,
      width: width,
      height: height,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      padding: padding,
      margin: margin,
      showGrid: showGrid,
      showBorder: showBorder,
      showTitles: showTitles,
      showTooltips: showTooltips,
      animationDuration: animationDuration,
      curve: curve,
      legend: legend,
      customConfig: customConfig,
      multipleDataSeries: multipleDataSeries,
      customGridData: customGridData,
      customTitlesData: customTitlesData,
      customBorderData: customBorderData,
      customTouchData: customTouchData,
      customLineBarsData: customLineBarsData,
      customBarGroups: customBarGroups,
      customClipData: customClipData,
      customRangeAnnotations: customRangeAnnotations,
      customBetweenBarsData: customBetweenBarsData,
      customExtraLinesData: customExtraLinesData,
      showingTooltipIndicators: showingTooltipIndicators,
      customLineTouchData: customLineTouchData,
      customBarTouchData: customBarTouchData,
      customAxisTitleData: customAxisTitleData,
      customBackgroundBarChartRodData: customBackgroundBarChartRodData,
      centerSpaceWidth: centerSpaceWidth,
      barGroupsSpace: barGroupsSpace,
      barRodsSpace: barRodsSpace,
      barRodsWidth: barRodsWidth,
      barRodsRadius: barRodsRadius,
      barRodsColor: barRodsColor,
      barRodsGradient: barRodsGradient,
      barRodsStrokeColor: barRodsStrokeColor,
      barRodsStrokeWidth: barRodsStrokeWidth,
      barRodsShadow: barRodsShadow,
      barRodsBackDrawRodData: barRodsBackDrawRodData,
      barRodsBelowBarData: barRodsBelowBarData,
      barRodsAboveBarData: barRodsAboveBarData,
      barRodsTouchData: barRodsTouchData,
      barRodsDotData: barRodsDotData,
      barRodsPreventCurveOverShooting: barRodsPreventCurveOverShooting,
      barRodsPreventCurveOvershootingThreshold:
          barRodsPreventCurveOvershootingThreshold,
      barRodsIsStrokeCapRound: barRodsIsStrokeCapRound,
      barRodsIsCurved: barRodsIsCurved,
      barRodsCurveSmoothness: barRodsCurveSmoothness,
      barRodsBarWidth: barRodsBarWidth,
      barRodsIsStepLineChart: barRodsIsStepLineChart,
      barRodsStepDirection: barRodsStepDirection,
      barRodsSpotColor: barRodsSpotColor,
      barRodsShow: barRodsShow,
      barRodsMeta: barRodsMeta,
    );
  }
}

class _FCPChartState extends State<FCPChart> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration ?? const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.curve ?? Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height ?? 300,
      margin: widget.margin,
      padding: widget.padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
        border: widget.showBorder == true
            ? Border.all(color: FCPColorScheme.neutral200)
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
          if (widget.title != null || widget.subtitle != null) ...[
            _buildHeader(),
            const SizedBox(height: 16),
          ],
          Expanded(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return _buildChart();
              },
            ),
          ),
          if (widget.legend != null) ...[
            const SizedBox(height: 16),
            _buildLegend(),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Text(
            widget.title!,
            style: FCPTextStyles.getTitleMedium(
              color: Theme.of(context).textTheme.titleMedium?.color,
            ),
          ),
        if (widget.subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            widget.subtitle!,
            style: FCPTextStyles.getBodySmall(
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildChart() {
    switch (widget.chartType) {
      case FCPChartType.area:
        return _buildAreaChart();
      case FCPChartType.bar:
        return _buildBarChart();
      case FCPChartType.line:
        return _buildLineChart();
      case FCPChartType.histogram:
        return _buildHistogramChart();
    }
  }

  Widget _buildAreaChart() {
    final config = widget.customConfig as FCPAreaChartConfig?;

    // Use custom line bars data if provided, otherwise create from data
    List<LineChartBarData> lineBarsData;
    if (widget.customLineBarsData != null) {
      lineBarsData = widget.customLineBarsData!;
    } else if (widget.multipleDataSeries != null) {
      // Support multiple data series
      lineBarsData = widget.multipleDataSeries!.map((series) {
        final spots = series.map((d) => FlSpot(d.x, d.y)).toList();
        return LineChartBarData(
          spots: spots,
          isCurved: config?.isCurved ?? true,
          color:
              series.first.color ?? config?.lineColor ?? FCPColorScheme.primary,
          barWidth: config?.lineWidth ?? 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: config?.showDots ?? false,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: config?.dotRadius ?? 4,
                color:
                    series.first.dotColor ??
                    config?.dotColor ??
                    FCPColorScheme.primary,
                strokeWidth: config?.dotStrokeWidth ?? 2,
                strokeColor: Colors.white,
              );
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            color:
                (series.first.areaColor ??
                        config?.areaColor ??
                        FCPColorScheme.primary)
                    .withValues(alpha: config?.areaOpacity ?? 0.3),
          ),
        );
      }).toList();
    } else {
      // Single data series
      final spots = widget.data.map((d) => FlSpot(d.x, d.y)).toList();
      lineBarsData = [
        LineChartBarData(
          spots: spots,
          isCurved: config?.isCurved ?? true,
          color: config?.lineColor ?? FCPColorScheme.primary,
          barWidth: config?.lineWidth ?? 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: config?.showDots ?? false,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: config?.dotRadius ?? 4,
                color: config?.dotColor ?? FCPColorScheme.primary,
                strokeWidth: config?.dotStrokeWidth ?? 2,
                strokeColor: Colors.white,
              );
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            color: (config?.areaColor ?? FCPColorScheme.primary).withValues(alpha: 
              config?.areaOpacity ?? 0.3,
            ),
          ),
        ),
      ];
    }

    return LineChart(
      LineChartData(
        gridData: _buildGridData(config),
        titlesData: _buildTitlesData(config),
        borderData: _buildBorderData(config),
        minX: config?.minX,
        maxX: config?.maxX,
        minY: config?.minY,
        maxY: config?.maxY,
        lineBarsData: lineBarsData,
        rangeAnnotations: widget.customRangeAnnotations,
        betweenBarsData: widget.customBetweenBarsData ?? [],
        extraLinesData: widget.customExtraLinesData,
        lineTouchData: widget.customLineTouchData ?? _buildLineTouchData(),
      ),
    );
  }

  Widget _buildBarChart() {
    final config = widget.customConfig as FCPBarChartConfig?;

    // Use custom bar groups if provided, otherwise create from data
    List<BarChartGroupData> barGroups;
    if (widget.customBarGroups != null) {
      barGroups = widget.customBarGroups!;
    } else {
      barGroups = widget.data.asMap().entries.map((entry) {
        final index = entry.key;
        final data = entry.value;
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: data.y,
              color: data.color ?? FCPColorScheme.primary,
              width: config?.barWidth ?? 20,
              borderRadius: BorderRadius.circular(config?.barBorderRadius ?? 4),
              backDrawRodData: BackgroundBarChartRodData(
                show: config?.showBackground ?? false,
                color: FCPColorScheme.neutral100,
              ),
            ),
          ],
        );
      }).toList();
    }

    return BarChart(
      BarChartData(
        alignment: config?.alignment ?? BarChartAlignment.spaceAround,
        maxY: config?.maxY,
        minY: config?.minY,
        groupsSpace: config?.groupsSpace ?? 4,
        barTouchData: widget.customBarTouchData ?? _buildBarTouchData(),
        titlesData: _buildTitlesData(config),
        borderData: _buildBorderData(config),
        barGroups: barGroups,
        gridData: _buildGridData(config),
        rangeAnnotations: widget.customRangeAnnotations,
      ),
    );
  }

  Widget _buildLineChart() {
    final config = widget.customConfig as FCPLineChartConfig?;

    // Use custom line bars data if provided, otherwise create from data
    List<LineChartBarData> lineBarsData;
    if (widget.customLineBarsData != null) {
      lineBarsData = widget.customLineBarsData!;
    } else if (widget.multipleDataSeries != null) {
      // Support multiple data series
      lineBarsData = widget.multipleDataSeries!.map((series) {
        final spots = series.map((d) => FlSpot(d.x, d.y)).toList();
        return LineChartBarData(
          spots: spots,
          isCurved: config?.isCurved ?? false,
          color:
              series.first.color ?? config?.lineColor ?? FCPColorScheme.primary,
          barWidth: config?.lineWidth ?? 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: config?.showDots ?? true,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: config?.dotRadius ?? 4,
                color:
                    series.first.dotColor ??
                    config?.dotColor ??
                    FCPColorScheme.primary,
                strokeWidth: config?.dotStrokeWidth ?? 2,
                strokeColor: Colors.white,
              );
            },
          ),
          belowBarData: BarAreaData(show: false),
        );
      }).toList();
    } else {
      // Single data series
      final spots = widget.data.map((d) => FlSpot(d.x, d.y)).toList();
      lineBarsData = [
        LineChartBarData(
          spots: spots,
          isCurved: config?.isCurved ?? false,
          color: config?.lineColor ?? FCPColorScheme.primary,
          barWidth: config?.lineWidth ?? 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: config?.showDots ?? true,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: config?.dotRadius ?? 4,
                color: config?.dotColor ?? FCPColorScheme.primary,
                strokeWidth: config?.dotStrokeWidth ?? 2,
                strokeColor: Colors.white,
              );
            },
          ),
          belowBarData: BarAreaData(show: false),
        ),
      ];
    }

    return LineChart(
      LineChartData(
        gridData: _buildGridData(config),
        titlesData: _buildTitlesData(config),
        borderData: _buildBorderData(config),
        minX: config?.minX,
        maxX: config?.maxX,
        minY: config?.minY,
        maxY: config?.maxY,
        lineBarsData: lineBarsData,
        rangeAnnotations: widget.customRangeAnnotations,
        betweenBarsData: widget.customBetweenBarsData ?? [],
        extraLinesData: widget.customExtraLinesData,
        lineTouchData: widget.customLineTouchData ?? _buildLineTouchData(),
      ),
    );
  }

  Widget _buildHistogramChart() {
    final config = widget.customConfig as FCPHistogramChartConfig?;

    // Use custom bar groups if provided, otherwise create from data
    List<BarChartGroupData> barGroups;
    if (widget.customBarGroups != null) {
      barGroups = widget.customBarGroups!;
    } else {
      barGroups = widget.data.asMap().entries.map((entry) {
        final index = entry.key;
        final data = entry.value;
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: data.y,
              color: data.color ?? FCPColorScheme.primary,
              width: config?.barWidth ?? 30,
              borderRadius: BorderRadius.zero,
              backDrawRodData: BackgroundBarChartRodData(show: false),
            ),
          ],
        );
      }).toList();
    }

    return BarChart(
      BarChartData(
        alignment: config?.alignment ?? BarChartAlignment.spaceBetween,
        maxY: config?.maxY,
        minY: config?.minY,
        groupsSpace: config?.groupsSpace ?? 0,
        barTouchData: widget.customBarTouchData ?? _buildBarTouchData(),
        titlesData: _buildTitlesData(config),
        borderData: _buildBorderData(config),
        barGroups: barGroups,
        gridData: _buildGridData(config),
        rangeAnnotations: widget.customRangeAnnotations,
      ),
    );
  }

  Widget _buildLegend() {
    if (widget.legend == null) return const SizedBox.shrink();

    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: widget.legend!.items.map((item) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: item.color,
                shape: item.shape == FCPLegendShape.circle
                    ? BoxShape.circle
                    : BoxShape.rectangle,
                borderRadius: item.shape == FCPLegendShape.rectangle
                    ? BorderRadius.circular(2)
                    : null,
              ),
            ),
            const SizedBox(width: 6),
            Text(item.label, style: FCPTextStyles.getBodySmall()),
          ],
        );
      }).toList(),
    );
  }

  /// Helper method to build grid data with custom support
  FlGridData _buildGridData(FCPChartConfig? config) {
    if (widget.customGridData != null) {
      return FlGridData(
        show: widget.customGridData!.show,
        drawVerticalLine: widget.customGridData!.drawVerticalLine,
        drawHorizontalLine: widget.customGridData!.drawHorizontalLine,
        horizontalInterval: widget.customGridData!.horizontalInterval,
        verticalInterval: widget.customGridData!.verticalInterval,
        getDrawingHorizontalLine:
            widget.customGridData!.getDrawingHorizontalLine != null
            ? (value) => _convertFCPLineToFlLine(
                widget.customGridData!.getDrawingHorizontalLine!(value),
              )
            : (value) =>
                  FlLine(color: FCPColorScheme.neutral200, strokeWidth: 1),
        getDrawingVerticalLine:
            widget.customGridData!.getDrawingVerticalLine != null
            ? (value) => _convertFCPLineToFlLine(
                widget.customGridData!.getDrawingVerticalLine!(value),
              )
            : (value) =>
                  FlLine(color: FCPColorScheme.neutral200, strokeWidth: 1),
        checkToShowHorizontalLine:
            widget.customGridData!.checkToShowHorizontalLine ?? (value) => true,
        checkToShowVerticalLine:
            widget.customGridData!.checkToShowVerticalLine ?? (value) => true,
      );
    }

    // Default grid data
    return FlGridData(
      show: widget.showGrid ?? true,
      drawVerticalLine: true,
      drawHorizontalLine: true,
      horizontalInterval: config is FCPAreaChartConfig
          ? config.horizontalInterval
          : config is FCPLineChartConfig
          ? config.horizontalInterval
          : null,
      verticalInterval: config is FCPAreaChartConfig
          ? config.verticalInterval
          : config is FCPLineChartConfig
          ? config.verticalInterval
          : null,
      getDrawingHorizontalLine: (value) {
        return FlLine(color: FCPColorScheme.neutral200, strokeWidth: 1);
      },
      getDrawingVerticalLine: (value) {
        return FlLine(color: FCPColorScheme.neutral200, strokeWidth: 1);
      },
    );
  }

  /// Helper method to build titles data with custom support
  FlTitlesData _buildTitlesData(FCPChartConfig? config) {
    if (widget.customTitlesData != null) {
      return FlTitlesData(
        show: widget.customTitlesData!.show,
        rightTitles: widget.customTitlesData!.rightTitles != null
            ? _convertFCPAxisTitlesToAxisTitles(
                widget.customTitlesData!.rightTitles!,
              )
            : const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: widget.customTitlesData!.topTitles != null
            ? _convertFCPAxisTitlesToAxisTitles(
                widget.customTitlesData!.topTitles!,
              )
            : const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: widget.customTitlesData!.bottomTitles != null
            ? _convertFCPAxisTitlesToAxisTitles(
                widget.customTitlesData!.bottomTitles!,
              )
            : AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 30),
              ),
        leftTitles: widget.customTitlesData!.leftTitles != null
            ? _convertFCPAxisTitlesToAxisTitles(
                widget.customTitlesData!.leftTitles!,
              )
            : AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 40),
              ),
      );
    }

    // Default titles data
    return FlTitlesData(
      show: widget.showTitles ?? true,
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: config is FCPAreaChartConfig
              ? config.bottomInterval
              : config is FCPLineChartConfig
              ? config.bottomInterval
              : null,
          getTitlesWidget: (value, meta) {
            return Text(
              value.toStringAsFixed(0),
              style: FCPTextStyles.getBodySmall(),
            );
          },
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          interval: config is FCPAreaChartConfig
              ? config.leftInterval
              : config is FCPLineChartConfig
              ? config.leftInterval
              : config is FCPBarChartConfig
              ? config.leftInterval
              : config is FCPHistogramChartConfig
              ? config.leftInterval
              : null,
          getTitlesWidget: (value, meta) {
            return Text(
              value.toStringAsFixed(0),
              style: FCPTextStyles.getBodySmall(),
            );
          },
        ),
      ),
    );
  }

  /// Helper method to build border data with custom support
  FlBorderData _buildBorderData(FCPChartConfig? config) {
    if (widget.customBorderData != null) {
      return FlBorderData(
        show: widget.customBorderData!.show,
        border: widget.customBorderData!.border,
      );
    }

    // Default border data
    return FlBorderData(
      show: widget.showBorder ?? false,
      border: Border.all(color: FCPColorScheme.neutral300),
    );
  }

  /// Helper method to build line touch data
  LineTouchData _buildLineTouchData() {
    return LineTouchData(
      enabled: widget.showTooltips ?? true,
      touchTooltipData: LineTouchTooltipData(
        tooltipBorderRadius: BorderRadius.circular(8),
        tooltipPadding: const EdgeInsets.all(8),
        getTooltipItems: (touchedSpots) {
          return touchedSpots.map((touchedSpot) {
            return LineTooltipItem(
              '${touchedSpot.x.toStringAsFixed(1)}, ${touchedSpot.y.toStringAsFixed(1)}',
              FCPTextStyles.getBodySmall(color: Colors.white),
            );
          }).toList();
        },
      ),
    );
  }

  /// Helper method to build bar touch data
  BarTouchData _buildBarTouchData() {
    return BarTouchData(
      enabled: widget.showTooltips ?? true,
      touchTooltipData: BarTouchTooltipData(
        tooltipBorderRadius: BorderRadius.circular(8),
        tooltipPadding: const EdgeInsets.all(8),
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          return BarTooltipItem(
            '${widget.data[groupIndex].label ?? group.x.toInt()}\n${rod.toY.toStringAsFixed(1)}',
            FCPTextStyles.getBodySmall(color: Colors.white),
          );
        },
      ),
    );
  }

  /// Convert FCPLine to FlLine
  FlLine _convertFCPLineToFlLine(FCPLine fcpLine) {
    return FlLine(
      color: fcpLine.color,
      strokeWidth: fcpLine.strokeWidth,
      dashArray: fcpLine.dashArray,
    );
  }

  /// Convert FCPSideTitles to SideTitles
  SideTitles _convertFCPSideTitlesToSideTitles(FCPSideTitles fcpSideTitles) {
    return SideTitles(
      showTitles: fcpSideTitles.showTitles,
      reservedSize: fcpSideTitles.reservedSize,
      interval: fcpSideTitles.interval,
      getTitlesWidget: fcpSideTitles.getTitlesWidget != null
          ? (value, meta) => fcpSideTitles.getTitlesWidget!(
              value,
              FCPTitleMeta(
                min: meta.min,
                max: meta.max,
                axisSide: _convertAxisSideToFCPAxisSide(meta.axisSide),
              ),
            )
          : (value, meta) => Text(value.toString()),
    );
  }

  /// Convert AxisSide to FCPAxisSide
  FCPAxisSide _convertAxisSideToFCPAxisSide(AxisSide axisSide) {
    switch (axisSide) {
      case AxisSide.left:
        return FCPAxisSide.left;
      case AxisSide.top:
        return FCPAxisSide.top;
      case AxisSide.right:
        return FCPAxisSide.right;
      case AxisSide.bottom:
        return FCPAxisSide.bottom;
    }
  }

  /// Convert FCPAxisTitles to AxisTitles
  AxisTitles _convertFCPAxisTitlesToAxisTitles(FCPAxisTitles fcpAxisTitles) {
    return AxisTitles(
      sideTitles: fcpAxisTitles.sideTitles != null
          ? _convertFCPSideTitlesToSideTitles(fcpAxisTitles.sideTitles!)
          : const SideTitles(showTitles: false),
      axisNameWidget: fcpAxisTitles.axisNameWidget,
      axisNameSize: fcpAxisTitles.axisNameSize,
    );
  }
}
