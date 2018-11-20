// How to use a global variable: import this file, then say 'globals.yourvariablename'

library my_prj.globals;

// is this user a DJ?  This info will come from the server/database immediately after login
bool isDJ = false;
int djID = 0;
String userUserName = "";

// this will store the DJ's songlist for the duration of the user's involvement in the event
// NOTE: indexes must align (index 0 for song should match index 0 for artist
//                           ...there may be a way to do this a different way on my end but this was the most simple)
List<String> djSonglist = ["Tell It to My Heart", "Barbie Girl", "What Is Love", "The Rhythm Of The Night",
"Girls Just Want to Have Fun", "Take On Me", "I Wanna Dance with Somebody", "Livin' On A Prayer", "How Deep Is Your Love", "Country Roads", "Good Vibrations", "California Dreamin'"];
List<String> djArtistlist = ["Taylor Dayne", "Aqua", "Haddaway", "Corona",
"Cyndi Lauper", "A-Ha", "Whitney Houston", "Bon Jovi", "Bee Gees", "John Denver", "The Beach Boys", "The Mamas & The Papas"];

// this will store the search results of the participant
// NOTE: indexes must align (index 0 for song should match index 0 for artist
//                           ...there may be a way to do this a different way on my end but this was the most simple)
List<String> userSearchSongs = ["short"];
List<String> userSearchArtists = ["taylor swift"];
// this saves the original index of the song
List<int> djIndex = [1];

// stores the index of the song and artist the participant has chosen
// used in "choose song page"
int selectedSongIndex;

// stores the karaoke participants and their respective song choices
//List<String> participantList = ["lukeusername", "MrMWardster", "SeanLeonhard", "EvanRhoades", "my name is humongous", "person6", "person7", "person8", "person 9"];
//List<String> participantSongs = ["la la land", "lamp", "asdfjkl;", "goldfish suck","this is a reallllllly lonnnnnng sonnnnnng", "song 6", "song7", "song8", "song 9"];
List<String> participantList = ["lukeusername", "MrMWardster", "SeanLeonhard", "EvanRhoades", "SteveTate"];
List<String> participantSongs = ["la la land", "I Wanna Dance with Somebody", "Country Roads", "Livin' On A Prayer","California Dreamin'"];

// this will store the event code itself; will be displayed only to the DJ
int eventCode;