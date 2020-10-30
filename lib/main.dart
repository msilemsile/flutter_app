import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/theme/res/ColorsKey.dart';
import 'package:flutter_app/theme/res/ShapeRes.dart';
import 'package:flutter_app/utils/Loading.dart';
import 'package:flutter_app/utils/Toast.dart';

import 'common/CommonPage.dart';
import 'theme/ThemeProvider.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(new MaterialApp(
    builder: (context, widget) {
      return ThemeProvider(
          initThemeType: ThemeProvider.type_light, child: widget);
    },
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonPage(
      child: Container(
        alignment: Alignment.center,
        color: ThemeProvider.getColor(context, ColorsKey.bg_ffffff),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButton(context, "更改主题", () {
              changeTheme(context);
            }),
            buildButton(context, "展示toast", () {
              showToast(context);
            }),
            buildButton(context, "展示loading(5s消失)", () {
              showLoading(context);
            }),
            buildButton(context, "展示可点击消失loading", () {
              showCancelLoading(context);
            }),
            buildButton(context, "展示popupWindow", () {
              showPopupWindow(context);
            }),
          ],
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, String name, Function click) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: RectangleShape(
          solidColor: ThemeProvider.getColor(context, ColorsKey.bg_000000),
          stokeColor: Colors.yellow,
          stokeWidth: 1,
          cornerAll: 5,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Text(
              name,
              style: TextStyle(
                  color: ThemeProvider.getColor(context, ColorsKey.bg_ffffff)),
            ),
          ),
        ),
        onTap: click,
      ),
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
    Toast.show(context: context, text: "custom toast");
  }

  ///展示loading(5秒消失,不可点击消失)
  void showLoading(BuildContext context) {
    Loading.show(context: context);
    Timer(Duration(seconds: 5), () {
      Loading.hide(context);
    });
  }

  ///展示loading(可点击消失)
  void showCancelLoading(BuildContext context) {
    Loading.show(context: context, canClose: true);
  }

  ///展示popupWindow
  void showPopupWindow(BuildContext context) {

  }
}
