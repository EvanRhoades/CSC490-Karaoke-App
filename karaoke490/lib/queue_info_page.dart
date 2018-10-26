import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class QueueInfoPage extends StatefulWidget {
  @override
  _QueueInfoPageState createState() => new _QueueInfoPageState();
}

class _QueueInfoPageState extends State<QueueInfoPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Queue Info"),
      ),
      backgroundColor: Colors.lightGreen,
      body: 
      new Text('Your song: ${globals.djSonglist[globals.selectedSongIndex]}'),
    );
  }
}