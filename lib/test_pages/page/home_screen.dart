import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:good_book_back/data/book_data.dart';
import 'package:good_book_back/pages/detail.dart';
import 'package:good_book_back/services/auth.dart';
import 'package:good_book_back/test_pages/page/pages_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";
  HomeScreen({this.onSignedOut, this.auth});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollViewController;
  AnimationController _animationController;
  List<Posts> postsList = <Posts>[];

  @override
  void initState() {
    super.initState();
    DatabaseReference postRef =
        FirebaseDatabase.instance.reference().child('Posts');
    postRef.once().then((DataSnapshot snap) {
      var bookKeys = snap.value.keys;
      var bookData = snap.value;

      postsList.clear();
      for (var individualKey in bookKeys) {
        Posts posts = Posts(
          bookData[individualKey]['Image'],
          bookData[individualKey]['Title'],
          bookData[individualKey]['Author'],
          bookData[individualKey]['Description'],
          bookData[individualKey]['Price'],
          bookData[individualKey]['Location'],
          bookData[individualKey]['Date'],
          bookData[individualKey]['Time'],
        );
        postsList.add(posts);
      }

      setState(() {
        print('Length : $postsList.length');
      });
    });
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    super.dispose();
  }

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
    _animationController.forward();

    return Scaffold(
        body: NestedScrollView(
      controller: _scrollViewController,
      // animation: _animationController,
      headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white.withOpacity(0.5),
            expandedHeight: 200.0,
//            floating: true,
            pinned: true,
            forceElevated: boxIsScrolled,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: IconButton(
                  icon: Icon(Icons.menu),
                  color: Colors.deepOrangeAccent,
                  onPressed: (){
                  Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => PagesScreen()));
                  }
                ),
              ),
                IconButton(
            padding: EdgeInsets.only(right: 15.0),
            icon: Icon(Icons.power_settings_new),
            iconSize: 40.0,
            onPressed: _signOut,
          ),
            ],
             
        
     
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text('Good Book Back'),
                background: Image.network(
                  "https://www.snapphotography.co.nz/wp-content/uploads/New-Zealand-Landscape-Photography-prints-12.jpg",
                  fit: BoxFit.cover,
                )),
          )
        ];
      },
      body: Container(
        child: Center(
          child: postsList.length == 0
              ? Text(
                  'No Book post are available',
                  style: Theme.of(context).textTheme.title,
                  textAlign: TextAlign.center,
                )
              : ListView.builder(
                  itemCount: postsList.length,
                  itemBuilder: (_, index) {
                    return postUI(
                      postsList[index].image,
                      postsList[index].bookTitle,
                      postsList[index].description,
                      postsList[index].writer,
                      postsList[index].price,
                      postsList[index].location,
                      postsList[index].date,
                      postsList[index].time,
                    );
                  }),
        ),
      ),
    ));
  }

  Widget postUI(
    String image,
    String bookTitle,
    String writer,
    String description,
    String price,
    String location,
    String date,
    String time,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Detail(Posts(image, bookTitle,
                        description, writer, price, location, time, date))));
            print('Card tapped');
          },
          child: Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 60.0),
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 40.0),
                        child: Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              date,
                              style: Theme.of(context).textTheme.subhead,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              time,
                              style: Theme.of(context).textTheme.subhead,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: 300.0,
                        height: 400.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new NetworkImage(image),
                            ),
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 370.0,
                    left: 55.0,
                    child: Container(
                      width: 270.0,
                      height: 90.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 1.0,
                                color: Colors.black12,
                                spreadRadius: 2.0)
                          ]),
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  bookTitle,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat', fontSize: 20.0),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            SizedBox(
                              height: 20.0,
                              child: Text(
                                description,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15.0,
                                  color: Colors.grey,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 240.0,
                    right: 5.0,
                    child: Container(
                      width: 90.0,
                      height: 90.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45.0),
                          color: Colors.deepOrangeAccent,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 1.0,
                                color: Colors.black12,
                                spreadRadius: 2.0)
                          ]),
                      child: Container(
                        padding: EdgeInsets.all(7.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              price + ' KR',
                              style: TextStyle(
                                  fontFamily: 'Montserrat', fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
