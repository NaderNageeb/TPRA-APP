// ignore_for_file: prefer_const_constructors
import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, 'login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Align(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/images/logo2.png',
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
