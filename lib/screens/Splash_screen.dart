import 'dart:async';

import 'package:flutter/material.dart';
import 'package:to_do/screens/Login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (Context) => LoginScreen()),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF45644A),
        child: Center(
          child: Text(
            'To Do',
            style: TextStyle(
              color: Color(0xFFE4DBC4),
              fontSize: 70,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
