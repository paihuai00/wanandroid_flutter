import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid/IndexPage.dart';
import 'package:wanandroid/bases/nets/DioUtils.dart';
import 'package:wanandroid/bases/utils/log_util.dart';
import 'package:wanandroid/constants/UrlConstants.dart';

void main() {
  runApp(MyApp());


}

class MyApp extends StatelessWidget {
  MyApp(){
    initDio(baseUrl: UrlConstants.BaseUrl,sendTimeOut: 11);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _init(context);



    return MaterialApp(
      title: 'WanAndroid ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: IndexPage(),
    );
  }

  ///初始化
  void _init(BuildContext context) {
//    ScreenUtil.init(context);



  }
}
