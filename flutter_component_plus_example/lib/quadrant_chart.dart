import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class QuadrantChartDemo extends StatefulWidget {
  const QuadrantChartDemo({super.key});

  @override
  State<QuadrantChartDemo> createState() => _QuadrantChartDemoState();
}

class _QuadrantChartDemoState extends State<QuadrantChartDemo> {
  double _ctInd = 4;
  double _jhInd = 3;
  double _ctIndRight = 6;
  double _jhIndRight = 5;
  double _xThreshold = 5;
  double _yThreshold = 5;
  bool _showSquare = true;

  /// `0` = auto (three ticks: 0, mid, max). Otherwise step size on each axis.
  double _xTitleInterval = 0;
  double _yTitleInterval = 0;

  double _clampToSlider(double value, double max) => value.clamp(0.0, max);

  TextStyle _demoAxisTitleStyle(BuildContext context) {
    return Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Colors.grey.shade300,
          fontWeight: FontWeight.w700,
        ) ??
        const TextStyle(fontWeight: FontWeight.w700);
  }

  /// User-provided titles; scales with [meta.max] (i.e. `threshold * 2`).
  FCPTitlesData _demoTitlesData(BuildContext context) {
    final style = _demoAxisTitleStyle(context);
    return FCPTitlesData(
      show: true,
      leftTitles: FCPAxisTitles(
        sideTitles: FCPSideTitles(
          showTitles: true,
          reservedSize: 56,
          interval: _yTitleInterval <= 0 ? null : _yTitleInterval,
          getTitlesWidget: (value, meta) {
            final topInches = 24.0;
            final inches = meta.max <= 0 ? 0.0 : (value / meta.max) * topInches;
            return Text('${inches.toStringAsFixed(0)}"', style: style);
          },
        ),
      ),
      bottomTitles: FCPAxisTitles(
        sideTitles: FCPSideTitles(
          showTitles: true,
          interval: _xTitleInterval <= 0 ? null : _xTitleInterval,
          getTitlesWidget: (value, meta) {
            final topSeconds = 0.4;
            final seconds = meta.max <= 0
                ? 0.0
                : (value / meta.max) * topSeconds;
            return Text('${seconds.toStringAsFixed(2)}s', style: style);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final xMax = _xThreshold * 2 + 2;
    final yMax = _yThreshold * 2 + 2;

    return Scaffold(
      appBar: AppBar(title: const Text('Quadrant chart')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('Show square marker'),
            value: _showSquare,
            onChanged: (v) => setState(() => _showSquare = v),
          ),
          FCPQuadrantChart(
            xValue: _ctInd,
            yValue: _jhInd,
            secondaryXValue: _ctIndRight,
            secondaryYValue: _jhIndRight,
            xThreshold: _xThreshold,
            yThreshold: _yThreshold,
            showSecondaryMarker: _showSquare,
            title: 'Review',
            subtitle: '10/5 RSI Result',
            titleTextStyle: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            subtitleTextStyle: Theme.of(context).textTheme.titleMedium
                ?.copyWith(
                  color: Colors.grey.shade300,
                  fontWeight: FontWeight.w600,
                ),
            width: MediaQuery.sizeOf(context).width * 0.8,
            height: MediaQuery.sizeOf(context).height * 0.4,
            markerSize: 4,
            pointSize: 18,
            titlesData: _demoTitlesData(context),
            xAxisTextPadding: 12,
            yAxisTextPadding: 12,
            xAxisPosition: FCPQuadrantXAxisPosition.top,
            yAxisPosition: FCPQuadrantYAxisPosition.left,
            showRegionColors: true,
            regionOverlayOpacity: 0.9,
            topLeftColor: const Color(0xFF0A249C),
            topRightColor: const Color(0xFFFF0000),
            bottomLeftColor: const Color(0xFF43BE4B),
            bottomRightColor: const Color(0xFFF1F000),
            showRegionLabels: true,
            topLeftRegionLabel: 'Low RSI',
            topRightRegionLabel: 'Strength',
            bottomLeftRegionLabel: 'Elastic',
            bottomRightRegionLabel: 'High RSI',
            regionLabelPadding: const EdgeInsets.all(6),
            showCenterCross: false,
            centerCrossColor: Colors.red,
            centerCrossStrokeWidth: 1,
            backgroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.all(5),
            quadrantInternalStrokeWidth: 1,
            quadrantExternalStrokeWidth: 2,
            quadrantInternalStrokeColor: Colors.black54,
            quadrantExternalStrokeColor: Colors.white30,
            circleMarkerBuilder: (ctx, markerType) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade500, width: 2),
              ),
            ),
            squareMarkerBuilder: (ctx, markerType) => Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                border: Border.all(color: Colors.grey.shade500, width: 2),
                borderRadius: BorderRadius.circular(2),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
            regionLabelTextStyle: Theme.of(context).textTheme.bodySmall
                ?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Circle: ctInd = ${_clampToSlider(_ctInd, xMax).toStringAsFixed(1)}',
          ),
          Slider(
            value: _clampToSlider(_ctInd, xMax),
            max: xMax,
            onChanged: (v) => setState(() => _ctInd = v),
          ),
          Text(
            'Circle: jhInd = ${_clampToSlider(_jhInd, yMax).toStringAsFixed(1)}',
          ),
          Slider(
            value: _clampToSlider(_jhInd, yMax),
            max: yMax,
            onChanged: (v) => setState(() => _jhInd = v),
          ),
          if (_showSquare) ...[
            Text(
              'Square: ctIndRight = ${_clampToSlider(_ctIndRight, xMax).toStringAsFixed(1)}',
            ),
            Slider(
              value: _clampToSlider(_ctIndRight, xMax),
              max: xMax,
              onChanged: (v) => setState(() => _ctIndRight = v),
            ),
            Text(
              'Square: jhIndRight = ${_clampToSlider(_jhIndRight, yMax).toStringAsFixed(1)}',
            ),
            Slider(
              value: _clampToSlider(_jhIndRight, yMax),
              max: yMax,
              onChanged: (v) => setState(() => _jhIndRight = v),
            ),
          ],
          Text('xThreshold = ${_xThreshold.toStringAsFixed(1)}'),
          Slider(
            value: _xThreshold,
            min: 0.5,
            max: 20,
            onChanged: (v) => setState(() {
              _xThreshold = v;
              final updatedXMax = _xThreshold * 2 + 2;
              _ctInd = _clampToSlider(_ctInd, updatedXMax);
              _ctIndRight = _clampToSlider(_ctIndRight, updatedXMax);
            }),
          ),
          Text('yThreshold = ${_yThreshold.toStringAsFixed(1)}'),
          Slider(
            value: _yThreshold,
            min: 0.5,
            max: 20,
            onChanged: (v) => setState(() {
              _yThreshold = v;
              final updatedYMax = _yThreshold * 2 + 2;
              _jhInd = _clampToSlider(_jhInd, updatedYMax);
              _jhIndRight = _clampToSlider(_jhIndRight, updatedYMax);
            }),
          ),
          Text(
            'X title interval: ${_xTitleInterval <= 0 ? "auto" : _xTitleInterval.toStringAsFixed(1)}',
          ),
          Slider(
            value: _xTitleInterval,
            min: 0,
            max: 20,
            divisions: 40,
            label: _xTitleInterval <= 0
                ? 'auto'
                : _xTitleInterval.toStringAsFixed(1),
            onChanged: (v) => setState(() => _xTitleInterval = v),
          ),
          Text(
            'Y title interval: ${_yTitleInterval <= 0 ? "auto" : _yTitleInterval.toStringAsFixed(1)}',
          ),
          Slider(
            value: _yTitleInterval,
            min: 0,
            max: 20,
            divisions: 40,
            label: _yTitleInterval <= 0
                ? 'auto'
                : _yTitleInterval.toStringAsFixed(1),
            onChanged: (v) => setState(() => _yTitleInterval = v),
          ),
        ],
      ),
    );
  }
}
