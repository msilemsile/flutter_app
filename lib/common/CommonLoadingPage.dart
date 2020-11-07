import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CommonPage.dart';
import 'LoadingPage.dart';

///通用展示loading界面
class CommonLoadingPage extends StatefulWidget {
  final Widget child;
  final Color color;
  final bool showLoading;
  final LoadingController loadingController;

  CommonLoadingPage(
      {Key key,
      @required this.child,
      this.color,
      @required this.loadingController,
      this.showLoading = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    _CommonLoadingState commonLoadingState = _CommonLoadingState(showLoading);
    loadingController._loading = commonLoadingState;
    return commonLoadingState;
  }
}

class _CommonLoadingState extends State<CommonLoadingPage> with LoadingMixin {
  bool hasShowLoading;

  _CommonLoadingState(this.hasShowLoading);

  @override
  Widget build(BuildContext context) {
    return hasShowLoading
        ? BasePage(
            child: Stack(
              children: [
                widget.child,
                Align(
                  alignment: Alignment.center,
                  child: LoadingWidget(),
                )
              ],
            ),
            color: widget.color,
          )
        : BasePage(child: widget.child, color: widget.color);
  }

  @override
  dismissLoading() {
    setState(() {
      hasShowLoading = false;
    });
  }

  @override
  showLoading() {
    setState(() {
      hasShowLoading = true;
    });
  }
}

///loading控制器
class LoadingController {
  LoadingMixin _loading;

  showLoading() {
    if (_loading != null) {
      _loading.showLoading();
    }
  }

  dismissLoading() {
    if (_loading != null) {
      _loading.dismissLoading();
    }
  }
}

///loading mixin
mixin LoadingMixin {
  showLoading();

  dismissLoading();
}
