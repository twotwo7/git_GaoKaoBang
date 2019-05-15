import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      new Scaffold(
      appBar: new AppBar(
        title: new Text('性格测试'),
        backgroundColor: Color.fromRGBO(0x57, 0xC3, 0xC2, 100),
      ),
      body:
      new MaterialApp(
        routes: {
          "/": (_) => new WebviewScaffold(
            url: "https://hd.xinli001.cc/cp-m/index.html#/ceshi/838/answer?channelId=513&userAwaitTestScaleId=0",
            appBar: new AppBar(
              title: new Text("Widget webview"),
            ),
          )
        },
      )
    );
  }
}