import 'package:flutter/material.dart';
import 'package:flutter_component_plus_example/widgets/constants/colors.dart';
import 'package:flutter_component_plus_example/widgets/constants/paddings.dart';
import 'package:flutter_component_plus_example/widgets/constants/texts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// Quadrant image, axis labels, and circle / optional square (SL 5-Hop) markers.
class QuadrantChartWidget extends StatelessWidget {
  const QuadrantChartWidget({
    super.key,
    required this.imageKey,
    required this.assessmentType,
    required this.yTop,
    required this.yMid,
    required this.yBottom,
    required this.xStart,
    required this.xMid,
    required this.xEnd,
    required this.imageWidth,
    required this.imageHeight,
    required this.xAxisCircle,
    required this.yAxisCircle,
    required this.xAxisSquare,
    required this.yAxisSquare,
    this.showSl5HopLegendRows = false,
    this.yAxisLabelsPadding = EdgeInsets.zero,
    this.circleSquareSize = 25,
  });

  final GlobalKey imageKey;
  final String assessmentType;
  final String yTop;
  final String yMid;
  final String yBottom;
  final String xStart;
  final String xMid;
  final String xEnd;
  final RxDouble imageWidth;
  final RxDouble imageHeight;
  final double xAxisCircle;
  final double yAxisCircle;
  final double xAxisSquare;
  final double yAxisSquare;
  final bool showSl5HopLegendRows;
  final EdgeInsets yAxisLabelsPadding;
  final double circleSquareSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showSl5HopLegendRows && assessmentType == "SL 5-Hop RSI")
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '24" ',
                    style: kTextStyleTitleBox.copyWith(
                      fontSize: 20,
                      color: kColorBackDark,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: kPaddingValueHalf),
                    child: Text(
                      assessmentType == "SL 5-Hop RSI"
                          ? 'Left Leg: Circle'
                          : '',
                      style: kTextStyleBottomBtn.copyWith(
                        color: kColorDivider,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '24" ',
                    style: kTextStyleTitleBox.copyWith(
                      fontSize: 20,
                      color: kColorBackDark,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: kPaddingValueHalf),
                    child: Text(
                      assessmentType == "SL 5-Hop RSI"
                          ? 'Right Leg: Square'
                          : '',
                      style: kTextStyleBottomBtn.copyWith(
                        color: kColorDivider,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  _imageQuad(),
                  Container(
                    padding: yAxisLabelsPadding,
                    height: imageHeight.value,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                yTop,
                                textAlign: TextAlign.end,
                                style: kTextStyleTitleBox.copyWith(
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 50,
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                yMid,
                                textAlign: TextAlign.end,
                                style: kTextStyleTitleBox.copyWith(
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 50,
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                yBottom,
                                textAlign: TextAlign.end,
                                style: kTextStyleTitleBox.copyWith(
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  _labels(),
                ],
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: kPaddingValue),
          width: imageWidth.value,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    xStart,
                    style: kTextStyleTitleBox.copyWith(fontSize: 11),
                  ),
                  Text(xMid, style: kTextStyleTitleBox.copyWith(fontSize: 11)),
                  Text(xEnd, style: kTextStyleTitleBox.copyWith(fontSize: 11)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _imageQuad() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(
                  kPaddingValue * 2,
                  0,
                  kPaddingValue,
                  0,
                ),
                child: Image.asset('assets/quadrant/quadrant.png', key: imageKey),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _labels() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.fromLTRB(kPaddingValue * 2, 0, kPaddingValue, 0),
        child: SizedBox(
          height: imageHeight.value,
          width: imageWidth.value,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(
                          () => imageHeight.value == 0
                              ? const SizedBox()
                              : assessmentType == "SL 5-Hop RSI" &&
                                    imageHeight.value != 0
                              ? Container(
                                  padding: EdgeInsets.only(
                                    left: xAxisSquare,
                                    bottom: yAxisSquare,
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/quadrant/square.svg',
                                    width: circleSquareSize,
                                    height: circleSquareSize,
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(
                          () => imageHeight.value != 0
                              ? Container(
                                  padding: EdgeInsets.only(
                                    left: xAxisCircle,
                                    bottom: yAxisCircle,
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/quadrant/circle.svg',
                                    width: circleSquareSize,
                                    height: circleSquareSize,
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
