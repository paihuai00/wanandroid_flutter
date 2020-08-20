import 'package:flutter/material.dart';

///Author: cuishuxiang
///Date: 2020/8/19 13:37
///Description:   http 方法 枚举

enum HttpMethod {
  GET,
  POST
}

extension ExtensionMethod on HttpMethod {
  String get value => ['get', 'post'][index];
}