import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/theme/res/ShapeRes.dart';

///Toast
class Toast {
  static const int LENGTH_SHORT = 0;
  static const int LENGTH_LONG = 1;

  ///展示toast
  static void show(
      {@required BuildContext context,
      @required String text,
      int length = LENGTH_SHORT,
      int offsetY = -1}) {
    if (context == null || text == null) return;
    OverlayEntry toastOverLayEntry = OverlayEntry(builder: (context) {
      return _ToastWidget(
        text: text,
        offsetY: offsetY,
      );
    });
    Overlay.of(context).insert(toastOverLayEntry);
    startToastDismissTask(toastOverLayEntry, length);
  }

  ///执行toast消失任务
  static void startToastDismissTask(
      OverlayEntry toastOverLayEntry, int length) {
    Duration duration;
    if (length > 0) {
      duration = Duration(seconds: 4);
    } else {
      duration = Duration(seconds: 2);
    }
    Timer(duration, () {
      toastOverLayEntry.remove();
    });
  }
}

class _ToastWidget extends StatelessWidget {
  final String text;
  final int offsetY;
  final double offsetYPercent = 0.8;

  _ToastWidget({@required this.text, this.offsetY = -1});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Stack(
        children: [
          Positioned(
            width: width,
            top: offsetY >= 0
                ? offsetY
                : ((height - statusBarHeight) * offsetYPercent),
            child: Center(
              child: RectangleShape(
                cornerAll: 3,
                solidColor: Color.fromRGBO(0, 0, 0, 0.6),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodyText2,
                    child: Text(
                      text,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
