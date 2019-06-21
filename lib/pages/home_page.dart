import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:good_book_back/data/book_data.dart';
import 'package:good_book_back/services/auth.dart';
import 'package:good_book_back/styleguide/text_styles.dart';
import 'detail.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home";
  HomePage({this.onSignedOut, this.auth});
  final BaseAuth auth;

  final VoidCallback onSignedOut;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          bookData[individualKey]['Name'],
          bookData[individualKey]['Date'],
          bookData[individualKey]['Time'],
        );
        postsList.add(posts);
      }
      setState(() {
        print('Length : $postsList.length');
      });
    });
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
    return Scaffold(
      backgroundColor: Colors.white70,
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
                       postsList[index].name,
                      postsList[index].date,
                      postsList[index].time,
                    );
                  }),
        ),
      ),
    );
  }

  Widget postUI(
    String image,
    String bookTitle,
    String writer,
    String description,
    String price,
    String location,
    String name,
    String date,
    String time,
  ) {
    return Card(
      elevation: 7.0,
      margin: EdgeInsets.all(15.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Detail(Posts(
                            image,
                            bookTitle,
                            description,
                            writer,
                            price,
                            location,
                            name,
                            time,
                            date))));
                print('Card tapped');
              },
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 10.0),
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
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                          height: 240,
                          width: 180,
                        ),
                      ),
                      Container(
                        height: 50.0,
                        width: 50.0,
                        color: Colors.tealAccent,
                        child: Center(child: Text('$price' + ' KR'),),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    bookTitle,
                    style: headingStyle,
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    'by $writer',
                    style: Theme.of(context).textTheme.subtitle,
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    '$description' + '...',
                    style: Theme.of(context).textTheme.title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                  Text(
                    '$price' + ' kr',
                    style: Theme.of(context).textTheme.title,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    location,
                    style: Theme.of(context).textTheme.title,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  
                ],
              ),
              
            ),
          ],
        ),
        
      ),
    );
  }
}
