import 'package:flutter/material.dart';
import 'package:good_book_back/pages/home_page.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadPhotoPage extends StatefulWidget {
  static const String routeName = "/photoUpload";

  @override
  _UploadPhotoPageState createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  File sampleImage;
  String _bookTitle;
  String _bookDesc;
  String _bookWriter;
  String _bookPrice;
  String _bookLocation;

  String url;
  final formKey = GlobalKey<FormState>();

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempImage;
      print('Add image button clicked');
    });
  }

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void uploadStatusImage() async {
    if (validateAndSave()) {
      final StorageReference bookImageRef =
          FirebaseStorage.instance.ref().child('Book Images');
      var timeKey = DateTime.now();
      final StorageUploadTask uploadTask =
          bookImageRef.child(timeKey.toString() + '.jpg').putFile(sampleImage);
      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

      url = imageUrl.toString();

      print('Book Image Url = ' + url);

      goToHomePage();
      saveToDataBase(url);
    }
  }

  void saveToDataBase(url) {
    var dbTimeKey = DateTime.now();
    var formatDate =  DateFormat('MMM d, yyyy');
    var formatTime =  DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    DatabaseReference ref = FirebaseDatabase.instance.reference();

    var data = {
      'Image': url,
      'Title': _bookTitle,
      'Author': _bookWriter,
      'Descriptions': _bookDesc,
      'Price': _bookPrice,
      'Location': _bookLocation,
      "Date": date,
      'Time': time,
    };
    ref.child('Posts').push().set(data);
  }

  void goToHomePage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomePage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PhotoUpload"),
        centerTitle: true,
      ),
      body: Center(
        child: sampleImage == null ? Text('Select an image') : enableUpload(),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 18.0, bottom: 18.0),
        child: FloatingActionButton(
          onPressed: getImage,
          tooltip: 'Add Image',
          child: Icon(Icons.add_a_photo),
        ),
      ),
    );
  }

  Widget enableUpload() {
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Container(
              height: 160, width: 110,
                child: Image.file(
                  sampleImage, 
             )
                ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Book Title',
                    hintText: 'Cad Series : Google Sketchup 3D'),
                validator: (value) =>
                    value.isEmpty ? 'Book Title is required!' : null,
                onSaved: (value) => _bookTitle = value,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'This book is about Sketch 3D'),
                validator: (value) =>
                    value.isEmpty ? 'Description is required!' : null,
                onSaved: (value) => _bookDesc = value,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Writer', hintText: 'John Rambo'),
                validator: (value) =>
                    value.isEmpty ? 'Writer is required!' : null,
                onSaved: (value) => _bookWriter = value,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: TextFormField(
                decoration:
                    InputDecoration(labelText: 'Pirce', hintText: '10 €'),
                validator: (value) =>
                    value.isEmpty ? 'Pirce is required!' : null,
                onSaved: (value) => _bookPrice = value,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Location', hintText: 'London, UK'),
                validator: (value) =>
                    value.isEmpty ? 'Location is required!' : null,
                onSaved: (value) => _bookLocation = value,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: RaisedButton(
                // key: Key('signIn'),
                color: Colors.teal,
                elevation: 7.0,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),

                onPressed: uploadStatusImage,
                child: Center(
                  child: Text(
                    'Add a  Post',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
