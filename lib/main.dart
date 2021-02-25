import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synop/screens/Home.dart';
import 'package:synop/screens/Login.dart';
import 'package:synop/screens/Profile.dart';
import 'package:synop/screens/Splash.dart';
import 'package:synop/screens/wrapper.dart';
import 'package:synop/utils/constants.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constants.prefs = await SharedPreferences.getInstance();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: true,
    // theme: ThemeData(primarySwatch: Colors.grey),
    routes: {
      '/': (context) => SplashScreeen(),
      '/wrapper': (context) =>
          Constants.prefs.getBool("loggedin") == true ? Home() : Wrapper(),
      '/login': (context) => LoginScreen(),
      '/home': (context) => Home(),
      '/profile': (context) => Profile()
    },
  ));
}
