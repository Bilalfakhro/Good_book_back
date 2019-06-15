import 'package:flutter/material.dart';
import 'package:good_book_back/test/post.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'PostService.dart';
import 'edit_post.dart';

class PostView extends StatefulWidget {
  final Post post;

  PostView(this.post);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.Title),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    timeago.format(DateTime.fromMillisecondsSinceEpoch(widget.post.date)),
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                ),),
              IconButton(icon: Icon(Icons.delete),
              onPressed: (){
                PostService postService = PostService(widget.post.toMap());
                postService.deletePost();
                Navigator.pop(context);

              },),
              IconButton(icon: Icon(Icons.edit),
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditPost(widget.post)));
                },),
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.post.Descreption),
          ),
        ],
      ),
    );
  }
}
