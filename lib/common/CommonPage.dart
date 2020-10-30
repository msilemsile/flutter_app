import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/theme/ThemeProvider.dart';

///自定义基础界面 适配暗色模式状态栏
class CommonPage extends StatelessWidget {
  final Widget child;
  final Color color;

  CommonPage({Key key, this.child, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///状态栏样式
    SystemUiOverlayStyle uiOverlayStyle;
    var themeModel = ThemeProvider.watch(context).getThemeType();
    if (themeModel == ThemeProvider.type_light) {
      uiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      );
    } else {
      uiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      );
    }
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: uiOverlayStyle,
        child: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyText2,
            child: Padding(
              padding: EdgeInsets.only(top: statusBarHeight),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: color ?? Colors.white,
                ),
                child: child,
              ),
            )));
  }
}
