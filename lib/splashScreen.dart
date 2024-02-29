import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gemini/homepage.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: LottieBuilder.asset("assets/animation/gemini.json"),
      ),
    );
  }
}
