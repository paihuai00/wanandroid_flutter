import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/src/cancel_token.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wanandroid/bases/mvp/IModel.dart';
import 'package:wanandroid/bases/nets/DioUtils.dart';
import 'package:wanandroid/bases/nets/HttpMethod.dart';
import 'package:wanandroid/bases/utils/log_util.dart';
import 'package:wanandroid/beans/BannerBean.dart';
import 'package:wanandroid/constants/UrlConstants.dart';

///Author: cuishuxiang
///Date: 2020/8/19 16:12
///Description:

class HomeModel extends IModel {
//  CancelToken cancelToken;

  void getBannerData(NetListCallBack netListCallBack) {
//    DioUtils.getInstance().requestList<BannerBean>(
//        HttpMethod.GET,
//        UrlConstants.BannerUrl,
//        cancelToken: cancelToken,
//        callBack: netListCallBack);

    String picUrl =
        'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1970585368,2576171845&fm=15&gp=0.jpg';
    DioUtils.getInstance().downLoad(picUrl,
        progressCallback: (int count, int total) =>
            {LogUtils.print('下载进度 count = $count  , total = $total')});
  }

  @override
  CancelToken createCancelToken() {
    return CancelToken();
  }
}
