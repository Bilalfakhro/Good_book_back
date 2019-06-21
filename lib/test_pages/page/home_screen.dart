import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:good_book_back/card_pages/styles.dart';
import 'package:good_book_back/data/book_data.dart';
import 'package:good_book_back/pages/detail.dart';
import 'package:good_book_back/services/auth.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  HomeScreen({this.onSignedOut, this.auth});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  int id = 0;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollViewController;
  AnimationController _animationController;
  List<Posts> postsList = <Posts>[];
  var title = ' ';

  Drawer _buildDrawer(context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Container(
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: new BorderRadius.circular(50.0),
                    child: Image.asset(
                      'assets/StoryOfMe.jpg',
                      height: 100.0,
                      width: 100.0,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Your Name',
                    style: Styles.activeSeasonText,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://img00.deviantart.net/35f0/i/2015/018/2/6/low_poly_landscape__the_river_cut_by_bv_designs-d8eib00.jpg"),
                    fit: BoxFit.fill)),
          ),
          CustomListTitle(Icons.home, 'Home', () => {}),
          CustomListTitle(Icons.person, 'Profile', () => {}),
          Divider(),
          CustomListTitle(Icons.cancel, 'Cancel', () => {}),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: InkWell(
              splashColor: Colors.deepOrangeAccent,
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, '/loginPage');
              },
              child: Container(
                height: 44.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.lock),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Log Out',
                            style: Styles.subMenuText,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_right),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

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

  // void _signOut() async {
  //   try {
  //     await widget.auth.signOut();
  //     widget.onSignedOut();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white.withOpacity(0.5),
              expandedHeight: 200.0,
//            floating: true,
              pinned: true,
              forceElevated: boxIsScrolled,
              flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'Good Book Back',
                    style: Styles.appBarTiitle,
                  ),
                  centerTitle: true,
                  background: Image.network(
                    "https://www.snapphotography.co.nz/wp-content/uploads/New-Zealand-Landscape-Photography-prints-12.jpg",
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Container(
          child: Center(
            child: postsList.length == 0
                ? Text(
                    'No Book post are available',
                    style: Styles.headlineName,
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
      ),
      drawer: _buildDrawer(context),
    );
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
                        padding: const EdgeInsets.only(left: 35.0, right: 45.0),
                        child: Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              date,
                              style: Styles.headlineDescription,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              time,
                              style: Styles.headlineDescription,
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
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(image),
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
                                  style: Styles.titleText,
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            SizedBox(
                              height: 20.0,
                              child: Text(
                                description,
                                style: Styles.descriptionText,
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
                              style: Styles.priceText,
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

class CustomListTitle extends StatelessWidget {
  IconData icons;
  String text;
  Function onTap;

  CustomListTitle(this.icons, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: InkWell(
        splashColor: Colors.deepOrangeAccent,
        onTap: () => {},
        child: Container(
          height: 44.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(icons),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      text,
                      style: Styles.subMenuText,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_right),
            ],
          ),
        ),
      ),
    );
  }
}
