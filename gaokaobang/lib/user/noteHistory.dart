import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';
//import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:gaokaobang/tools/tools.dart';
import 'package:http/http.dart' as http;
import 'package:gbk2utf8/gbk2utf8.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:gaokaobang/news/newslist.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:gaokaobang/tools/SqlHelper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class noteHistory extends StatefulWidget {
  @override
  createState() => new noteHistoryState();
}
class noteHistoryState extends State<noteHistory> {
  //List<OneNew> newsList = new List();
  List<Map> noteList = new List();
  SqlHelper sqlhelper=new SqlHelper();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  bool isReadyDownLoad=true;
  @override
  void deleteall() async{
    //SqlHelper sqlhelper=new SqlHelper();
    //var databasesPath = await getDatabasesPath();
    //String path = join(databasesPath, 'history.db');
    //String SqlCreate='CREATE TABLE IF NOT EXISTS News (id INTEGER PRIMARY KEY, url TEXT, title TEXT, date TEXT)';
   // await sqlhelper.open(path, SqlCreate);
    String SqlDeleteAll='Delete * FROM Note';
    int count = await sqlhelper.db.delete("Note");
    //sqlhelper.close();
    print(count);
    setState(() {

      noteList=noteList.sublist(0);
    });
  }
  @override
  void initlist() async{
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'Note1.db');
    String SqlCreate='CREATE TABLE IF NOT EXISTS Note (id INTEGER PRIMARY KEY, text TEXT, date TEXT)';
    await sqlhelper.open(path, SqlCreate);
    String SqlQuery='SELECT * FROM Note';
    List<Map> list =await sqlhelper.query(path,SqlQuery);
    //sqlhelper.close();
    setState(() {
      noteList = list;
    });
  }
  String s1;
  void deletenode(int id,int index) async{
    //String SqlQuery='SELECT * FROM News';
    //newsList =await sqlhelper.query(path,SqlQuery);
    //SqlHelper sqlhelper=new SqlHelper();

    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'Note1.db');
    String SqlCreate='CREATE TABLE IF NOT EXISTS Note (id INTEGER PRIMARY KEY, text TEXT, date TEXT)';
    await sqlhelper.open(path, SqlCreate);String SqlQuery='SELECT * FROM Note';

    String SqlDelete='Delete FROM Note WHERE id=$id';
    await sqlhelper.query(path,SqlDelete);
    //List<Map> list =await sqlhelper.query(path,SqlQuery);
    List<Map> list =await sqlhelper.query(path,SqlQuery);
    //sqlhelper.close();
    setState(() {
      noteList = list;
    });
  }
  @override
  Widget build(BuildContext context) {

    initlist();

    return
      new Scaffold(
        appBar: new AppBar(
          title: new Text('便签历史纪录'),

          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.delete_outline),
                onPressed: () {
                  showDialog<Null>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return new AlertDialog(
                        title: new Text('确认删除所有便签吗？'),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text('取消'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          new FlatButton(
                            child: new Text('确定'),
                            onPressed: () {
                              deleteall();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  ).then((val) {
                    print(val);
                  });
                }),
          ],
          backgroundColor: Color.fromRGBO(0x57, 0xC3, 0xC2, 100),
          elevation: 0,
        ),
        body: _buildSuggestions() ,
      );
  }
  Widget _buildSuggestions() {
    if (noteList.isEmpty) {
      return new Center(child: new Text("暂无便签记录"));
    } else {
      return new ListView.builder(

        padding: const EdgeInsets.all(0),
        itemBuilder: (context, i) {

          //分割线
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          try{

            OneNote a=OneNote(noteList[noteList.length-index-1]["id"],noteList[noteList.length-index-1]["text"],noteList[noteList.length-index-1]["data"]);
            return _buildRow(a,context,index);
          }catch(e){
            return _buildRow(new OneNote(-1,"XXXXXXXXXXXXXXXXX", " "),context,i);
          }
        },
        itemCount: noteList.length+noteList.length,
      );
    }

  }
  Widget _buildRow(OneNote note,BuildContext context,int index) {
    return new ListTile(
        title: new Text(
          note.text,
          style: _biggerFont,
        ),
        trailing: new Container(
          margin: EdgeInsets.all(0),
          child: new Row(
            mainAxisSize:MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //date
              new Container(
                margin: EdgeInsets.all(0),
                child: new Text(
                note.date,
                style: new TextStyle(
                  height: 0.5,
                  color: Colors.grey[500],
                ),
              ),),
              new Container(
                margin: EdgeInsets.all(0),
                child: new IconButton(
                    icon: new Icon(Icons.delete_forever , color: Colors.red ,),
                    onPressed: () {
                      showDialog<Null>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return new AlertDialog(
                            title: new Text('确认删除这条便签吗？'),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text('取消'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              new FlatButton(
                                child: new Text('确定'),
                                onPressed: () {
                                  deletenode(note.id,index);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      ).then((val) {
                        print(val);
                      });
                    }
                ),
              ),
            ],
          ),)


    );
  }
  void clickNote(OneNote onenote) {
    Navigator.push(
        this.context,
        new MaterialPageRoute(
            builder: (context) => new NewsWebPage(onenote.text, onenote.date)));
  }
  @override
  void dispose(){
    super.dispose();
    sqlhelper.close();
  }
}
