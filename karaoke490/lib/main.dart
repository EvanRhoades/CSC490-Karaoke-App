import 'package:flutter/material.dart';

// simply starts the app
void main() => runApp(new MyApp());

// creates setting / frame of app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: new LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

// this is the landing page to login, with the option to traverse to the create account page
class _LoginPageState extends State<LoginPage> {
  // the purpose of these keys are to reference the corresponding widgets
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  // stores user input for email and password; underscore means private
  String _email;
  String _password;

  // what happens when the user clicks "Login"
  void _submit() {
    // first we grab the formKey as it currently stands
    final form = formKey.currentState;

    // if the input is syntactically valid, we save it
    if (form.validate()) {
      form.save();
      performLogin();
    }
  }
  // if we are good to go, we try to use the user input to login
  void performLogin() {
    final snackbar = new SnackBar(
      content: new Text("Validating..."),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);

    // SEAN: INSERT CODE HERE
    // variables: _email and _password
  }

  // what happens when the user clicks "Create Account"
  // (they are pushed over to the "Create Account" page)
  void _gotoCreate() {
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new CreatePage()));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: new Text("Login"),
      ),
      backgroundColor: Colors.lightGreen,
      body: new ListView(children: <Widget>[
        new Container(
          alignment: Alignment.center,
          child: new RichText(
            text: new TextSpan(
              text: 'Happy Funtime Karaoke',
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.red,
                fontWeight: FontWeight.bold,
                letterSpacing: 3.0,
                height: 4.0,
              ),
            ),
          ),
        ),
        new Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 10.0, left: 40.0, right: 40.0),
          child: new Form(
              key: formKey,
              child: new Column(
                children: <Widget>[
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "Email"),
                    // validates email input; val = user input
                    validator: (val) =>
                    !val.contains('@') ? 'Invalid Email' : null,
                    // assigns user input to appropriate variable
                    onSaved: (val) => _email = val,
                  ),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "Password"),
                    validator: (val) => val.length < 8
                        ? 'Password should be at least 8 characters'
                        : null,
                    onSaved: (val) => _password = val,
                    obscureText: true,
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                  ),
                  new RaisedButton(
                    child: new Text("Login"),
                    color: Colors.amber,
                    onPressed: _submit,
                  )
                ],
              )),
        ),
        new Container(
            alignment: Alignment.center,
            child: new RaisedButton(
              child: new Text("Create Account"),
              color: Colors.red,
              onPressed: _gotoCreate,
            )),
      ]),
    );
  }
}

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => new _CreatePageState();
}

// this is a page that allows the user to create an account
class _CreatePageState extends State<CreatePage> {
  final scaffoldKey2 = new GlobalKey<ScaffoldState>();
  final formKey2 = new GlobalKey<FormState>();

  // stores user input for email and password; underscore means private
  String _emailC;
  String _usernameC;
  String _passwordC;
  String _tempPass; // for comparison to see if the passwords match

  // what will be done when they press "create account"
  void _doThis() {
    // first we grab the formKey as it currently stands
    final form = formKey2.currentState;

    // if the input is syntactically valid, we save it
    if (form.validate()) {
      if (_passwordC != _tempPass) // NEEDS FINISHING; THIS IS NOT AN ACTUAL VALIDATION
        print("passwords do not match");
      form.save();
      createAccount();
    }
  }


  // if we are good to go, we try to use the user input to login
  void createAccount() {
    final snackbar = new SnackBar(
      content: new Text("Validating..."),
    );
    scaffoldKey2.currentState.showSnackBar(snackbar);

    // SEAN: INSERT CODE HERE
    // variables: _emailC and _passwordC
    print("email: $_emailC");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey2,
      appBar: AppBar(
        title: new Text("Create Account"),
      ),
      backgroundColor: Colors.lightGreen,
      body: new ListView(children: <Widget>[
        new Container(
          alignment: Alignment.center,
          child: new RichText(
            text: new TextSpan(
              text: 'Happy Funtime Karaoke',
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.red,
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
                    decoration: new InputDecoration(labelText: "Email"),
                    // validates email input; val = user input
                    validator: (val) =>
                    !val.contains('@') ? 'Invalid Email' : null,
                    // assigns user input to appropriate variable
                    onSaved: (val) => _emailC = val,
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
                    color: Colors.amber,
                    onPressed: _doThis,
                  )
                ],
              )),
        ),
      ]),
    );
  }
}
