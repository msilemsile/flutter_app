import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CommonPage.dart';

///loading组件
class LoadingWidget extends StatelessWidget {
  final double width;
  final double height;

  LoadingWidget({Key key, this.width = 50, this.height = 50}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CircularProgressIndicator(
        strokeWidth: 4.0,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    );
  }
}

typedef OnLoadingPageCloseListener = void Function();

///loading页面
class LoadingPage extends StatefulWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final bool canTouchClose;
  final OnLoadingPageCloseListener pageCloseListener;

  LoadingPage(
      {Key key,
      this.width = 50,
      this.height = 50,
      this.backgroundColor = Colors.transparent,
      this.canTouchClose = false,
      this.pageCloseListener})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoadingState();
  }
}

class _LoadingState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (widget.canTouchClose && widget.pageCloseListener != null) {
          widget.pageCloseListener();
        }
        return Future.value(false);
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: CommonPage(
            color: widget.backgroundColor,
            child: Center(
              child: LoadingWidget(
                width: widget.width,
                height: widget.height,
              ),
            )),
        onTap: () {
          if (widget.canTouchClose && widget.pageCloseListener != null) {
            widget.pageCloseListener();
          }
        },
      ),
    );
  }
}
