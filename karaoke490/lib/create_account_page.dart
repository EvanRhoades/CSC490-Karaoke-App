import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'login_page.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => new _CreatePageState();
}

// this is a page that allows the user to create an account
class _CreatePageState extends State<CreatePage> {
  final scaffoldKey2 = new GlobalKey<ScaffoldState>();
  final formKey2 = new GlobalKey<FormState>();
  final snackbar2 = new SnackBar(
    content: new Text("Account Creation Failed"),
  );

  // stores user input for email and password; underscore means private
  String _emailC;
  String _usernameC;
  String _passwordC;
  String _fName;
  String _lName;
  String _tempPass; // for comparison to see if the passwords match

  // what will be done when they press "create account"
  void _doThis() {
    // first we grab the formKey as it currently stands
    final form = formKey2.currentState;

    // if the input is syntactically valid, we save it
    if (form.validate() && _passwordC == _tempPass) {
      form.save();
      createAccount();
    }
    else
      print("Passwords do not match.");
  }

  // if we are good to go, we try to use the user input to login
  void createAccount() {
    final snackbar = new SnackBar(
      content: new Text("Validating..."),
    );
    scaffoldKey2.currentState.showSnackBar(snackbar);

    // variables: _emailC, _passwordC, _fName, _lName, and _usernameC
    var url = "http://ec2-18-206-245-108.compute-1.amazonaws.com:3000/userList/";
    http.post(url, body: {"email":_emailC,"username":_usernameC, "firstName":_fName,"lastName":_lName,"password":_passwordC,"dj_id":"0"}).then((response){
      if(response.statusCode == 201)
      {
        // enter command to return to log in screen here
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new LoginPage()));
      }
      // tell user that account creation has failed
      else
      {
        scaffoldKey2.currentState.showSnackBar(snackbar2);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey2,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: new Text("Create Account"),
      ),
      backgroundColor: Colors.white,
      // widget that contains pretty much everything on this page
      body: new ListView(children: <Widget>[
        new Container(
          alignment: Alignment.center,
          child: new RichText(
            text: new TextSpan(
              text: 'Happy Funtime Karaoke',
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
                letterSpacing: 3.0,
                height: 4.0,
              ),
            ),
          ),
        ),
        new Text(
          "All fields must be entered.",
          textAlign: TextAlign.center,
        ),
        new Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 10.0, left: 40.0, right: 40.0),
          child: new Form(
              key: formKey2,
              child: new Column(
                children: <Widget>[
                  new TextFormField(
                    style: TextStyle(color: Colors.black),
                    decoration: new InputDecoration(labelText: "Email"),
                    // validates email input; val = user input
                    validator: (val) =>
                    !val.contains('@') ? 'Invalid Email' : null,
                    // assigns user input to appropriate variable
                    onSaved: (val) => _emailC = val,
                  ),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "First Name"),
                    // validates email input; val = user input
                    validator: (val) => val.length < 2
                        ? 'First name should be at least 4 characters'
                        : null,
                    // assigns user input to appropriate variable
                    onSaved: (val) => _fName = val,
                  ),
                  new TextFormField(

                    decoration: new InputDecoration(labelText: "Last Name"),
                    // validates email input; val = user input
                    validator: (val) => val.length < 2
                        ? 'Last name should be at least 2 characters'
                        : null,
                    // assigns user input to appropriate variable
                    onSaved: (val) => _lName = val,
                  ),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "Username"),
                    // validates email input; val = user input
                    validator: (val) => val.length < 4
                        ? 'Username should be at least 4 characters'
                        : null,
                    // assigns user input to appropriate variable
                    onSaved: (val) => _usernameC = val,
                  ),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "Password"),
                    validator: (val) => val.length < 8
                        ? 'Password should be at least 8 characters'
                        : null,
                    onSaved: (val) => _passwordC = val,
                    obscureText: true,
                  ),
                  new TextFormField(
                    decoration:
                    new InputDecoration(labelText: "Confirm Password"),
                    validator: (val) => val.length < 8
                        ? 'Password should be at least 8 characters'
                        : null,
                    onSaved: (val) => _tempPass = val,
                    obscureText: true,
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                  ),
                  new RaisedButton(
                    child: new Text("Create Account"),
                    color: Colors.cyan,
                    onPressed: _doThis,
                  )
                ],
              )),
        ),
      ]),
    );
  }
}