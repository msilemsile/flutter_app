import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'DecorationRes.dart';

///矩形装饰器
class RectangleShape extends StatelessWidget {
  final Widget child;
  final Color solidColor;
  final Color stokeColor;
  final double stokeWidth;
  final double cornerTopLeft;
  final double cornerTopRight;
  final double cornerBottomLeft;
  final double cornerBottomRight;
  final double cornerAll;
  final double width;
  final double height;

  const RectangleShape(
      {Key key,
      this.solidColor = Colors.transparent,
      this.stokeColor = Colors.transparent,
      this.stokeWidth = 0,
      this.cornerTopLeft = 0,
      this.cornerTopRight = 0,
      this.cornerBottomLeft = 0,
      this.cornerBottomRight = 0,
      this.cornerAll = 0,
      this.child,
      this.width = 0,
      this.height = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (width > 0 && height > 0) {
      content = SizedBox(
        width: width,
        height: height,
        child: child,
      );
    } else {
      content = child;
    }
    return DecoratedBox(
      decoration: cornerAll > 0
          ? DecorationRes.createRectangle(
              solidColor: solidColor,
              stokeColor: stokeColor,
              stokeWidth: stokeWidth,
              cornerAll: cornerAll,
            )
          : DecorationRes.createRectangle(
              solidColor: solidColor,
              stokeColor: stokeColor,
              stokeWidth: stokeWidth,
              cornerTopLeft: cornerTopLeft,
              cornerTopRight: cornerTopRight,
              cornerBottomLeft: cornerBottomLeft,
              cornerBottomRight: cornerBottomRight),
      child: content,
    );
  }
}

///圆形装饰器
class CircleShape extends StatelessWidget {
  final Widget child;
  final Color solidColor;
  final Color stokeColor;
  final double stokeWidth;
  final double radius;

  const CircleShape(
      {Key key,
      this.solidColor = Colors.transparent,
      this.stokeColor = Colors.transparent,
      this.stokeWidth = 0,
      this.child,
      this.radius = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (radius > 0) {
      double size = radius * 2;
      content = SizedBox(
        width: size,
        height: size,
        child: child,
      );
    } else {
      content = child;
    }
    return DecoratedBox(
      decoration: DecorationRes.createCircle(
          solidColor: solidColor,
          stokeColor: stokeColor,
          stokeWidth: stokeWidth),
      child: content,
    );
  }
}
