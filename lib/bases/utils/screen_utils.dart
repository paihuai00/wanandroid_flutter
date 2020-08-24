import 'package:flutter/material.dart';
import 'dart:ui';

///Author: cuishuxiang
///Date: 2020/8/24 13:37
///Description:  屏幕尺寸工具类

class ScreenUtils {

  static Size _size;

  ///获取屏幕宽度，px
  static double getScreenWidth() {
    if(_size==null)_size=window.physicalSize;

    return _size.width;
  }

  static double getScreenHeight() {
    if(_size==null)_size=window.physicalSize;
    return _size.height;
  }
}