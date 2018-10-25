import 'package:flutter/material.dart';

class ChooseSongPage extends StatefulWidget {
  @override
  _ChooseSongPageState createState() => new _ChooseSongPageState();
}

class _ChooseSongPageState extends State<ChooseSongPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Join Event"),
      ),
    );
  }
}