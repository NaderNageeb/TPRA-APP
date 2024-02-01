// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:tpra/app/ShowMyReports.dart';
import 'package:tpra/app/show_myPosts.dart';
import 'package:tpra/components/Drawer.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
              "Reports",
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
      body: SeeReports(),
    );
  }
}
