import 'package:flutter/material.dart';

class userPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return new Page();
  }
}

class Page extends State<userPage> {
  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(context),
      body: new ListView(
        children: <Widget>[
          new Text("这里是我的页面"),
        ],
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(title: const Text('我的'));
  }

  Widget header(BuildContext context) {
    return new Image.network(
      'http://i2.yeyou.itc.cn/2014/huoying/hd_20140925/hyimage06.jpg',

    );
  }
}
