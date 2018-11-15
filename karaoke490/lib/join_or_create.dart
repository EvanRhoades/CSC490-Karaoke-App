import 'package:flutter/material.dart';
import 'choose_song_page.dart';
import 'globals.dart' as globals;
import 'queue_dj_page.dart';
import 'login_page.dart';

class JoinOrCreatePage extends StatefulWidget {
  @override
  _JoinOrCreatePageState createState() => new _JoinOrCreatePageState();
}

class _JoinOrCreatePageState extends State<JoinOrCreatePage> {
  final scaffoldKey3 = new GlobalKey<ScaffoldState>();
  final formKey3 = new GlobalKey<FormState>();
  String _eventCodeUser;

  // adjust color of button depending on whether or not the user is a DJ
  Color _buttonColor() {
    if (globals.isDJ)
      return Colors.cyan;
    else
      return Colors.grey;
  }

  // what happens when the user clicks "Join Karaoke Event"
  void _routeJoin() {

    // first we grab the formKey as it currently stands
    final form = formKey3.currentState;

    // I set this to true to test the routing, this should normally be initialized to false
    bool eventCodeExists = true;
    // SEAN: INSERT CODE HERE
    // 1. check if this event code exists


    // if the input is syntactically valid, we save it and move to the next page
    if (form.validate() && eventCodeExists) {
      form.save();

      /*
         SEAN:
         This is when we pull the event data & songlist
         Variables:
          Songlist Stuff:
            a) globals.djSonglist
            b) globals.djArtistlist
          Event Queue Stuff:
            a) globals.participantList
            b) globals.participantSongs
      */

      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new ChooseSongPage()));
    }
    // if not, let the user know
    else{
      final snackbar2 = new SnackBar(
        content:
        new Text("Invalid event code."),
      );
      scaffoldKey3.currentState.showSnackBar(snackbar2);
    }
  }

  // what happens when the user clicks "Create Karaoke Event"
  void _createEvent() {
    if (globals.isDJ)
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new QueueDjPage()));
    // if the user is not a DJ, let them know that they cannot create an event
    else {
      final snackbar = new SnackBar(
        content:
            new Text("You do not have a song-list setup yet.  Please visit "
                "www.happyfuntimekaraoke.com to do so."),
      );
      scaffoldKey3.currentState.showSnackBar(snackbar);
    }
  }

  // these variables exist to adjust the visual display of the logout button when pressed
  Color backColor = Colors.white;
  bool yesNoVisible = false;
  IconData beginIcon = Icons.close;
  bool userLeaving = false;
  String leaveButtonText = "Logout";
  Color beginColor = Colors.black;

  // if participant is trying to logout, display "Yes" and "no" buttons
  void yesOrNo(bool yesNo) {
    // if yes, logout
    if (yesNo) {
      /*
        SEAN:
        So at this point the user wants to logout.  At this point, the user would not
        be in an event or be managing an event, but maybe the server needs to know
        if a user logs out...?  I'm not sure.
       */

      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new LoginPage()));
    }
    // if no, go back to previous state
    else {
      userLeaving = false;
      backColor = Colors.white;
      leaveButtonText = "Logout";
      beginIcon = Icons.close;
      yesNoVisible = false;
      setState(() {});
    }
  }

  void dblCheckLeave() {
    // If participant wants to leave...
    if (!userLeaving) {
      userLeaving = true;
      backColor = Colors.white;
      leaveButtonText = "Are you sure?";
      beginIcon = Icons.warning;
      yesNoVisible = true;
      setState(() {});
    }
  }

  // when user presses "logout", this method is used to help facilitate the button changes
  // for transitioning to "are you sure?"
  Row exitButton() {
    return new Row(mainAxisAlignment: MainAxisAlignment.center, children: <
        Widget>[
          // if the user has tried to logout, display this button
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
        color: Colors.blueGrey,
        splashColor: Colors.cyan,
        padding:
        EdgeInsets.only(left: 4.0, right: 4.0, bottom: 6.0, top: 2.0),
        // if they press this button ("yes"), continue with logout process
        onPressed: () => yesOrNo(true),
      )
          : new Text(""),
      new Icon(beginIcon),
      // this "button" really just displays "are you sure?"
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
        color: beginColor,
        padding: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 6.0, top: 2.0),
        onPressed: dblCheckLeave,
      ),
      new Icon(beginIcon),
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
        padding:
        EdgeInsets.only(left: 4.0, right: 4.0, bottom: 6.0, top: 2.0),
        onPressed: () => yesOrNo(false),
      )
          : new Text(""),
    ]);
  }

  // the icon that is displayed above "create event" button
  // it changes depending on whether or not the user is a DJ
  IconData whichIcon() {
    IconData lockOrUnlock;

    if (globals.isDJ)
      lockOrUnlock = Icons.lock_open;
    else
      lockOrUnlock = Icons.lock;
    return lockOrUnlock;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey3,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: new Text("Join or Create Event"),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: exitButton(),
      // this is the widget where everything on this page is displayed (more or less)
      body: new ListView(children: <Widget>[
        // text containing app name
        new Container(
          alignment: Alignment.center,
          child: new RichText(
            text: new TextSpan(
              text: 'Happy Funtime Karaoke',
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
                letterSpacing: 3.0,
                height: 4.0,
              ),
            ),
          ),
        ),
        // event code form and button that goes with it
        new Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 10.0, left: 40.0, right: 40.0),
          child: new Form(
              key: formKey3,
              child: new Column(children: <Widget>[
                new TextFormField(
                  decoration: new InputDecoration(labelText: "Event Code"),
                  style: TextStyle(color: Colors.black),
                  // validates email input; val = user input
                  validator: (val) => val.length < 6
                      ? 'Event code should be 6 digits'
                      : null,
                  // assigns user input to appropriate variable
                  onSaved: (val) => _eventCodeUser = val,
                ),
                new Padding(
                  padding: const EdgeInsets.all(5.0),
                ),
                new RaisedButton(
                  child: new RichText(
                    text: new TextSpan(
                      text: 'Join Event',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        letterSpacing: 1.0,
                        height: 1.5,
                      ),
                    ),
                  ),
                  color: Colors.cyan,
                  padding: EdgeInsets.only(
                      left: 8.0, right: 8.0, bottom: 8.0, top: 2.0),
                  onPressed: _routeJoin,
                ),
              ])),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 50.0),
        ),
        new Icon(whichIcon()),
        // create event button
        new Container(
          alignment: Alignment.center,
          child: new RaisedButton(
            child: new RichText(
              text: new TextSpan(
                text: 'Create Event',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  letterSpacing: 1.0,
                  height: 1.5,
                ),
              ),
            ),
            color: _buttonColor(),
            padding:
                EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 2.0),
            onPressed: _createEvent,
          ),
        ),
      ]),
    );
  }
}
