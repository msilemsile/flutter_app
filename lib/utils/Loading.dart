import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/common/LoadingPage.dart';

///加载
class Loading {
  Map<NavigatorState, TransparentRoute> loadingRouterMap = HashMap();

  static void show({@required BuildContext context, bool canClose = false}) {
    NavigatorState navigatorState = Navigator.of(context);
    bool containsKey = _instance.loadingRouterMap.containsKey(navigatorState);
    if (!containsKey) {
      TransparentRoute loadingRouter = TransparentRoute(builder: (context) {
        return LoadingPage(
          canTouchClose: canClose,
          pageCloseListener: canClose
              ? () {
                  hide(context);
                }
              : null,
        );
      });
      navigatorState.push(loadingRouter);
      _instance.loadingRouterMap.addAll({navigatorState: loadingRouter});
    }
  }

  static void hide(BuildContext context) {
    NavigatorState navigatorState = Navigator.of(context);
    bool containsKey = _instance.loadingRouterMap.containsKey(navigatorState);
    if (containsKey) {
      TransparentRoute loadingRouter =
          _instance.loadingRouterMap[navigatorState];
      navigatorState.removeRoute(loadingRouter);
      _instance.loadingRouterMap.remove(navigatorState);
    }
  }

  static Loading _instance = new Loading._internal();

  Loading._internal();

  static Loading getInstance() {
    return _instance;
  }
}

class TransparentRoute extends PageRoute<void> {
  TransparentRoute({
    @required this.builder,
    RouteSettings settings,
  })  : assert(builder != null),
        super(settings: settings, fullscreenDialog: false);

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 350);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final result = builder(context);
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(animation),
      child: Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        child: result,
      ),
    );
  }
}
