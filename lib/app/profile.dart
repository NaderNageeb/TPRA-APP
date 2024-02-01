// ignore_for_file: prefer_final_fields, use_build_context_synchronously, avoid_print, prefer_const_constructors, prefer_interpolation_to_compose_strings, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, non_constant_identifier_names, unused_local_variable, duplicate_ignore

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tpra/components/alerts.dart';
import 'package:tpra/components/crud.dart';
import 'package:tpra/components/valid.dart';
import 'package:tpra/constant/linkapi.dart';
import 'package:tpra/main.dart';

import '../../components/custometextform.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? myfile;
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController username = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();
  String user_id = "";
  var oldImage = sharedPref.getString("user_image");
  Crud crud = Crud();
  bool isLoading = false;

  @override
  void initState() {
    // user_id = sharedPref.getString("user_id")!;
    // username.text = sharedPref.getString("user_name")!;
    // fullname.text = sharedPref.getString("full_name")!;
    // department.text = sharedPref.getString("department")!;
    // email.text = sharedPref.getString("user_email")!;
    // phone.text = sharedPref.getString("phone")!;
    // address.text = sharedPref.getString("address")!;
    // password.text = sharedPref.getString("password")!;
    // oldImage = sharedPref.getString('user_image')!;
    getUserData();
    super.initState();
  }

  getUserData() async {
    var responce = await crud.postRequests(linkeprofiledata, {
      "user_id": sharedPref.getString("user_id").toString(),
    });

    if (responce['status'] == 'success') {
      username.text = responce['data']['user_name'];
      fullname.text = responce['data']['full_name'];
      address.text = responce['data']['address'];
      department.text = responce['data']['department'];
      email.text = responce['data']['email'];
      phone.text = responce['data']['phone'];
      password.text = responce['data']['password'];
    }
  }

  UpdateProfile() async {
    bool isLoading = true;
    setState(() {});
    if (formstate.currentState!.validate()) {
      if (myfile == null) {
        var responce = await crud.postRequests(linkeditProfile, {
          "user_name": username.text,
          "full_name": fullname.text,
          "department": department.text,
          "user_email": email.text,
          "phone": phone.text,
          "address": address.text,
          "password": password.text,
          "user_id": sharedPref.getString("user_id")
        });

        if (responce['status'] == 'success') {
          return showDialog(
              context: context,
              builder: (context) {
                return AlertSuccess(
                    message: "Profile Update", routename: "profile");
              });
        }

        if (responce['status'] == 'Faild') {
          return showDialog(
              context: context,
              builder: (context) {
                return AlertFailed(message: "Profile Update Faild");
              });
        }

        if (responce['status'] == 'Invalid_file_extension') {
          return showDialog(
              context: context,
              builder: (context) {
                return AlertFailed(message: "Invalid file extension");
              });
        }
      }

      var responce = await crud.postReuestWithFile(
          linkeditProfile,
          {
            "user_name": username.text,
            "full_name": fullname.text,
            "department": department.text,
            "user_email": email.text,
            "phone": phone.text,
            "address": address.text,
            "password": password.text,
            "user_id": sharedPref.getString("user_id")
          },
          myfile!);
      if (responce['status'] == 'success') {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertSuccess(message: "Profile Update", routename: "home");
            });
      }

      if (responce['status'] == 'Faild') {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertFailed(message: "Profile Update Faild");
            });
      }

      if (responce['status'] == 'Invalid_file_extension') {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertFailed(message: "Invalid file extension");
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color(0xff0B4CA6),
        // iconTheme: IconThemeData(color: Color(0xff0B4CA6)),
        title: const Text("Registration"),
      ),
      body: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: const EdgeInsets.only(top: 10),
              child: ListView(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          // color: Color.fromARGB(255, 135, 122, 196),
                          ),
                      image: DecorationImage(
                        alignment: Alignment.bottomCenter,
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          '$ImageLinkusers' + '/' + oldImage!,
                        ),
                      ),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 100, vertical: 5),
                    // padding: EdgeInsets.only(top: 50),
                    alignment: Alignment.center,
                  ),
                  IconButton(
                    onPressed: () {
                      ShowProfileBottonSheet();
                    },
                    icon: myfile == null ? Icon(Icons.edit) : Icon(Icons.done),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(top: 15, left: 20, right: 20),
                    child: Form(
                      key: formstate,
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          CustomeFormFeild(
                            valid: (val) {
                              return validInput(val!, 3, 30);
                            },
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            myController: username,
                            label: "User name",
                            isPasswort: false,
                            prefixIcon: Icon(
                              Icons.person,
                              // color: Color.fromARGB(255, 92, 132, 188),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomeFormFeild(
                            valid: (val) {
                              return validInput(val!, 3, 30);
                            },
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            myController: fullname,
                            label: "Full Name",
                            isPasswort: false,
                            prefixIcon: Icon(
                              Icons.person_pin,
                              // color: Color.fromARGB(255, 92, 132, 188),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomeFormFeild(
                            valid: (val) {
                              return validInput(val!, 8, 30);
                            },
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            myController: email,
                            label: "Email",
                            isPasswort: false,
                            prefixIcon: Icon(
                              Icons.email,
                              // color: Color.fromARGB(255, 92, 132, 188),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomeFormFeild(
                            valid: (val) {
                              return validInput(val!, 2, 20);
                            },
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            myController: department,
                            label: "Department",
                            isPasswort: false,
                            prefixIcon: Icon(
                              Icons.align_horizontal_left_sharp,
                              // color: Color.fromARGB(255, 92, 132, 188),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomeFormFeild(
                            valid: (val) {
                              return validInput(val!, 6, 20);
                            },
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            myController: phone,
                            label: "Phone",
                            isPasswort: false,
                            prefixIcon: Icon(
                              Icons.phone,
                              // color: Color.fromARGB(255, 92, 132, 188),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomeFormFeild(
                            valid: (val) {
                              return validInput(val!, 2, 20);
                            },
                            // keyboardType: TextInputType.none,
                            textInputAction: TextInputAction.next,
                            myController: address,
                            label: "Address",
                            isPasswort: false,
                            prefixIcon: Icon(
                              Icons.home,
                              // color: Color.fromARGB(255, 92, 132, 188),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomeFormFeild(
                            valid: (val) {
                              return validInput(val!, 2, 8);
                            },
                            // keyboardType: TextInputType.none,
                            textInputAction: TextInputAction.done,
                            myController: password,
                            label: "Password",
                            isPasswort: true,
                            prefixIcon: Icon(
                              Icons.lock,
                              // color: Color.fromARGB(255, 92, 132, 188),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 20),
                            height: 50,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  // backgroundColor: MaterialStatePropertyAll(
                                  //   // Color.fromARGB(255, 92, 132, 188),
                                  // ),
                                  ),
                              onPressed: () async {
                                await UpdateProfile();
                                // await editProfile();
                              },
                              child: const Text(
                                "Update Account",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  // ignore: non_constant_identifier_names
  ShowProfileBottonSheet() {
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
