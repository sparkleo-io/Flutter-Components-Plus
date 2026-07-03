import 'package:flutter/material.dart';

double kPaddingValue = 20;
double kPaddingValueHalf = 10;
EdgeInsets kEdgePadding = EdgeInsets.all(kPaddingValue);
EdgeInsets kEdgePaddingHalf = EdgeInsets.all(kPaddingValueHalf);
Container kEdgePaddContainer = Container(
  padding: kEdgePadding,
);
Container kEdgePaddHalfContainer = Container(
  padding: kEdgePaddingHalf,
);
Container kEdgePaddContainerRight = Container(
  padding: EdgeInsets.only(right: kPaddingValue),
);
Container kEdgePaddContainerLeft = Container(
  padding: EdgeInsets.only(left: kPaddingValue),
);
Container kEdgePaddContainerTop = Container(
  padding: EdgeInsets.only(top: kPaddingValue),
);
Container kEdgePaddContainerTopHalf = Container(
  padding: EdgeInsets.only(top: kPaddingValueHalf),
);

class EdgesPadding extends StatelessWidget {
  const EdgesPadding({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kEdgePadding,
      child: child,
    );
  }
}

class EdgesPaddingHalf extends StatelessWidget {
  const EdgesPaddingHalf({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kEdgePaddingHalf,
      child: child,
    );
  }
}
