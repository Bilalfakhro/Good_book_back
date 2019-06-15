import 'package:firebase_database/firebase_database.dart';

class Post {
  static const KEY = 'key';
  static const DATE = 'date';
  static const BookImage = 'bookImage';
  static const BookTitle = 'Title';
  static const BookDescr = 'Descreption';
  static const BookWriter = 'Writer';
  static const BookPrice = 'Price';
  static const BookLocation = 'Location';

  int date;
  String key;
  String bookImage;
  String Title;
  String Descreption;
  String Writer;
  String Price;
  String Location;

  Post(this.date, this.bookImage, this.Title, this.Descreption, this.Writer,
      this.Price, this.Location, this.key);

  Post.fromSnapshot(DataSnapshot snap)
      : this.key = snap.key,
        this.date = snap.value[DATE],
        this.bookImage = snap.value[BookImage],
        this.Title = snap.value[BookTitle],
        this.Descreption = snap.value[BookDescr],
        this.Writer = snap.value[BookWriter],
        this.Price = snap.value[BookPrice],
        this.Location = snap.value[BookLocation];

  Map toMap() {
    return {
      BookImage: bookImage,
      BookTitle: Title,
      BookDescr: Descreption,
      BookWriter: Writer,
      BookPrice: Price,
      BookLocation: Location,
      DATE: date,
      KEY: key
    };
  }
}