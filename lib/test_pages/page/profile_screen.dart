import 'package:flutter/material.dart';
import 'package:good_book_back/card_pages/styles.dart';

class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
 
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
        automaticallyImplyLeading: false, 
        title: Text('Welocme', style: Styles.appBarTiitle,),
        centerTitle: true,
      ),
      body: Container(
        child: Center(child: Text('PROFILE')),
      )
    );
  }



  
}
