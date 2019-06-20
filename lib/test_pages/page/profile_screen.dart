import 'package:flutter/material.dart';
import 'package:good_book_back/services/auth.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({this.onSignedOut, this.auth});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
 
   void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
        title: Text('Welocme'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 15.0),
            icon: Icon(Icons.power_settings_new),
            iconSize: 40.0,
            onPressed: () => _signOut(),
          ),
        ],
      ),
      body: Container(
        child: Center(child: Text('PROFILE')),
      )
    );
  }



  
}
