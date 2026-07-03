import 'package:flutter/material.dart';
import 'package:example/widgets/constants/colors.dart';
import 'package:example/widgets/quadrant_chart_widget.dart';
import 'package:get/get.dart';

/// Standalone preview of [QuadrantChartWidget] with sample axis labels and markers.
///
/// Run: `flutter run --dart-define=QUADRANT_DEMO=true`
class QuadrantChartDemoPage extends StatefulWidget {
  const QuadrantChartDemoPage({super.key});

  @override
  State<QuadrantChartDemoPage> createState() => _QuadrantChartDemoPageState();
}

class _QuadrantChartDemoPageState extends State<QuadrantChartDemoPage> {
  final GlobalKey _chartImageKey = GlobalKey();
  final RxDouble _imageWidth = 100.0.obs;
  final RxDouble _imageHeight = 100.0.obs;

  static const String _assessmentType = 'SL 5-Hop RSI';
  static const double _circleSquareSize = 25;

  // Demo axis (matches typical DB-driven labels)
  final String yTop = '60cm';
  final String yMid = '30cm';
  final String yBottom = '0cm';
  final String xStart = '0s';
  final String xMid = '0.35s';
  final String xEnd = '0.7s';

  // Thresholds implied by labels above
  static const double _xAxisSec = 0.7;
  static const double _yThreshold = 30.0;

  double _xAxisCircle = 0;
  double _yAxisCircle = 0;
  double _xAxisSquare = 0;
  double _yAxisSquare = 0;

  double get _xTh => _xAxisSec / 2;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _measureAndPlaceDemo());
  }

  void _measureAndPlaceDemo() {
    final ctx = _chartImageKey.currentContext;
    if (ctx == null) return;
    final sz = ctx.size;
    if (sz == null || sz.width == 0 || sz.height == 0) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _measureAndPlaceDemo(),
      );
      return;
    }

    _imageWidth.value = sz.width;
    _imageHeight.value = sz.height;

    // Demo metrics: left leg (circle) — upper-right quadrant; right (square) — lower-left
    const ctLeft = 0.28;
    const jhLeft = 48.0;
    const ctRight = 0.52;
    const jhRight = 18.0;

    setState(() {
      _xAxisCircle = _axisX(ctLeft, sz.width);
      _yAxisCircle = _axisY(jhLeft, sz.height);
      _xAxisSquare = _axisX(ctRight, sz.width);
      _yAxisSquare = _axisY(jhRight, sz.height);
    });
  }

  double _axisX(double ct, double w) {
    if (ct > _xTh * 2) {
      return w - _circleSquareSize;
    }
    final x = w * (ct / (_xTh * 2));
    if (x.isInfinite || x.isNaN) return 0;
    return x;
  }

  double _axisY(double jh, double h) {
    if (jh > _yThreshold * 2) {
      return h - _circleSquareSize;
    }
    final y = h * (jh / (_yThreshold * 2));
    if (y.isInfinite || y.isNaN) return 0;
    return y;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBackLight,
      appBar: AppBar(
        title: const Text('Quadrant chart (demo)'),
        backgroundColor: kColorBackDark,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sample inputs: SL 5-Hop RSI, left CT/JH = 0.28s / 48cm, '
                'right CT/JH = 0.52s / 18cm; axes 0–0.7s × 0–60cm.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              QuadrantChartWidget(
                imageKey: _chartImageKey,
                assessmentType: _assessmentType,
                yTop: yTop,
                yMid: yMid,
                yBottom: yBottom,
                xStart: xStart,
                xMid: xMid,
                xEnd: xEnd,
                imageWidth: _imageWidth,
                imageHeight: _imageHeight,
                xAxisCircle: _xAxisCircle,
                yAxisCircle: _yAxisCircle,
                xAxisSquare: _xAxisSquare,
                yAxisSquare: _yAxisSquare,
                showSl5HopLegendRows: true,
                circleSquareSize: _circleSquareSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
