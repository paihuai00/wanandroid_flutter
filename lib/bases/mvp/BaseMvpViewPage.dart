import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:wanandroid/bases/mvp/IPresenter.dart';
import 'package:wanandroid/bases/mvp/IView.dart';
import 'package:wanandroid/bases/utils/DialogUtils.dart';
import 'package:wanandroid/bases/utils/log_util.dart';
import 'package:wanandroid/bases/utils/screen_utils.dart';
import 'package:wanandroid/constants/Constant.dart';

///Author: cuishuxiang
///Date: 2020/8/19 16:03
///Description:

typedef EmptyErrorClick = Function();

abstract class BaseMvpViewPage extends StatefulWidget {}

abstract class BaseViewState<V extends BaseMvpViewPage, P extends IPresenter>
    extends State<V> implements IView {
  P _presenter;

  YYDialog _yyDialog;

  bool _isContentWidgetShow; // 是否显示内容
  bool _isShowEmpty; // 显示空页面
  bool _isShowError; // 显示错误页面
  bool _isShowLoading; // 显示错误页面
  EmptyErrorClick _emptyErrorClick;

  @override
  void initState() {
    super.initState();
    _presenter = createPresenter();
    if (_presenter != null) _presenter.attach(this);

    ///注意，需要在base里面初始化，不然页面无法直接调用
    YYDialog.init(context);

    initView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      color: Colors.white,

      ///页面背景色
      child: Stack(
        children: [
          /// Offstage  控制child是否显示
          ///
          ///    当offstage为true，控件隐藏； 当offstage为false，显示；
          ///    当Offstage不可见的时候，如果child有动画等，需要手动停掉，Offstage并不会停掉动画等操作。
          Offstage(
            offstage: !_isContentWidgetShow,
            child: buildWidget(context),
          ),
          Offstage(
            offstage: !_isShowEmpty,
            child: _buildEmptyWidget(),
          ),
          Offstage(
            offstage: !_isShowError,
            child: _buildErrorWidget(),
          ),
          Offstage(
            offstage: !_isShowLoading,
            child: _buildLoadingWidget(),
          ),
        ],
      ),
    );
  }

  initView();

  P createPresenter();

  P get presenter => _presenter;

  Widget buildWidget(BuildContext context);

  ///错误页面
  Widget _buildErrorWidget() {
    return GestureDetector(
      child: Container(
        width: ScreenUtils.getScreenWidth(),
        height: ScreenUtils.getScreenHeight(),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,///垂直居中
              children: [
                Image.asset(
                  Constant.Image_Assets + 'ic_error.png',
                  width: 100,
                  height: 100,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text('未知错误,点击重试!'),
                )
              ],
            )),
      ),
      onTap: () {
        ///点击事件
        _emptyErrorClick?.call();
      },
    );
  }

  ///空数据页面
  Widget _buildEmptyWidget() {
    return GestureDetector(
      child: Container(
        width: ScreenUtils.getScreenWidth(),
        height: ScreenUtils.getScreenHeight(),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,///垂直居中
          children: [
            Image.asset(
              Constant.Image_Assets + 'ic_empty.png',
              width: 100,
              height: 100,
            ),
            Container(
              alignment: Alignment.center,
              child: Text('暂无数据'),
            )
          ],
        )),
      ),
      onTap: () {
        ///点击事件
        _emptyErrorClick?.call();
      },
    );
  }

  ///加载中页面
  Widget _buildLoadingWidget({EmptyErrorClick click}) {
    return GestureDetector(
      child: Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      onTap: () {
        ///点击事件
      },
    );
  }

  void showLoading() {
    _isShowLoading = true;
    _isContentWidgetShow = false;
    _isShowError = false;
    _isShowEmpty = false;
    setState(() {});
  }

  void showContent() {
    _isShowLoading = false;
    _isContentWidgetShow = true;
    _isShowError = false;
    _isShowEmpty = false;
    setState(() {});
  }

  void showError({EmptyErrorClick click}) {
    _isShowLoading = false;
    _isContentWidgetShow = false;
    _isShowError = true;
    _isShowEmpty = false;
    _emptyErrorClick = click;
    setState(() {});
  }

  void showEmpty({EmptyErrorClick click}) {
    _isShowLoading = false;
    _isContentWidgetShow = false;
    _isShowError = false;
    _isShowEmpty = true;
    _emptyErrorClick = click;
    setState(() {});
  }

  ///显示弹框，初始化[YYDialog.init(ctx)]
  void showProgress() {
    if (_yyDialog == null) _yyDialog = DialogUtil.getLoadingDialog();

    if (!_yyDialog.isShowing) _yyDialog.show();
  }

  ///隐藏弹框，初始化[YYDialog.init(ctx)]
  void hindProgress() {
    if (_yyDialog == null) return;

    if (_yyDialog.isShowing) _yyDialog.dismiss();
  }

  @override
  void dispose() {
    super.dispose();
    if (_presenter != null) {
      _presenter.detach();
      _presenter = null;
    }

    if (_yyDialog != null) {
      _yyDialog.dismiss();
      _yyDialog = null;
    }
  }
}
