// How to use a global variable: import this file, then say 'globals.yourvariablename'

library my_prj.globals;

// is this user a DJ?  This info will come from the server/database immediately after login
bool isDJ = false;

// this will store the DJ's songlist for the duration of the user's involvement in the event
List<String> djSonglist;