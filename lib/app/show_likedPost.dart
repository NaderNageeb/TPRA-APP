// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:tpra/components/crud.dart';
import 'package:tpra/constant/linkapi.dart';
import 'package:tpra/main.dart';

class ShowLikedPost extends StatefulWidget {
  ShowLikedPost({super.key});

  @override
  State<ShowLikedPost> createState() => _ShowLikedPostState();
}

class _ShowLikedPostState extends State<ShowLikedPost> {
  Crud crud = Crud();
  // @override
  // void initState() {
  //   getLikedPost();
  //   super.initState();
  // }

  getLikedPost() async {
    var responce = await crud.postRequests(
        linkLikedPost, {"user_id": sharedPref.getString("user_id").toString()});
    return responce;

    // print(responce);
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
              future: getLikedPost(),
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
                      return Card(
                        child: ListTile(
                          subtitle:
                              Text(snapshot.data['data'][i]['post_details']),
                          title: Text(snapshot.data['data'][i]['full_name']),
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
                        ),
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
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}

// ListTile(
//         subtitle: Text("badboy"),
//         // tileColor: const Color.fromARGB(255, 214, 203, 203),
//         title: Text("test"),
//         leading: CircleAvatar(
//           backgroundImage: AssetImage("assets/images/profile-1.png"),
//         ),
//       ),
