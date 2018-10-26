// How to use a global variable: import this file, then say 'globals.yourvariablename'

library my_prj.globals;

// is this user a DJ?  This info will come from the server/database immediately after login
bool isDJ = false;

// this will store the DJ's songlist for the duration of the user's involvement in the event
// NOTE: indexes must align (index 0 for song should match index 0 for artist
//                           ...there may be a way to do this a different way on my end but this was the most simple)
List<String> djSonglist = ["this is a very long title", "short", "medium length", "this is a super d duper long title that won't fit",
"test5", "test6", "test7", "test8", "test9",];
List<String> djArtistlist = ["bon jovi", "taylor swift", "this artis has a very long name who knows why", "bob dylan",
"nirvana", "hot dog", "billy", "asdfjkl", "a;sldkfjalfj",];

int selectedSongIndex;