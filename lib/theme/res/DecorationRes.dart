import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///创建装饰器
abstract class DecorationRes {
  ///矩形rect(带圆角)
  static Decoration createRectangle(
      {Color solidColor = Colors.transparent,
      Color stokeColor = Colors.transparent,
      double stokeWidth = 0,
      double cornerTopLeft = 0,
      double cornerTopRight = 0,
      double cornerBottomLeft = 0,
      double cornerBottomRight = 0,
      double cornerAll = 0}) {
    //corner
    BorderRadius borderRadius;
    if (cornerAll > 0) {
      borderRadius = BorderRadius.circular(cornerAll);
    } else {
      borderRadius = BorderRadius.only(
          topLeft: Radius.circular(cornerTopLeft),
          topRight: Radius.circular(cornerTopRight),
          bottomLeft: Radius.circular(cornerBottomLeft),
          bottomRight: Radius.circular(cornerBottomRight));
    }
    //stoke
    Border border;
    if (stokeWidth > 0) {
      border = Border.all(
        color: stokeColor,
        width: stokeWidth,
      );
    }
    return BoxDecoration(
      color: solidColor,
      borderRadius: borderRadius,
      border: border,
    );
  }

  ///圆形
  static Decoration createCircle(
      {Color solidColor = Colors.transparent,
      Color stokeColor = Colors.transparent,
      double stokeWidth = 0}) {
    //stoke
    Border border;
    if (stokeWidth > 0) {
      border = Border.all(
        color: stokeColor,
        width: stokeWidth,
      );
    }
    return BoxDecoration(
        color: solidColor, border: border, shape: BoxShape.circle);
  }
}
