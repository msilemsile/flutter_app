import 'package:flutter/material.dart';

///背景颜色Selector
class ColorSelector extends StatefulWidget {
  final Color pressColor;
  final Color normalColor;
  final Function onPress;
  final Widget child;

  ColorSelector(
      {Key key,
      @required this.normalColor,
      @required this.pressColor,
      @required this.child,
      this.onPress})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ColorSelectorState();
  }
}

class _ColorSelectorState extends State<ColorSelector> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: _isPressed ? widget.pressColor : widget.normalColor),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: widget.child,
        onTapDown: (downDetails) {
          setState(() {
            _isPressed = true;
          });
        },
        onTapUp: (upDetails) {
          setState(() {
            _isPressed = false;
          });
        },
        onTapCancel: () {
          setState(() {
            _isPressed = false;
          });
        },
        onTap: widget.onPress,
      ),
    );
  }
}

typedef CheckImageCallback = void Function(bool isChecked);

///图片选中Selector
class CheckImageSelector extends StatefulWidget {
  final String checkedImage;
  final String unCheckImage;
  final CheckImageCallback callback;
  final double width;
  final double height;

  CheckImageSelector(
      {Key key,
      @required this.checkedImage,
      @required this.unCheckImage,
      this.width,
      this.height,
      this.callback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CheckImageSelectorState();
  }
}

class _CheckImageSelectorState extends State<CheckImageSelector> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Image(
        image: _isChecked
            ? AssetImage(widget.checkedImage)
            : AssetImage(widget.unCheckImage),
        width: widget.width,
        height: widget.height,
      ),
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
          if (widget.callback != null) {
            widget.callback(_isChecked);
          }
        });
      },
    );
  }
}

///DecorationSelector [DecorationRes]
class DecorationSelector extends StatefulWidget {
  final Decoration pressDecoration;
  final Decoration normalDecoration;
  final Function onPress;
  final Widget child;

  DecorationSelector(
      {Key key,
      @required this.normalDecoration,
      @required this.pressDecoration,
      @required this.child,
      this.onPress})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DecorationSelectorState();
  }
}

class _DecorationSelectorState extends State<DecorationSelector> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: _isPressed ? widget.pressDecoration : widget.normalDecoration,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: widget.child,
        onTapDown: (downDetails) {
          setState(() {
            _isPressed = true;
          });
        },
        onTapUp: (upDetails) {
          setState(() {
            _isPressed = false;
          });
        },
        onTapCancel: () {
          setState(() {
            _isPressed = false;
          });
        },
        onTap: widget.onPress,
      ),
    );
  }
}
