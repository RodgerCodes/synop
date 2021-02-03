import 'package:flutter/material.dart';
import 'package:synop/screens/Login.dart';
import 'package:synop/screens/Splash.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.blue),
    routes: {
      '/': (context) => SplashScreeen(),
      '/login': (context) => LoginScreen()
    },
  ));
}
