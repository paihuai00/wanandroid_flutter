import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

///Author: cuishuxiang
///Date: 2020/8/19 15:28
///Description: M 层

abstract class IModel {
  //主要用于释放 m 层的资源
  void dispose();
}
