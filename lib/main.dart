import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_common/flutter_common.dart';
void main() {
  FlutterError.onError = (FlutterErrorDetails errorDetail) {
    ///捕获错误
    Log.message(errorDetail);
  };
  runZoned(() {
    ///start with MaterialApp
    runApp(MaterialApp(
      navigatorKey: AppManager.getInstance().globalNaviStateKey(),
      builder: (BuildContext context, Widget? widget) {
        return ThemeProvider(
            initThemeType: ThemeProvider.typeLight, child: widget!);
      },
      home: Builder(
        builder: (BuildContext context) {
          return BaseLoadingPage(
            textColor: ThemeProvider.getColor(context, ColorsKey.bgLightMode),
            child: buildChild(),
          );
        },
      ),
    ));

    ///start with WidgetsApp
    // runApp(WidgetsApp(
    //   navigatorKey: AppManager.getInstance().globalNaviStateKey(),
    //   builder: (BuildContext context, Widget? widget) {
    //     return ThemeProvider(
    //         initThemeType: ThemeProvider.typeLight, child: widget!);
    //   },
    //   pageRouteBuilder: <T>(RouteSettings settings, WidgetBuilder builder) =>
    //       PageRouteBuilder(
    //         settings: settings,
    //         pageBuilder: (BuildContext context, Animation<double> animation,
    //             Animation<double> secondaryAnimation) =>
    //             builder(context),
    //       ),
    //   color: Colors.transparent,
    //   home: Builder(
    //     builder: (BuildContext context) {
    //       return BaseLoadingPage(
    //         textColor: ThemeProvider.getColor(context, ColorsKey.bgLightMode),
    //         child: buildChild(),
    //       );
    //     },
    //   ),
    // ));
  }, zoneSpecification: ZoneSpecification(handleUncaughtError: (Zone self,
      ZoneDelegate parent, Zone zone, Object error, StackTrace stackTrace) {
    ///捕获未知错误(异步等)
    Log.message('$error $stackTrace');
  }));
}

Widget buildChild() {
  return Builder(builder: (BuildContext context) {
    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomPaint(
            painter: ProgressPainter(),
            size: const Size(120, 120),
          ),
          buildButton(context, "更改主题", () {
            changeTheme(context);
          }),
          Builder(
            builder: (BuildContext popContext) {
              return buildButton(context, "展示popupWindow", () {
                showPopupWindow(popContext);
              });
            },
          ),
          buildButton(context, "展示toast", () {
            showToast(context);
          }),
          buildButton(context, "展示dialog", () {
            showDialog(context);
          }),
          buildButton(context, "展示Alertdialog", () {
            showAlertDialog(context);
          }),
          buildButton(context, "展示loading[控件级别](3s消失)", () {
            showWidgetLoading(context);
          }),
          buildButton(context, "展示loading[页面级别](3s消失)", () {
            showPageLoading(context);
          }),
          buildButton(context, "展示可点击消失loading[页面级别]", () {
            showCancelPageLoading(context);
          }),
          buildButton(context, "展示全局Loading[全局级别]", () {
            showAppLoading(context);
          }),
          buildButton(context, "取消全局Loading[全局级别]", () {
            hideAppLoading();
          }),
        ],
      ),
    );
  });
}

Widget buildButton(
    BuildContext context, String name, GestureTapCallback click) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: click,
    child: RectangleShape(
      solidColor: ThemeProvider.getColor(context, ColorsKey.bgDarkMode),
      stokeColor: Colors.yellow,
      stokeWidth: 1,
      cornerAll: 5,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Text(name),
      ),
    ),
  );
}

///更改主题
void changeTheme(BuildContext context) {
  var themeType = ThemeProvider.read(context)?.getThemeType();
  if (themeType == ThemeProvider.typeLight) {
    ThemeProvider.changeTheme(context, ThemeProvider.typeDark);
  } else {
    ThemeProvider.changeTheme(context, ThemeProvider.typeLight);
  }
}

///弹出toast
void showToast(BuildContext context) {
  AppToast.show("custom toast");
}

///展示loading[控件级别](3s消失)
void showWidgetLoading(BuildContext context) {
  BaseLoadingPage.of(context)?.showLoading();
  Timer(const Duration(seconds: 3), () {
    BaseLoadingPage.of(context)?.hideLoading();
  });
}

///展示loading[页面级别](3s消失)
void showPageLoading(BuildContext context) {
  PageLoading.show(context);
  Timer(const Duration(seconds: 3), () {
    PageLoading.hide(context);
  });
}

///展示可点击消失loading[页面级别]
void showCancelPageLoading(BuildContext context) {
  PageLoading.show(context, true);
}

///展示dialog(可点击消失)
void showDialog(BuildContext context) {
  AppDialog dialog = AppDialog();
  Widget dialogWidget = GestureDetector(
    behavior: HitTestBehavior.opaque,
    child: RectangleShape(
      width: 270,
      height: 200,
      stokeColor: ThemeProvider.getColor(context, ColorsKey.bgDarkMode),
      cornerAll: 10,
      child: Center(
        child: Text(
          "show dialog",
          style: TextStyle(
              color: ThemeProvider.getColor(context, ColorsKey.bgLightMode)),
        ),
      ),
    ),
    onTap: () {
      AppToast.show("click dialog");
    },
  );
  dialog.show(context, dialogWidget);
}

///展示AlertDialog
void showAlertDialog(BuildContext context) {
  AppAlertDialog.builder()
      .setTitle("title")
      .setContent("content")
      .setCancelTxt("取消")
      .show(context);
}

///展示popupWindow(!!!context为当前点击的元素)
void showPopupWindow(BuildContext context) {
  PopupWindow popupWindow = PopupWindow();
  itemClick() {
    popupWindow.hide(context);
  }

  Widget popWidget = Column(
    children: [
      buildPopupWindowsItem(context, 1, itemClick),
      buildPopupWindowsItem(context, 2, itemClick),
      buildPopupWindowsItem(context, 3, itemClick),
    ],
  );
  popupWindow.show(context, popWidget);
}

Widget buildPopupWindowsItem(
    BuildContext context, int index, Function itemClick) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    child: RectangleShape(
      solidColor: ThemeProvider.getColor(context, ColorsKey.bgDarkMode),
      stokeWidth: 1,
      stokeColor: ThemeProvider.getColor(context, ColorsKey.bgLightMode),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        child: Text(
          "PopWindowItem$index",
          style: TextStyle(
              color: ThemeProvider.getColor(context, ColorsKey.bgLightMode)),
        ),
      ),
    ),
    onTap: () {
      AppToast.show("PopWindowItem$index");
      itemClick();
    },
  );
}

///展示app全局loading
void showAppLoading(BuildContext context) {
  AppLoading.show(true);
}

///取消app全局loading
void hideAppLoading() {
  AppLoading.hide();
}

class ProgressPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;
    double strokeWidth = 10;
    double progress = 0.7;
    Rect rect = Rect.fromLTRB(
        strokeWidth, strokeWidth, width - strokeWidth, height - strokeWidth);
    double totalArcLength = 3 / 2 * pi;
    double startArcLength = 1 / 4 * pi;
    SweepGradient sweepGradient = const SweepGradient(
      colors: [Colors.red, Colors.yellow],
    );
    Paint proPaint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..shader = sweepGradient.createShader(rect);
    Paint bgPaint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = Colors.lightBlue;
    canvas.save();
    // 计算画布中心轨迹圆半径
    double r = sqrt(pow(size.width, 2) + pow(size.height, 2));
    // 计算画布中心点初始弧度
    double startAngle = atan(size.height / size.width);
    // 计算画布初始中心点坐标
    Point p0 = Point(r * cos(startAngle), r * sin(startAngle));
    // 需要旋转的弧度
    double xAngle = pi / 2;
    // 计算旋转后的画布中心点坐标
    Point px =
        Point(r * cos(xAngle + startAngle), r * sin(xAngle + startAngle));
    // 先平移画布
    canvas.translate((p0.x - px.x) / 2, (p0.y - px.y) / 2);
    // 后旋转
    canvas.rotate(xAngle);
    canvas.drawArc(rect, startArcLength, totalArcLength, false, bgPaint);
    canvas.drawArc(
        rect, startArcLength, totalArcLength * progress, false, proPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
