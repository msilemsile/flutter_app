import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CommonPage.dart';

typedef OnPageWillPopCallback = void Function(BuildContext context);

///监听返回WillPopPage(touchPopCallback点击透明区域回调 backPopCallback是否点击返回按键回调)
class WillPopCallbackPage extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final OnPageWillPopCallback touchPopCallback;
  final OnPageWillPopCallback backPopCallback;

  WillPopCallbackPage(
      {Key key,
      @required this.child,
      this.backgroundColor = Colors.transparent,
      this.touchPopCallback,
      this.backPopCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (backPopCallback != null) {
          backPopCallback(context);
        }
        return Future.value(false);
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: BasePage(color: backgroundColor, child: child),
        onTap: () {
          if (touchPopCallback != null) {
            touchPopCallback(context);
          }
        },
      ),
    );
  }
}
