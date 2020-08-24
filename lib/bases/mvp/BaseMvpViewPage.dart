import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:wanandroid/bases/mvp/IPresenter.dart';
import 'package:wanandroid/bases/mvp/IView.dart';
import 'package:wanandroid/bases/utils/DialogUtils.dart';

///Author: cuishuxiang
///Date: 2020/8/19 16:03
///Description:

abstract class BaseMvpViewPage extends StatefulWidget {}


abstract class BaseViewState<V extends BaseMvpViewPage,P extends IPresenter> extends State<V> implements IView{
  P _presenter;

  YYDialog _yyDialog;

  @override
  void initState() {
    super.initState();
    _presenter=createPresenter();
    if(_presenter!=null) _presenter.attach(this);

    ///注意，需要在base里面初始化，不然页面无法直接调用
    YYDialog.init(context);

    initView();
  }

  initView();

  P createPresenter();

  P get presenter =>_presenter;


  ///显示弹框，初始化[YYDialog.init(ctx)]
  void showProgress(){
    if(_yyDialog==null) _yyDialog=DialogUtil.getLoadingDialog();

    if(!_yyDialog.isShowing)_yyDialog.show();
  }


  ///隐藏弹框，初始化[YYDialog.init(ctx)]
  void hindProgress() {
    if(_yyDialog==null) return;

    if(_yyDialog.isShowing)_yyDialog.dismiss();
  }


  @override
  void dispose() {
    super.dispose();
    if(_presenter!=null){
      _presenter.detach();
      _presenter=null;
    }
  }

}
