import 'package:flutter/material.dart';
import '../../core/constants.dart';

/// Widget extensions for common layout operations
extension WidgetExtensions on Widget {
  /// Add padding to all sides
  Widget padAll(double padding) {
    return Padding(padding: EdgeInsets.all(padding), child: this);
  }

  /// Add horizontal padding
  Widget padHorizontal(double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: this,
    );
  }

  /// Add vertical padding
  Widget padVertical(double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: this,
    );
  }

  /// Add padding with specific sides
  Widget pad({double? left, double? top, double? right, double? bottom}) {
    return Padding(
      padding: EdgeInsets.only(
        left: left ?? 0,
        top: top ?? 0,
        right: right ?? 0,
        bottom: bottom ?? 0,
      ),
      child: this,
    );
  }

  /// Center the widget
  Widget center() {
    return Center(child: this);
  }

  /// Add margin to all sides
  Widget marginAll(double margin) {
    return Container(margin: EdgeInsets.all(margin), child: this);
  }

  /// Add horizontal margin
  Widget marginHorizontal(double margin) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin),
      child: this,
    );
  }

  /// Add vertical margin
  Widget marginVertical(double margin) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: margin),
      child: this,
    );
  }

  /// Add margin with specific sides
  Widget margin({double? left, double? top, double? right, double? bottom}) {
    return Container(
      margin: EdgeInsets.only(
        left: left ?? 0,
        top: top ?? 0,
        right: right ?? 0,
        bottom: bottom ?? 0,
      ),
      child: this,
    );
  }

  /// Add border radius
  Widget borderRadius(double radius) {
    return ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);
  }

  /// Add shadow
  Widget shadow({
    Color? color,
    double? blurRadius,
    double? spreadRadius,
    Offset? offset,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: color ?? Colors.black.withValues(alpha: 0.1),
            blurRadius: blurRadius ?? 4,
            spreadRadius: spreadRadius ?? 0,
            offset: offset ?? const Offset(0, 2),
          ),
        ],
      ),
      child: this,
    );
  }

  /// Add background color
  Widget backgroundColor(Color color) {
    return Container(color: color, child: this);
  }

  /// Add width constraint
  Widget width(double width) {
    return SizedBox(width: width, child: this);
  }

  /// Add height constraint
  Widget height(double height) {
    return SizedBox(height: height, child: this);
  }

  /// Add size constraint
  Widget size(double width, double height) {
    return SizedBox(width: width, height: height, child: this);
  }

  /// Add square size constraint
  Widget square(double size) {
    return SizedBox(width: size, height: size, child: this);
  }

  /// Add expanded widget
  Widget expanded({int? flex}) {
    return Expanded(flex: flex ?? 1, child: this);
  }

  /// Add flexible widget
  Widget flexible({int? flex}) {
    return Flexible(flex: flex ?? 1, child: this);
  }

  /// Add opacity
  Widget opacity(double opacity) {
    return Opacity(opacity: opacity, child: this);
  }

  /// Add scale transform
  Widget scale(double scale) {
    return Transform.scale(scale: scale, child: this);
  }

  /// Add rotation transform
  Widget rotate(double angle) {
    return Transform.rotate(angle: angle, child: this);
  }

  /// Add translate transform
  Widget translate(double dx, double dy) {
    return Transform.translate(offset: Offset(dx, dy), child: this);
  }

  /// Add gesture detector
  Widget onTap(VoidCallback? onTap) {
    return GestureDetector(onTap: onTap, child: this);
  }

  /// Add ink well
  Widget inkWell({VoidCallback? onTap}) {
    return InkWell(onTap: onTap, child: this);
  }

  /// Add hero widget
  Widget hero(Object tag) {
    return Hero(tag: tag, child: this);
  }

  /// Add animated container
  Widget animatedContainer({
    Duration? duration,
    Curve? curve,
    double? width,
    double? height,
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Decoration? decoration,
  }) {
    return AnimatedContainer(
      duration: duration ?? FCPConstants.durationNormal,
      curve: curve ?? Curves.easeInOut,
      width: width,
      height: height,
      color: color,
      padding: padding,
      margin: margin,
      decoration: decoration,
      child: this,
    );
  }

  /// Add animated opacity
  Widget animatedOpacity({Duration? duration, Curve? curve, double? opacity}) {
    return AnimatedOpacity(
      duration: duration ?? FCPConstants.durationNormal,
      curve: curve ?? Curves.easeInOut,
      opacity: opacity ?? 1.0,
      child: this,
    );
  }

  /// Add animated size
  Widget animatedSize({
    Duration? duration,
    Curve? curve,
    AlignmentGeometry? alignment,
  }) {
    return AnimatedSize(
      duration: duration ?? FCPConstants.durationNormal,
      curve: curve ?? Curves.easeInOut,
      alignment: alignment ?? Alignment.topCenter,
      child: this,
    );
  }
}
