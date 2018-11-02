import 'package:flutter/material.dart';
import 'create_account_page.dart';
import 'join_or_create.dart';

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
  bool _validated = false;

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

    /* SEAN: INSERT CODE HERE
       Two things:
        1. if the validation is successful, change _validated to true
        2. email will be used for logging in, but I will be using their username
           to display within the app (and its what other participants will see).
           Point being, I will need a way to access their username, so maybe you
           can just return the username once you finish the validation.
       variables: _email, _password, _validated */

    // DELETE IN THE FUTURE
    // (the following line of code is for my own testing purposes)
    _validated = true;

    if (_validated)
      Navigator.push(context, new MaterialPageRoute(builder: (context) => new JoinOrCreatePage()));
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
        centerTitle: true,
        title: new Text("Login"),
      ),
      backgroundColor: Colors.green[200],
      body: new ListView(children: <Widget>[
        new Container(
          alignment: Alignment.center,
          child: new RichText(
            text: new TextSpan(
              text: 'Happy Funtime Karaoke',
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.red[900],
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
              color: Colors.red[900],
              onPressed: _gotoCreate,
            )),
      ]),
    );
  }
}