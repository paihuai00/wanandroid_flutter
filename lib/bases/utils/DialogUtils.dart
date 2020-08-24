import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

class DialogUtil {
  static final double _width = 100;
  static final double _height = 100;

  static YYDialog getLoadingDialog() {
    return YYDialog().build()
      ..width = _width
      ..height = _height
      ..barrierColor = Colors.black.withOpacity(0.5)
      ..borderRadius = 4.0
      ..circularProgress(padding: EdgeInsets.all(10))
      ..text(text: '加载中....', alignment: Alignment.center);
  }
}
