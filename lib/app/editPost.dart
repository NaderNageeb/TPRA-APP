// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, non_constant_identifier_names, avoid_types_as_parameter_names, curly_braces_in_flow_control_structures, use_build_context_synchronously, unused_local_variable, prefer_typing_uninitialized_variables, unused_import, duplicate_ignore

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tpra/components/valid.dart';
import 'package:tpra/constant/linkapi.dart';
import '../components/alerts.dart';
import 'package:tpra/main.dart';

import '../components/crud.dart';

class EditPost extends StatefulWidget {
  // postdata : comming from another screen
  final postdata;
  const EditPost({super.key, required this.postdata});

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  File? myfile;
  String oldimage = "";
  String postid = "";
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController postDetails = TextEditingController();
  bool isLoading = false;
  Crud crud = Crud();

  @override
  void initState() {
    postDetails.text = widget.postdata['post_details'];
    postid = widget.postdata['post_id'];
    oldimage = widget.postdata['post_photo'];
    super.initState();
  }

  editPost() async {
    bool isLoading = true;
    setState(() {});
    if (formstate.currentState!.validate()) {
      if (myfile == null) {
        var responce = await crud.postRequests(linkEditPost, {
          "post_id": postid.toString(),
          "old_image": oldimage.toString(),
          "post_details": postDetails.text.toString()
        });
        if (responce['status'] == 'success') {
          return showDialog(
              context: context,
              builder: (BuildContext) {
                return AlertSuccess(
                    message: "Post Updated", routename: "myposts");
              });
        }
        if (responce['status'] == 'Faild') {
          return showDialog(
              context: context,
              builder: (BuildContext) {
                return AlertFailed(message: "Updated Faild");
              });
        }
        if (responce['status'] == 'Invalid_file_extension') {
          return showDialog(
              context: context,
              builder: (BuildContext) {
                return AlertFailed(message: "Invalid file extension");
              });
        }
      }
      // return showDialog(
      //     context: context,
      //     builder: (BuildContext) {
      //       return AlertWarning(message: "Please Select Photo");
      //     });

      var responce = await crud.postReuestWithFile(
          linkEditPost,
          {
            "post_id": postid.toString(),
            "old_image": oldimage.toString(),
            "post_details": postDetails.text.toString()
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
              return AlertSuccess(
                  message: "Post Updated", routename: "myposts");
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
          Image.network(
            '$ImageLinkposts/' + oldimage,
            height: 200,
          ),
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
                        // await Add_post();
                        await editPost();
                      },
                      child: Text(
                        "Edit Post",
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
