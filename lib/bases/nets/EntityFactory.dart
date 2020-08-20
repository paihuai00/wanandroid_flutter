import 'package:flutter/material.dart';
import 'package:wanandroid/beans/BannerBean.dart';

///Author: cuishuxiang
///Date: 2020/8/19 13:40
///Description:

class EntityFactory {

  static T generateObj<T>(json) {
    if (json == null)
      return null;

    //可以在这里加入任何需要并且可以转换的类型，例如下面
    if (T.toString() == "BannerBean") {
      return BannerBean.fromJson(json) as T;
    } else {
      return json as T;
    }
  }
}
