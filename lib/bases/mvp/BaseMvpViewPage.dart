import 'package:flutter/material.dart';
import 'package:wanandroid/bases/mvp/IPresenter.dart';
import 'package:wanandroid/bases/mvp/IView.dart';

///Author: cuishuxiang
///Date: 2020/8/19 16:03
///Description:

abstract class BaseMvpViewPage extends StatefulWidget {}


abstract class BaseViewState<V extends BaseMvpViewPage,P extends IPresenter> extends State<V> implements IView{
  P _presenter;

  @override
  void initState() {
    super.initState();
    _presenter=createPresenter();
    if(_presenter!=null) _presenter.attach(this);

    initView();
  }

  initView();

  P createPresenter();

  P get presenter =>_presenter;


  @override
  void dispose() {
    super.dispose();
    if(_presenter!=null){
      _presenter.detach();
      _presenter=null;
    }
  }

}
