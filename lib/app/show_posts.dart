// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, must_call_super, unused_import, prefer_interpolation_to_compose_strings, override_on_non_overriding_member, unnecessary_new, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, avoid_types_as_parameter_names, use_build_context_synchronously, prefer_final_fields, unused_field, avoid_unnecessary_containers, duplicate_ignore
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ffi';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

import 'package:tpra/components/alerts.dart';
import 'package:tpra/components/custometextform.dart';
import 'package:tpra/components/valid.dart';
import 'package:tpra/constant/linkapi.dart';
import 'package:tpra/main.dart';

import '../components/crud.dart';
import 'comments.dart';

class ShowPosts extends StatefulWidget {
  const ShowPosts({super.key});

  @override
  State<ShowPosts> createState() => _ShowPostsState();
}

class _ShowPostsState extends State<ShowPosts>
    with SingleTickerProviderStateMixin {
  // SingleTickerProviderStateMixin & with SingleTickerProviderStateMixin i used for like Botton
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);
  bool _isFavorite = false;
  List<bool> isLikedList = [];
  var isLiked;

  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController customereport_details = TextEditingController();

  String _postId = "";
  String report_details = "";

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    getPosts();
    super.initState();
  }

  bool isLoading = false;
  add_Report(postId, report_details, customereport_details) async {
    // print(customereport_details.text);
    // print(postId);
    // print(report_details);

    isLoading = true;

    if (report_details != "") {
      var responce = await crud.postRequests(linkaddReport, {
        "post_id": postId.toString(),
        "user_id": sharedPref.getString("user_id").toString(),
        "report_details": report_details.toString()
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
        return showDialog(
          context: context,
          builder: (context) {
            return AlertSuccess(
              message: "Reported",
              routename: "home",
            );
          },
        );
      }
    } else {
      // print("Not valid");
      return showDialog(
          context: context,
          builder: (BuildContext) {
            return AlertWarning(message: "Select Reason !");
          });
    }
  }

  likeReation(_postId) async {
    print(isLiked);
    var responce = await crud.postRequests(linkUserReaction, {
      "user_id": sharedPref.getString('user_id').toString(),
      "post_id": _postId.toString(),
      "status": 1.toString(),
    });
    if (responce['status'] == "success") {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          content: Text("liked post"),
        ),
      );
    }
    if (responce['status'] == 'Exist') {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          content: Text("Already liked post !! "),
        ),
      );
    } else {
      // return responce;
      print(responce);
    }
  }

  Crud crud = Crud();
  getPosts() async {
    var responce = await crud.getRequests(linkVeiwPost);

    return responce;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
        return Future<void>.delayed(const Duration(seconds: 3));
      },
      child: ListView(
        children: [
          FutureBuilder(
              future: getPosts(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  for (int i = 0; i <= snapshot.data['data'].length; i++) {
                    isLikedList.add(false);
                    // print(isLikedList);
                  }
                  return ListView.builder(
                      itemCount: snapshot.data['data'].length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        // return Text(snapshot.data['data'][i]['post_details']);
                        return new Column(
                          children: [
                            // countLike(snapshot.data['data'][i]['post_id'].toString()),

                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              '$ImageLinkusers/' +
                                                  snapshot.data['data'][i]
                                                          ['user_image']
                                                      .toString()),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(snapshot.data['data'][i]
                                                ['full_name']
                                            .toString()),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // alignment: Alignment.topRight,
                                    child: PopupMenuButton<String>(
                                      itemBuilder: (BuildContext context) {
                                        return <PopupMenuEntry<String>>[
                                          PopupMenuItem<String>(
                                            value: 'Report',
                                            child: Text('Report'),
                                          ),
                                        ];
                                      },
                                      onSelected: (String value) {
                                        _postId =
                                            snapshot.data['data'][i]['post_id'];
                                        showReportsheet(_postId);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // height: 300,
                              margin: EdgeInsets.only(top: 5),
                              color: Colors.white,
                              child: Align(
                                alignment: Alignment.center,
                                child: Image.network(
                                  '$ImageLinkposts/' +
                                      snapshot.data['data'][i]['post_photo']
                                          .toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      setState(() {
                                        // isLiked = snapshot.data['data'][i]
                                        //     ['like_poststatus'];
                                        // isLiked == '0'
                                        //     ? _isFavorite = true
                                        //     : _isFavorite;
                                        // print(isLiked);
                                        isLikedList[i] = true;
                                      });
                                      _postId = snapshot.data['data'][i]
                                              ['post_id']
                                          .toString();
                                      // print(_postId);
                                      await likeReation(_postId);
                                    },
                                    icon: Icon(
                                      isLikedList[i] == true
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isLikedList[i] == true
                                          ? Colors.red
                                          : Colors.black,
                                      size: 35,
                                    ),
                                  ),
                                  // Icon(
                                  //   Icons.favorite_border,
                                  //   size: 35,
                                  // ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     setState(() {
                                  //       _isFavorite = !_isFavorite;
                                  //     });
                                  //     _controller.reverse().then(
                                  //         (value) => _controller.forward());
                                  //   },
                                  //   child: ScaleTransition(
                                  //     scale: Tween(begin: 0.7, end: 1.0)
                                  //         .animate(CurvedAnimation(
                                  //             parent: _controller,
                                  //             curve: Curves.easeOut)),
                                  //     child: _isFavorite
                                  //         ? const Icon(
                                  //             Icons.favorite,
                                  //             size: 35,
                                  //             color: Colors.red,
                                  //           )
                                  //         : const Icon(
                                  //             Icons.favorite_border,
                                  //             size: 35,
                                  //           ),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Comments(
                                                    post: snapshot.data['data']
                                                        [i],
                                                  )));
                                    },
                                    icon: Icon(
                                      Icons.mode_comment_outlined,
                                      size: 35,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  // Icon(
                                  //   Icons.bookmark_outline_sharp,
                                  //   size: 35,
                                  // ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15, bottom: 15),
                              // padding: EdgeInsets.symmetric(horizontal: ),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Text(CountLikes + "likes"),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        snapshot.data['data'][i]['full_name']
                                                .toString() +
                                            " " +
                                            snapshot.data['data'][i]
                                                    ['post_details']
                                                .toString(),
                                        textAlign: TextAlign.start,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // Navigator.of(context)
                                          //     .pushNamed("comments");
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Comments(
                                                        post: snapshot
                                                            .data['data'][i],
                                                      )));
                                        },
                                        child: Text(
                                          "view all comments",
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        );
                      });
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
                // return Center(
                //   // child: Text("Loading ...."),
                //   child: CircularProgressIndicator(
                //     color: Colors.black,
                //   ),
                // );
              }),
        ],
      ),
    );
  }

  showReportsheet(String postId) {
    return showBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 600,
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    child: const Text(
                      "Report ",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    report_details = "Harassment or Bullying";
                    await add_Report(
                        postId, report_details, customereport_details);
                  },
                  child: Card(
                    child: ListTile(
                      leading: Text("1"),
                      title: Text(
                        "Harassment or Bullying",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    report_details = "Impersonation";
                    await add_Report(
                        postId, report_details, customereport_details);
                  },
                  child: Card(
                    child: ListTile(
                      leading: Text("2"),
                      title: Text(
                        "Impersonation",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    report_details = "Intellectual Property Violation";
                    await add_Report(
                        postId, report_details, customereport_details);
                  },
                  child: Card(
                    child: ListTile(
                      leading: Text("3"),
                      title: Text(
                        "Intellectual Property Violation",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    report_details = "Self-Harm or Suicide";
                    await add_Report(
                        postId, report_details, customereport_details);
                  },
                  child: Card(
                    child: ListTile(
                      leading: Text("4"),
                      title: Text(
                        "Self-Harm or Suicide",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    report_details = "Spam or Scam";
                    await add_Report(
                        postId, report_details, customereport_details);
                  },
                  child: Card(
                    child: ListTile(
                      leading: Text("5"),
                      title: Text(
                        "Spam or Scam",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    report_details = "Hate Speech or Offensive Content";
                    await add_Report(
                        postId, report_details, customereport_details);
                  },
                  child: Card(
                    child: ListTile(
                      leading: Text("6"),
                      title: Text(
                        "Hate Speech or Offensive Content",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
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
                          myController: customereport_details,
                          label: "Other...",
                          isPasswort: false,
                          suffixIcon: IconButton(
                            onPressed: () async {
                              report_details = customereport_details.text;
                              await add_Report(postId, report_details,
                                  customereport_details);
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
          );
        });
  }
}
