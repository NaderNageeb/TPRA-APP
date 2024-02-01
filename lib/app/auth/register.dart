// ignore_for_file: prefer_final_fields, use_build_context_synchronously, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tpra/components/alerts.dart';
import 'package:tpra/components/crud.dart';
import 'package:tpra/components/valid.dart';
import 'package:tpra/constant/linkapi.dart';

import '../../components/custometextform.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController username = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();

  Crud _crud = Crud();
  bool isLoading = false;

  signUp() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var responce = await _crud.postRequests(linkSignUp, {
        "username": username.text,
        "fullname": fullname.text,
        "email": email.text,
        "department": department.text,
        "phone": phone.text,
        "address": address.text,
        "password": password.text
      });
      isLoading = false;
      setState(() {});
      if (responce['status'] == "success") {
        // Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
        return showDialog(
          context: context,
          builder: (context) {
            return AlertSuccess(
              message: "Registration",
              routename: "login",
            );
          },
        );
      }
      if (responce['status'] == "Exist") {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertWarning(
              message: "This User Exist",
            );
          },
        );
      } else {
        print("Sign up feild");
      }
    } else {
      print("not valid");
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
                              return validInput(val!, 3, 20);
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
                              return validInput(val!, 3, 8);
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
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                const Text("I have Account "),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed("login");
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 92, 132, 188),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 50,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  // backgroundColor: MaterialStatePropertyAll(
                                  //   // Color.fromARGB(255, 92, 132, 188),
                                  // ),
                                  ),
                              onPressed: () async {
                                await signUp();
                              },
                              child: const Text(
                                "Creat Account",
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
}
