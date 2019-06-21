import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:good_book_back/setup/loginpage.dart';
import 'package:good_book_back/setup/registerpage.dart';
import 'package:good_book_back/test_pages/bottom_navigation_widget.dart';
import 'package:good_book_back/test_pages/page/home_screen.dart';
import 'setup/mapping.dart';
import 'services/auth.dart';

Future<void> main() async {
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'db2',
    options: Platform.isIOS
        ? const FirebaseOptions(
            googleAppID: '1:575197193611:ios:b7a49f7be2da9f35',
            gcmSenderID: '575197193611',
            databaseURL: 'https://goodbookback.firebaseio.com',
          )
        : const FirebaseOptions(
            googleAppID: '1:575197193611:android:288dba13c03ef9cc',
            apiKey: 'AIzaSyDSv87zdYE-2-qgdSr_Z73sjkMes1ouE7g',
            databaseURL: 'https://goodbookback.firebaseio.com',
          ),
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
      title: 'Good Book Back',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MappingPage(auth: Auth(),),
      routes: {
        '/homePage':(context)=>BottomNavigationWidget(),
        '/loginPage':(context)=>LoginPage(),
        '/registerPage':(context)=>RegisterPage(),
      },
    ));
}
