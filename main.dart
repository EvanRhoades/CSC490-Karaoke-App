import 'package:flutter/material.dart';

// kickstarts app
void main() {
  runApp(new MyApp());
}

// (FYI: all stateless widgets have a build method)
// WIDGET: LEVEL 1 (TOP) - sets framework for login page and calls it
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new LoginPage(),
        theme: new ThemeData(primarySwatch: Colors.red)
    );
  }
}

// (FYI: all stateful widgets have a createState method)
// WIDGET: Level 2 - facilitates creation of login page
class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

// FUNCTION (to be used by LoginPage widget) - logistics of login page UI
class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage('assets/kar.jpg'),
            fit: BoxFit.cover,
            color: Colors.black54,
            colorBlendMode: BlendMode.darken,
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Form(
                child: new Theme(
                  data: new ThemeData(
                    brightness: Brightness.dark,
                    inputDecorationTheme: new InputDecorationTheme(
                        labelStyle: new TextStyle(
                            color: Colors.white70, fontSize: 20.0)),
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
                          keyboardType: TextInputType.emailAddress,
                        ),
                        new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Enter Password",
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                        ),
                        new MaterialButton(
                          color: Colors.white70,
                          textColor: Colors.black87,
                          child: new Text("Login"),
                          onPressed: () => {},
                          splashColor: Colors.redAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
