import 'package:flutter/material.dart';

///Author: cuishuxiang
///Date: 2020/8/18 13:25
///Description:

class SquarePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SquareState();
  }
}

class _SquareState extends State<SquarePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('广场'),
    );
  }
}
