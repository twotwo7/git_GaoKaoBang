import 'package:flutter/material.dart';
import 'package:gaokaobang/user/History.dart';

class userPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return new Page();
  }
}

class Page extends State<userPage> {
  String noteStr="记录下你每天的奋斗心情";
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
        resizeToAvoidBottomPadding: false, //输入框抵住键盘 内容不随键盘滚动
        //appBar: buildAppBar(context),
        body: new SingleChildScrollView(child: new Column(
          children: <Widget>[
            //上半部分，显示座右铭和背景图片
            new Container(height: 300, width: MediaQuery
                .of(context)
                .size
                .width, child: new Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/black.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                //文字部分
                child: Center(
                    child: new Row(
                      children: <Widget>[
                        new Container(width: 50,),
                        new Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 100,
                          child: Text(noteStr, style: TextStyle(
                              fontSize: 22.0, color: Colors.white)),
                        ),
                        new Container(width: 50,),
                      ],
                    )

                ),
              ),
            ),),
            //多个设置
            new Container(
              margin: EdgeInsets.only(top: 8),
              child: new Wrap(
                spacing: 2.0, // gap between adjacent chips
                runSpacing: 2.0, // gap between lines
                children: <Widget>[
                  //历史记录
                  new Card(
                    child: new Container(height: cardWidth, width: cardWidth,
                      child: new MaterialButton(
                        child: new Center(
                            child: new Column(
                              children: <Widget>[
                                new Container(height: cardWidth / 6,),
                                new Container(
                                  child: new Image.asset("images/talk.png"),
                                  width: cardWidth / 2,
                                  height: cardWidth / 2,),
                                new Text("历史记录", style: TextStyle(fontSize: 10,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900))
                              ],
                            )
                        ),
                        onPressed: clickHistory,
                      ),
                    ),
                  ),
                  //奋斗心情,点击在底部弹出输入框
                  new Card(
                    child: new Container(height: cardWidth, width: cardWidth,
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
                                        new Container(child: new TextField(
                                          maxLines: 2,
                                          controller: _noteController,
                                          decoration: new InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              /*边角*/
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(30), //边角为30
                                              ),
                                              borderSide: BorderSide(
                                                color: Colors.amber, //边线颜色为黄色
                                                width: 2, //边线宽度为2
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.blue, //边框颜色为绿色
                                                  width: 5, //宽度为5
                                                )),
                                            // errorText: "errorText",
                                            hintText: '写下你今天的奋斗心情',
                                          ),
                                        ),),
                                        //确认按钮
                                        new Container(
                                          child: new Align(
                                            alignment: new FractionalOffset(0.9, 0.5),
                                            child: new MaterialButton(
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide.none,
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(20))),
                                                color: Colors.blue,
                                                textColor: Colors.white,
                                                child: new Text('确认'),
                                                onPressed: () {
                                                  noteStr = _noteController.text
                                                      .toString();
                                                  setState(() {});
                                                }
                                            ),
                                          ),
                                        )
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
                                      "奋斗心情", style: TextStyle(fontSize: 10,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900))
                                ],
                              )
                          )
                      ),
                    ),),
                  //设置
                  new Card(
                    child: new Container(height: cardWidth, width: cardWidth,
                        child: new Center(
                            child: new Column(
                              children: <Widget>[
                                new Container(height: cardWidth / 6,),
                                new Container(
                                  child: new Image.asset("images/setup.png"),
                                  width: cardWidth / 2,
                                  height: cardWidth / 2,),
                                new Text("设置", style: TextStyle(fontSize: 10,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900))
                              ],
                            )
                        )
                    ),),

                ],
              ),
            )
          ],
        ),)

    );
  }


  Widget header(BuildContext context) {
    return new Image.network(
      'http://i2.yeyou.itc.cn/2014/huoying/hd_20140925/hyimage06.jpg',
    );
  }
}
