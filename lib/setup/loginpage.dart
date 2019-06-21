import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'registerpage.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/loginPage";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String text = "Login";
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  FirebaseAuth mauth = FirebaseAuth.instance;
  signin() async {
    String Email = email.text;
    String Password = password.text;

    await mauth
        .signInWithEmailAndPassword(
      email: Email,
      password: Password,
    )
        .then((FirebaseUser user) {
      setState(() {
        text = "Please Wait..";
      });
      Navigator.pushNamed(context, '/homePage');
    }).catchError((e) => print(e));
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
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
                    padding: EdgeInsets.fromLTRB(15.0, 50.0, 0.0, 0.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(220.0, 50.0, 0.0, 0.0),
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
              onPressed: signin,
              child: Center(
                child: Text(
                  'LOGIN',
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
            'New to Good Book Back?  ',
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
          SizedBox(width: 5.0),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/registerPage');
            },
            child: Text(
              'REGISTER',
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
