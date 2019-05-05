import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gaokaobang/mainpage.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'tools/SqlHelper.dart';
void main() {
    debugPaintSizeEnabled = false;
    runApp(new MyApp());
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor:Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}
class MyApp extends StatelessWidget {
  /*void sqldemo() async{
    SqlHelper sqlhelper=new SqlHelper();
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    String SqlCreate='CREATE TABLE IF NOT EXISTS Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)';
    await sqlhelper.open(path, SqlCreate);

    String tablename='Test';
    var valuesmap = <String, dynamic>{
      'name': 'hehao',
      'value': 27,
      'num':456.789
    };
    int id=await sqlhelper.insert(tablename,valuesmap);
    print(id);

    String SqlQuery='SELECT * FROM Test WHERE id=$id';
    List<Map> list=await sqlhelper.query(SqlQuery);
    print(list);

    sqlhelper.close();
  }*/
  @override
  Widget build(BuildContext context) {
    //sqldemo();
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

