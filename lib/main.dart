import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synop/screens/Add.dart';
import 'package:synop/screens/Home.dart';
import 'package:synop/screens/Login.dart';
import 'package:synop/screens/Splash.dart';
import 'package:synop/utils/constants.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constants.prefs = await SharedPreferences.getInstance();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // theme: ThemeData(primarySwatch: Colors.blue),
    routes: {
      '/': (context) => SplashScreeen(),
      '/login': (context) =>
          Constants.prefs.getBool("loggedin") == true ? Home() : LoginScreen(),
      '/home': (context) => Home(),
      '/add': (context) => AddCode()
    },
  ));
}
