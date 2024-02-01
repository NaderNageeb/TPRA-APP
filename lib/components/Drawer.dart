// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:tpra/constant/linkapi.dart';

import 'package:tpra/main.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String? username = sharedPref.getString('user_name');
  String? email = sharedPref.getString('user_email');
  String? user_image = sharedPref.getString('user_image');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            // currentAccountPicture: CircleAvatar(
            //   backgroundImage: AssetImage("images/nader.jpg"),
            // ),
            accountName: Text(
              username!,
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              email!,
              style: TextStyle(color: Colors.black),
            ),

            decoration: BoxDecoration(
              image: DecorationImage(
                // fit: BoxFit.cover,
                fit: BoxFit.contain,
                // image: AssetImage("assets/images/logo.jpg"),
                image: NetworkImage(ImageLinkusers + '/' + user_image!),
              ),
            ),
            // decoration: BoxDecoration(color: Colors.white),
          ),
          ListTile(
            title: Text("Home"),
            leading: Icon(
              Icons.home_outlined,
              color: Colors.black,
            ),
            // splashColor: Colors.black,
            onTap: () {
              Navigator.of(context).pushNamed("home");
            },
          ),
          ListTile(
            title: Text("Profile"),
            leading: Icon(
              Icons.person_outlined,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).pushNamed("profile");
            },
          ),
          ListTile(
            title: Text("Liked"),
            leading: Icon(
              Icons.favorite_outline_sharp,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).pushNamed("likedPost");
            },
          ),
          ListTile(
            title: Text("My Posts"),
            leading: Icon(
              Icons.post_add_rounded,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).pushNamed("myposts");
            },
          ),
          ListTile(
            title: Text("My Reports"),
            leading: Icon(
              Icons.report_gmailerrorred_outlined,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).pushNamed("reports");
            },
          ),
          ListTile(
            title: Text("Exit"),
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
            onTap: () {
              sharedPref.clear();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
