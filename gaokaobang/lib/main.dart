import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gaokaobang/mainpage.dart';
void main() {
    debugPaintSizeEnabled = false;
    runApp(new MyApp());
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor:Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '高考帮',
      theme: new ThemeData(
        primaryColor: Colors.green,
      ),
      home: new Scaffold(
        body:MainPage(),
      ),
    );
  }
}

