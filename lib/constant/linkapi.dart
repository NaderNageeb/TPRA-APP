// ignore_for_file: constant_identifier_names

const String linkServerName = "http://192.168.43.63/Tpra_system/include/API/";
const String linkServerImage = "http://192.168.43.63/Tpra_system/uploads/";

// const String linkServerName = "http://10.0.2.2/Tpra_system/include/API/";
// const String linkServerImage = "http://10.0.2.2/Tpra_system/uploads/";

//if i work with emulator : http://10.0.2.2 he is the ip of the emulator;
// if i work with physical device : ip of pc : 192.168.43.63;
// if i work with the online server must put the server link

// Auth

const String ImageLinkusers = "$linkServerImage/users/";
const String ImageLinkposts = "$linkServerImage/posts/";

const String linkSignUp = "$linkServerName/index.php?register";
const String linkLogin = "$linkServerName/index.php?login";
// register
// Posts
const String linkAddPost = "$linkServerName/index.php?addpost";
const String linkVeiwPost = "$linkServerName/index.php?viewposts";
const String linkAddComment = "$linkServerName/index.php?usercomment";
const String linkVeiwComments = "$linkServerName/index.php?viewcomments";
const String linkCountLikedPost = "$linkServerName/index.php?countlikedpost";
const String linkUserReaction = "$linkServerName/index.php?reaction";
const String linkLikedPost = "$linkServerName/index.php?likedpost";
const String linkmyPosts = "$linkServerName/index.php?myposts";
const String linkaddReport = "$linkServerName/index.php?reportadd";
const String linkshowReport = "$linkServerName/index.php?showreport";
const String linkdeleteReport = "$linkServerName/index.php?deletereport";
const String linkEditPost = "$linkServerName/index.php?editPost";
const String linkeditProfile = "$linkServerName/index.php?editProfile";
const String linkeprofiledata = "$linkServerName/index.php?profiledata";

const String linkDelete = "$linkServerName/notes/delete.php";
const String linkAddnote = "$linkServerName/notes/add_notes.php";
