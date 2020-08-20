import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/bases/utils/log_util.dart';

///Author: cuishuxiang
///Date: 2020/8/20 14:16
///Description:

///日志拦截器，在 debug 状态下，会添加到 DioUtils 中
class LoggerInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    ///打印请求信息：

    LogUtils.print(' LogInterceptor - onRequest ->'
        '\n\n 请求 ： url = ${options.baseUrl + options.path} + Method =  ${options.method.toString()} '
        '\n\n 请求头：${options.headers.toString()} '
        '\n\n 请求参数： ${options.queryParameters.toString()} '
        '\n\n ');
  }

  @override
  Future onError(DioError error) async {
    LogUtils.print(' LogInterceptor - onError ->'
        '\n\n 请求异常 ： url = ${error.request.baseUrl + error.request.path} '
        '\n\n error == ${error.toString()}');
  }

  @override
  Future onResponse(Response response) async {
    ///打印请求信息：
    LogUtils.print(' LogInterceptor - onResponse->'
        '\n\n 请求 ： url = ${response.request.baseUrl + response.request.path} '
        '\n\n 请求头：${response.request.headers.toString()} '
        '\n\n 请求参数： ${response.request.queryParameters?.toString()} '
        '\n\n 返回data = ${response.toString()} \n\n');
  }
}


///请求拦截器
class RequestInterceptor extends Interceptor{

  @override
  Future onRequest(RequestOptions options) async{
    String path=options.path;
    if(path.startsWith('http')) {
      //path 为地址全路径
      options.baseUrl='';
    }

    return super.onRequest(options);
  }

  @override
  Future onError(DioError err) async{
    return super.onError(err);
  }

  @override
  Future onResponse(Response response) async{
    return super.onResponse(response);
  }
}