import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/CommonPage.dart';
import 'package:flutter_app/common/TransparentPage.dart';
import 'package:flutter_app/common/WillPopPage.dart';

///AppDialog
class AppDialog {
  TransparentRoute _dialogRoute;
  ModalRoute _currentPageRoute;

  ///展示dialog
  void show(BuildContext context, Widget dialogWidget,
      [bool canTouchOpaqueClose = true]) {
    _dialogRoute = TransparentRoute(builder: (_) {
      return WillPopPage(
        canTouchOpaqueClose: canTouchOpaqueClose,
        pageWillPopCallback: canTouchOpaqueClose
            ? (_) {
                dismiss(context);
              }
            : null,
        child: _DialogInnerPage(
          child: dialogWidget,
        ),
      );
    });
    _currentPageRoute = ModalRoute.of(context);
    Navigator.of(context).push(_dialogRoute);
  }

  ///隐藏dialog
  void dismiss(BuildContext context) {
    if (_dialogRoute == null || _currentPageRoute == null) {
      return;
    }
    ModalRoute currentPageRoute = ModalRoute.of(context);
    if (_currentPageRoute == currentPageRoute) {
      Navigator.of(context).removeRoute(_dialogRoute);
    }
  }
}

///dialog Page页面展示居中位置
class _DialogInnerPage extends StatelessWidget {
  final Widget child;

  _DialogInnerPage({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
        color: Colors.transparent,
        child: Center(
          child: child,
        ));
  }
}
