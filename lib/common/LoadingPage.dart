import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/theme/ThemeProvider.dart';
import 'package:flutter_app/theme/res/ColorsKey.dart';

import 'CommonPage.dart';

///居中loading页
class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      color: Colors.transparent,
      child: Center(
        child: LoadingWidget(),
      ),
    );
  }
}

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
        valueColor: new AlwaysStoppedAnimation<Color>(ThemeProvider.getColor(context, ColorsKey.loading_color)),
      ),
    );
  }
}
