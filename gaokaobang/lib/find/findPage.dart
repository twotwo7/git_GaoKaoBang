import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:gaokaobang/find/College.dart';
import 'package:gaokaobang/find/NoteScreen.dart';
import 'package:gaokaobang/find/SearchScreen.dart';
import 'package:gaokaobang/find/TestScreen.dart';
import 'package:gaokaobang/find/ZizhuScreen.dart';
import 'package:gaokaobang/news/newslist.dart';

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
        backgroundColor: Color.fromRGBO(0x57, 0xC3, 0xC2, 100),
        elevation: 0,
      ),
      body: new Container(
        //背景颜色
          //color: Color.fromRGBO(255, 246, 127, 100),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/userBG2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(0),
          child: new Column(
            children: <Widget>[
              /*new Container(
                padding: new EdgeInsets.all(20),
                color: Colors.green,
                //height: MediaQuery.of(context).size.height * (1.2 / 5.0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    new Container(height:0),
                    new Text(
                      "The reason why a great man is great is that he resolves to be a great man.\n伟人之所以伟大，是因为他立志要成为伟大的人", style: TextStyle(fontSize:18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w900),),
                    /*new Text("每日一句，点击刷新", style: TextStyle(fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700)
                    ),*/
                  ],
                ),
              ),*/
              new CountDownPage(),
              Expanded(
                child:new SingleChildScrollView(
                  child:new morePage(),
                ) ,
              ),


            ],
          )),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(title: const Text('发现'));
  }
}

//
class morePage extends StatefulWidget {
  @override
  createState() => new morePageState();
}

class morePageState extends State<morePage> {
  Color textColor=Color.fromRGBO(0x36, 0x29, 0x2F, 100);
  Set<Color> cardColor={
    Color.fromRGBO(0xEB, 0xDA, 0xCC, 100),
    Color.fromRGBO(0xF5, 0xF9, 0xF1, 100),
    Color.fromRGBO(0x8D, 0x91, 0xAA, 100),
    Color.fromRGBO(0xDC, 0xE2, 0xEC, 100),
  };
  clickZiZhu() {
    print("Z");
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new ZizhuScreen()),
    );
  }

  clickTest() {
    print("T");
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new TestScreen()),
    );

  }

  clickNote() {
    print("N");
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new NoteScreen()),
    );
  }

  clickCollege() {
    print("C");
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new CollegeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var cardHighet = MediaQuery
        .of(context)
        .size
        .height - 40;
    var cardWidth = MediaQuery
        .of(context)
        .size
        .width;
    return new Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Column(
          children: <Widget>[
            /* new Row(
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    //左上
                    new Container(
                      margin: new EdgeInsets.fromLTRB(0, 0, 5, 5),
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 4,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 2 - 15,
                      //color: Colors.green,
                      child: new Container(
                          alignment: Alignment.center,
                          child: new Container(
                              child: new Center(
                                  child: new MaterialButton(
                                      onPressed: (){clickSearch();},
                                      child: new Column(
                                        children: <Widget>[
                                          new Container(
                                            child: new Image.asset(
                                                "images/search.png"),
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 20, 0, 0),
                                          ),
                                          new Text("信息查询", style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w700))
                                        ],
                                      ))
                              )
                            /*new Column(
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
                          ),*/
                          )

                      ),
                    ),
                    //左下
                    new Container(

                      margin: new EdgeInsets.fromLTRB(0, 5, 5, 0),
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 4,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 2 - 15,
                      //color: Colors.green,
                      child: new Container(
                          alignment: Alignment.center,
                          child: new Container(
                              child: new Center(
                                  child: new MaterialButton(
                                      onPressed: (){clickTest();}, child: new Column(
                                    children: <Widget>[
                                      new Container(
                                        child: new Image.asset(
                                            "images/test.png"),
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 30, 0, 0),
                                      ),
                                      new Text("性格测试", style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w700))
                                    ],
                                  ))
                              )
                            /*new Column(
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
                          ),*/
                          )

                      ),
                    ),
                  ],
                ),
                new Column(
                  children: <Widget>[
                    //右上
                    new Container(
                      margin: new EdgeInsets.fromLTRB(5, 0, 0, 5),
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 4,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 2 - 15,
                      //color: Colors.green,
                      child: new Container(
                          alignment: Alignment.center,
                          child: new Container(
                              child: new Center(
                                  child: new MaterialButton(
                                      onPressed: (){clickCollege();},
                                      child: new Column(
                                        children: <Widget>[
                                          new Container(
                                            child: new Image.asset(
                                              "images/building.png",),
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 20, 0, 0),
                                          ),
                                          new Text("高校推荐", style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w700))
                                        ],
                                      ))

                              )
                            /*new Column(
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
                          ),*/
                          )

                      ),
                    ),
                    //右下
                    new Container(
                      margin: new EdgeInsets.fromLTRB(5, 5, 0, 0),
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 4,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 2 - 15,
                      //color: Colors.green,
                      child: new Container(
                          alignment: Alignment.center,
                          child: new Container(
                              child: new Center(
                                  child: new MaterialButton(
                                      onPressed: (){clickNote();},
                                      child: new Column(
                                    children: <Widget>[
                                      new Container(
                                        child: new Image.asset(
                                            "images/book.png"),
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 20, 0, 0),
                                      ),
                                      new Text("高考须知", style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w700))
                                    ],
                                  ))

                              )
                            /*new Column(
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
                          ),*/
                          )

                      ),
                    )
                  ],
                )

              ],
            ),*/
            //高校查询
            new Card(
                color: cardColor.elementAt(0),
                elevation: 1,
                //color: Colors.green,
                child: new MaterialButton(
                  minWidth: cardWidth,
                  height: cardHighet / 6,
                  onPressed: clickCollege,
                  child: new Container(

                    width: cardWidth,
                    height: cardHighet / 6,
                    child: new Row(
                      children: <Widget>[
                        //图标
                        Expanded(
                          child: Container(
                            //color: Colors.red,
                            padding: EdgeInsets.all(5.0),
                            child: new Image.asset("images/search.png"),
                          ),
                          flex: 1,
                        ),
                        //文字
                        Expanded(
                          child: Center(
                            child: Container(
                              //color: Colors.yellow,
                              padding: EdgeInsets.all(5.0),
                              child: new Text("高校查询",
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                )),
            //自主招生
            new Card(
                color: cardColor.elementAt(1),
                elevation: 1,
                //color: Colors.green,
                child: new MaterialButton(
                    minWidth: cardWidth,
                    height: cardHighet / 6,
                    onPressed: clickZiZhu,
                    child: new Container(
                      width: cardWidth,
                      height: cardHighet / 6,
                      child: new Row(
                        children: <Widget>[
                          //图标
                          Expanded(
                            child: Container(
                              //color: Colors.red,
                              padding: EdgeInsets.all(5.0),
                              child: new Image.asset("images/building.png"),
                            ),
                            flex: 1,
                          ),
                          //文字
                          Expanded(
                            child: Center(
                              child: Container(
                                //color: Colors.yellow,
                                padding: EdgeInsets.all(5.0),
                                child: new Text("自主招生",
                                    style: TextStyle(
                                        color: textColor,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.w700)),
                              ),
                            ),
                            flex: 2,
                          ),
                        ],
                      ),
                    ))),
            //性格测试
            new Card(
                color: cardColor.elementAt(2),
                elevation: 1,
                //color: Colors.green,
                child: new MaterialButton(
                    minWidth: cardWidth,
                    height: cardHighet / 6,
                    onPressed: clickTest,
                    child: new Container(
                      width: cardWidth,
                      height: cardHighet / 6,
                      child: new Row(
                        children: <Widget>[
                          //图标
                          Expanded(
                            child: Container(
                              //color: Colors.red,
                              padding: EdgeInsets.all(5.0),
                              child: new Image.asset("images/test.png"),
                            ),
                            flex: 1,
                          ),
                          //文字
                          Expanded(
                            child: Center(
                              child: Container(
                                //color: Colors.yellow,
                                padding: EdgeInsets.all(5.0),
                                child: new Text("性格测试",
                                    style: TextStyle(
                                        color:textColor,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.w700)),
                              ),
                            ),
                            flex: 2,
                          ),
                        ],
                      ),
                    ))),
            //高考须知
            new Card(
              color: cardColor.elementAt(3),
              elevation: 1,
              //color: Colors.green,
              child: new MaterialButton(
                  minWidth: cardWidth,
                  height: cardHighet / 6,
                  onPressed: clickNote,
                  child: new Container(
                    width: cardWidth,
                    height: cardHighet / 6,
                    child: new Row(
                      children: <Widget>[
                        //图标
                        Expanded(
                          child: Container(
                            //color: Colors.red,
                            padding: EdgeInsets.all(5.0),
                            child: new Image.asset("images/book.png"),
                          ),
                          flex: 1,
                        ),
                        //文字
                        Expanded(
                          child: Center(
                            child: Container(
                              //color: Colors.yellow,
                              padding: EdgeInsets.all(5.0),
                              child: new Text("高考须知",
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                          flex: 2,
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ));
  }
}
