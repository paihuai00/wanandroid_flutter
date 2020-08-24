import 'package:flutter/material.dart';
import 'package:wanandroid/bases/mvp/IBasePresenter.dart';
import 'package:wanandroid/bases/mvp/IModel.dart';
import 'package:wanandroid/bases/mvp/IView.dart';

///Author: cuishuxiang
///Date: 2020/8/19 15:33
///Description:  p 层 ,持有 m v层

//如果有一个类 A,你想让类B拥有A的API，但又不想拥有A里的实现，那么你就应该把A当做接口，类B implements 类A.
abstract class IPresenter<V extends IView, M extends IModel>
    implements IBasePresenter {
  V _view;
  M _model;
  BuildContext _context;

  IPresenter(this._context);



  @override
  void attach(IView view) {
    this._model = createModel();
    this._view = view;
  }

  //get 方法
  V get view => _view;

  M get model => _model;

  //抽象类，生成model
  IModel createModel();

  @override
  void detach() {
    if(_view!=null) _view=null;
    if(_model!=null) _model.dispose();
  }
}
