import 'package:flutter/material.dart';
import 'package:wanandroid/bases/mvp/IModel.dart';
import 'package:wanandroid/bases/mvp/IPresenter.dart';
import 'package:wanandroid/bases/mvp/IView.dart';
import 'package:wanandroid/bases/nets/DioUtils.dart';
import 'package:wanandroid/beans/BannerBean.dart';
import 'package:wanandroid/models/HomeModel.dart';

///Author: cuishuxiang
///Date: 2020/8/19 17:04
///Description:

class HomPresenter extends IPresenter<HomeView, HomeModel> {
  @override
  IModel createModel() {
    return HomeModel();
  }

  void getBannerData() {
    model.getBannerData((code, data, msg) => {
          if (view != null) {view.onBannerDataCallBack(code==200, data, msg)}
        });
  }
}

abstract class HomeView extends IView {
  void onBannerDataCallBack(bool isSuccess, List<BannerBean> bannerList, String msg);
}
