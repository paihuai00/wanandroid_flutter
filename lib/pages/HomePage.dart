import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:wanandroid/bases/nets/HttpMethod.dart';
import 'package:wanandroid/bases/utils/DialogUtils.dart';
import 'package:wanandroid/bases/utils/ToastUtils.dart';
import 'package:wanandroid/bases/utils/log_util.dart';
import 'package:wanandroid/bases/utils/screen_utils.dart';
import 'package:wanandroid/beans/BannerBean.dart';
import 'package:wanandroid/constants/Constant.dart';
import 'package:wanandroid/constants/UrlConstants.dart';
import 'package:wanandroid/bases/mvp/BaseMvpViewPage.dart';
import 'package:wanandroid/bases/mvp/IPresenter.dart';
import 'package:wanandroid/presenters/HomPresenter.dart';
import 'dart:ui';
import 'package:flutter_swiper/flutter_swiper.dart';

///Author: cuishuxiang
///Date: 2020/8/18 13:25
///Description: 首页

class HomePage extends BaseMvpViewPage {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends BaseViewState<HomePage, HomPresenter>
    implements HomeView {
  List<Image> _bannerListImages = List();

  ///空、错误 页面 点击事件
  EmptyErrorClick emptyErrorClick = () {
    LogUtils.print('点击kongyem');
  };

  @override
  createPresenter() {
    return HomPresenter(context);
  }

  @override
  initView() {
    showLoading();
    presenter.getBannerData();
  }

  //banner 回调
  @override
  void onBannerDataCallBack(bool isSuccess, List<BannerBean> bannerList,
      String msg) {
    // banner 数据回调

    if (isSuccess) {
      _bannerListImages.clear();
      bannerList.forEach((banner) {
        _bannerListImages.add(Image.network(
          banner.imagePath,
          fit: BoxFit.fill,
        ));
      });
      setState(() {

      });
      showContent();
    }
  }

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Column(
      children: <Widget>[
        getSwiper(),
      ],
    );
  }

  ///轮播图
  Widget getSwiper() {
    return Container(
      width: ScreenUtils.getScreenWidth(),
      height: 200,
      child: Swiper(
        loop: true,
        autoplay: true,
        itemCount: _bannerListImages.length,
        itemBuilder: (BuildContext content, int index) {
          return _bannerListImages[index];
        },
        pagination: SwiperPagination(//圆点指示器
          alignment: Alignment.bottomRight
        ),
//        control: SwiperControl(), // 展示默认分页按钮
        onTap: (index) {
          ToastUtils.show(context, '点击了$index');
        },
      ),
    );
  }
}
