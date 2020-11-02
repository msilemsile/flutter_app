import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dark/DarkColors.dart';
import 'dark/DartImages.dart';
import 'light/LightColors.dart';
import 'light/LightImages.dart';

///主题提供者
class ThemeProvider extends InheritedNotifier<ThemeModel> {
  ///亮色模式
  static const int type_light = 0;
  ///暗色模式
  static const int type_dark = 1;

  ///初始化主题模式
  final int initThemeType;

  ThemeProvider({
    Key key,
    @required this.initThemeType,
    @required Widget child,
  }) : super(
            key: key,
            notifier: initThemeType == type_light
                ? ThemeModel(type_light)
                : ThemeModel(type_dark),
            child: child);

  @override
  bool updateShouldNotify(InheritedNotifier<ThemeModel> oldWidget) {
    return oldWidget.notifier._themeType != notifier._themeType;
  }

  ///获取当前主题模式
  int getThemeType(){
    return notifier._themeType;
  }

  ///监听ThemeProvider.themeType
  static ThemeProvider watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
  }

  ///读取ThemeProvider.themeType
  static ThemeProvider read(BuildContext context) {
    return context
        .getElementForInheritedWidgetOfExactType<ThemeProvider>()
        .widget;
  }

  ///获取指定颜色(根据当前主题模式)
  static Color getColor(BuildContext context, int colorsKey) {
    ThemeProvider themeProvider = watch(context);
    if (themeProvider == null) {
      return Color(0);
    }
    return themeProvider._getColor(colorsKey);
  }

  Color _getColor(int colorsKey) {
    if (colorsKey <= 0) {
      return Color(0);
    }
    int realColor;
    if (notifier.getThemeType() == type_light) {
      realColor = LightColors.Colors[colorsKey];
    } else {
      realColor = DarkColors.Colors[colorsKey];
    }
    if (realColor == null) {
      realColor = 0;
    }
    return Color(realColor);
  }

  ///获取指定图片(根据当前主题模式)
  static AssetImage getImage(BuildContext context, int imagesKey) {
    ThemeProvider themeProvider = watch(context);
    if (themeProvider == null) {
      return null;
    }
    return themeProvider._getImage(imagesKey);
  }

  AssetImage _getImage(int imagesKey) {
    if (imagesKey <= 0) {
      return null;
    }
    String realImage;
    if (notifier.getThemeType() == type_light) {
      realImage = LightImages.Images[imagesKey];
    } else {
      realImage = DartImages.Images[imagesKey];
    }
    if (realImage == null) {
      return null;
    }
    return AssetImage(realImage);
  }

  ///不要在build时候掉用，这里只是读取旧值 然后设置新的值 之后自己会刷新相应element
  ///@themeType = {ThemeProvider.type_light | ThemeProvider.type_dark}
  static void changeTheme(BuildContext context, int themeType) {
    ThemeProvider themeProvider = read(context);
    themeProvider.notifier.setThemeType(themeType);
  }

  ///获取状态栏样式根据当前主题
  static SystemUiOverlayStyle getSystemUiStyle(BuildContext context){
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
    return uiOverlayStyle;
  }

}

///主题模式 (type_light=0 亮色 || type_light=1 暗色)
class ThemeModel with ChangeNotifier {
  ThemeModel(int themeType) {
    _themeType = themeType;
  }

  int _themeType = ThemeProvider.type_light;

  void setThemeType(int themeType) {
    if (_themeType != themeType) {
      _themeType = themeType;
      notifyListeners();
    }
  }

  int getThemeType() {
    return _themeType;
  }
}
