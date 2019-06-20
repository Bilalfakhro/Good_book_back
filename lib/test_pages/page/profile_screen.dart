import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
 
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
        title: Text('Welocme'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(child: Text('PROFILE')),
      )
    );
  }



  
}
