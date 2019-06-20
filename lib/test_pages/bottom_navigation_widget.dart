import 'package:flutter/material.dart';
import 'package:good_book_back/services/auth.dart';
import 'package:good_book_back/test_pages/page/profile_screen.dart';
import 'page/image_screen.dart';
import 'page/home_screen.dart';

class BottomNavigationWidget extends StatefulWidget {
  BottomNavigationWidget({this.onSignedOut, this.auth});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  State<StatefulWidget> createState() => BottomNavigationWidgetState();
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final _bottomNavigationColor = Colors.deepOrangeAccent;
  int _currentIndex = 0;
  List<Widget> list = List();

  @override
  void initState() {
    list
      ..add(HomeScreen())
      // ..add(UploadPhotoPage())
      // ..add(PagesScreen())
      ..add(ProfileScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _bottomNavigationColor,
              ),
              title: Text(
                'HOME',
                style: TextStyle(color: _bottomNavigationColor),
              )),
          // BottomNavigationBarItem(
          //     icon: Icon(
          //       Icons.add_a_photo,
          //       color: _bottomNavigationColor,
          //     ),
          //     title: Text(
          //       'Add Photo',
          //       style: TextStyle(color: _bottomNavigationColor),
          //     )),

          // BottomNavigationBarItem(
          //     icon: Icon(
          //       Icons.pages,
          //       color: _bottomNavigationColor,
          //     ),
          //     title: Text(
          //       'PAGES',
          //       style: TextStyle(color: _bottomNavigationColor),
          //     )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _bottomNavigationColor,
              ),
              title: Text(
                'PROFILE',
                style: TextStyle(color: _bottomNavigationColor),
              )),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.shifting,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return UploadPhotoPage();
          }));
        },
        tooltip: 'Add Image',
        child: Icon(
          Icons.add_a_photo,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
