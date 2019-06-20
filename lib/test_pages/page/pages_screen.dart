import 'package:flutter/material.dart';

class PagesScreen extends StatefulWidget {

  @override
  _PagesScreenState createState() => _PagesScreenState();
}

class _PagesScreenState extends State<PagesScreen>{


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text("Page Tutorialy", style: new TextStyle(fontSize: 35.0)),
      )
    );
  }
}