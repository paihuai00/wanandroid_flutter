import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:wanandroid/bases/nets/HttpMethod.dart';
import 'package:wanandroid/bases/utils/DialogUtils.dart';
import 'package:wanandroid/bases/utils/ToastUtils.dart';
import 'package:wanandroid/bases/utils/log_util.dart';
import 'package:wanandroid/beans/BannerBean.dart';
import 'package:wanandroid/constants/Constant.dart';
import 'package:wanandroid/constants/UrlConstants.dart';
import 'package:wanandroid/bases/mvp/BaseMvpViewPage.dart';
import 'package:wanandroid/bases/mvp/IPresenter.dart';
import 'package:wanandroid/presenters/HomPresenter.dart';
import 'dart:ui';

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
  ///空、错误 页面 点击事件
  EmptyErrorClick emptyErrorClick = () {
    LogUtils.print('点击kongyem');
  };

  @override
  createPresenter() {
    return HomPresenter(context);
  }

  @override
  initView() {
    showError(click: emptyErrorClick);
//    showLoading();
//    presenter.getBannerData();
  }

  @override
  void onBannerDataCallBack(
      bool isSuccess, List<BannerBean> bannerList, String msg) {
    //数据回调

    if (isSuccess) {
      showContent();
      ToastUtils.show(context, '数据加载成功');
    }
  }

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Row(
      children: <Widget>[
        RaisedButton(
          child: Text('点我'),
          onPressed: () {
            showProgress();
          },
        )
      ],
    );
  }
}
