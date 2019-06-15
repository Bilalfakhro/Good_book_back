import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_book_back/services/auth.dart';
import 'package:good_book_back/services/dialogBox.dart';

// class EmailFieldValidator {
//   static String validate(String value) {
//     return value.isEmpty ? 'Email can\'t be empty' : null;
//   }
// }

// class PasswordFieldValidator {
//   static String validate(String value) {
//     return value.isEmpty ? 'Password can\'t be empty' : null;
//   }
// }

class LoginPage extends StatefulWidget {
  static const String routeName = "/loginpage";

  const LoginPage({this.auth, this.onSignedIn});
  final VoidCallback onSignedIn;
  final BaseAuth auth;

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  DialogBox dialogBox = DialogBox();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = '';
  String _password = '';

  bool validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  Future<void> validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          final String userId = await widget.auth.signIn(_email, _password);
          // dialogBox.information(
          //     context, 'Congratulations', 'your are logged in successfully.');
          print('Signed in user ID: ' + userId);
        } else {
          final String userId = await widget.auth.signUp(_email, _password);
          // dialogBox.information(context, 'Congratulations',
          //     'your account has been created successfully.');
          print('Registered user ID: ' + userId);
        }
        widget.onSignedIn();
      } catch (e) {
        dialogBox.information(context, 'Error = ', e.toString());
        print('Error: ' + e.toString());
      }
    }
  }

  void moveToRegister() {
    // formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: buildLogoType(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: buildInputs() + buildSubmitButtons(),
                ),
              ),
            ),
          ],
        ));
  }

    List<Widget> buildLogoType() {
    if (_formType == FormType.login) {
      return [
        Container(
          padding: EdgeInsets.fromLTRB(15.0, 125.0, 0.0, 0.0),
          child: Text(
            'Login',
            style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(215.0, 125.0, 0.0, 0.0),
          child: Text(
            '.',
            style: TextStyle(
                fontSize: 80.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal),
          ),
        )
      ];
    } else {
      return [
        Container(
          padding: EdgeInsets.fromLTRB(15.0, 125.0, 0.0, 0.0),
          child: Text(
            'Signup',
            style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(260.0, 125.0, 0.0, 0.0),
          child: Text(
            '.',
            style: TextStyle(
                fontSize: 80.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal),
          ),
        )
      ];
    }
  }

  List<Widget> buildInputs() {
    return [
      TextFormField(
        key: Key('email'),
        decoration: InputDecoration(
            labelText: 'EMAIL',
            labelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.grey),
            hintText: 'email@example.com',
            hintStyle: TextStyle(color: Colors.grey),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.teal))),
        validator: (value) => value.isEmpty ? 'Email is required!' : null,
        onSaved: (value) => _email = value,
      ),
      SizedBox(height: 20.0),
      TextFormField(
        key: Key('password'),
        decoration: InputDecoration(
            labelText: 'PASSWORD',
            labelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.grey),
            hintText: '******',
            hintStyle: TextStyle(color: Colors.grey),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.teal))),
        validator: (value) => value.isEmpty ? 'Password is required!' : null,
        onSaved: (value) => _password = value,
        obscureText: true,
      ),
      SizedBox(height: 5.0),
    ];
  }



  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        SizedBox(height: 40.0),
        Container(
          height: 44.0,
          child: Material(
            borderRadius: BorderRadius.circular(20.0),
            elevation: 7.0,
            child: RaisedButton(
              key: Key('signIn'),
              color: Colors.teal,
              elevation: 7.0,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              onPressed: validateAndSubmit,
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
        SizedBox(height: 20.0),
        Container(
          height: 44.0,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black, style: BorderStyle.solid, width: 1.0),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Center(
                //   child:
                //       ImageIcon(AssetImage('assets/facebook.png')),
                // ),
                // SizedBox(width: 10.0),
                Center(
                  child: Text('Log in with Google',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat')),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'New to Good Book Back?  ',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            SizedBox(width: 5.0),
            InkWell(
              onTap: moveToRegister,
              child: Text(
                'Register',
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
    } else {
      return [
        SizedBox(height: 40.0),
        Container(
          height: 44.0,
          child: Material(
            borderRadius: BorderRadius.circular(20.0),
            elevation: 7.0,
            child: RaisedButton(
              color: Colors.teal,
              elevation: 7.0,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              onPressed: validateAndSubmit,
              child: Center(
                child: Text(
                  'SIGN UP',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20.0),
        Container(
          height: 44.0,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black, style: BorderStyle.solid, width: 1.0),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Center(
                //   child:
                //       ImageIcon(AssetImage('assets/facebook.png')),
                // ),
                // SizedBox(width: 10.0),
                Center(
                  child: Text(' Sign up with Google',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat')),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Have an account?  ',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            SizedBox(width: 5.0),
            InkWell(
              onTap: moveToLogin,
              child: Text(
                'Login',
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
}
