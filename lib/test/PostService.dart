//import 'package:firebase_course/models/post.dart';
import 'package:firebase_database/firebase_database.dart';


class PostService{
  String nodeName = 'posts';
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;
  Map post;

  PostService(this.post);

  addPost(){
//    this is going to give a reference to the posts node
   database.reference().child(nodeName).push().set(post);
  }

  deletePost(){
    database.reference().child('$nodeName/${post['key']}').remove();
  }

  updatePost(){
    database.reference().child('$nodeName/${post['key']}').update(
      // {"bookTitle": post['bookTitle'], "bookDescr": post['bookDescr'], "date":post['date']}
      {"title": post['title'], "body": post['body'], "date":post['date']}
    );
  }
}