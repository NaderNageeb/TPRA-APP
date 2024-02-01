// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_element, non_constant_identifier_names, avoid_types_as_parameter_names, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:tpra/components/valid.dart';
import 'package:tpra/main.dart';

import '../components/alerts.dart';
import '../components/crud.dart';
import '../components/custometextform.dart';
import '../constant/linkapi.dart';

class Comments extends StatefulWidget {
  final post;
  const Comments({super.key, this.post});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController usercomment = TextEditingController();
  TextEditingController post_details = TextEditingController();
  TextEditingController postId = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController userimage = TextEditingController();
  Crud crud = Crud();
  String functionlength = "";

  @override
  void initState() {
    postId.text = widget.post['post_id'];
    post_details.text = widget.post['post_details'];
    username.text = widget.post['full_name'];
    // userimage.text = widget.post['user_image'];
    getcomments();
    super.initState();
  }

  getcomments() async {
    var responce = await crud.postRequests(linkVeiwComments, {
      "post_id": postId.text.toString(),
    });
    functionlength = responce['data'].length.toString();
    // print(functionlength);
    return responce;
  }

  bool isLoading = false;
  Add_Comment() async {
    isLoading = true;

    if (formstate.currentState!.validate()) {
      var responce = await crud.postRequests(linkAddComment, {
        "post_id": postId.text.toString(),
        "user_id": sharedPref.getString("user_id").toString(),
        "comment_details": usercomment.text
      });

      isLoading = false;
      setState(() {});
      if (responce['status'] == 'Exist') {
        return showDialog(
            context: context,
            builder: (BuildContext) {
              return AlertWarning(message: "Comment Exist");
            });
      }
      if (responce['status'] == 'success') {
        // return CircularProgressIndicator();
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 1),
            content: Text(" Commented !!"),
          ),
        );
      }
    } else {
      print("Not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Comments"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).popAndPushNamed("home");
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : ListView(
              children: [
                Column(
                  children: [
                    ListTile(
                      subtitle: Text(post_details.text),
                      // tileColor: const Color.fromARGB(255, 214, 203, 203),
                      title: Text(username.text),
                      // leading: CircleAvatar(
                      //   backgroundImage:
                      //       AssetImage(ImageLinkusers + '/' + userimage.text,),
                      // ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20, left: 20),
                      child: Divider(thickness: 0.5),
                    ),
                    Container(
                      height: 500,
                      // decoration: BoxDecoration(color: Colors.black),
                      margin: EdgeInsets.only(bottom: 5),
                      child: ListView(
                        // shrinkWrap: true,
                        children: [
                          FutureBuilder(
                              future: getcomments(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      itemCount: snapshot.data['data'].length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (contex, i) {
                                        return ListTile(
                                          subtitle: Text(snapshot.data['data']
                                              [i]['comment_details']),
                                          // tileColor: const Color.fromARGB(255, 214, 203, 203),
                                          title: Text(
                                            snapshot.data['data'][i]
                                                ['full_name'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          // leading: CircleAvatar(
                                          //   backgroundImage: AssetImage(
                                          //       "assets/images/profile-1.png"),
                                          // ),
                                        );
                                      });
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    heightFactor: 5,
                                    // child: Text("Loading ...."),
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                  );
                                }
                                return Center(
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        "assets/images/2372379-200.png",
                                        height: 100,
                                        width: 100,
                                      ),
                                      Text("No Comments Yet"),
                                    ],
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Form(
                        key: formstate,
                        child: Column(
                          children: [
                            CustomeFormFeild(
                              valid: (val) {
                                return validInput(val!, 1, 300);
                              },
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              myController: usercomment,
                              label: "Comment...",
                              isPasswort: false,
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  await Add_Comment();
                                },
                                icon: Icon(Icons.arrow_forward),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}



      //  ListTile(
      //                 subtitle: Text("badboy"),
      //                 // tileColor: const Color.fromARGB(255, 214, 203, 203),
      //                 title: Text("test"),
      //                 leading: CircleAvatar(
      //                   backgroundImage:
      //                       AssetImage("assets/images/profile-1.png"),
      //                 ),
      //               ),


             // Card(
                    //   child: ListTile(
                    //     subtitle: Text("badboy"),
                    //     // tileColor: const Color.fromARGB(255, 214, 203, 203),
                    //     title: Text("test"),
                    //     leading: CircleAvatar(
                    //       backgroundImage:
                    //           AssetImage("assets/images/profile-1.png"),
                    //     ),
                    //   ),
                    // ),