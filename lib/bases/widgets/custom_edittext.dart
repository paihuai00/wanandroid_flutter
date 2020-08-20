import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/constants/Constant.dart';

typedef void ITextFieldCallBack(String content);

String _inputAccount = "";
bool _isShowDelete = false;
var hintText = "手机号或者邮箱";
int maxLines = 1;
int maxLengths = 25;

///登陆注册界面edittext输入框
class AccountEditText extends StatefulWidget {
  final ITextFieldCallBack contentStrCallBack;



  AccountEditText({Key key, hintText, maxLines, maxLengths, this.contentStrCallBack}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AccountState();
  }
}

class _AccountState extends State<AccountEditText> {
  @override
  Widget build(BuildContext context) {
    ///输入框 控制器
    TextEditingController textEditingController =
        TextEditingController.fromValue(TextEditingValue(
            text: _inputAccount,
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: _inputAccount.length))));

    return Container(
      child: Theme(
        data: ThemeData(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent),
        child: TextField(
          controller: textEditingController,
          style: TextStyle(color: Color(0xff333333), fontSize: 14),
          decoration: InputDecoration(
              counterText: "",
              hintText: hintText,
              hintStyle: TextStyle(color: Color(0xff8C8C8C), fontSize: 14),
              contentPadding: const EdgeInsets.only(top: 14, bottom: 14),
              focusedBorder: UnderlineInputBorder(
                  //获取焦点后，边框的颜色
                  borderSide: BorderSide(color: Colors.orange)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              fillColor: Colors.transparent,
              filled: true,
              suffixIcon: _isShowDelete
                  ? Container(
                      width: 15,
                      height: 15,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _inputAccount = "";
                            _isShowDelete = (_inputAccount.isNotEmpty);
                            widget.contentStrCallBack(_inputAccount);
                          });
                        },
                        padding: EdgeInsets.all(2),
                        iconSize: 15,
                        icon: Image.asset(
                          Constant.Image_Assets + 'icon_et_delete.png',
                          width: 15,
                          height: 15,
                        ),
                      ),
                    )
                  : Text('')),
          onChanged: (str) {
            //内容发生改变时候的回调
            setState(() {
              _inputAccount = str;
              _isShowDelete = (_inputAccount.isNotEmpty);
              widget.contentStrCallBack(_inputAccount);
            });
          },
          keyboardType: TextInputType.text,
          maxLength: maxLengths,
          maxLines: maxLines,
        ),
      ),
    );
  }

  ///样式
//  InputDecoration _inputDecoration() {
//    return InputDecoration(
//        counterText: "",
//        hintText: hintText,
//        hintStyle: TextStyle(color: Color(0xff8C8C8C), fontSize: 14),
//        contentPadding: const EdgeInsets.only(top: 14, bottom: 14),
//        focusedBorder: UnderlineInputBorder(
//            //获取焦点后，边框的颜色
//            borderSide: BorderSide(color: Colors.orange)),
//        enabledBorder:
//            UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
//        fillColor: Colors.transparent,
//        filled: true,
//        suffixIcon: _isShowDelete
//            ? Container(
//                width: 14,
//                height: 14,
//                child: IconButton(
//                  padding: const EdgeInsets.all(0),
//                  iconSize: 14,
//                  icon: Image.asset(
//                    Constant.Image_Assets + 'icon_et_delete.png',
//                    width: 14,
//                    height: 14,
//                  ),
//                  onPressed: () {
//                    setState(() {
//                      _inputAccount = "";
//                      _isShowDelete = _inputAccount.isNotEmpty;
//                      widget.contentStrCallBack(_inputAccount);
//                    });
//                  },
//                ),
//              )
//            : Text('')
//    );
//  }
}
