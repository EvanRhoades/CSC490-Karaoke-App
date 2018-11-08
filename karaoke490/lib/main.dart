import 'package:flutter/material.dart';
import 'login_page.dart';
import 'globals.dart' as globals;

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