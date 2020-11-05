import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/LoadingPage.dart';

///app全局loading
class AppLoading {
  static OverlayEntry _toastOverLayEntry;
  static bool isShowing = false;

  ///展示loading
  static void show(BuildContext context, [bool canTouchOutSide = false]) {
    if (isShowing) {
      return;
    }
    if (_toastOverLayEntry == null) {
      _toastOverLayEntry = OverlayEntry(builder: (context) {
        return Listener(
          behavior: canTouchOutSide
              ? HitTestBehavior.translucent
              : HitTestBehavior.opaque,
          child: Center(
            child: LoadingWidget(),
          ),
        );
      });
    }
    Overlay.of(context).insert(_toastOverLayEntry);
    isShowing = true;
  }

  ///取消loading
  static void hide() {
    if (_toastOverLayEntry == null) {
      return;
    }
    if (!isShowing) {
      return;
    }
    _toastOverLayEntry.remove();
    isShowing = false;
  }
}
