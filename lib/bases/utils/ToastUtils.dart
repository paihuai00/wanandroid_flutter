import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

///Author: cuishuxiang
///Date: 2020/8/18 13:57
///Description: 

class ToastUtils {

  static void show(BuildContext context,String str) {
    Toast.show(str, context,duration: Toast.LENGTH_SHORT);
  }
}