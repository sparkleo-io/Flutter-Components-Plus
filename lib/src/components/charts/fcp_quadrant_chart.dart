import 'package:flutter/material.dart';
import 'models/chart_models.dart';

typedef FCPQuadrantMarkerBuilder =
    Widget Function(BuildContext context, FCPQuadrantMarkerType markerType);

enum FCPQuadrantMarkerType { circle, square }

enum FCPQuadrantRegion { topLeft, topRight, bottomLeft, bottomRight }

/// Horizontal axis titles: above or below the chart.
enum FCPQuadrantXAxisPosition { top, bottom }

/// Vertical axis titles: left or right of the chart.
enum FCPQuadrantYAxisPosition { left, right }

/// Highly customizable quadrant chart without an image asset dependency.
///
/// By default, chart body size is:
/// - width: 500
/// - height: 500
///
/// Axis title ticks are driven by [FCPTitlesData] and each axis
/// [FCPSideTitles.interval]: when `interval` is null or `<= 0`, three ticks
/// are used (`0`, midpoint, `max`); otherwise ticks are `0, interval, 2*interval, …`
/// up to `max` (inclusive).
class FCPQuadrantChart extends StatelessWidget {
  const FCPQuadrantChart({
    super.key,
    required this.xValue,
    required this.yValue,
    required this.xThreshold,
    required this.yThreshold,
    this.secondaryXValue,
    this.secondaryYValue,
    this.showSecondaryMarker = false,
    this.width,
    this.height,
    this.title,
    this.subtitle,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.markerSize = 16,
    this.pointSize,
    this.titlesData,
    this.xAxisTextStyle,
    this.yAxisTextStyle,
    this.xAxisTextPadding = 5,
    this.yAxisTextPadding = 5,
    this.xAxisPosition = FCPQuadrantXAxisPosition.bottom,
    this.yAxisPosition = FCPQuadrantYAxisPosition.left,
    this.showRegionColors = true,
    this.regionOverlayOpacity = 0.9,
    this.topLeftColor,
    this.topRightColor,
    this.bottomLeftColor,
    this.bottomRightColor,
    this.showRegionLabels = false,
    this.topLeftRegionLabel,
    this.topRightRegionLabel,
    this.bottomLeftRegionLabel,
    this.bottomRightRegionLabel,
    this.regionLabelTextStyle,
    this.regionLabelPadding = const EdgeInsets.all(8),
    this.showCenterCross = false,
    this.centerCrossColor = const Color(0x55000000),
    this.centerCrossStrokeWidth = 1,
    this.backgroundDecoration,
    this.padding = const EdgeInsets.all(5),
    this.quadrantInternalStrokeWidth = 1,
    this.quadrantExternalStrokeWidth = 2,
    this.quadrantInternalStrokeColor = const Color(0xFF5F5F5F),
    this.quadrantExternalStrokeColor = const Color(0xFF2E2E2E),
    this.circleMarkerBuilder,
    this.squareMarkerBuilder,
  });

  final double xValue;
  final double yValue;
  final double? secondaryXValue;
  final double? secondaryYValue;
  final double xThreshold;
  final double yThreshold;
  final bool showSecondaryMarker;

  final double? width;
  final double? height;
  final String? title;
  final String? subtitle;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;

  final double markerSize;
  final double? pointSize;
  final FCPQuadrantMarkerBuilder? circleMarkerBuilder;
  final FCPQuadrantMarkerBuilder? squareMarkerBuilder;

  final FCPTitlesData? titlesData;
  final TextStyle? xAxisTextStyle;
  final TextStyle? yAxisTextStyle;
  final double xAxisTextPadding;
  final double yAxisTextPadding;
  final FCPQuadrantXAxisPosition xAxisPosition;
  final FCPQuadrantYAxisPosition yAxisPosition;

  final bool showRegionColors;
  final double regionOverlayOpacity;
  final Color? topLeftColor;
  final Color? topRightColor;
  final Color? bottomLeftColor;
  final Color? bottomRightColor;

  final bool showRegionLabels;
  final String? topLeftRegionLabel;
  final String? topRightRegionLabel;
  final String? bottomLeftRegionLabel;
  final String? bottomRightRegionLabel;
  final TextStyle? regionLabelTextStyle;
  final EdgeInsets regionLabelPadding;

  final bool showCenterCross;
  final Color centerCrossColor;
  final double centerCrossStrokeWidth;

  final BoxDecoration? backgroundDecoration;
  final EdgeInsetsGeometry padding;
  final double quadrantInternalStrokeWidth;
  final double quadrantExternalStrokeWidth;
  final Color quadrantInternalStrokeColor;
  final Color quadrantExternalStrokeColor;

  double _calculateAxis({
    required double value,
    required double threshold,
    required double imageSize,
    required double maxClamp,
  }) {
    final rangeMax = threshold * 2;
    if (rangeMax <= 0) return 0;
    if (value > rangeMax) return maxClamp;
    final position = imageSize * (value / rangeMax);
    if (position.isNaN || position.isInfinite) return 0;
    return position.clamp(0, maxClamp);
  }

  TextStyle _resolvedYAxisStyle(BuildContext context) {
    return yAxisTextStyle ??
        (Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11) ??
            const TextStyle(fontSize: 11));
  }

  TextStyle _resolvedXAxisStyle(BuildContext context) {
    return xAxisTextStyle ??
        (Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12) ??
            const TextStyle(fontSize: 12));
  }

  /// Tick values from [min] to [max] inclusive.
  ///
  /// If [interval] is null or `<= 0`, uses three ticks: `min`, midpoint, `max`
  /// (like fl_chart’s default spacing). Otherwise steps by [interval] and
  /// ensures [max] is included when missing.
  static List<double> tickValuesForAxis({
    required double min,
    required double max,
    double? interval,
  }) {
    if (max < min) return [min];
    if ((max - min).abs() < 1e-9) return [min];
    final step = interval;
    if (step == null || step <= 0) {
      final mid = min + (max - min) / 2;
      final ticks = <double>{min, mid, max}.toList()..sort();
      return ticks;
    }
    final out = <double>[];
    var v = min;
    const eps = 1e-9;
    while (v <= max + eps) {
      out.add(v);
      v += step;
    }
    if (out.isEmpty) return [min, max];
    if ((out.last - max).abs() > eps) {
      out.add(max);
    }
    return out;
  }

  TextStyle _resolvedRegionLabelStyle(BuildContext context) {
    return regionLabelTextStyle ??
        (Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ) ??
            const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ));
  }

  Widget _defaultCircleMarker(BuildContext context) {
    final outline = Theme.of(context).colorScheme.outline;
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.primary,
        border: Border.all(color: outline, width: 1),
      ),
    );
  }

  Widget _defaultSquareMarker(BuildContext context) {
    final outline = Theme.of(context).colorScheme.outline;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        border: Border.all(color: outline, width: 1),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildMarker(BuildContext context, FCPQuadrantMarkerType markerType) {
    if (markerType == FCPQuadrantMarkerType.circle) {
      return circleMarkerBuilder?.call(context, markerType) ??
          _defaultCircleMarker(context);
    }
    return squareMarkerBuilder?.call(context, markerType) ??
        _defaultSquareMarker(context);
  }

  FCPSideTitles? _xAxisSideTitles() {
    if (!(titlesData?.show ?? false)) return null;
    return xAxisPosition == FCPQuadrantXAxisPosition.top
        ? (titlesData?.topTitles?.sideTitles ?? titlesData?.bottomTitles?.sideTitles)
        : (titlesData?.bottomTitles?.sideTitles ?? titlesData?.topTitles?.sideTitles);
  }

  FCPSideTitles? _yAxisSideTitles() {
    if (!(titlesData?.show ?? false)) return null;
    return yAxisPosition == FCPQuadrantYAxisPosition.right
        ? (titlesData?.rightTitles?.sideTitles ?? titlesData?.leftTitles?.sideTitles)
        : (titlesData?.leftTitles?.sideTitles ?? titlesData?.rightTitles?.sideTitles);
  }

  Widget _buildRegionColors(
    BuildContext context,
    double chartWidth,
    double chartHeight,
  ) {
    final halfW = chartWidth / 2;
    final halfH = chartHeight / 2;
    final fallback = Theme.of(context).colorScheme.surface;
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            width: halfW,
            height: halfH,
            child: ColoredBox(
              color: (topLeftColor ?? fallback).withValues(
                alpha: regionOverlayOpacity,
              ),
            ),
          ),
          Positioned(
            left: halfW,
            top: 0,
            width: halfW,
            height: halfH,
            child: ColoredBox(
              color: (topRightColor ?? fallback).withValues(
                alpha: regionOverlayOpacity,
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: halfH,
            width: halfW,
            height: halfH,
            child: ColoredBox(
              color: (bottomLeftColor ?? fallback).withValues(
                alpha: regionOverlayOpacity,
              ),
            ),
          ),
          Positioned(
            left: halfW,
            top: halfH,
            width: halfW,
            height: halfH,
            child: ColoredBox(
              color: (bottomRightColor ?? fallback).withValues(
                alpha: regionOverlayOpacity,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegionLabels(BuildContext context) {
    Widget buildLabel(FCPQuadrantRegion region, Alignment alignment) {
      final text = switch (region) {
        FCPQuadrantRegion.topLeft => topLeftRegionLabel ?? '',
        FCPQuadrantRegion.topRight => topRightRegionLabel ?? '',
        FCPQuadrantRegion.bottomLeft => bottomLeftRegionLabel ?? '',
        FCPQuadrantRegion.bottomRight => bottomRightRegionLabel ?? '',
      };
      if (text.isEmpty) return const SizedBox.shrink();
      return Align(
        alignment: alignment,
        child: Padding(
          padding: regionLabelPadding,
          child: Text(text, style: _resolvedRegionLabelStyle(context)),
        ),
      );
    }

    return IgnorePointer(
      child: Stack(
        children: [
          Positioned.fill(
            child: buildLabel(FCPQuadrantRegion.topLeft, Alignment.topLeft),
          ),
          Positioned.fill(
            child: buildLabel(FCPQuadrantRegion.topRight, Alignment.topRight),
          ),
          Positioned.fill(
            child: buildLabel(
              FCPQuadrantRegion.bottomLeft,
              Alignment.bottomLeft,
            ),
          ),
          Positioned.fill(
            child: buildLabel(
              FCPQuadrantRegion.bottomRight,
              Alignment.bottomRight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYAxisTitlesColumn(BuildContext context, double chartHeight) {
    final side = _yAxisSideTitles();
    if (side == null || !side.showTitles) {
      return const SizedBox.shrink();
    }
    final max = yThreshold * 2;
    final ascending = tickValuesForAxis(
      min: 0,
      max: max,
      interval: side.interval,
    );
    final values = ascending.reversed.toList();
    final style = _resolvedYAxisStyle(context);
    final yOnRight = yAxisPosition == FCPQuadrantYAxisPosition.right;
    final axisSide = yOnRight ? FCPAxisSide.right : FCPAxisSide.left;
    return SizedBox(
      width: side.reservedSize,
      height: chartHeight,
      child: Padding(
        padding: yOnRight
            ? EdgeInsets.only(left: yAxisTextPadding)
            : EdgeInsets.only(right: yAxisTextPadding),
        child: Column(
          crossAxisAlignment:
              yOnRight ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: values.map((value) {
            final widgetFromBuilder = side.getTitlesWidget?.call(
              value,
              FCPTitleMeta(min: 0, max: max, axisSide: axisSide),
            );
            final child = widgetFromBuilder ??
                Text(value.toStringAsFixed(0), style: style);
            return Expanded(
              child: Align(
                alignment: yOnRight
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: yOnRight
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: child,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildXAxisTitlesRow(BuildContext context, double chartWidth) {
    final side = _xAxisSideTitles();
    if (side == null || !side.showTitles) {
      return const SizedBox.shrink();
    }
    final max = xThreshold * 2;
    final values = tickValuesForAxis(
      min: 0,
      max: max,
      interval: side.interval,
    );
    final style = _resolvedXAxisStyle(context);
    final xOnTop = xAxisPosition == FCPQuadrantXAxisPosition.top;
    final axisSide = xOnTop ? FCPAxisSide.top : FCPAxisSide.bottom;
    return SizedBox(
      width: chartWidth,
      child: Padding(
        padding: xOnTop
            ? EdgeInsets.only(bottom: xAxisTextPadding)
            : EdgeInsets.only(top: xAxisTextPadding),
        child: Row(
          children: values.map((value) {
            final widgetFromBuilder = side.getTitlesWidget?.call(
              value,
              FCPTitleMeta(min: 0, max: max, axisSide: axisSide),
            );
            final child = widgetFromBuilder ??
                Text(value.toStringAsFixed(0), style: style);
            return Expanded(
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: child,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveMarkerSize = pointSize ?? markerSize;
    final chartHeight = height ?? 500;
    final totalWidth = width ?? 500;
    final ySide = _yAxisSideTitles();
    final hasYAxisTitles = ySide != null && ySide.showTitles;
    final yReservedSize = hasYAxisTitles ? ySide.reservedSize : 0.0;
    final yOnLeft = yAxisPosition == FCPQuadrantYAxisPosition.left;
    final double leftReservedSize =
        (hasYAxisTitles && yOnLeft) ? yReservedSize : 0;
    final double rightReservedSize =
        (hasYAxisTitles && !yOnLeft) ? yReservedSize : 0;
    final double chartWidth = (totalWidth -
            leftReservedSize -
            rightReservedSize -
            (hasYAxisTitles ? yAxisTextPadding : 0))
        .clamp(0.0, double.infinity)
        .toDouble();

    final xMax = (chartWidth - effectiveMarkerSize).clamp(0.0, double.infinity);
    final yMax = (chartHeight - effectiveMarkerSize).clamp(0.0, double.infinity);

    final xPrimary = _calculateAxis(
      value: xValue,
      threshold: xThreshold,
      imageSize: chartWidth,
      maxClamp: xMax,
    );
    final yPrimary = _calculateAxis(
      value: yValue,
      threshold: yThreshold,
      imageSize: chartHeight,
      maxClamp: yMax,
    );
    final xSecondary = _calculateAxis(
      value: secondaryXValue ?? 0,
      threshold: xThreshold,
      imageSize: chartWidth,
      maxClamp: xMax,
    );
    final ySecondary = _calculateAxis(
      value: secondaryYValue ?? 0,
      threshold: yThreshold,
      imageSize: chartHeight,
      maxClamp: yMax,
    );

    return Padding(
      padding: padding,
      child: SizedBox(
        width: totalWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if ((title ?? '').isNotEmpty)
              Text(
                title!,
                style:
                    titleTextStyle ?? Theme.of(context).textTheme.titleMedium,
              ),
            if ((subtitle ?? '').isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  subtitle!,
                  style: subtitleTextStyle ?? Theme.of(context).textTheme.bodySmall,
                ),
              ),
            if ((title ?? '').isNotEmpty || (subtitle ?? '').isNotEmpty)
              const SizedBox(height: 8),
            if (xAxisPosition == FCPQuadrantXAxisPosition.top)
              Padding(
                padding: EdgeInsets.only(
                  left: yOnLeft ? leftReservedSize : 0.0,
                  right: yOnLeft ? 0.0 : rightReservedSize,
                ),
                child: _buildXAxisTitlesRow(context, chartWidth),
              ),
            SizedBox(
              width: totalWidth,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (yOnLeft) _buildYAxisTitlesColumn(context, chartHeight),
                  SizedBox(
                    width: chartWidth,
                    height: chartHeight,
                    child: DecoratedBox(
                      decoration: backgroundDecoration ?? const BoxDecoration(),
                      child: ClipRRect(
                        borderRadius:
                            backgroundDecoration?.borderRadius is BorderRadius
                            ? backgroundDecoration!.borderRadius as BorderRadius
                            : BorderRadius.zero,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            if (showRegionColors)
                              _buildRegionColors(context, chartWidth, chartHeight),
                          Positioned.fill(
                            child: IgnorePointer(
                              child: CustomPaint(
                                painter: _QuadrantBorderPainter(
                                  internalStrokeWidth: quadrantInternalStrokeWidth,
                                  externalStrokeWidth: quadrantExternalStrokeWidth,
                                  internalColor: quadrantInternalStrokeColor,
                                  externalColor: quadrantExternalStrokeColor,
                                ),
                              ),
                            ),
                          ),
                          if (showCenterCross)
                            Positioned.fill(
                              child: IgnorePointer(
                                child: CustomPaint(
                                  painter: _CenterCrossPainter(
                                    color: centerCrossColor,
                                    strokeWidth: centerCrossStrokeWidth,
                                  ),
                                ),
                              ),
                            ),
                            if (showRegionLabels) _buildRegionLabels(context),
                            Positioned(
                              left: xPrimary,
                              bottom: yPrimary,
                              width: effectiveMarkerSize,
                              height: effectiveMarkerSize,
                              child: IgnorePointer(
                                child: _buildMarker(
                                  context,
                                  FCPQuadrantMarkerType.circle,
                                ),
                              ),
                            ),
                            if (showSecondaryMarker)
                              Positioned(
                                left: xSecondary,
                                bottom: ySecondary,
                                width: effectiveMarkerSize,
                                height: effectiveMarkerSize,
                                child: IgnorePointer(
                                  child: _buildMarker(
                                    context,
                                    FCPQuadrantMarkerType.square,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (!yOnLeft) _buildYAxisTitlesColumn(context, chartHeight),
                ],
              ),
            ),
            if (xAxisPosition == FCPQuadrantXAxisPosition.bottom)
              Padding(
                padding: EdgeInsets.only(
                  left: yOnLeft ? leftReservedSize : 0.0,
                  right: yOnLeft ? 0.0 : rightReservedSize,
                ),
                child: _buildXAxisTitlesRow(context, chartWidth),
              ),
          ],
        ),
      ),
    );
  }
}

class _CenterCrossPainter extends CustomPainter {
  _CenterCrossPainter({required this.color, required this.strokeWidth});

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    final midX = size.width / 2;
    final midY = size.height / 2;
    canvas.drawLine(Offset(midX, 0), Offset(midX, size.height), paint);
    canvas.drawLine(Offset(0, midY), Offset(size.width, midY), paint);
  }

  @override
  bool shouldRepaint(covariant _CenterCrossPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
  }
}

class _QuadrantBorderPainter extends CustomPainter {
  _QuadrantBorderPainter({
    required this.internalStrokeWidth,
    required this.externalStrokeWidth,
    required this.internalColor,
    required this.externalColor,
  });

  final double internalStrokeWidth;
  final double externalStrokeWidth;
  final Color internalColor;
  final Color externalColor;

  @override
  void paint(Canvas canvas, Size size) {
    final outer = Paint()
      ..color = externalColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = externalStrokeWidth;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), outer);

    final inner = Paint()
      ..color = internalColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = internalStrokeWidth;
    final midX = size.width / 2;
    final midY = size.height / 2;
    canvas.drawLine(Offset(midX, 0), Offset(midX, size.height), inner);
    canvas.drawLine(Offset(0, midY), Offset(size.width, midY), inner);
  }

  @override
  bool shouldRepaint(covariant _QuadrantBorderPainter oldDelegate) {
    return oldDelegate.internalStrokeWidth != internalStrokeWidth ||
        oldDelegate.externalStrokeWidth != externalStrokeWidth ||
        oldDelegate.internalColor != internalColor ||
        oldDelegate.externalColor != externalColor;
  }
}
