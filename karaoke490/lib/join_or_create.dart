import 'package:flutter/material.dart';
import 'choose_song_page.dart';
import 'create_event_page.dart';
import 'globals.dart' as globals;

class JoinOrCreatePage extends StatefulWidget {
  @override
  _JoinOrCreatePageState createState() => new _JoinOrCreatePageState();
}

class _JoinOrCreatePageState extends State<JoinOrCreatePage> {
  final scaffoldKey3 = new GlobalKey<ScaffoldState>();

  final formKey3 = new GlobalKey<FormState>();
  String _eventCodeUser;


  _JoinOrCreatePageState() {
    // SEAN: INSERT CODE HERE
    // check if this user is a DJ or not
    // perhaps I should get this value when the user logs in, I'm not sure

    // this is how you access the global variables from "globals.dart"
    globals.isDJ = true;
  }

  // adjust color of button depending on whether or not the user is a DJ
  Color _buttonColor() {
    if (globals.isDJ)
      return Colors.amber;
    else
      return Colors.green;
  }

  // what happens when the user clicks "Join Karaoke Event"
  void _routeJoin() {
    // first we grab the formKey as it currently stands
    final form = formKey3.currentState;

    // I set this to true to test the routing, this should normally be initialized to false
    bool eventCodeExists = true;
    // SEAN: INSERT CODE HERE
    // check if this event code exists

    // if the input is syntactically valid, we save it
    if (form.validate() && eventCodeExists) {
      form.save();

      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new ChooseSongPage()));
    }
  }

  // what happens when the user clicks "Create Karaoke Event"
  void _createEvent() {
    if (globals.isDJ)
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new CreateEventPage()));
    else {
      final snackbar = new SnackBar(
        content:
            new Text("You do not have a song-list setup yet.  Please visit "
                "www.happyfuntimekaraoke.com to do so."),
      );
      scaffoldKey3.currentState.showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey3,
        appBar: AppBar(
          title: new Text("Join or Create Event"),
        ),
        backgroundColor: Colors.lightGreen,
        body: new ListView(children: <Widget>[
          new Container(
            alignment: Alignment.center,
            child: new RichText(
              text: new TextSpan(
                text: 'Happy Funtime Karaoke',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3.0,
                  height: 4.0,
                ),
              ),
            ),
          ),
          new Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 10.0, left: 40.0, right: 40.0),
            child: new Form(
                key: formKey3,
                child: new Column(children: <Widget>[
                  new TextFormField(
                    decoration: new InputDecoration(labelText: "Event Code"),
                    // validates email input; val = user input
                    validator: (val) => val.length < 6
                        ? 'Event code should be 6 characters'
                        : null,
                    // assigns user input to appropriate variable
                    onSaved: (val) => _eventCodeUser = val,
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
                    color: Colors.amber,
                    padding: EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 8.0, top: 2.0),
                    onPressed: _routeJoin,
                  ),
                ])),
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 50.0),
          ),
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
        ]));
  }
}
