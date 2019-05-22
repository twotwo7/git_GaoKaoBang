import 'package:flutter/material.dart';
import 'package:gaokaobang/user/HelpScreen.dart';
import 'package:gaokaobang/user/History.dart';
import 'package:gaokaobang/user/noteHistory.dart';

class userPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return new Page();
  }
}

class Page extends State<userPage> {
  String noteStr="记录每一刻心情,\n记录每一滴汗水,\n点击写下你的第一个便签吧！";
  final TextEditingController _noteController = new TextEditingController();
  clickHistory() {
    print("H");
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new History()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    var cardWidth = MediaQuery
        .of(context)
        .size
        .width / 3.5;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('高考帮'),
        backgroundColor: Color.fromRGBO(0x57, 0xC3, 0xC2, 100),
        elevation: 0,
      ),
      body: new Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/userBG3.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        //resizeToAvoidBottomPadding: false, //输入框抵住键盘 内容不随键盘滚动
        //appBar: buildAppBar(context),
        child: new SingleChildScrollView(
          child: Container(
            child: Center(
              child: new Column(
                children: <Widget>[
                  //上半部分，显示座右铭和背景图片
                  Opacity(
                      opacity: 0.8,
                      child: new Container(
                        margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: new Card(
                          child: Container(
                            //color: Color.fromRGBO(0x57, 0xC3, 0xC2, 100),
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 2,
                            /*decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/black.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),*/
                            //文字部分
                            child: Center(
                                child: new Row(
                                  children: <Widget>[
                                    new Container(width: 20,),
                                    Expanded(
                                      child: new Container(
                                        alignment: Alignment.center,
                                        child: Text(noteStr, style: TextStyle(
                                            fontSize: 22.0,
                                            color: Colors.black),
                                          textAlign: TextAlign.center,),
                                      ),
                                    ),
                                    new Container(width: 20,),
                                  ],
                                )

                            ),
                          ),
                        ),
                      )

                  ),
                  //多个设置
                  new Container(
                    margin: EdgeInsets.only(top: 8),
                    child: new Wrap(
                      spacing: 2.0, // gap between adjacent chips
                      runSpacing: 2.0, // gap between lines
                      children: <Widget>[
                        //历史记录
                        Opacity(
                          opacity: 0.8,
                          child: new Card(
                            child: new Container(
                              height: cardWidth, width: cardWidth,
                              //color: Color.fromRGBO(0x57, 0xC3, 0xC2, 100),
                              child: new MaterialButton(
                                child: new Center(
                                    child: new Column(
                                      children: <Widget>[
                                        new Container(height: cardWidth / 6,),
                                        new Container(
                                          child: new Image.asset(
                                              "images/talk.png"),
                                          width: cardWidth / 2,
                                          height: cardWidth / 2,),
                                        new Text("历史记录",
                                            style: TextStyle(fontSize: 10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w900))
                                      ],
                                    )
                                ),
                                onPressed: clickHistory,
                              ),
                            ),
                          ),
                        ),
                        //便签,点击在底部弹出输入框
                        Opacity(
                          opacity: 0.8,
                          child: new Card(
                            child: new Container(
                              height: cardWidth, width: cardWidth,
                              //color: Color.fromRGBO(0x57, 0xC3, 0xC2, 100),
                              child: new MaterialButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return new SingleChildScrollView(
                                            child: new Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                //输入框
                                                new Container(
                                                  child: new TextField(
                                                    maxLines: 2,
                                                    controller: _noteController,
                                                    decoration: new InputDecoration(
                                                      enabledBorder: OutlineInputBorder(
                                                        /*边角*/
                                                        borderRadius: BorderRadius
                                                            .all(
                                                          Radius.circular(
                                                              30), //边角为30
                                                        ),
                                                        borderSide: BorderSide(
                                                          color: Color.fromRGBO(
                                                              0x57, 0xC3, 0xC2,
                                                              100), //边线颜色为黄色
                                                          width: 2, //边线宽度为2
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: Color
                                                                .fromRGBO(
                                                                0x57, 0xC3,
                                                                0xC2, 100),
                                                            //边框颜色为绿色
                                                            width: 5, //宽度为5
                                                          )),
                                                      // errorText: "errorText",
                                                      hintText: '写下便签',
                                                    ),
                                                  ),),

                                                new Row(
                                                  children: <Widget>[
                                                    //隔开
                                                    new Expanded(
                                                      flex: 1,
                                                      child: new Container(),
                                                    ),
                                                    //查看历史记录按钮
                                                    new Expanded(
                                                      child: new Container(
                                                        child: new MaterialButton(
                                                            shape: RoundedRectangleBorder(
                                                                side: BorderSide
                                                                    .none,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                    .circular(
                                                                    20))),
                                                            color: Color
                                                                .fromRGBO(
                                                                0x57, 0xC3,
                                                                0xC2, 100),
                                                            textColor: Colors
                                                                .white,
                                                            child: new Text(
                                                                '历史便签'),
                                                            onPressed: () {
                                                              clickNoteHistory();
                                                            }
                                                        ),
                                                      ),
                                                      flex: 2,
                                                    ),
                                                    //隔开
                                                    new Expanded(
                                                      flex: 1,
                                                      child: new Container(),
                                                    ),
                                                    //确认按钮
                                                    new Expanded(
                                                      child: new Container(
                                                        child: new MaterialButton(
                                                            shape: RoundedRectangleBorder(
                                                                side: BorderSide
                                                                    .none,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                    .circular(
                                                                    20))),
                                                            color: Color
                                                                .fromRGBO(
                                                                0x57, 0xC3,
                                                                0xC2, 100),
                                                            textColor: Colors
                                                                .white,
                                                            child: new Text(
                                                                '确认'),
                                                            onPressed: () {
                                                              clickNoteSubmit();
                                                            }
                                                        ),
                                                      ),
                                                      flex: 2,
                                                    ),
                                                    //隔开
                                                    new Expanded(
                                                      flex: 1,
                                                      child: new Container(),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                    );
                                  },
                                  //foregroundColor: Colors.white,
                                  child: new Center(
                                      child: new Column(
                                        children: <Widget>[
                                          new Container(height: cardWidth / 6,),
                                          new Container(
                                            child: new Image.asset(
                                                "images/notebook.png"),
                                            width: cardWidth / 2,
                                            height: cardWidth / 2,),
                                          new Text(
                                              "便签",
                                              style: TextStyle(fontSize: 10,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900))
                                        ],
                                      )
                                  )
                              ),
                            ),),
                        ),
                        //使用帮助
                        Opacity(
                          opacity: 0.8,
                          child: new Card(
                            child: new Container(
                              height: cardWidth, width: cardWidth,
                              //color: Color.fromRGBO(0x57, 0xC3, 0xC2, 100),
                              child: new MaterialButton(
                                child: new Center(
                                    child: new Column(
                                      children: <Widget>[
                                        new Container(height: cardWidth / 6,),
                                        new Container(
                                          child: new Image.asset(
                                              "images/setup.png"),
                                          width: cardWidth / 2,
                                          height: cardWidth / 2,),
                                        new Text("使用帮助",
                                            style: TextStyle(fontSize: 10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w900))
                                      ],
                                    )
                                ),
                                onPressed: clickHelp,
                              ),
                            ),
                          ),
                        ),


                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

        ),


      ),
    )
    ;
  }
  //点击便签历史记录
  clickNoteHistory(){
    print("NH");
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new noteHistory()),
    );
  }
  //点击便签确定
  clickNoteSubmit(){
    noteStr = _noteController.text
        .toString();
    Navigator.pop(context);
    setState(() {});
  }
  //点击使用帮助
  clickHelp(){
    print("HELP");
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new HelpScreen()),
    );
  }

  Widget header(BuildContext context) {
    return new Image.network(
      'http://i2.yeyou.itc.cn/2014/huoying/hd_20140925/hyimage06.jpg',
    );
  }
}
