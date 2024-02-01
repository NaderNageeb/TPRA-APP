// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, curly_braces_in_flow_control_structures, use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:tpra/app/editPost.dart';
import 'package:tpra/components/alerts.dart';
import 'package:tpra/components/crud.dart';
import 'package:tpra/main.dart';

import '../constant/linkapi.dart';

class ShowMyPosts extends StatefulWidget {
  const ShowMyPosts({super.key});

  @override
  State<ShowMyPosts> createState() => _ShowMyPostsState();
}

class _ShowMyPostsState extends State<ShowMyPosts> {
  Crud crud = Crud();
  String post_id = "";

  deletePost(post_id) async {
    var responce = await crud.postRequests(linkdeleteReport, {
      "post_id": post_id.toString(),
      "user_id": sharedPref.getString("user_id").toString()
    });
    if (responce['status'] == "success") {
      // Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      return showDialog(
        context: context,
        builder: (context) {
          return AlertSuccess(
            message: "Deleted",
            routename: "myposts",
          );
        },
      );
    }
    if (responce['status'] == "Faild") {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertFailed(
            message: "Faild to Delete",
          );
        },
      );
    }
  }

  getMyPost() async {
    var responce = await crud.postRequests(
        linkmyPosts, {"user_id": sharedPref.getString("user_id").toString()});
    return responce;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      // semanticsLabel: "Loading",
      onRefresh: () {
        setState(() {});
        return Future<void>.delayed(const Duration(seconds: 3));
      },
      child: ListView(
        // shrinkWrap: true,
        padding: EdgeInsets.all(10),
        children: [
          FutureBuilder(
              future: getMyPost(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data['status'] == 'Faild')
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: Image.asset("assets/images/nopost.png"),
                      ),
                    );
                  return ListView.builder(
                    itemCount: snapshot.data['data'].length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      return InkWell(
                        child: Card(
                          child: ListTile(
                            subtitle: Text(
                              " Date : /" +
                                  snapshot.data['data'][i]['post_date'],
                              style: TextStyle(fontSize: 8),
                            ),
                            title: Text(
                              snapshot.data['data'][i]['post_details'],
                              style: TextStyle(fontSize: 15),
                            ),
                            leading: Container(
                              width: 80,
                              height: 80,
                              child: Image.network(
                                '$ImageLinkposts/' +
                                    snapshot.data['data'][i]['post_photo']
                                        .toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () async {
                                post_id = snapshot.data['data'][i]['post_id'];
                                await deletePost(post_id);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                                // size: 15,
                              ),
                              // color: Colors.red,
                            ),
                          ),
                        ),
                        // edit Part
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditPost(
                                    postdata: snapshot.data['data'][i],
                                  )));
                          // print("tabed");
                        },
                      );
                    },
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
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
                        "assets/images/nopost.png",
                        // height: 100,
                        // width: 100,
                      ),
                      // Text("No Comments Yet"),
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}


        //                PopupMenuItem<int>(
        //                         value: 0,
        //                         child: Text("My Account"),
        //                     ),

        //                     PopupMenuItem<int>(
        //                         value: 1,
        //                         child: Text("Settings"),
        //                     ),

        //                     PopupMenuItem<int>(
        //                         value: 2,
        //                         child: Text("Logout"),
        //                     ),
        //                 ];
        //            },
        //            onSelected:(value){
        //               if(value == 0){
        //                  print("My account menu is selected.");
        //               }else if(value == 1){
        //                  print("Settings menu is selected.");
        //               }else if(value == 2){
        //                  print("Logout menu is selected.");
        //               }
        //            }
        //           ),

                   
        //     ],
        //  ),