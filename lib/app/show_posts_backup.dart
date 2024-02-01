// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, must_call_super, unused_import
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tpra/constant/linkapi.dart';

import '../components/crud.dart';

class ShowPosts extends StatefulWidget {
  const ShowPosts({super.key});

  @override
  State<ShowPosts> createState() => _ShowPostsState();
}

class _ShowPostsState extends State<ShowPosts> {
  @override
  void initState() {
    getPosts();
  }

  Crud crud = Crud();
  getPosts() async {
    var responce = await crud.getRequests(linkVeiwPost);
    // print(responce);
    return responce;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FutureBuilder(
            future: getPosts(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data['data'].length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      // return Text(snapshot.data['data'][i]['post_details']);
                      return Container();
                    });
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("Loading ...."),
                );
              }
              return Center(
                child: Text("Loading ...."),
              );
            }),

        // ////////////////////////////////
        // Post One
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/prof4.png"),
              ),
              SizedBox(
                width: 5,
              ),
              Text("Omer Osman"),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          color: Colors.white,
          child: Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/edod.jpg',
              // width: 200,
              // height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(
                Icons.favorite_border,
                size: 35,
              ),
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.insert_comment_sharp,
                size: 35,
              ),
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.turned_in_not,
                size: 35,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("12 likes"),
              SizedBox(
                height: 5,
              ),
              Text("Omer Osman  : good planet"),
              Text(
                "view all comment count 552",
                style: TextStyle(color: Colors.black54),
              ),
              Text("time post"),
            ],
          ),
        ),

// /////////////////////////////////////////
        //  Post 2
        SizedBox(
          height: 10,
        ),
        // Post One
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/profile-2.png"),
              ),
              SizedBox(
                width: 5,
              ),
              Text("Ahmed Ali"),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          color: Colors.white,
          child: Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/onepice.jpg',
              // width: 200,
              // height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(
                Icons.favorite_border,
                size: 35,
              ),
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.insert_comment_sharp,
                size: 35,
              ),
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.save_alt_outlined,
                size: 35,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("12 likes"),
              SizedBox(
                height: 5,
              ),
              Text("Omer Osman  : good planet"),
              Text(
                "view all comment count 552",
                style: TextStyle(color: Colors.black54),
              ),
              Text("time post"),
            ],
          ),
        ),
      ],
    );
  }
}
