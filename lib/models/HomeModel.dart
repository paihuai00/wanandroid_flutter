import 'package:dio/src/cancel_token.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/bases/mvp/IModel.dart';
import 'package:wanandroid/bases/nets/DioUtils.dart';
import 'package:wanandroid/bases/nets/HttpMethod.dart';
import 'package:wanandroid/beans/BannerBean.dart';
import 'package:wanandroid/constants/UrlConstants.dart';

///Author: cuishuxiang
///Date: 2020/8/19 16:12
///Description:

class HomeModel implements IModel {
  CancelToken _cancelToken = CancelToken();

  void getBannerData(NetListCallBack netListCallBack) {
    DioUtils.getInstance().requestList<List<BannerBean>>(
        HttpMethod.GET,
        UrlConstants.BannerUrl,
        cancelToken: _cancelToken,
        callBack: netListCallBack);

  }

  @override
  void dispose() {
    if (_cancelToken != null) _cancelToken.cancel();
    _cancelToken = null;
  }
}
