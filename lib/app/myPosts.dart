// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tpra/app/show_myPosts.dart';
import 'package:tpra/components/Drawer.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({super.key});

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu, // Replace with your desired icon
            color: Colors.black,
            size: 35, // Replace with your desired color
          ),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Text(
              "Posts",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('addposts');
                  },
                  child: Icon(
                    Icons.add_box_outlined,
                    color: Colors.black,
                    size: 35,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed("likedPost");
                  },
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.black,
                    size: 35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: ShowMyPosts(),
    );
  }
}
