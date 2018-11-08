import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'queue_info_page.dart';
import 'join_or_create.dart';

class ChooseSongPage extends StatefulWidget {
  @override
  _ChooseSongPageState createState() => new _ChooseSongPageState();
}

class _ChooseSongPageState extends State<ChooseSongPage> {
  // this will be called when the user presses the select button
  void selectMe(int index) {
    globals.selectedSongIndex = index;
    // SEAN: We now have the selected song from the user.  This should be sent back to the server
    // so that it can go in the Queue for the event/DJ.
    // Variable: index (index of both the song and the artist arrays)
    // Song Array: globals.djSonglist
    // Artist Array: globals.djArtistlist

    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new QueueInfoPage()));
  }

  // indicates whether to display search results or entire list
  bool searching = false;
  Color backColor = Colors.green[200];

  bool yesNoVisible = false;
  IconData beginIcon = Icons.audiotrack;
  bool userLeaving = false;
  String leaveButtonText = "Leave Event";
  Color beginColor = Colors.red[900];

  void leaveEvent() {
    // If participant wants to leave...
    if (!userLeaving) {
      userLeaving = true;
      backColor = Colors.white;
      leaveButtonText = "Are you sure?";
      beginColor = Colors.white;
      beginIcon = Icons.warning;
      yesNoVisible = true;
      setState(() {});
    }
  }

  // if dj is trying to finish event, display "Yes" and "no" buttons
  void yesOrNo(bool yesNo) {
    // if yes, exit event
    if (yesNo) {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new JoinOrCreatePage()));
    }
    // if no, go back to previous state
    else {
      userLeaving = false;
      backColor = Colors.green[200];
      leaveButtonText = "Leave Event";
      beginColor = Colors.red[900];
      beginIcon = Icons.audiotrack;
      yesNoVisible = false;
      setState(() {});
    }
  }

  Row exitButton() {
    return new Row(mainAxisAlignment: MainAxisAlignment.center, children: <
        Widget>[
      yesNoVisible
          ? new RaisedButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              child: new RichText(
                text: new TextSpan(
                  text: "Yes",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    letterSpacing: 1.0,
                    height: 1.5,
                  ),
                ),
              ),
              color: Colors.green[900],
              padding:
                  EdgeInsets.only(left: 4.0, right: 4.0, bottom: 6.0, top: 2.0),
              onPressed: () => yesOrNo(true),
            )
          : new Text(""),
      new Icon(beginIcon),
      // begins the event
      new RaisedButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        child: new RichText(
          text: new TextSpan(
            text: leaveButtonText,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.black,
              letterSpacing: 1.0,
              height: 1.5,
            ),
          ),
        ),
        color: beginColor,
        padding: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 6.0, top: 2.0),
        onPressed: leaveEvent,
      ),
      new Icon(beginIcon),
      yesNoVisible
          ? new RaisedButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              child: new RichText(
                text: new TextSpan(
                  text: "No",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    letterSpacing: 1.0,
                    height: 1.5,
                  ),
                ),
              ),
              color: Colors.red[900],
              padding:
                  EdgeInsets.only(left: 4.0, right: 4.0, bottom: 6.0, top: 2.0),
              onPressed: () => yesOrNo(false),
            )
          : new Text(""),
    ]);
  }

  // when displaying the list to the user, checks whether or not it will be the search results or regular list
  ListView listOfSongs() {
    double cWidth = MediaQuery.of(context).size.width * 0.8;
    if (!searching) {
      return new ListView.builder(
        // the scrollable list of songs
        itemCount: globals.djSonglist.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            shape: Border(bottom: BorderSide(color: Colors.red[900])),
            child: new Container(
              width: cWidth,
              color: Colors.green[200],
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
      );
    } else if (searching) {
      return new ListView.builder(
        // the scrollable list of songs
        itemCount: globals.userSearchSongs.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            shape: Border(bottom: BorderSide(color: Colors.red[900])),
            child: new Container(
              width: cWidth,
              color: Colors.green[200],
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: new RichText(
                      text: new TextSpan(
                        text: '${globals.userSearchSongs[index]}',
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
                        text: '${globals.userSearchArtists[index]}',
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
                    onPressed: () => selectMe(globals.djIndex[index]),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  Widget appBarTitle = new Text("Select a song");
  Icon actionIcon = new Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    // to help with text wrapping if the song title is too long
    return new Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: appBarTitle,
            automaticallyImplyLeading: false,
            actions: <Widget>[
              // this is where the search function will go
              new IconButton(
                icon: actionIcon,
                onPressed: () {
                  setState(() {
                    // if they press this button and it is currently the search button, do search things
                    if (this.actionIcon.icon == Icons.search) {
                      this.actionIcon = new Icon(Icons.close);
                      this.appBarTitle = new TextField(
                        style: new TextStyle(
                          color: Colors.black,
                        ),
                        decoration: new InputDecoration(
                            prefixIcon:
                                new Icon(Icons.search, color: Colors.black),
                            hintText: "Enter Search Here",
                            hintStyle: new TextStyle(color: Colors.black26)),
                        maxLength: 12,
                        onSubmitted: (String findMe) {
                          print(findMe);
                          /* SEAN: We now have the string to search with
                         Variable: findMe

                         We need to search these arrays:
                         Song Array: globals.djSonglist
                         Artist Array: globals.djArtistlist

                         And put them in these arrays:
                         globals.userSearchSongs
                         globals.userSearchArtists
                      */
                          searching = true;
                        },
                      );
                    }
                    // else the icon they have pressed is the exit button, so go back
                    else {
                      this.actionIcon = new Icon(Icons.search);
                      this.appBarTitle = new Text("Select a song");
                      searching = false;
                    }
                  });
                },
              ),
            ]),
        backgroundColor: backColor,
        body: new Column(
          children: <Widget>[
            new Expanded(child: listOfSongs()),
            exitButton(),
          ],
        ));
  }
}
