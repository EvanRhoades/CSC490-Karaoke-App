import 'package:flutter/material.dart';
import './pages/LoginPage.dart';

// kickstarts app
void main() {
  runApp(new MaterialApp(
    home: new LoginPage(),
    theme: new ThemeData(primarySwatch: Colors.red),
  ));
}
