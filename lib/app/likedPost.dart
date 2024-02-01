// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:flutter/material.dart';
import 'package:tpra/app/show_likedPost.dart';
import 'package:tpra/components/Drawer.dart';

class LikedPosts extends StatefulWidget {
  const LikedPosts({super.key});

  @override
  State<LikedPosts> createState() => _LikedPostsState();
}

class _LikedPostsState extends State<LikedPosts> {
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
              "Liked",
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
              ],
            ),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: ShowLikedPost(),
    );
  }
}
