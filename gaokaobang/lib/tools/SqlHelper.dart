import 'package:sqflite/sqflite.dart';
/*
* 使用方法具体参考main.dart中的sqldemo
*
* 增加其他方法可以参考https://pub.dartlang.org/packages/sqflite#-readme-tab-
* */
class SqlHelper{
  Database db;
  /*
  //使用的时候记得在函数前加上await
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'demo.db');
  SqlCreate='CREATE TABLE IF NOT EXISTS Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)';
  */
  Future open(String path,String SqlCreate) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(SqlCreate);
        });
  }

/*Future create(String path,String SqlCreate) async{
    db = await openDatabase(path);
    await db.execute(SqlCreate);
    db.close();
  }

  String tablename='Test';
   var valuesmap = <String, dynamic>{
      'name': 'hehao',
      'value': 27,
      'num':456.789
    };
  * */
  Future<int> insert(String path,String tablename,Map<String,dynamic> valuesmap) async {
    String url = valuesmap["url"];
    String SqlDelete = "DELETE FROM $tablename WHERE url = ?";
    int count = await db.rawDelete(SqlDelete, ['$url']);
    print(count);
    int id=-1;
    if(db==null)return id;
    id=await db.insert(tablename, valuesmap);
    return id;
  }

  /*
  * SqlQuery='SELECT * FROM Test';
  * */
  Future<List> query(String path,String SqlQuery) async{
    List<Map> list = await db.rawQuery(SqlQuery);
    return list;
  }

  Future close() async => db.close();
}