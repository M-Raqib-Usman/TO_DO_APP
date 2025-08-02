import 'package:flutter/material.dart';
import 'package:to_do/screens/Splash_screen.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch:Colors.green,
      ),
      home: SplashScreen(),
    );
  }
}
