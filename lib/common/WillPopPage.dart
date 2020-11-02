import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CommonPage.dart';

typedef OnPageWillPopCallback = void Function(BuildContext context);

///监听返回WillPopPage(canTouchOpaqueClose是否点击透明区域关闭)
class WillPopPage extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final bool canTouchOpaqueClose;
  final OnPageWillPopCallback pageWillPopCallback;

  WillPopPage(
      {Key key,
      @required this.child,
      this.backgroundColor = Colors.transparent,
      this.canTouchOpaqueClose = false,
      this.pageWillPopCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (pageWillPopCallback != null) {
          pageWillPopCallback(context);
        }
        return Future.value(false);
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: BasePage(color: backgroundColor, child: child),
        onTap: () {
          if (canTouchOpaqueClose && pageWillPopCallback != null) {
            pageWillPopCallback(context);
          }
        },
      ),
    );
  }
}
