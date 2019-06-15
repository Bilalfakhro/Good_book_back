import 'package:flutter/material.dart';
import 'package:good_book_back/services/auth.dart';
import 'package:good_book_back/test/post.dart';
import 'package:good_book_back/test/viewPost.dart';
import 'add_post.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomePage extends StatefulWidget {
  HomePage({this.onSignedOut, this.auth});
  final BaseAuth auth;

  final VoidCallback onSignedOut;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "posts";
  List<Post> postsList = <Post>[];

  @override
  void initState() {
    _database.reference().child(nodeName).onChildAdded.listen(_childAdded);
    _database.reference().child(nodeName).onChildRemoved.listen(_childRemoves);
    _database.reference().child(nodeName).onChildChanged.listen(_childChanged);
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
      backgroundColor: Theme.of(context).primaryColor,
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
        color: Colors.black87,
        child: Column(
          children: <Widget>[
            Visibility(
              visible: postsList.isEmpty,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: postsList.isNotEmpty,
              child: Flexible(
                  child: FirebaseAnimatedList(
                      query: _database.reference().child('posts'),
                      itemBuilder: (_, DataSnapshot snap,
                          Animation<double> animation, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 7.0,
                            margin: EdgeInsets.all(15.0),
                            child: Container(
                              padding: EdgeInsets.all(14.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PostView(postsList[index])));
                                      print('Card tapped');
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      // Text(
                                      //   timeago.format(
                                      //       DateTime.fromMillisecondsSinceEpoch(
                                      //           postsList[index].date)),
                                      //   style: TextStyle(
                                      //       fontSize: 14.0, color: Colors.grey),
                                      // ),
                                      //     Text(
                                      //       date,
                                      //       style: Theme.of(context).textTheme.subhead,
                                      //       textAlign: TextAlign.center,
                                      //     ),
                                      //     Text(
                                      //       time,
                                      //       style: Theme.of(context).textTheme.subhead,
                                      //       textAlign: TextAlign.center,
                                      //     ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  // Image.network(postsList[index].bookImage,
                                  //     fit: BoxFit.cover),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    postsList[index].Title,
                                    style: Theme.of(context).textTheme.title,
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    postsList[index].Descreption,
                                    style: Theme.of(context).textTheme.title,
                                    textAlign: TextAlign.center,
                                  ),
                                  // Text(
                                  //   postsList[index].Writer,
                                  //   style: Theme.of(context).textTheme.subtitle,
                                  //   textAlign: TextAlign.start,
                                  // ),
                                  // Text(
                                  //   postsList[index].Price,
                                  //   style: Theme.of(context).textTheme.title,
                                  //   textAlign: TextAlign.center,
                                  // ),
                                  // Text(
                                  //   postsList[index].Location,
                                  //   style: Theme.of(context).textTheme.title,
                                  //   textAlign: TextAlign.center,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPost()));
        },
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        tooltip: "add a post",
      ),
    );
  }

  _childAdded(Event event) {
    setState(() {
      postsList.add(Post.fromSnapshot(event.snapshot));
    });
  }

  void _childRemoves(Event event) {
    var deletedPost = postsList.singleWhere((post) {
      return post.key == event.snapshot.key;
    });

    setState(() {
      postsList.removeAt(postsList.indexOf(deletedPost));
    });
  }

  void _childChanged(Event event) {
    var changedPost = postsList.singleWhere((post) {
      return post.key == event.snapshot.key;
    });

    setState(() {
      postsList[postsList.indexOf(changedPost)] =
          Post.fromSnapshot(event.snapshot);
    });
  }
}
