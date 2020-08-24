import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:wanandroid/bases/nets/HttpMethod.dart';
import 'package:wanandroid/bases/utils/DialogUtils.dart';
import 'package:wanandroid/beans/BannerBean.dart';
import 'package:wanandroid/constants/Constant.dart';
import 'package:wanandroid/constants/UrlConstants.dart';
import 'package:wanandroid/bases/mvp/BaseMvpViewPage.dart';
import 'package:wanandroid/bases/mvp/IPresenter.dart';
import 'package:wanandroid/presenters/HomPresenter.dart';

///Author: cuishuxiang
///Date: 2020/8/18 13:25
///Description: 首页

class HomePage extends BaseMvpViewPage {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends BaseViewState<HomePage, HomPresenter>
    implements HomeView {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Row(
        children: <Widget>[
          RaisedButton(
            child: Text('点我'),
            onPressed: () {

              showProgress();
            },
          )
        ],
      ),
    );
  }

  @override
  createPresenter() {
    return HomPresenter(context);
  }

  @override
  initView() {
    presenter.getBannerData();
  }

  @override
  void onBannerDataCallBack(
      bool isSuccess, List<BannerBean> bannerList, String msg) {
    //数据回调
  }

  @override
  BuildContext getContext() {
    return context;
  }
}
