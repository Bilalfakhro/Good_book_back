import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'loginpage.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = "/registerPage";

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isdisabled = false;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseAuth mauth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.reference().child('users');

  void signup() {
    isdisabled = true;
    String namedata = name.text;
    String emaildata = email.text;
    String passworddata = password.text;

    mauth
        .createUserWithEmailAndPassword(
      email: emaildata,
      password: passworddata,
    )
        .then((FirebaseUser user) {
      ref.child("users2").child(user.uid).set({
        'key': ref.key,
        'name': namedata,
        'email': emaildata,
        'password': passworddata,
      });
      ref.push().set({
        'key': ref.key,
        'name': namedata,
        'email': emaildata,
        'password': passworddata,
      });

      Navigator.pushNamed(context, '/homePage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: buildLogoInput(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Form(
                child: Column(
                  children: buildTextFieldInput() +
                      buildLoginButtonInput() +
                      buildRegisterButtonInput(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildLogoInput() {
    return [
      Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                    child: Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 70.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(265.0, 43.0, 0.0, 0.0),
                    child: Text(
                      '.',
                      style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> buildTextFieldInput() {
    return [
      Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: TextField(
          controller: name,
          decoration: InputDecoration(
            icon: Icon(Icons.person),
            labelText: "Name",
            hintText: "Name",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 10.0,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: TextField(
          controller: email,
          decoration: InputDecoration(
            icon: Icon(Icons.person),
            labelText: "Email",
            hintText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 10.0,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: TextField(
          controller: password,
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(Icons.lock),
            labelText: "Password",
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 25.0,
      ),
    ];
  }

  List<Widget> buildLoginButtonInput() {
    return [
      Padding(
        padding: const EdgeInsets.only(left: 50.0, right: 15.0),
        child: Container(
          height: 50.0,
          child: Material(
            borderRadius: BorderRadius.circular(25.0),
            elevation: 7.0,
            child: RaisedButton(
              color: Colors.teal,
              elevation: 7.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              onPressed: signup,
              child: Center(
                child: Text(
                  'SIGN IN',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
              ),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 25.0,
      ),
    ];
  }

  List<Widget> buildRegisterButtonInput() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'You have an account?  ',
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
          SizedBox(width: 5.0),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/loginPage');
            },
            child: Text(
              'LOGIN',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.teal,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
          )
        ],
      ),
    ];
  }
}
