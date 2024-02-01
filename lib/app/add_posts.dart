// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_types_as_parameter_names, use_build_context_synchronously, unused_local_variable, duplicate_ignore, sized_box_for_whitespace, curly_braces_in_flow_control_structures

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tpra/components/crud.dart';
import 'package:tpra/main.dart';

import '../components/alerts.dart';
import '../components/valid.dart';
import '../constant/linkapi.dart';

class AddPosts extends StatefulWidget {
  const AddPosts({super.key});

  @override
  State<AddPosts> createState() => _AddPostsState();
}

class _AddPostsState extends State<AddPosts> {
  File? myfile;
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController postDetails = TextEditingController();
  bool isLoading = false;
  Crud crud = Crud();

  Add_post() async {
    bool isLoading = true;
    setState(() {});
    if (formstate.currentState!.validate()) {
      if (myfile == null)
        return showDialog(
            context: context,
            builder: (BuildContext) {
              return AlertWarning(message: "Please Select Photo");
            });
      var responce = await crud.postReuestWithFile(
          linkAddPost,
          {
            "post_details": postDetails.text,
            "user_id": sharedPref.getString('user_id')
          },
          myfile!);
      isLoading = false;
      setState(() {});
      if (responce['status'] == 'Exist') {
        return showDialog(
            context: context,
            builder: (BuildContext) {
              return AlertWarning(message: "Post Exist");
            });
      }
      if (responce['status'] == 'success') {
        return showDialog(
            context: context,
            builder: (BuildContext) {
              return AlertSuccess(message: "Post Uploded", routename: "home");
            });
      }
      if (responce['status'] == 'Invalid_file_extension') {
        return showDialog(
            context: context,
            builder: (BuildContext) {
              return AlertFailed(message: "Invalid file extension");
            });
      }
    } else {
      print("Not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 35,
            )),
        backgroundColor: Colors.white,
        title: Text(
          "POST",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Form(
              key: formstate,
              child: Column(
                children: [
                  TextFormField(
                    controller: postDetails,
                    validator: (val) {
                      return validInput(val!, 3, 200);
                    },
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      ),
                      contentPadding: EdgeInsets.all(10),
                      // prefixIcon: Icon(Icons.note_add),
                      label: Text("Say Somthing...."),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        ShowBottonSheet();
                      },
                      child: myfile == null
                          ? Text(
                              "Add Image",
                              style: TextStyle(fontSize: 18),
                            )
                          : Icon(
                              Icons.done,
                              color: Colors.green,
                            ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () async {
                        await Add_post();
                      },
                      child: Text(
                        "Add Post",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  ShowBottonSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 195,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: const Text(
                    "Select Image From : ",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    // print("from Gellary");
                    XFile? xfile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    Navigator.of(context).pop();
                    myfile = File(xfile!.path);
                    setState(() {});
                  },
                  child: const ListTile(
                    leading: Icon(
                      Icons.image,
                      // color: Colors.blue,
                    ),
                    title: Text(
                      "From Gallarey",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    XFile? xfile = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    myfile = File(xfile!.path);
                    setState(() {});
                  },
                  child: const ListTile(
                    leading: Icon(
                      Icons.camera_alt,
                      // color: Colors.blue,
                    ),
                    title: Text(
                      "Camera",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
