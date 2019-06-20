import 'package:good_book_back/data/book_data.dart';
import 'package:flutter/material.dart';


class Detail extends StatelessWidget {
  static const String routeName = "/detail";
  final Posts posts;

  Detail(this.posts);

  @override
  Widget build(BuildContext context) {
    //app bar
    final appBar = AppBar(
      elevation: .5,
      title: Text('${posts.bookTitle}'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        )
      ],
    );

    ///detail of book image and it's pages
    final topLeft = Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Hero(
            
            tag: posts,
            child: Material(
              
              color: Colors.white,
              elevation: 15.0,
              shadowColor: Colors.yellow.shade900,
              child: Image.network('${posts.image}', fit: BoxFit.cover, height: 160, width: 110,),
            ),
          ),
        ),
      ],
    );

    ///detail top right
    final topRight = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
         text('${posts.bookTitle}',
            size: 24, isBold: true, padding: EdgeInsets.only(top: 16.0)),
        text('by ${posts.writer}',
            size: 18, isBold: false, padding: EdgeInsets.only(top: 10.0)),
     
        Row(
          children: <Widget>[
            text(
              '${posts.price}' + ' kr',
              
              size: 18,
              isBold: true,
              padding: EdgeInsets.only(top: 10.0),
            ),
            // RatingBar(rating: posts.rating)
          ],
        ),
        SizedBox(height: 32.0),
        Material(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.teal,
          shadowColor: Colors.blue.shade200,
          elevation: 5.0,
          child: MaterialButton(
            onPressed: () {},
            minWidth: 160.0,
            // color: Colors.blue,
            child: text('BUY IT NOW', color: Colors.white, size: 13),
          ),
        )
      ],
    );

    final topContent = Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(flex: 2, child: topLeft),
          Flexible(flex: 3, child: topRight),
        ],
      ),
    );

    ///scrolling text description
    final bottomContent = Container(
      height: 300.0,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          posts.description,
          style: TextStyle(fontSize: 13.0, height: 1.5),
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }

  ///create text widget
  text(String data,
          {Color color = Colors.black87,
          num size = 14,
          EdgeInsetsGeometry padding = EdgeInsets.zero,
          bool isBold = false}) =>
      Padding(
        padding: padding,
        child: Text(
          data,
          style: TextStyle(
              color: color,
              fontSize: size.toDouble(),
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
      );
}
