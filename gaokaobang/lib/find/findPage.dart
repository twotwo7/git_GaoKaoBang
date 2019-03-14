import 'package:flutter/material.dart';

class findPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return new Page();
  }
}

class Page extends State<findPage> {
  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('高考帮'),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: new Container(
        padding: const EdgeInsets.all(10),
        child: new collegeSearchPage(),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(title: const Text('发现'));
  }
}

//
class collegeSearchPage extends StatefulWidget{
  @override
  createState() => new collegeSearchPageState();
}
class collegeSearchPageState extends State<collegeSearchPage> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      //color: Colors.greenAccent,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Row(
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Container(
                //左上
                margin: new EdgeInsets.fromLTRB(0, 0, 5, 5),
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 2 - 100,
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 2 - 15,
                color: Colors.green,
                child: new Container(
                  alignment: Alignment.center,
                  child: new Container(
                    child: new Column(
                      children: <Widget>[
                        new Text("高校", style: TextStyle(fontSize: MediaQuery
                            .of(context)
                            .size
                            .width / 5,
                            color: Colors.white,
                            fontWeight: FontWeight.w900)),
                        new Text("查询", style: TextStyle(fontSize: MediaQuery
                            .of(context)
                            .size
                            .width / 5,
                            color: Colors.white,
                            fontWeight: FontWeight.w900)),
                      ],
                    ),
                  )

                ),
              ),
              new Container(
                //左下
                margin: new EdgeInsets.fromLTRB(0, 5, 5, 0),
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 2 - 100,
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 2 - 15,
                color: Colors.green,
              )
            ],
          ),
          new Column(
            children: <Widget>[
              new Container(
                //右上
                margin: new EdgeInsets.fromLTRB(5, 0, 0, 5),
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 2 - 100,
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 2 - 15,
                color: Colors.green,
              ),
              new Container(
                //右下
                margin: new EdgeInsets.fromLTRB(5, 5, 0, 0),
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 2 - 100,
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 2 - 15,
                color: Colors.green,
              )
            ],
          )

        ],
      ),
    );
  }
}