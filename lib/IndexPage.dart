import 'package:flutter/material.dart';
import 'package:wanandroid/bases/utils/ToastUtils.dart';
import 'package:wanandroid/bases/utils/log_util.dart';
import 'package:wanandroid/pages/HomePage.dart';
import 'package:wanandroid/pages/MinePage.dart';
import 'package:wanandroid/pages/ProjectPage.dart';
import 'package:wanandroid/pages/SquarePage.dart';
import 'package:wanandroid/pages/WechatPage.dart';

import 'bases/nets/DioUtils.dart';
import 'bases/nets/HttpMethod.dart';
import 'beans/BannerBean.dart';
import 'constants/UrlConstants.dart';

///Author: cuishuxiang
///Date: 2020/8/18 13:36
///Description:

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IndexState();
}

class _IndexState extends State<IndexPage> {
  int _tabIndex = 0;
  var tabImages;
  var titles = ['首页', '项目', '广场', '公众号', '我'];
  var curPage;
  List<Widget> tabPages;

  List<BottomNavigationBarItem> _bottomNavTabs;

  @override
  Widget build(BuildContext context) {
    initView();
    /// SafeArea : 会自动适配手机，顶部刘海、底部指示器
    return SafeArea(
      child: WillPopScope(
        child: _getScaffold(),
        onWillPop: () {
          ///点击，返回
          ToastUtils.show(context, "点击返回");

          return;
        },
      ),
    );
  }

  Widget _getScaffold() {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _tabIndex,
        items: _bottomNavTabs,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
            curPage = tabPages[index];
          });
        },
      ),
      body: IndexedStack(
        index: _tabIndex,
        children: tabPages,
      ),
    );
  }

  ///初始化
  void initView() {
    tabImages = [
      [
        _getTabImage('assets/images/ic_home.png'),
        _getTabImage('assets/images/ic_home_select.png'),
      ],
      [
        _getTabImage('assets/images/ic_project.png'),
        _getTabImage('assets/images/ic_project_select.png'),
      ],
      [
        _getTabImage('assets/images/ic_square.png'),
        _getTabImage('assets/images/ic_square_select.png'),
      ],
      [
        _getTabImage('assets/images/ic_wechat.png'),
        _getTabImage('assets/images/ic_wechat_select.png'),
      ],
      [
        _getTabImage('assets/images/ic_my.png'),
        _getTabImage('assets/images/ic_my_select.png'),
      ]
    ];

    ///页面内容
    tabPages = [
      HomePage(),
      ProjectPage(),
      SquarePage(),
      WechatPage(),
      MinePage()
    ];

    _bottomNavTabs = [
      BottomNavigationBarItem(icon: _getTabIcon(0), title: _getTabTitle(0)),
      BottomNavigationBarItem(icon: _getTabIcon(1), title: _getTabTitle(1)),
      BottomNavigationBarItem(icon: _getTabIcon(2), title: _getTabTitle(2)),
      BottomNavigationBarItem(icon: _getTabIcon(3), title: _getTabTitle(3)),
      BottomNavigationBarItem(icon: _getTabIcon(4), title: _getTabTitle(4))
    ];
  }

  ///根据角标获取当前文字
  Text _getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return Text(titles[curIndex],
          style: TextStyle(fontSize: 13.0, color: Colors.blue));
    } else {
      return Text(titles[curIndex],
          style: TextStyle(fontSize: 13.0, color: Colors.grey));
    }
  }

  Image _getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    } else {
      return tabImages[curIndex][0];
    }
  }

  Image _getTabImage(path) {
    return Image.asset(path, width: 25.0, height: 25.0);
  }
}
