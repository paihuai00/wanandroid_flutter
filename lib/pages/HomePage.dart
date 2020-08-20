import 'package:flutter/material.dart';
import 'package:wanandroid/bases/nets/HttpMethod.dart';
import 'package:wanandroid/beans/BannerBean.dart';
import 'package:wanandroid/constants/Constant.dart';
import 'package:wanandroid/constants/UrlConstants.dart';
import 'package:wanandroid/bases/mvp/BaseMvpViewPage.dart';
import 'package:wanandroid/bases/mvp/IPresenter.dart';
import 'package:wanandroid/presenters/HomPresenter.dart';

///Author: cuishuxiang
///Date: 2020/8/18 13:25
///Description: 首页

class HomePage extends BaseMvpViewPage {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends BaseViewState<HomePage, HomPresenter> implements HomeView{
  var center = Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text('标题'),
      Text('子 - 标题'),
    ],
  );

  var right = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text('06.05'),
      Icon(
        Icons.visibility_off,
        size: 18,
        color: Colors.grey,
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          getWrap(),
          Expanded(
            child: center,
          ),
          right
        ],
      ),
    );
  }

  Widget getLeft() {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset(Constant.Image_Assets + 'ic_home_select.png',
            fit: BoxFit.cover),
      ),
      width: 50.0,
      height: 50.0,
    );
  }

  Widget getWrap() {
    return Stack(
      alignment: Alignment(1.2, -1.2),
      children: <Widget>[
        getLeft(),
        ClipOval(
          child: Container(
            width: 10,
            height: 10,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  @override
  createPresenter() {
    return HomPresenter();
  }

  @override
  initView() {
//    AlertDialog alertDialog=AlertDialog(
//      content: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
//      ),
//    );
//    showDialog(context: context,child: alertDialog);
    presenter.getBannerData();

  }


  @override
  void onBannerDataCallBack(bool isSuccess, List<BannerBean> bannerList, String msg) {
    //数据回调
  }
}
