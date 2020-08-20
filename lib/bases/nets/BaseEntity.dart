import 'package:flutter/material.dart';
import 'package:wanandroid/bases/nets/EntityFactory.dart';
import 'package:wanandroid/bases/nets/Entity.dart';

///Author: cuishuxiang
///Date: 2020/8/19 13:48
///Description:

class BaseEntity<T> extends Entity{
  int code;
  String message;
  T data;

  BaseEntity({this.code, this.message, this.data});

  factory BaseEntity.fromJson(json) {
    int code = 0;
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

    return BaseEntity(
        code: code,
        message: msg,
        data: EntityFactory.generateObj<T>(json['data']));
  }
}
