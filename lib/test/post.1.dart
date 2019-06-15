import 'package:firebase_database/firebase_database.dart';

class Post {
  static const KEY = 'key';
  static const DATE = 'date';
  static const BookImage = 'bookImage';
  static const BookTitle = 'bookTitle';
  static const BookDescr = 'bookDescr';
  static const BookWriter = 'bookWriter';
  static const BookPrice = 'bookPrice';
  static const BookLocation = 'bookLocation';

  int date;
  String key;
  String bookImage;
  String bookTitle;
  String bookDescr;
  String bookWriter;
  String bookPrice;
  String bookLocation;

  Post(this.date, this.bookImage, this.bookTitle, this.bookDescr, this.bookWriter,
      this.bookPrice, this.bookLocation, this.key);

//  String get key  => _key;
//  String get date  => _date;
//  String get title  => _title;
//  String get body  => _body;

  Post.fromSnapshot(DataSnapshot snap)
      : this.key = snap.key,
        this.date = snap.value[DATE],
        this.bookImage = snap.value[BookImage],
        this.bookTitle = snap.value[BookTitle],
        this.bookDescr = snap.value[BookDescr],
        this.bookWriter = snap.value[BookWriter],
        this.bookPrice = snap.value[BookPrice],
        this.bookLocation = snap.value[BookLocation];

  Map toMap() {
    return {
      BookImage: bookImage,
      BookTitle: bookTitle,
      BookDescr: bookDescr,
      BookWriter: bookWriter,
      BookPrice: bookPrice,
      BookLocation: bookLocation,
      DATE: date,
      KEY: key
    };
  }
}