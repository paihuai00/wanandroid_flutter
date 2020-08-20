import 'package:flutter/material.dart';
import 'package:wanandroid/bases/mvp/IView.dart';

///Author: cuishuxiang
///Date: 2020/8/19 15:31
///Description:  p 层

abstract class IBasePresenter<V extends IView> {

  void attach(V view);

  void detach();
}