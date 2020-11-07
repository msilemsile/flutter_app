import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/common/LoadingPage.dart';
import 'package:flutter_app/common/TransparentPage.dart';
import 'package:flutter_app/common/WillPopCallbackPage.dart';

///加载页面（A+B -> A+{loading}+B）
class Loading {
  Map<ModalRoute, TransparentRoute> loadingRouterMap = HashMap();

  ///展示loading页
  static void show(BuildContext context,
      [bool canTouchClose = false, bool canBackClose = true]) {
    ModalRoute currentPageRoute = ModalRoute.of(context);
    if (!currentPageRoute.isCurrent) {
      return;
    }
    bool containsKey = _instance.loadingRouterMap.containsKey(currentPageRoute);
    if (!containsKey) {
      TransparentRoute loadingRouter = TransparentRoute(builder: (_) {
        return WillPopCallbackPage(
          touchPopCallback: canTouchClose
              ? (_) {
                  hide(context);
                }
              : null,
          backPopCallback: canBackClose
              ? (_) {
                  hide(context);
                }
              : null,
          child: Center(
            child: LoadingWidget(),
          ),
        );
      });
      Navigator.of(context).push(loadingRouter);
      _instance.loadingRouterMap.addAll({currentPageRoute: loadingRouter});
    }
  }

  ///隐藏loading页
  static void hide(BuildContext context) {
    ModalRoute currentPageRoute = ModalRoute.of(context);
    bool containsKey = _instance.loadingRouterMap.containsKey(currentPageRoute);
    if (containsKey) {
      TransparentRoute loadingRouter =
          _instance.loadingRouterMap[currentPageRoute];
      Navigator.of(context).removeRoute(loadingRouter);
      _instance.loadingRouterMap.remove(currentPageRoute);
    }
  }

  static Loading _instance = new Loading._internal();

  Loading._internal();

  static Loading getInstance() {
    return _instance;
  }
}
