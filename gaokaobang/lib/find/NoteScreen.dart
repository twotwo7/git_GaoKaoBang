import 'package:flutter/material.dart';

class NoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('高考须知'),
        backgroundColor: Colors.brown,
      ),
      body: new Center(
        child: new RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text('返回'),
        ),
      ),
    );
  }
}