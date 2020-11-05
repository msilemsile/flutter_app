import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/CommonPage.dart';
import 'package:flutter_app/common/TransparentPage.dart';
import 'package:flutter_app/common/WillPopCallbackPage.dart';
import 'package:flutter_app/utils/Toast.dart';

///popup window
class PopupWindow {
  TransparentRoute _popRoute;
  ModalRoute _currentPageRoute;

  ///展示popup window
  void show(BuildContext context, Widget popWidget,
      [double offsetX = 0, double offsetY = 0]) {
    RenderBox renderBox = context.findRenderObject();
    if (renderBox != null) {
      Size size = renderBox.size;
      Offset offset = renderBox.localToGlobal(Offset.zero);
      _popRoute = TransparentRoute(builder: (_) {
        return WillPopCallbackPage(
          touchPopCallback: (_) {
            hide(context);
          },
          backPopCallback: (_) {
            hide(context);
          },
          child: _PopupInnerPage(
            popX: offset.dx + offsetX,
            popY: offset.dy + size.height + offsetY,
            child: popWidget,
          ),
        );
      });
      _currentPageRoute = ModalRoute.of(context);
      Navigator.of(context).push(_popRoute);
    } else {
      Toast.show(context, "获取弹窗位置失败!");
    }
  }

  ///隐藏popup window
  void hide(BuildContext context) {
    if (_popRoute == null || _currentPageRoute == null) {
      return;
    }
    ModalRoute currentPageRoute = ModalRoute.of(context);
    if (_currentPageRoute == currentPageRoute) {
      Navigator.of(context).removeRoute(_popRoute);
    }
  }
}

///popup window页面展示在指定位置
class _PopupInnerPage extends StatelessWidget {
  final double popX;
  final double popY;
  final Widget child;

  _PopupInnerPage(
      {Key key, @required this.popX, @required this.popY, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              left: popX,
              top: popY,
              child: child,
            )
          ],
        ));
  }
}
