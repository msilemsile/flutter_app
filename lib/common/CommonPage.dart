import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/theme/ThemeProvider.dart';

class CommonPage extends BasePage {
  final Widget child;
  final Color color;

  CommonPage({Key key, @required this.child, this.color})
      : super(key: key, child: child, color: color);

  @override
  double getTitlePadding(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }
}

///自定义基础界面 适配暗色模式状态栏
class BasePage extends StatelessWidget {
  final Widget child;
  final Color color;

  BasePage({Key key, @required this.child, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget realChild = DecoratedBox(
      decoration: BoxDecoration(
        color: color ?? Colors.white,
      ),
      child: child,
    );
    double titlePadding = getTitlePadding(context);
    if (titlePadding > 0) {
      realChild = Padding(
        padding: EdgeInsets.only(top: titlePadding),
        child: realChild,
      );
    }
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: ThemeProvider.getSystemUiStyle(context),
        child: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyText2, child: realChild));
  }

  double getTitlePadding(BuildContext context) {
    return 0;
  }
}
