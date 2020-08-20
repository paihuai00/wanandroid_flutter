import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/bases/nets/BaseEntity.dart';
import 'package:wanandroid/bases/nets/BaseListEntity.dart';
import 'package:wanandroid/bases/nets/DioHelper.dart';
import 'package:wanandroid/bases/nets/HttpMethod.dart';
import 'package:wanandroid/bases/utils/log_util.dart';
import 'package:wanandroid/constants/Constant.dart';
import 'package:wanandroid/constants/UrlConstants.dart';
import 'package:wanandroid/bases/nets/Entity.dart';

///Author: cuishuxiang
///Date: 2020/8/18 15:26
///Description:
///参考：- https://book.flutterchina.club/chapter10/dio.html
///      - https://juejin.im/post/6844903893172748295

// 默认dio配置
int _connectTimeout = 10000;
int _receiveTimeout = 5000;
int _sendTimeout = 5000;
String _baseUrl;

List<Interceptor> _interceptors = [];
bool _isNeedCookie = false;

///初始化属性方法，在类中导入 该类，即可调用
void initDio(
    {connectTimeout,
    int receiveTimeOut,
    int sendTimeOut,
    String baseUrl,
    List<Interceptor> inteceptors,
    bool isNeedCookie}) {
  _connectTimeout = connectTimeout ?? _connectTimeout;
  _receiveTimeout = receiveTimeOut ?? _receiveTimeout;
  _sendTimeout = sendTimeOut ?? _sendTimeout;
  _baseUrl = baseUrl ?? baseUrl;
  _interceptors = inteceptors ?? _interceptors;
  _isNeedCookie = isNeedCookie ?? false;
}

//回调函数
typedef NetCallBack<T> = Function(int code, T data, String msg);
typedef NetListCallBack<T> = Function(int code, List<T> data, String msg);

class DioUtils {
  static DioUtils _dioUtils; //单例对象

  static Dio _dio;

  //内部构造方法
  DioUtils._internal() {
    BaseOptions _baseOptions = BaseOptions(
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
        sendTimeout: _sendTimeout,
        responseType: ResponseType.json,
        baseUrl: _baseUrl);
    //json 数据解析
    LogUtils.print('DioUtils - _baseUrl = $_baseUrl');

    _dio = Dio(_baseOptions);

    //添加拦截器
    if (_interceptors != null && _interceptors.length != 0) {
      _interceptors.forEach((element) {
        _dio.interceptors.add(element);
      });
    }

    //cookie , 添加 cookie
    if(_isNeedCookie) {
      CookieJar cookieJar=CookieJar();
      _dio.interceptors.add(CookieManager(cookieJar));
    }

  }

  /// 工厂构造方法，这里使用命名构造函数方式进行声明
  factory DioUtils.getInstance() => _getInstance();

  static DioUtils _getInstance() {
    if (_dioUtils == null) _dioUtils = DioUtils._internal();
    return _dioUtils;
  }

  //同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
  Future request<T>(HttpMethod httpMethod, String urlPath,
      {Map<String, dynamic> paramMap,
      NetCallBack<T> callBack,
      CancelToken cancelToken}) async {
    // CancelToken - 用于取消请求
    try {
      Response response = await _dio.request(urlPath,
          queryParameters: paramMap,
          cancelToken: cancelToken,
          options: Options(method: httpMethod.value));
      if (response != null) {
        var json = response.data;

        ///打印请求信息：
        LogUtils.print(' DioUtils - ->'
            '\n\n 请求 ： url = ${response.request.baseUrl + urlPath} '
            '\n\n 请求头：${_dio.options.headers.toString()} '
            '\n\n 请求参数： ${paramMap?.toString()} '
            '\n\n 返回data = ${json.toString()} \n\n');

        BaseEntity entity = BaseEntity<T>.fromJson(json);
        if (entity.code == 0) {
          if (callBack != null) callBack(200, entity.data, "");
        } else {
          //调用失败
          if (callBack != null) callBack(-1, null, "未知错误");
        }
      }
    } on DioError catch (error) {
      LogUtils.print(' DioUtils - ->'
          '\n\n 请求异常 ： url = ${urlPath.toString()} '
          '\n\n error == ${error.toString()}');
      if (callBack != null)
        callBack(error.response.statusCode, null, DioHelper.getErrorMsg(error));
    }
  }

  //同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
  Future requestList<T>(HttpMethod httpMethod, String urlPath,
      {Map<String, dynamic> paramMap,
      NetListCallBack<T> callBack,
      CancelToken cancelToken}) async {
    try {
      Response response = await _dio.request(urlPath,
          queryParameters: paramMap,
          cancelToken: cancelToken,
          options: Options(method: httpMethod.value, responseType: ResponseType.json));

      if (response != null) {
        var json = response.data;

        ///打印请求信息：
        LogUtils.print(' DioUtils - ->'
            '\n\n 请求 ： url = ${response.request.baseUrl + urlPath} '
            '\n\n 请求头：${_dio.options.headers.toString()} '
            '\n\n 请求参数： ${paramMap?.toString()} '
            '\n\n 返回data = ${json.toString()} \n\n');

        BaseListEntity entity = BaseListEntity<T>.fromJson(json);
        if (entity.code == 0) {
          if (callBack != null) callBack(200, entity.data, "");
        } else {
          //调用失败
          if (callBack != null) callBack(-1, null, "未知错误");
        }
      } else {
        ///打印请求信息：
        LogUtils.print(' DioUtils - ->'
            '\n\n 请求 ： url = ${response.request.baseUrl + urlPath} '
            '\n\n response == null');
      }
    } on DioError catch (error) {
      LogUtils.print(' DioUtils - ->'
          '\n\n 请求异常 ： url = ${error.request.baseUrl + urlPath.toString()} '
          '\n\n error == ${error.toString()}');

      if (callBack != null) {
        int code = -1;
        if (error != null && error.response != null)
          code = error.response.statusCode;
        callBack(code, null, DioHelper.getErrorMsg(error));
      }
    }
  }
}
