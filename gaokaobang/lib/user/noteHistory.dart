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

class noteHistory extends StatefulWidget {
  @override
  createState() => new noteHistoryState();
}
class noteHistoryState extends State<noteHistory> {
  //List<OneNew> newsList = new List();
  List<Map> newsList = new List();
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
    String SqlDeleteAll='Delete * FROM News';
    int count = await sqlhelper.db.delete("News");
    //sqlhelper.close();
    print(count);
    setState(() {
      newsList=newsList.sublist(0);
    });
  }
  @override
  void initlist() async{
    //String SqlQuery='SELECT * FROM News';
    //newsList =await sqlhelper.query(path,SqlQuery);
    //SqlHelper sqlhelper=new SqlHelper();
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'history.db');
    String SqlCreate='CREATE TABLE IF NOT EXISTS News (id INTEGER PRIMARY KEY, url TEXT, title TEXT, date TEXT)';
    await sqlhelper.open(path, SqlCreate);
    String SqlQuery='SELECT * FROM News';
    List<Map> list =await sqlhelper.query(path,SqlQuery);
    //sqlhelper.close();
    setState(() {
      newsList = list;
    });
  }
  @override
  Widget build(BuildContext context) {
    //init();
    initlist();
    //print(newsList.length);
    return /*Text(newsList.elementAt(0).toString());*/
      new Scaffold(
        appBar: new AppBar(
          title: new Text('便签历史纪录'),

          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.delete_outline), onPressed:deleteall),
          ],
          backgroundColor: Color.fromRGBO(0x57, 0xC3, 0xC2, 100),
          elevation: 0,
        ),
        body: _buildSuggestions() ,
      );
  }
  Widget _buildSuggestions() {
    if (newsList.isEmpty) {
      return new Center(child: new Text("暂无浏览记录"));
    } else {
      return new ListView.builder(
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, i) {
          //分割线
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          try{
            OneNew a=OneNew(newsList[newsList.length-index-1]["url"],newsList[newsList.length-index-1]["title"],newsList[newsList.length-index-1]["date"]);
            return _buildRow(a);
          }catch(e){
            return _buildRow(new OneNew("nothing", "XXXXXXXXXXXXXXXXX", " "));
          }
        },
        itemCount: newsList.length+newsList.length,
      );
    }

  }
  Widget _buildRow(OneNew news) {
    return new ListTile(
      title: new Text(
        news.title,
        style: _biggerFont,
      ),
      trailing: new Text(news.date),
      onTap: () {
        setState(
              () {
            clicknews(news);
          },
        );
      },
    );
  }
  void clicknews(OneNew onenew) {
    print(onenew.url);
    Navigator.push(
        this.context,
        new MaterialPageRoute(
            builder: (context) => new NewsWebPage(onenew.url, onenew.title)));
  }
  @override
  void dispose(){
    super.dispose();
    sqlhelper.close();
  }
}
