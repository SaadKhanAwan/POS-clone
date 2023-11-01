import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_pos_clone/Screeens/homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // this is for shifting to next screen after splash screen
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildSplashScreen());
  }

  _buildSplashScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.asset("assets/images/1.png"),
        Padding(
          padding:
              const EdgeInsets.only(top: 35, left: 40, bottom: 20, right: 40),
          child: Text(
            textAlign: TextAlign.center,
            "Loading...",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade800,
                fontSize: 40),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20),
          child: CircularProgressIndicator(),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 35, left: 40, bottom: 20, right: 40),
          child: Text(
            textAlign: TextAlign.center,
            "powered by Saad For IT Solutions mobile/n +93 3009803695",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        )
      ],
    );
  }
}
