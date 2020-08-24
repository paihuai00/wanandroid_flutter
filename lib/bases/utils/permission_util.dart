import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wanandroid/bases/utils/ToastUtils.dart';

///Author: cuishuxiang
///Date: 2020/8/20 18:20
///Description:

typedef XPermissionCallBack = Function(
    Permission permission, bool isGranted, bool neverAsk);



class XPermission {
  static const String denyHintStr = '不开启权限，将会影响使用，请前往设置开启';
  static Future check(Permission permission,
      {XPermissionCallBack xPermissionCallBack}) async {
    PermissionStatus status = await permission.status;

    if (status.isGranted) {
      //已获得权限
      if (xPermissionCallBack != null)
        xPermissionCallBack(permission, true, false);
      return;
    }

    //请求权限
    PermissionStatus newStatus = await permission.request();

    if (newStatus.isGranted) {
      //已获得权限
      if (xPermissionCallBack != null)
        xPermissionCallBack(permission, true, false);
    } else if (newStatus.isDenied) {
      //已拒绝
      if (xPermissionCallBack != null)
        xPermissionCallBack(permission, false, false);
    } else if (newStatus.isPermanentlyDenied) {
      //永久拒绝
      if (xPermissionCallBack != null)
        xPermissionCallBack(permission, false, true);
    }
  }

  static Future checks(List<Permission> permissions, {XPermissionCallBack xPermissionCallBack}) async {
    //找到没有权限的List
    List<Permission> noPermissionList = [];
    permissions.forEach((element) {
      if (element.status != PermissionStatus.granted)
        noPermissionList.add(element);
    });

    //批量请求权限
    Map<Permission, PermissionStatus> statuses =
        await noPermissionList.request();
    statuses.forEach((permission, statue) {
      //key: 权限名称； value ： 当前状态
      if (xPermissionCallBack == null) return;
      if (statue == PermissionStatus.denied) {
        xPermissionCallBack(permission, false, false);
      } else if (statue == PermissionStatus.permanentlyDenied) {
        xPermissionCallBack(permission, false, true);
      }
    });
  }

}
