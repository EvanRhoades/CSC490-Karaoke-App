import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class QueueDjPage extends StatefulWidget {
  @override
  _QueueDjPageState createState() => new _QueueDjPageState();
}

class _QueueDjPageState extends State<QueueDjPage> {
  // up and down icons that appear when editing the queue
  Icon upIcon = new Icon(Icons.arrow_upward);
  Icon downIcon = new Icon(Icons.arrow_downward);

  // this is a placeholder icon to be replaced by the up and down icons for queue editing
  Icon nullIcon = new Icon(Icons.chevron_right);

  // this is switched on when the user clicks "edit"
  bool editSwitch = false;

  // a temporary string for rotating list data around
  String temp;
  // this is the "up button" for moving a participant up in the queue; it will only appear when the user presses "edit"
  IconButton upButton(int ind) {
    if (editSwitch == true){
      return new IconButton(
        icon: upIcon,

        // when the button is pressed, move the data around and show it to the dj
        onPressed: () {
          setState(() {
            if (ind != 0) {
              temp = globals.participantList[ind-1];
              globals.participantList[ind-1] = globals.participantList[ind];
              globals.participantList[ind] = temp;
              temp = globals.participantSongs[ind-1];
              globals.participantSongs[ind-1] = globals.participantSongs[ind];
              globals.participantSongs[ind] = temp;
            }
          });
        },
      );
    }
    // if the switch is not pressed, just show the immutable placeholder icon
    else
      return new IconButton(
        icon: nullIcon,
        onPressed: () {
        },
      );
  }

  // this is the "up button" for moving a participant up in the queue; it will only appear when the user presses "edit"
  IconButton downButton(int ind) {
    if (editSwitch == true){
      return new IconButton(
        icon: downIcon,

        // when the button is pressed, move the data around and show it to the dj
        onPressed: () {
          setState(() {
            if (ind != globals.participantSongs.length-1) {
              temp = globals.participantList[ind+1];
              globals.participantList[ind+1] = globals.participantList[ind];
              globals.participantList[ind] = temp;
              temp = globals.participantSongs[ind+1];
              globals.participantSongs[ind+1] = globals.participantSongs[ind];
              globals.participantSongs[ind] = temp;
            }
          });
        },
      );
    }
    // if the switch is not pressed, just show the immutable placeholder icon
    else
      return new IconButton(
        icon: nullIcon,
        onPressed: () {
        },
      );
  }

  // simply flips the switch to allow the dj to edit the queue
  void editQueue() {
    editSwitch = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // to help with text wrapping if the song title is too long
    double cWidth = MediaQuery.of(context).size.width * 0.8;

    // for listing to the dj each participant's queue placement (this was needed to add 1 to the index for printing)
    int queuePlace;

    return new Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: new Text("Event Management"),
        ),
        backgroundColor: Colors.lightGreen,
        // we need buttons and things below the list, so I put the list in a column
        body: new Column(
          children: <Widget>[
            // where the list starts
            new Expanded(
                child: new ListView.builder(
              itemCount: globals.participantList.length,
              itemBuilder: (BuildContext context, int index) {
                queuePlace = index + 1;
                return new Card(
                  shape: Border(bottom: BorderSide(color: Colors.red)),
                  child: new Container(
                    width: cWidth,
                    color: Colors.lightGreen,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new RichText(
                          text: new TextSpan(
                            text: '$queuePlace',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                              letterSpacing: 1.0,
                              height: 1.0,
                            ),
                          ),
                        ),
                        new Icon(Icons.chevron_right),
                        Expanded( // displays the participant's chosen song
                          child: new RichText(
                            text: new TextSpan(
                              text: '${globals.participantSongs[index]}',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                letterSpacing: 1.0,
                                height: 1.0,
                              ),
                            ),
                          ),
                        ),
                        downButton(index), // these buttons appear when the "edit" button below is pressed
                        upButton(index),
                        new Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                        ),
                        Expanded( // displays the username of the participant
                          child: new RichText(
                            text: new TextSpan(
                              text: '${globals.participantList[index]}',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                letterSpacing: 1.0,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
            new Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            new RaisedButton( // button for editing the queue
              child: new RichText(
                text: new TextSpan(
                  text: 'Edit Queue',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    letterSpacing: 1.0,
                    height: 1.5,
                  ),
                ),
              ),
              color: Colors.amber,
              padding:
                  EdgeInsets.only(left: 4.0, right: 4.0, bottom: 6.0, top: 2.0),
              onPressed: editQueue,
            ),
            new Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Icon(Icons.subdirectory_arrow_right),
                  new RaisedButton( // begins the event
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: new RichText(
                      text: new TextSpan(
                        text: 'Begin Event',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                          letterSpacing: 1.0,
                          height: 1.5,
                        ),
                      ),
                    ),
                    color: Colors.lightBlue,
                    padding: EdgeInsets.only(
                        left: 4.0, right: 4.0, bottom: 6.0, top: 2.0),
                    onPressed: editQueue,
                  ),
                  new Icon(Icons.subdirectory_arrow_left),
                ]),
          ],
        ));
  }
}
