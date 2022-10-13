import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quranapp/home_page.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});
  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  startSplashScreen() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Get.off(homePage());
    });
  }

  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "Welcome,",
          style: TextStyle(
              color: Colors.teal, fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Image.asset(
          "assets/images/logo.png",
          height: 300,
          width: 300,
        ),
      ])),
    );
  }
}
