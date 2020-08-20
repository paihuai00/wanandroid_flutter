
import 'package:flutter/material.dart';
import 'package:wanandroid/bases/nets/EntityFactory.dart';
import 'package:wanandroid/bases/nets/Entity.dart';

///Author: cuishuxiang
///Date: 2020/8/19 13:52
///Description:  data 类型为 List

class BaseListEntity<T> extends Entity{
  int code;
  String message;
  List<T> data;

  BaseListEntity({this.code, this.message, this.data});

  factory BaseListEntity.fromJson(json) {
    List<T> mData = List();
    if (json['data'] != null) {
      //遍历data并转换为我们传进来的类型
      (json['data'] as List).forEach((itemValue) {
        //Banner
        mData.add(EntityFactory.generateObj<T>(itemValue));
      });
    }

    int code = -1;
    if (json['code'] != null) {
      code = json['code'];
    } else if (json['errorCode'] != null) {
      code = json['errorCode'];
    }

    String msg = '';
    if (json['message'] != null) {
      msg = json['message'];
    } else if (json['errorMsg'] != null) {
      msg = json['errorMsg'];
    }

    return BaseListEntity(
      code: code,
      message: msg,
      data: mData,
    );
  }
}
