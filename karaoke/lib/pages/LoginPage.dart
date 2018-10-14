import 'package:flutter/material.dart';
import '../UI/LoginForm.dart';

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
              MyCustomForm(),
            ],
          )
        ],
      ),
    );
  }
}