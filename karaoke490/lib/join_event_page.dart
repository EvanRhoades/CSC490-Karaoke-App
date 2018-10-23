import 'package:flutter/material.dart';

class JoinEventPage extends StatefulWidget {
  @override
  _JoinEventPageState createState() => new _JoinEventPageState();
}

class _JoinEventPageState extends State<JoinEventPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Join Event"),
      ),
    );
  }
}