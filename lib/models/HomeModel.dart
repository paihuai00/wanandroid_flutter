import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/src/cancel_token.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wanandroid/bases/mvp/IModel.dart';
import 'package:wanandroid/bases/nets/DioUtils.dart';
import 'package:wanandroid/bases/nets/HttpMethod.dart';
import 'package:wanandroid/bases/utils/ToastUtils.dart';
import 'package:wanandroid/bases/utils/log_util.dart';
import 'package:wanandroid/bases/utils/permission_util.dart';
import 'package:wanandroid/beans/BannerBean.dart';
import 'package:wanandroid/constants/UrlConstants.dart';
import 'package:wanandroid/main.dart';

///Author: cuishuxiang
///Date: 2020/8/19 16:12
///Description:

class HomeModel extends IModel {

  //请求banner
  void getBannerData(NetListCallBack netListCallBack) {

    DioUtils.getInstance().requestList<BannerBean>(
        HttpMethod.GET,
        UrlConstants.BannerUrl,
        cancelToken: cancelToken,
        callBack: netListCallBack);
  }

  @override
  CancelToken createCancelToken() {
    return CancelToken();
  }
}
