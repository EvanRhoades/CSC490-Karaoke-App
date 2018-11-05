import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'join_or_create.dart';

class QueueDjPage extends StatefulWidget {
  @override
  _QueueDjPageState createState() => new _QueueDjPageState();
}

class _QueueDjPageState extends State<QueueDjPage>
    with SingleTickerProviderStateMixin {
  // sets background color for this page
  // this will only change when the dj is trying to exit
  Color backColor = Colors.green[200];

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
    if (editSwitch == true) {
      return new IconButton(
        icon: upIcon,

        // when the button is pressed, move the data around and show it to the dj
        onPressed: () {
          setState(() {
            if (ind != 0) {
              temp = globals.participantList[ind - 1];
              globals.participantList[ind - 1] = globals.participantList[ind];
              globals.participantList[ind] = temp;
              temp = globals.participantSongs[ind - 1];
              globals.participantSongs[ind - 1] = globals.participantSongs[ind];
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
        onPressed: () {},
      );
  }

  // this is the "up button" for moving a participant up in the queue; it will only appear when the user presses "edit"
  IconButton downButton(int ind) {
    if (editSwitch == true) {
      return new IconButton(
        icon: downIcon,

        // when the button is pressed, move the data around and show it to the dj
        onPressed: () {
          setState(() {
            if (ind != globals.participantSongs.length - 1) {
              temp = globals.participantList[ind + 1];
              globals.participantList[ind + 1] = globals.participantList[ind];
              globals.participantList[ind] = temp;
              temp = globals.participantSongs[ind + 1];
              globals.participantSongs[ind + 1] = globals.participantSongs[ind];
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
        onPressed: () {},
      );
  }

  // edit queue button changes when pressed; these help facilitate those changes
  String editButtonText = "Edit Queue";
  Color editColor = Colors.amber;
  Color editColor2 = Colors.amber;

  // simply flips the switch to allow the dj to edit the queue
  void editQueue() {
    // flip edit switch on
    if (editSwitch == false) {
      editSwitch = true;
      editButtonText = "Save Changes";
      editColor = Colors.teal;
      editColor2 = Colors.teal[200];
      setState(() {});
    }
    // flip edit switch off
    else {
      editSwitch = false;
      editButtonText = "Edit Queue";
      editColor = Colors.amber;
      editColor2 = Colors.green[200];
      /*
        SEAN: At this point in time, the queue edit has been saved and
        should be communicated to the other participants
       */
      setState(() {});
    }
  }

  bool yesNoVisible = false;
  IconData beginIcon = Icons.audiotrack;
  bool eventOngoing = false;
  String beginButtonText = "Begin Event";
  Color beginColor = Colors.amber;

  // begins the event,
  void beginEvent() {
    // if event has not begun yet, begin it
    if (!eventOngoing) {
      beginButtonText = "Conclude Event";
      beginColor = Colors.red[900];
      beginIcon = Icons.close;
      eventOngoing = true;
      setState(() {});
    }
    // if dj is trying to finish event, double check
    else {
      backColor = Colors.white;
      beginButtonText = "Are you sure?";
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
      /*
        SEAN: At this moment, the DJ is concluding the event.  This info needs
        to be given to the server to be passed on to the participants.
      */
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new JoinOrCreatePage()));
    }
    // if no, go back to previous state
    else {
      backColor = Colors.green[200];
      beginButtonText = "Conclude Event";
      beginColor = Colors.red[900];
      beginIcon = Icons.close;
      yesNoVisible = false;
      setState(() {});
    }
  }

  Color currentlySinging(int index) {
    if (eventOngoing) {
      if (index == 0) {
        editColor2 = Colors.green;
        return editColor2;
      }
    }
    if (editSwitch)
      editColor2 = Colors.teal;
    else
      editColor2 = Colors.amber;
    return editColor2;
  }

  void nextUp(){
    if (globals.participantList.length == 0) {
      setState(() {});
    }
    else {
      globals.participantList.removeAt(0);
      globals.participantSongs.removeAt(0);
      setState(() {});
    }
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
          automaticallyImplyLeading: false,
        ),
        backgroundColor: backColor,
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
                  shape: Border(bottom: BorderSide(color: Colors.red[900])),
                  child: new Container(
                    width: cWidth,
                    color: currentlySinging(index),
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
                        Expanded(
                          // displays the participant's chosen song
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
                        downButton(index),
                        // these buttons appear when the "edit" button below is pressed
                        upButton(index),
                        new Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                        ),
                        Expanded(
                          // displays the username of the participant
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
            // button for editing the queue and NEXT UP
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new RaisedButton(
                  child: new RichText(
                    text: new TextSpan(
                      text: editButtonText,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        letterSpacing: 1.0,
                        height: 1.5,
                      ),
                    ),
                  ),
                  color: editColor,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(6.0, 6.0))),
                  padding: EdgeInsets.only(
                      left: 4.0, right: 4.0, bottom: 6.0, top: 2.0),
                  onPressed: editQueue,
                ),
                new Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                ),
                new RaisedButton(
                  child: new RichText(
                    text: new TextSpan(
                      text: "NEXT UP",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        letterSpacing: 1.0,
                        height: 1.5,
                      ),
                    ),
                  ),
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(6.0, 6.0))),
                  padding: EdgeInsets.only(
                      left: 4.0, right: 4.0, bottom: 6.0, top: 2.0),
                  onPressed: nextUp,
                ),
              ],
            ),
            // button for finishing the event
            new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                          padding: EdgeInsets.only(
                              left: 4.0, right: 4.0, bottom: 6.0, top: 2.0),
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
                        text: beginButtonText,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                          letterSpacing: 1.0,
                          height: 1.5,
                        ),
                      ),
                    ),
                    color: beginColor,
                    padding: EdgeInsets.only(
                        left: 4.0, right: 4.0, bottom: 6.0, top: 2.0),
                    onPressed: beginEvent,
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
                          padding: EdgeInsets.only(
                              left: 4.0, right: 4.0, bottom: 6.0, top: 2.0),
                          onPressed: () => yesOrNo(false),
                        )
                      : new Text(""),
                ]),
          ],
        ));
  }
}