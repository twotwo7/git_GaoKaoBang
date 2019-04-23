import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
class NoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '高考须知'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final str="                                                               ";
  var vlist = new List<bool>();
  String data;
  void onButton(int index) {
    setState(() {
      this.vlist[index]=!this.vlist[index];
    });
  }
  Future<String> loadAsset() async {
    return await rootBundle.loadString('data/gaoKaoXuZhi.json');
  }
  //List data;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: FutureBuilder(
          future: DefaultAssetBundle.
          of(context).
          loadString('data/gaoKaoXuZhi.json'),
          builder: (context,snapshot){
            // ignore: deprecated_member_use
            var mydata = json.decode(snapshot.data.toString());
            //print(snapshot.data.toString());
            return ListView.builder(
              itemBuilder: (BuildContext context,int index){
                return Container(
                  child: _buildColumn(mydata[index]["name"],mydata[index]["text"],index),
                );
              },
              itemCount: mydata == null ? 0 : mydata.length,
            );
          },
        ),
      ),
    );
  }

  Widget _buildColumn(String name,String text,int index)
  {
    this.vlist.add(true);
    bool isOff = false;
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Container(
              width: MediaQuery.of(context).size.width,
              child: new MaterialButton(
                onPressed: () {
                  //Navigator.pop(context);
                  //onButton(index);
                  onButton(index);
                },
                child: new Container(
                  width: MediaQuery.of(context).size.width,
                  child: new Text(name+str),
                ),
                //borderSide:new BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
        new Row(
          children: <Widget>[
            new Container(
              margin: EdgeInsets.only(top: 0.0),
              child: Offstage(
                offstage: this.vlist[index],
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(text,
                    softWrap: true,
                  ),
                ),
              ),
            ),
          ],
        ),
        new Divider(),
      ],
    );
  }
}