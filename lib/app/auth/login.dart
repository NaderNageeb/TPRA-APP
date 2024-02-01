// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, use_build_context_synchronously, sized_box_for_whitespace, unused_import, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tpra/components/crud.dart';
import 'package:tpra/components/custometextform.dart';
import 'package:tpra/constant/linkapi.dart';
import 'package:tpra/main.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../../components/alerts.dart';
import '../../components/valid.dart';

// late SharedPreferences sharedPref;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Crud _crud = Crud();
  bool isLoading = false;

  loinUser() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var responce = await _crud.postRequests(linkLogin, {
        'username': username.text,
        'password': password.text,
      });
      isLoading = false;
      setState(() {});
      if (responce['status'] == 'success') {
        sharedPref.setString('user_id', responce['data']['user_id'].toString());
        sharedPref.setString('user_name', responce['data']['user_name']);
        sharedPref.setString('department', responce['data']['department']);
        sharedPref.setString('full_name', responce['data']['full_name']);
        sharedPref.setString('address', responce['data']['address']);
        sharedPref.setString('user_email', responce['data']['email']);
        sharedPref.setString('phone', responce['data']['phone'].toString());
        sharedPref.setString(
            'password', responce['data']['password'].toString());

        sharedPref.setString(
            'user_image', responce['data']['user_image'].toString());

        return Navigator.of(context)
            .pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertFailed(
              message: "Login Faild Or Account Not Active",
              // routename: "login",
            );
          },
        );
      }
    } else {
      print("Form not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : ListView(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(top: 60),
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/logo2.png"),
                      ),
                    ),
                  ),
                ),
                // Center(
                //   child: Text(
                //     "Just Go For It",
                //     style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
                //   ),
                // ),
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Form(
                    key: formstate,
                    child: Column(
                      children: [
                        CustomeFormFeild(
                          valid: (val) {
                            return validInput(val!, 3, 20);
                          },
                          keyboardType: TextInputType.text,
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
                            return validInput(val!, 3, 8);
                          },
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
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Text("I dont have Account "),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed("signup");
                                },
                                child: const Text(
                                  "Registration",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 92, 132, 188)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 150,
                          child: ElevatedButton(
                            // style: ButtonStyle(
                            //     backgroundColor: MaterialStatePropertyAll(
                            //         Color(0xff0B4CA6))),
                            onPressed: () async {
                              await loinUser();
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
