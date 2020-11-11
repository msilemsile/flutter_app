import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/common/CommonLoadingPage.dart';
import 'package:flutter_app/theme/res/ColorsKey.dart';
import 'package:flutter_app/theme/res/ShapeRes.dart';
import 'package:flutter_app/utils/AppDialog.dart';
import 'package:flutter_app/utils/AppLoading.dart';
import 'package:flutter_app/utils/Loading.dart';
import 'package:flutter_app/utils/PopupWindow.dart';
import 'package:flutter_app/utils/Toast.dart';

import 'theme/ThemeProvider.dart';

void main() {
  runApp(new MaterialApp(
    builder: (context, widget) {
      return ThemeProvider(
          initThemeType: ThemeProvider.type_light, child: widget);
    },
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  ///loading控制器
  final LoadingController _loadingController = LoadingController();

  @override
  Widget build(BuildContext context) {
    return CommonLoadingPage(
      loadingController: _loadingController,
      child: Container(
        alignment: Alignment.center,
        color: ThemeProvider.getColor(context, ColorsKey.bg_ffffff),
        child: buildContent(context),
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(
          painter: ProgressPainter(),
          size: Size(120, 120),
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
        buildButton(context, "展示loading[页面级别](3s消失)", () {
          showLoading(context);

          ///打开新的界面 3秒后测试上一个loading加载界面是否会消失
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return HomePage();
          }));
        }),
        buildButton(context, "展示可点击消失loading[页面级别]", () {
          showCancelLoading(context);
        }),
        buildButton(context, "展示全局Loading[全局级别]", () {
          showAppLoading(context);
        }),
        buildButton(context, "取消全局Loading[全局级别]", () {
          hideAppLoading();
        }),
        buildButton(context, "展示Loading[控件级别]", () {
          _loadingController.showLoading();
        }),
        buildButton(context, "取消Loading[控件级别]", () {
          _loadingController.dismissLoading();
        }),
      ],
    );
  }

  Widget buildButton(BuildContext context, String name, Function click) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: RectangleShape(
        solidColor: ThemeProvider.getColor(context, ColorsKey.bg_000000),
        stokeColor: Colors.yellow,
        stokeWidth: 1,
        cornerAll: 5,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Text(
            name,
            style: TextStyle(
                color: ThemeProvider.getColor(context, ColorsKey.bg_ffffff)),
          ),
        ),
      ),
      onTap: click,
    );
  }

  ///更改主题
  void changeTheme(BuildContext context) {
    var themeType = ThemeProvider.read(context).getThemeType();
    if (themeType == ThemeProvider.type_light) {
      ThemeProvider.changeTheme(context, ThemeProvider.type_dark);
    } else {
      ThemeProvider.changeTheme(context, ThemeProvider.type_light);
    }
  }

  ///弹出toast
  void showToast(BuildContext context) {
    Toast.show(context, "custom toast");
  }

  ///展示loading(5秒消失,不可点击消失)
  void showLoading(BuildContext context) {
    Loading.show(context);
    Timer(Duration(seconds: 3), () {
      Loading.hide(context);
    });
  }

  ///展示loading(可点击消失)
  void showCancelLoading(BuildContext context) {
    Loading.show(context, true);
  }

  ///展示dialog(可点击消失)
  void showDialog(BuildContext context) {
    AppDialog dialog = AppDialog();
    Widget dialogWidget = GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: RectangleShape(
        width: 270,
        height: 200,
        solidColor: ThemeProvider.getColor(context, ColorsKey.bg_000000),
        stokeColor: Colors.yellow,
        stokeWidth: 1,
        cornerAll: 5,
        child: Center(
          child: Text(
            "show dialog",
            style: TextStyle(
                color: ThemeProvider.getColor(context, ColorsKey.bg_ffffff)),
          ),
        ),
      ),
      onTap: () {
        Toast.show(context, "click dialog");
      },
    );
    dialog.show(context, dialogWidget);
  }

  ///展示popupWindow(!!!context为当前点击的元素)
  void showPopupWindow(BuildContext context) {
    PopupWindow popupWindow = PopupWindow();
    Function itemClick = () {
      popupWindow.hide(context);
    };
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
        solidColor: ThemeProvider.getColor(context, ColorsKey.bg_000000),
        stokeWidth: 1,
        stokeColor: ThemeProvider.getColor(context, ColorsKey.bg_ffffff),
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
          child: Text(
            "PopWindowItem$index",
            style: TextStyle(
                color: ThemeProvider.getColor(context, ColorsKey.bg_ffffff)),
          ),
        ),
      ),
      onTap: () {
        Toast.show(context, "PopWindowItem$index");
        itemClick();
      },
    );
  }

  ///展示app全局loading
  void showAppLoading(BuildContext context) {
    AppLoading.show(context, true);
  }

  ///取消app全局loading
  void hideAppLoading() {
    AppLoading.hide();
  }
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
    SweepGradient sweepGradient = SweepGradient(
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
