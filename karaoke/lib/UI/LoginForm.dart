import 'package:flutter/material.dart';

// WIDGET: facilitates form to be used by login page
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// MyCustomForm corresponding class.  This class will hold the data related to
// the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return new Form(
      child: new Theme(
        data: new ThemeData(
          brightness: Brightness.dark,
          inputDecorationTheme: new InputDecorationTheme(
              labelStyle: new TextStyle(color: Colors.white70, fontSize: 20.0)),
        ),
        child: Container(
          padding: const EdgeInsets.all(40.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: "Enter Email",
                ),
                //keyboardType: TextInputType.emailAddress,
                validator: (val) => val.isEmpty? 'Email can\'t be empty.' : null,
                onSaved: (val) => _email = val,
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: "Enter Password",
                ),
                //keyboardType: TextInputType.text,
                obscureText: true,
                validator: (val) => val.isEmpty? 'Password can\'t be empty.' : null,
                onSaved: (val) => _password = val,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: MaterialButton(
                  color: Colors.white70,
                  textColor: Colors.black87,
                  child: new Text("Login"),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, we want to show a Snackbar
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
                    }
                  },
                  splashColor: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
