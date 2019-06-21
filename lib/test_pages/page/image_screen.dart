import 'package:flutter/material.dart';
import 'package:good_book_back/card_pages/styles.dart';
import 'package:image_picker_ui/image_picker_handler.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import '../bottom_navigation_widget.dart';

class UploadPhotoPage extends StatefulWidget {
  static const String routeName = "/photoUpload";

  @override
  _UploadPhotoPageState createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage>
    with TickerProviderStateMixin, ImagePickerListener {
  AnimationController _animationController;
  ImagePickerHandler imagePicker;
  File sampleImage;
  String _bookTitle;
  String _bookDesc;
  String _bookWriter;
  String _bookPrice;
  String _bookLocation;

  String url;
  final formKey = GlobalKey<FormState>();

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
    var formatDate = new DateFormat('MMM d, yyyy');
    var formatTime = new DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    DatabaseReference ref = FirebaseDatabase.instance.reference();

    var data = {
      'Image': url,
      'Title': _bookTitle,
      'Author': _bookWriter,
      'Description': _bookDesc,
      'Price': _bookPrice,
      'Location': _bookLocation,
      "Date": date,
      'Time': time,
    };
    ref.child('Posts').push().set(data);
  }

  void goToHomePage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BottomNavigationWidget();
    }));
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    imagePicker = ImagePickerHandler(this, _animationController);
    imagePicker.build(0xFFEE6969, 0xFFFFFFFF, false);
  }

  @override
  userImage(File sampleImage) {
    setState(() {
      this.sampleImage = sampleImage;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Add Piccture',
          style: Styles.appBarTiitle,
        ),
             actions: <Widget>[
           new IconButton(
             icon: new Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(null),
           ),
         ],
      ),
      body: GestureDetector(
        onTap: () => imagePicker.showDialog(context),
        child: Center(
            child: sampleImage == null
                ? Stack(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: CircleAvatar(
                              radius: 80.0,
                              backgroundColor: Colors.white70,
                              child: Icon(
                                Icons.add_a_photo,
                                size: 60.0,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 24.0),
                                child: Text(
                                  'Add image by cliking on the camera icon',
                                  style: Styles.headlineDescription,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : enablePhoto()),
      ),
    );
  }

  Widget enablePhoto() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(),
              child: Column(children: <Widget>[
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 300,
                          width: 200,
                          child: Image.file(
                            sampleImage,
                          )),
                      SizedBox(
                        height: 5.0,
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
                        height: 5.0,
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
                        height: 5.0,
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
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Pirce', hintText: '10 €'),
                          validator: (value) =>
                              value.isEmpty ? 'Pirce is required!' : null,
                          onSaved: (value) => _bookPrice = value,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
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
                        height: 25.0,
                      ),
                      Container(
                        height: 44.0,
                        width: 270.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          elevation: 7.0,
                          child: RaisedButton(
                            color: Colors.teal,
                            elevation: 7.0,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            onPressed: uploadStatusImage,
                            child: Center(
                              child: Text(
                                'ADD BOOK',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 45.0,
                      ),
                    ],
                  ),
                ),
              ]))),
    );
  }
}
