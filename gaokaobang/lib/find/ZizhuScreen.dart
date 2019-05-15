import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui';
import 'dart:convert';
import 'package:gaokaobang/find/zizhu.dart';
import 'package:gaokaobang/tools/tools.dart';
//List<List> chips_show=[["科",""],["科",""],["科",""],["学",""],["专",""],["分",""],["差",""]];
//List<List> chips_show=[];

//const chipwidth = 80.0;
//const chipheight = 60.0;
//List<Map> _suggestions=new List();

List<Map> _suggestions=new List();
//这个list存着待查找的数据
List<Map> major_map_list=new List();


class ZizhuScreen extends StatefulWidget{
  @override
  createState() => new ZizhuState();
}

class ZizhuState extends State<ZizhuScreen> {
  void _update() {
    //通知刷新
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false, //输入框抵住键盘 内容不随键盘滚动
        appBar: new AppBar(
          elevation: 1,
          backgroundColor: Color.fromRGBO(0x57, 0xC3, 0xC2, 100),
          title: new Text('自主招生'),
          actions: <Widget>[
            //new IconButton(icon: new Icon(Icons.list), onPressed: () {
            //  _EditPress(context);
            //}),
          ],
          //backgroundColor: Colors.blue,
        ),
        body: new SingleChildScrollView(
          child: new Container(
            child: new Column(
              children: <Widget>[
                //搜索框
                new Card(
                  child: new Container(
                    //color: Colors.blue,
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: new SearchInputView(_update),
                  ),
                ),
                new Card(
                  child:new Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height - 194,
                    child: new ResultList(),
                  ) ,
                ),
                //搜索结果列表

              ],
            ),
          ),
        )


    );
  }

//点击编辑框
/*_EditPress(BuildContext context) async {
    /*var result = await Navigator.push(context,
        new MaterialPageRoute(builder: (context) {
          return new MyDialog();
        }));
    setState(() {
    });*/
    List<Object>result = await showDialog<List>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new MyDialog();
        }
    );
    setState(() {
      _suggestions = _suggestions;
      chips_show = chips_show;
    });
  }*/
}

class SearchInputView extends StatefulWidget {
  final Function update;
  SearchInputView(this.update);
  @override
  createState() => new SearchInputViewState(update);
}
class SearchInputViewState extends State<SearchInputView> {
  /*String yaoqiu_id;
  List<bool> Checks = [false, false, false, false, false, false];
  List<String> Check_name = ["物理", "化学", "生物", "地理", "生物", "政治"];*/
  String schoolnamestr = "";
  /*String specialnamestr = "";
  String scorestr = "";
  String rangestr = "";*/
  // 声明一个方法成员方法

  final Function update;

  //保存传递来方法(引用)

  SearchInputViewState(this.update);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        //科目复选框
        /*new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            new Text("科目:"),
            new Container(width: 50,),
            new Column(
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                new Row(
                  children: <Widget>[
                    new Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: Checks[0],
                      onChanged: (bool value) {
                        setState(() {
                          Checks[0] = !Checks[0];
                        });
                      },
                    ),
                    new Text("物理"),
                    new Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: Checks[1],
                      onChanged: (bool value) {
                        setState(() {
                          Checks[1] = !Checks[1];
                        });
                      },
                    ),
                    new Text("化学"),
                    new Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: Checks[2],
                      onChanged: (bool value) {
                        setState(() {
                          Checks[2] = !Checks[2];
                        });
                      },
                    ),
                    new Text("生物"),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: Checks[3],
                      onChanged: (bool value) {
                        setState(() {
                          Checks[3] = !Checks[3];
                        });
                      },
                    ),
                    new Text("地理"),
                    new Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: Checks[4],
                      onChanged: (bool value) {
                        setState(() {
                          Checks[4] = !Checks[4];
                        });
                      },
                    ),
                    new Text("历史"),
                    new Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: Checks[5],
                      onChanged: (bool value) {
                        setState(() {
                          Checks[5] = !Checks[5];
                        });
                      },
                    ),
                    new Text("政治"),
                  ],
                )
              ],
            ),
          ],
        ),*/
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //大学名字输入
            new Container(
              child: new Row(
                children: <Widget>[
                  new Text(
                      "大学："
                  ),
                  new Container(
                    width: 200,
                    child: new TextField(
                      maxLines: 1,
                      //maxLength: 10,
                      onChanged: (String value) {
                        setState(() {
                          schoolnamestr = value;
                        });
                      },
                    ),
                  )
                  //new TextField(),
                ],
              ),
            ),
            //专业课名字输入
           /* new Container(
              child: new Row(
                children: <Widget>[
                  new Text("专业："),
                  new Container(
                    width: 100,
                    child: new TextField(
                      maxLines: 1,
                      //maxLength: 10,
                      onChanged: (String value) {
                        setState(() {
                          specialnamestr = value;
                        });
                      },
                    ),

                  )
                  //new TextField(),
                ],
              ),
            ),*/
          ],
        ),
        /*new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            //分数输入
            new Container(
              child: new Row(
                children: <Widget>[
                  new Text("分数："),
                  new Container(
                    width: 100,
                    child: new TextField(
                      maxLines: 1,
                      //maxLength: 10,
                      onChanged: (String value) {
                        setState(() {
                          if (value == "") {
                            scorestr = "0";
                          } else {
                            scorestr = value;
                          }
                        });
                      },
                    ),
                  )
                  //new TextField(),
                ],
              ),
            ),
            //分差输入
            new Container(
              child: new Row(
                children: <Widget>[
                  new Text("分差："),
                  new Container(
                    width: 100,
                    child: new TextField(
                      maxLines: 1,
                      //maxLength: 10,
                      onChanged: (String value) {
                        setState(() {
                          if (value == "") {
                            rangestr = "0";
                          } else {
                            rangestr = value;
                          }
                        });
                      },
                    ),
                  )
                  //new TextField(),
                ],
              ),
            ),
          ],
        ),*/
        //搜索按钮
        new MaterialButton(
          shape: RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          color: Color.fromRGBO(0x57, 0xC3, 0xC2, 100),
          textColor: Colors.white,
          child: new Text('立即查询'),
          onPressed: () {
            //Navigator.of(context).pop();
            //chips_show=[];
            clickSearch();
            setState(() {
              update();
            });
          },
        )
      ],
    );
  }
  void clickSearch(){
    /*yaoqiu_id="";
    for(int i=0;i<Checks.length;i++){
      if(Checks[i]==true){
        //chips_show.add(['科',Check_name[i]]);
        yaoqiu_id+="1";
      }else{yaoqiu_id+="0";}
    }*/
    //chips_show.add(['专',specialnamestr]);
    //chips_show.add(['学',schoolnamestr]);
    //chips_show.add(['分',scorestr]);
    //chips_show.add(['差',rangestr]);
    /*print(chips_show);
                  for (int i = 0; i < chips_show.length; i++) {
                    if (chips_show[i][0] == "专") {
                      specialtyname = chips_show[i][1];
                    }
                    else if (chips_show[i][0] == "学") {
                      schoolname = chips_show[i][1];
                    }
                    else if (chips_show[i][0] == "分") {
                      try {
                        score = int.parse(chips_show[i][1]);
                      } catch (e) {
                        score = 0;
                      }
                    }
                    else if (chips_show[i][0] == "差") {
                      try {
                        range = int.parse(chips_show[i][1]);
                      } catch (e) {
                        range = 0;
                      }
                    }
                  }*/
    //return major_map_list;
    List<Map> results = new List();
    results.clear();
    for (int i = 0; i < major_map_list.length; i++) {
      print(schoolnamestr+major_map_list[i]['colleague']);
      if(compareSCHOOLNAME(schoolnamestr, major_map_list[i]['colleague'])){
        results.add(major_map_list[i]);
      }
    }
    /*int scoreint=0;
    int rangeint=0;
    try{scoreint=int.parse(scorestr);}catch(e){scoreint=0;}
    try{rangeint=int.parse(rangestr);}catch(e){rangeint=0;}
    for (int i = 0; i < major_map_list.length; i++) {
      if (compareSCORE(scoreint, major_map_list[i]['var'], rangeint) &&
          compareSPECIALTYNAME(
              specialnamestr, major_map_list[i]['specialtyname']) &&
          compareYAOQIU(yaoqiu_id, major_map_list[i]['yaoqiu_id']) &&
          compareSCHOOLNAME(schoolnamestr, major_map_list[i]['schoolname'])) {
        results.add(major_map_list[i]);
      }
    }
    print(yaoqiu_id);
    print(_suggestions.length);*/
    _suggestions = results;
    print(_suggestions.length);
  }
  //将字符串转化成二进制数代表的int
  int str2byte(String str){
    int ans=0;
    int k=1;
    for(int i=str.length-1;i>-1;i--,k*=2){
      if(str[i]=="1"){
        ans=ans+k;
      }
    }
    return ans;
  }
  //输入：用户的yaoqiu_id，数据中的id
  bool compareYAOQIU(String user,String data){
    if(user==""||user=="000000")return true;
    bool result=false;
    int userint=str2byte(user);
    int dataint=str2byte(data.substring(1,7));
    if(data[0]=="1"){
      //必选，与之后必须等于原数
      if(dataint<=dataint&userint){
        //成功匹配
        return true;
      }else{
        return false;
      }
    }else if(data[0]=="0"){
      //选至少一项,与之后大于1
      if(dataint&userint>0){
        //成功匹配
        return true;
      }else{
        return false;
      }
    }else{
      //没有要求
      return true;
    }

  }
  bool compareSCHOOLNAME(String user,String data){
    /*if(user=="")return true;
    if(user==data)
      return true;
    return false;*/
    if(user=="")return true;
    int data_len=data.length;
    int user_len=user.length;
    for(int i=0;i<data_len-user_len+1;i++){
      if(user==data.substring(i,user_len+i)){
        return true;
      }
    }
    return false;
  }
  bool compareSPECIALTYNAME(String user,String data){
    if(user=="")return true;
    int data_len=data.length;
    int user_len=user.length;
    for(int i=0;i<data_len-user_len+1;i++){
      if(user==data.substring(i,user_len+i)){
        return true;
      }
    }
    return false;
  }
  bool compareSCORE(int user,String data,int range){
    if(user==0||range==0)return true;
    int dataint=int.parse(data);
    try{
      if(user<=dataint+range&&user>=dataint-range){
        return true;
      }
    }catch(e){
      return false;
    }

    return false;
  }
}
/*class MyDialog extends StatefulWidget{
  @override
  createState() => new MyDialogState();
}
class MyDialogState extends State<MyDialog>{
  List<bool> Checks=[false,false,false,false,false,false];
  List<String> Check_name=["物理","化学","生物","地理","生物","政治"];
  String schoolnamestr="";
  String specialnamestr="";
  String scorestr="";
  String rangestr="";
  @override
  Widget build(BuildContext context){
    return /*Text(newsList.elementAt(0).toString());*/
      new Scaffold(
        backgroundColor: Colors.transparent,
        body:Opacity(opacity: 1,child: new Container(
          //title: new Text('筛选条件'),
          child: new Container(
            child: new Column(
              children: <Widget>[
                //科目复选框
                new Container(
                  child: new Column(
                    textDirection: TextDirection.ltr,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text("科目:"),
                      new Row(
                        children: <Widget>[
                          new Checkbox(
                            materialTapTargetSize:MaterialTapTargetSize.shrinkWrap,
                            value: Checks[0],
                            onChanged: (bool value) {
                              setState(() {
                                Checks[0] = !Checks[0];
                              });
                            },
                          ),
                          new Text("物理"),
                          new Checkbox(
                            materialTapTargetSize:MaterialTapTargetSize.shrinkWrap,
                            value: Checks[1],
                            onChanged: (bool value) {
                              setState(() {
                                Checks[1] = !Checks[1];
                              });
                            },
                          ),
                          new Text("化学"),
                          new Checkbox(
                            materialTapTargetSize:MaterialTapTargetSize.shrinkWrap,
                            value: Checks[2],
                            onChanged: (bool value) {
                              setState(() {
                                Checks[2] = !Checks[2];
                              });
                            },
                          ),
                          new Text("生物"),
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Checkbox(
                            materialTapTargetSize:MaterialTapTargetSize.shrinkWrap,
                            value: Checks[3],
                            onChanged: (bool value) {
                              setState(() {
                                Checks[3] = !Checks[3];
                              });
                            },
                          ),
                          new Text("地理"),
                          new Checkbox(
                            materialTapTargetSize:MaterialTapTargetSize.shrinkWrap,
                            value: Checks[4],
                            onChanged: (bool value) {
                              setState(() {
                                Checks[4] = !Checks[4];
                              });
                            },
                          ),
                          new Text("历史"),
                          new Checkbox(
                            materialTapTargetSize:MaterialTapTargetSize.shrinkWrap,
                            value: Checks[5],
                            onChanged: (bool value) {
                              setState(() {
                                Checks[5] = !Checks[5];
                              });
                            },
                          ),
                          new Text("政治"),
                        ],
                      )
                    ],
                  ),
                ),
                //大学名字输入
                new Container(
                  child: new Row(
                    children: <Widget>[
                      new Text("大学："),
                      new Container(
                        width: 150,
                        child: new TextField(
                          maxLines: 1,
                          maxLength: 10,
                          onChanged: (String value) {
                            setState(() {
                              schoolnamestr = value;
                            });
                          },
                        ),
                      )
                      //new TextField(),
                    ],
                  ),
                ),
                //专业课名字输入
                new Container(
                  child: new Row(
                    children: <Widget>[
                      new Text("专业："),
                      new Container(
                        width: 150,
                        child: new TextField(
                          maxLines: 1,
                          maxLength: 10,
                          onChanged: (String value) {
                            setState(() {
                              specialnamestr = value;
                            });
                          },
                        ),

                      )
                      //new TextField(),
                    ],
                  ),
                ),
                //分数输入
                new Container(
                  child: new Row(
                    children: <Widget>[
                      new Text("分数："),
                      new Container(
                        width: 150,
                        child: new TextField(
                          maxLines: 1,
                          maxLength: 10,
                          onChanged: (String value) {
                            setState(() {
                              if(value==""){
                                scorestr="0";
                              }else{
                                scorestr = value;
                              }
                            });
                          },
                        ),
                      )
                      //new TextField(),
                    ],
                  ),
                ),
                //分差输入
                new Container(
                  child: new Row(
                    children: <Widget>[
                      new Text("分差："),
                      new Container(
                        width: 150,
                        child: new TextField(
                          maxLines: 1,
                          maxLength: 10,
                          onChanged: (String value) {
                            setState(() {
                              if(value==""){
                                rangestr="0";
                              }else{
                                rangestr = value;
                              }

                            });
                          },
                        ),
                      )
                      //new TextField(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          /*actions: <Widget>[
            new FlatButton(
              child: new Text('确定'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  chips_show=[];
                  yaoqiu_id="";
                  for(int i=0;i<Checks.length;i++){
                    if(Checks[i]==true){
                      chips_show.add(['科',Check_name[i]]);
                      yaoqiu_id+="1";
                    }else{yaoqiu_id+="0";}
                  }
                  chips_show.add(['专',specialnamestr]);
                  chips_show.add(['学',schoolnamestr]);
                  chips_show.add(['分',scorestr]);
                  chips_show.add(['差',rangestr]);
                  /*print(chips_show);
                  for (int i = 0; i < chips_show.length; i++) {
                    if (chips_show[i][0] == "专") {
                      specialtyname = chips_show[i][1];
                    }
                    else if (chips_show[i][0] == "学") {
                      schoolname = chips_show[i][1];
                    }
                    else if (chips_show[i][0] == "分") {
                      try {
                        score = int.parse(chips_show[i][1]);
                      } catch (e) {
                        score = 0;
                      }
                    }
                    else if (chips_show[i][0] == "差") {
                      try {
                        range = int.parse(chips_show[i][1]);
                      } catch (e) {
                        range = 0;
                      }
                    }
                  }*/
                  //return major_map_list;
                  List<Map> results = new List();
                  int scoreint=0;
                  int rangeint=0;
                  try{scoreint=int.parse(scorestr);}catch(e){scoreint=0;}
                  try{rangeint=int.parse(rangestr);}catch(e){rangeint=0;}
                  for (int i = 0; i < major_map_list.length; i++) {
                    if (compareSCORE(scoreint, major_map_list[i]['var'], rangeint) &&
                        compareSPECIALTYNAME(
                            specialnamestr, major_map_list[i]['specialtyname']) &&
                        compareYAOQIU(yaoqiu_id, major_map_list[i]['yaoqiu_id']) &&
                        compareSCHOOLNAME(schoolnamestr, major_map_list[i]['schoolname'])) {
                      results.add(major_map_list[i]);
                    }
                  }
                  print(chips_show);
                  print(yaoqiu_id);
                  _suggestions = results;
                  print(_suggestions.length);
                });
              },
            ),
          ],*/
        ),)
      );
  }
  //将字符串转化成二进制数代表的int
  int str2byte(String str){
    int ans=0;
    int k=1;
    for(int i=str.length-1;i>-1;i--,k*=2){
      if(str[i]=="1"){
        ans=ans+k;
      }
    }
    return ans;
  }
  //输入：用户的yaoqiu_id，数据中的id
  bool compareYAOQIU(String user,String data){
    if(user==""||user=="000000")return true;
    bool result=false;
    int userint=str2byte(user);
    int dataint=str2byte(data.substring(1,7));
    if(data[0]=="1"){
      //必选，与之后必须等于原数
      if(dataint<=dataint&userint){
        //成功匹配
        return true;
      }else{
        return false;
      }
    }else if(data[0]=="0"){
      //选至少一项,与之后大于1
      if(dataint&userint>0){
        //成功匹配
        return true;
      }else{
        return false;
      }
    }else{
      //没有要求
      return true;
    }

  }
  bool compareSCHOOLNAME(String user,String data){
    if(user=="")return true;
    int data_len=data.length;
    int user_len=user.length;
    for(int i=0;i<data_len-user_len+1;i++){
      if(user==data.substring(i,user_len+i)){
        return true;
      }
    }
    return false;
  }
  bool compareSPECIALTYNAME(String user,String data){
    if(user=="")return true;
    int data_len=data.length;
    int user_len=user.length;
    for(int i=0;i<data_len-user_len+1;i++){
      if(user==data.substring(i,user_len+i)){
        return true;
      }
    }
    return false;
  }
  bool compareSCORE(int user,String data,int range){
    if(user==0||range==0)return true;
    int dataint=int.parse(data);
    try{
      if(user<=dataint+range&&user>=dataint-range){
        return true;
      }
    }catch(e){
      return false;
    }

    return false;
  }
}*/
/*class MyChip extends StatefulWidget{
  MyChip({Key key, this.bActive: false, this.onChanged}) : super(key: key);
  final bActive;
  final ValueChanged<bool> onChanged;

  void _bActiveChanged() {
    onChanged(!bActive);
  }
  @override
  createState() => new MyChipState();
}
class MyChipState extends State<MyChip>{
  String schoolname="";
  String specialtyname="";
  int times=0;
  int score=0;
  int range=0;
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context){
    setState(() {
      _suggestions=_suggestions;
      chips_show=chips_show;
    });
    return /*Text(newsList.elementAt(0).toString());*/
      new Scaffold(
        body: _buildSuggestions() ,
      );
  }
  Widget _buildSuggestions(){
    return Wrap(

      spacing: 5.0,
      runSpacing: 2.0,
      alignment: WrapAlignment.spaceAround,
      //delegate: TestFlowDelegate(margin: EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 0.0)),
      children: _buildChips(),
      //_buildChips(),
    );
  }
  List<Widget> _buildChips(){
    List<Widget> ChipsList=new List();
    for(int i=0;i<chips_show.length;i++){
      if(chips_show[i][1]!=""){
        ChipsList.add(_buildOneChip(chips_show[i][0],chips_show[i][1]));
      }
    }
    setState(() {
      _suggestions=_suggestions;
      chips_show=chips_show;
    });
    return ChipsList;
    /*new Container(width: chipwidth, height: chipheight, color: Colors.yellow,),
    new Container(width: chipwidth, height: chipheight, color: Colors.green,),
    new Container(width: chipwidth, height: chipheight, color: Colors.red,),
    new Container(width: chipwidth, height: chipheight, color: Colors.black,),
    new Container(width: chipwidth, height: chipheight, color: Colors.blue,),
    new Container(width: chipwidth, height: chipheight, color: Colors.lightGreenAccent,),*/
  }
  Widget _buildOneChip(String name,String value){
    return new Container(
      child: Chip(
        label: Text(value, style: TextStyle(fontSize: 15.0,
            color: Color(0xff333333),
            fontStyle: FontStyle.italic),),
        labelPadding: EdgeInsets.fromLTRB(5,0,5,0),
        avatar: new CircleAvatar(backgroundColor: Colors.blue,child: Text(name),),//Icon(Icons.home, color: Color(0xff00ff00),),
        //删除标签
        //onDeleted: () {
          //ChipDelete(name,value);
        //},
        //deleteIcon: Icon(Icons.close),
        //deleteIconColor: Color(0xffff0000),
        //deleteButtonTooltipMessage: "手下留情",
        backgroundColor: Color(0xfff1f1f1),

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
        ),
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),
    );

  }
  //点击小标签的删除符号
  ChipDelete(String name,String value) async{
    for (int i = 0; i < chips_show.length; i++) {
      if (chips_show[i][0] == name && chips_show[i][1] == value) {chips_show.removeAt(i);break;}
    }
    for (int i = 0; i < chips_show.length; i++) {
      if (chips_show[i][0] == "专") {specialtyname = chips_show[i][1];}
      else if (chips_show[i][0] == "学") {schoolname = chips_show[i][1];}
      else if (chips_show[i][0] == "分") {try {score = int.parse(chips_show[i][1]);} catch (e) {score = 0;}}
      else if (chips_show[i][0] == "差") {try {range = int.parse(chips_show[i][1]);} catch (e) {range = 1;}}
    }
    List<Map> result = new List();
    for (int i = 0; i < major_map_list.length; i++) {
      if (await compareSCORE(score, major_map_list[i]['var'], range) && compareSPECIALTYNAME(specialtyname, major_map_list[i]['specialtyname']) && compareYAOQIU(yaoqiu_id, major_map_list[i]['yaoqiu_id']) && compareSCHOOLNAME(schoolname, major_map_list[i]['schoolname'])) {
        result.add(major_map_list[i]);
      }
    }
    setState(() {
      chips_show=chips_show;
      print(chips_show);
      _suggestions = result;
      print("点击删除小标签后的_suggestions："+_suggestions.length.toString()+"  "+_suggestions[0]['var']);
    });
  }
  //将字符串转化成二进制数代表的int
  int str2byte(String str){
    int ans=0;
    int k=1;
    for(int i=str.length-1;i>-1;i--,k*=2){
      if(str[i]=="1"){
        ans=ans+k;
      }
    }
    return ans;
  }
  //输入：用户的yaoqiu_id，数据中的id
  bool compareYAOQIU(String user,String data){
    if(user==""||user=="000000")return true;
    bool result=false;
    int userint=str2byte(user);
    int dataint=str2byte(data.substring(1,7));
    if(data[0]=="1"){
      //必选，与之后必须等于原数
      if(dataint<=dataint&userint){
        //成功匹配
        return true;
      }else{
        return false;
      }
    }else if(data[0]=="0"){
      //选至少一项,与之后大于1
      if(dataint&userint>0){
        //成功匹配
        return true;
      }else{
        return false;
      }
    }else{
      //没有要求
      return true;
    }

  }
  bool compareSCHOOLNAME(String user,String data){
    if(user=="")return true;
    int data_len=data.length;
    int user_len=user.length;
    for(int i=0;i<data_len-user_len+1;i++){
      if(user==data.substring(i,user_len+i)){
        return true;
      }
    }
    return false;
  }
  bool compareSPECIALTYNAME(String user,String data){
    if(user=="")return true;
    int data_len=data.length;
    int user_len=user.length;
    for(int i=0;i<data_len-user_len+1;i++){
      if(user==data.substring(i,user_len+i)){
        return true;
      }
    }
    return false;
  }
  bool compareSCORE(int user,String data,int range){
    if(user==0||range==0)return true;
    int dataint=int.parse(data);
    try{
      if(user<=dataint+range&&user>=dataint-range){
        return true;
      }
    }catch(e){
      return false;
    }

    return false;
  }
}*/
/*class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.all(0);
  TestFlowDelegate({this.margin});
  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(
                x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        context.paintChild(i,
            transform: new Matrix4.translationValues(
                x, y, 0.0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }
  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}*/
class ResultList extends StatefulWidget {
  @override
  createState() => new ResultListState();
}
class ResultListState extends State<ResultList> {

  String schoolname="";
  //String specialtyname="";
  //int times=0;
  //int score=0;
  //int range=0;

  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: _buildSuggestions(),
    );
  }
  @override
  void initState() {
    init();
    //search();
  }
  Widget _buildSuggestions() {
    if (_suggestions.isEmpty) {
      return new Center(child: new CircularProgressIndicator());
    } else
      return new ListView.builder(
        itemCount: _suggestions.length,
        padding: const EdgeInsets.all(1.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();

          final index = i ~/ 2;
          try{
            return _buildRow(_suggestions[index]);
          }catch(e){
            print(e.toString());
          }
        },
      );
  }

  Widget _buildRow(Map map) {
    //String spname=map['specialtyname'];
    //String yaoqiuname=map['yaoqiu'];
    //if(yaoqiuname.length>15)yaoqiuname=yaoqiuname.substring(0,15)+"...";
    //if(yaoqiuname.length<5)yaoqiuname="不提任何要求";
    //if(spname.length>15)spname=spname.substring(0,15)+"...";
    return new ListTile(
      title: new Container(
        child: _buildColumn(map),
        /*child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                Text(map['colleague']),
              ],
            ),new Row(
              children: <Widget>[
                Text(map['colleaguehref'])
              ],
            ),
            new Row(
              children: <Widget>[
                Text(map['time']),
              ],
            ),
            new Row(
              children: <Widget>[
                Text(map['timehref'])
              ],
            ),

          ],
        ),*/
      ),
    );
  }
  Widget _buildColumn(Map map){
    void clickcolleague(String url,String title)
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return zizhu(url,title);//url: map['colleaguehref']
      }));
    }
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new Card(
          elevation: 10,
          child: new Column(
            children: <Widget>[
              new Container(
                width: MediaQuery.of(context).size.width,
                child: new MaterialButton(
                  onPressed: ()
                  {
                    clickcolleague("http://112.74.39.182:5001/clearColleague?url=http://m"+map['colleaguehref'].split('http://www').elementAt(1),map['colleague']);
                  },
                  child: new Container(
                    width: MediaQuery.of(context).size.width,
                    child: new Text(map['colleague']),
                  ),
                ),
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                child: new MaterialButton(
                  onPressed: ()
                  {
                    clickcolleague("http://112.74.39.182:5001/clearTime?url=http://m"+map['timehref'].split('http://www').elementAt(1),map['colleague']+"——招生时间");
                  },
                  child: new Container(
                    width: MediaQuery.of(context).size.width,
                    child: new Text('招生时间:'+map['time']),
                  ),
                ),
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                child: new MaterialButton(
                  onPressed: ()
                  {
                    clickcolleague("http://112.74.39.182:5001/clearJianzhang?url=http://m"+map['jianzhang'].split('http://www').elementAt(1),map['colleague']+"——招生简章");
                  },
                  child: new Container(
                    width: MediaQuery.of(context).size.width,
                    child: new Text('招生简章'),
                  ),
                ),
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                child: new MaterialButton(
                  onPressed: ()
                  {
                    print("http://112.74.39.182:5001/clearCondition?url=http://m"+map['condition'].split('http://www').elementAt(1));
                    clickcolleague("http://112.74.39.182:5001/clearCondition?url=http://m"+map['condition'].split('http://www').elementAt(1),map['colleague']+"——招生条件");
                  },
                  child: new Container(
                    width: MediaQuery.of(context).size.width,
                    child: new Text('招生条件'),
                  ),
                ),
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                child: new MaterialButton(
                  onPressed: ()
                  {
                    clickcolleague("http://112.74.39.182:5001/clearEntrance?url=http://m"+map['entrance'].split('http://www').elementAt(1),map['colleague']+"——招生入口");
                  },
                  child: new Container(
                    width: MediaQuery.of(context).size.width,
                    child: new Text('入口'),
                  ),
                ),
              ),
              /*new Container(
              width: MediaQuery.of(context).size.width,
              child: new MaterialButton(
                onPressed: ()
                {
                  clickcolleague(map['homepage'],map['colleague']);
                },
                child: new Container(
                  width: MediaQuery.of(context).size.width,
                  child: new Text('主页'),
                ),
              ),
            ),*/
            ],
          ),
        ),

      ],
    );
  }
  Future<String> loadAsset() async {
    return await rootBundle.loadString('data/Zizhuzhaosheng.json');//data/2017allData_haveid.json
  }
  init() async{
    String data=await loadAsset();
    //print(data);
    //var mydate = json.decode(data);
    //print(mydate[0]);
    setState(() {
      var major_str = json.decode(data);
      major_map_list.clear();
      Map<String,Object> map=new Map();
      for(int i=0;i<major_str.length;i++){
        map=major_str[i];
        major_map_list.add(map);
      }
      _suggestions=major_map_list;
      print(_suggestions.length);
    });

  }
  update(){
    setState(() {

    });
  }
//输入：科目id(6位)，学校名，专业名，分数,分数范围
/*Future<List> search () async{
    for(int i=0;i<chips_show.length;i++){
      if(chips_show[i][0]=="专"){
        specialtyname=chips_show[i][1];
      }
      else if(chips_show[i][0]=="学"){
        schoolname=chips_show[i][1];
      }
      else if(chips_show[i][0]=="分"){
        try{
          score=int.parse(chips_show[i][1]);
        }catch(e){
          score=0;
        }
      }
      else if(chips_show[i][0]=="差"){
        try{
          range=int.parse(chips_show[i][1]);
        }catch(e){
          range=1;
        }
      }
    }
    //return major_map_list;
    await init();//读取JSON文件内容
    setState(() {
      print(major_map_list.length);
      List<Map> result=new List();
      for(int i=0;i<major_map_list.length;i++){
        if(compareSCORE(score, major_map_list[i]['var'], range)&&compareSPECIALTYNAME(specialtyname,major_map_list[i]['specialtyname'])&&compareYAOQIU(yaoqiu_id, major_map_list[i]['yaoqiu_id'])&&compareSCHOOLNAME(schoolname,  major_map_list[i]['schoolname'])){
          if(major_map_list[i]['yaoqiu']=="null")major_map_list[i]['yaoqiu']="不提科目要求";

          result.add(major_map_list[i]);
        }
      }
      _suggestions=result;
    });
    print("suggeststions:"+_suggestions.length.toString());
  }
  //将字符串转化成二进制数代表的int
  int str2byte(String str){
    int ans=0;
    int k=1;
    for(int i=str.length-1;i>-1;i--,k*=2){
      if(str[i]=="1"){
        ans=ans+k;
      }
    }
    return ans;
  }
  //输入：用户的yaoqiu_id，数据中的id
  bool compareYAOQIU(String user,String data){
    if(user==""||user=="000000")return true;
    bool result=false;
    int userint=str2byte(user);
    int dataint=str2byte(data.substring(1,7));
    if(data[0]=="1"){
      //必选，与之后必须等于原数
      if(dataint<=dataint&userint){
        //成功匹配
        return true;
      }else{
        return false;
      }
    }else if(data[0]=="0"){
      //选至少一项,与之后大于1
      if(dataint&userint>0){
        //成功匹配
        return true;
      }else{
        return false;
      }
    }else{
      //没有要求
      return true;
    }

  }
  bool compareSCHOOLNAME(String user,String data){
    if(user=="")return true;
    int data_len=data.length;
    int user_len=user.length;
    for(int i=0;i<data_len-user_len+1;i++){
      if(user==data.substring(i,user_len+i)){
        return true;
      }
    }
    return false;
  }
  bool compareSPECIALTYNAME(String user,String data){
    if(user=="")return true;
    int data_len=data.length;
    int user_len=user.length;
    for(int i=0;i<data_len-user_len+1;i++){
      if(user==data.substring(i,user_len+i)){
        return true;
      }
    }
    return false;
  }
  bool compareSCORE(int user,String data,int range){
    if(user==0||range==0)return true;
    int dataint=int.parse(data);
    try{
      if(user<=dataint+range&&user>=dataint-range){
        return true;
      }
    }catch(e){
      return false;
    }

    return false;
  }*/
}