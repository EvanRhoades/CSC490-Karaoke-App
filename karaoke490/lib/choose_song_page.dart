import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'queue_info_page.dart';

class ChooseSongPage extends StatefulWidget {
  @override
  _ChooseSongPageState createState() => new _ChooseSongPageState();
}

class _ChooseSongPageState extends State<ChooseSongPage> {
  void selectMe(int index) {
    globals.selectedSongIndex = index;

    // SEAN: We now have the selected song from the user.  This should be sent back to the server
    // so that it can go in the Queue for the event/DJ.
    // Variable: index (index of both the song and the artist arrays)

    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new QueueInfoPage()));
  }

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width * 0.8;
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Select a song"),
      ),
      backgroundColor: Colors.lightGreen,
      body: new ListView.builder(
        itemCount: globals.djSonglist.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            shape: Border(bottom: BorderSide(color: Colors.red)),
            child: new Container(
              width: cWidth,
              color: Colors.lightGreen,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: new RichText(
                      text: new TextSpan(
                        text: '${globals.djSonglist[index]}',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                          letterSpacing: 1.0,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                  new Icon(Icons.keyboard_arrow_right),
                  new Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                  ),
                  Expanded(
                    child: new RichText(
                      text: new TextSpan(
                        text: '${globals.djArtistlist[index]}',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                          letterSpacing: 1.0,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                  ),
                  new RaisedButton(
                    child: new RichText(
                      text: new TextSpan(
                        text: 'Select',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          letterSpacing: 1.0,
                          height: 1.5,
                        ),
                      ),
                    ),
                    color: Colors.amber,
                    padding: EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 8.0, top: 2.0),
                    onPressed: () => selectMe(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
