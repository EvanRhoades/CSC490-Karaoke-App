import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'join_or_create.dart';

class QueueInfoPage extends StatefulWidget {
  @override
  _QueueInfoPageState createState() => new _QueueInfoPageState();
}

class _QueueInfoPageState extends State<QueueInfoPage> {
  // the purpose of these keys are to reference the corresponding widgets
  final scaffoldKey4 = new GlobalKey<ScaffoldState>();

  // simple boolean switch for when the event starts
  bool eventOngoing = false;

  // this color will change for the participant currently singing
  Color currSing = Colors.white;

  // simply changes the color in the karaoke queue to indicate which participant
  // is currently singing
  Color currentlySinging(int index) {
    if (eventOngoing) {
      if (index == 0) {
        currSing = Colors.green;
        return currSing;
      }
    }
    currSing = Colors.white;
    return currSing;
  }

  /*
    SEAN:
    The following method indicates to the user that the event has begun.  Whenever the
    server communicates this information to the user, use this method.
  */
  void eventHasBegun(){
    eventOngoing = true;
    final snackbar = new SnackBar(
      content: new Text("Event has begun!"),
    );
    scaffoldKey4.currentState.showSnackBar(snackbar);
    setState(() {
    });
  }

  // this variables all need to change when the user presses the "leave event" button
  bool yesNoVisible = false;
  Color leaveColor;
  String leaveButtonText = "Leave Event";
  IconData leaveIcon = Icons.close;
  // starts process for leaving event
  void leaveEvent() {
    leaveColor = Colors.white;
    leaveButtonText = "Are you sure?";
    leaveIcon = Icons.warning;
    yesNoVisible = true;
    setState(() {});
  }

  // if dj is trying to finish event, display "Yes" and "no" buttons
  void yesOrNo(bool yesNo) {
    // if yes, exit event
    if (yesNo) {
      /*
        SEAN: At this moment, the participant is leaving the event.  This info needs
        to be given to the server to be passed on to the participants.
      */
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new JoinOrCreatePage()));
    }
    // if no, go back to previous state
    else {
      eventHasBegun();
      leaveColor = Colors.white;
      leaveButtonText = "Leave Event";
      leaveIcon = Icons.close;
      yesNoVisible = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // to help with text wrapping if the song title is too long
    double cWidth = MediaQuery.of(context).size.width * 0.8;

    // for listing to the current participant each participant's queue placement
    // (this was needed to add 1 to the index for printing)
    int queuePlace;

    return new Scaffold(
        key: scaffoldKey4,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: new Text("Queue Info"),
          // removes default back button within appbar
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.white,
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
                      shape: Border(bottom: BorderSide(color: Colors.cyan)),
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
                                  color: Colors.cyan,
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
                            new Icon(Icons.chevron_right),
                            // these buttons appear when the "edit" button below is pressed
                            new Icon(Icons.chevron_right),
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
            // button for finishing the event
            new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // if the user has tried to leave event, display this button
                  yesNoVisible
                      ? new RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: new RichText(
                      text: new TextSpan(
                        text: "Yes",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          letterSpacing: 1.0,
                          height: 1.5,
                        ),
                      ),
                    ),
                    splashColor: Colors.cyan,
                    color: Colors.blueGrey,
                    padding: EdgeInsets.only(
                        left: 4.0, right: 4.0, bottom: 6.0, top: 2.0),
                    // if they press this button ("yes"), continue with leave event process
                    onPressed: () => yesOrNo(true),
                  )
                      : new Text(""),
                  new Icon(leaveIcon),
                  // "leave event" button
                  // changes to "are you sure?" when pressed (not a usable button in that state)
                  new RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: new RichText(
                      text: new TextSpan(
                        text: leaveButtonText,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          letterSpacing: 1.0,
                          height: 1.5,
                        ),
                      ),
                    ),
                    splashColor: Colors.cyan,
                    color: Colors.black,
                    padding: EdgeInsets.only(
                        left: 4.0, right: 4.0, bottom: 6.0, top: 2.0),
                    onPressed: leaveEvent,
                  ),
                  new Icon(leaveIcon),
                  // if user changes their mind and presses "no", go back to previous state
                  yesNoVisible
                      ? new RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: new RichText(
                      text: new TextSpan(
                        text: "No",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          letterSpacing: 1.0,
                          height: 1.5,
                        ),
                      ),
                    ),
                    splashColor: Colors.cyan,
                    color: Colors.blueGrey,
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