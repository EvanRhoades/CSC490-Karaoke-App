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

  Widget appBarTitle = new Text("Select a song");
  Icon actionIcon = new Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    // to help with text wrapping if the song title is too long
    double cWidth = MediaQuery.of(context).size.width * 0.8;

    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBarTitle,
          actions: <Widget>[ // this is where the search function will go
            new IconButton(icon: actionIcon,onPressed:(){
              setState(() {
                if ( this.actionIcon.icon == Icons.search){
                  this.actionIcon = new Icon(Icons.close);
                  this.appBarTitle = new TextField(
                    style: new TextStyle(
                      color: Colors.black,

                    ),
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search,color: Colors.black),
                        hintText: "Enter Search Here",
                        hintStyle: new TextStyle(color: Colors.black)
                    ),
                  );}
                else {
                  this.actionIcon = new Icon(Icons.search);
                  this.appBarTitle = new Text("Select a song");
                }


              });
            } ,),]
      ),
      backgroundColor: Colors.lightGreen,
      body: new ListView.builder( // the scrollable list of songs
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
                          height: 1.0,
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
                    padding: const EdgeInsets.only(left: 5.0),
                  ),
                  new RaisedButton(
                    child: new RichText(
                      text: new TextSpan(
                        text: 'Select',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                          letterSpacing: 1.0,
                          height: 1.5,
                        ),
                      ),
                    ),
                    color: Colors.amber,
                    padding: EdgeInsets.only(
                        left: 4.0, right: 4.0, bottom: 6.0, top: 2.0),
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
