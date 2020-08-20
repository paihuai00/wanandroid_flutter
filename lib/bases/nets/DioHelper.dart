import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/bases/utils/log_util.dart';

///Author: cuishuxiang
///Date: 2020/8/19 16:31
///Description:

class DioHelper {
  static BaseOptions buildBaseOptions({
    String baseUrl,
      int connectTimeout,
      int receiveTimeout,
      int sendTimeout,
      ResponseType responseType}) {
    return BaseOptions(responseType: responseType ?? ResponseType.json);
  }

  //根据返回的response ，得到错误信息
  static String getErrorMsg(DioError error) {
    switch (error.type) {
      case DioErrorType.CANCEL:
        return "请求取消";
      case DioErrorType.CONNECT_TIMEOUT:
        return "连接超时";
      case DioErrorType.SEND_TIMEOUT:
        return "请求超时";
      case DioErrorType.RECEIVE_TIMEOUT:
        return "响应超时";
      case DioErrorType.RESPONSE:
        try {
          int code = error.response.statusCode;
          String errorMsg = error.response.statusMessage;

          LogUtils.print("DioUtils ---> getErrorMsg "
              "\n\n code = ${code}"
              "\n\n errorMsg = ${errorMsg}");

          switch (code) {
            case 500:
              return "服务器内部错误";
            case 404:
              return "无法连接服务器";
            default:
              return 'return "未知错误"';
          }
        } on Exception catch (e) {
          return "未知错误";
        }
        return 'return "未知错误"';

      default:
        return 'return "未知错误"';
    }
  }
}
