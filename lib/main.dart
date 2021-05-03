import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synop/screens/Add.dart';
import 'package:synop/screens/Home.dart';
import 'package:synop/screens/Login.dart';
import 'package:synop/screens/Profile.dart';
import 'package:synop/screens/Splash.dart';
import 'package:synop/screens/wrapper.dart';
import 'package:synop/utils/constants.dart';
import 'package:responsive_framework/responsive_framework.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constants.prefs = await SharedPreferences.getInstance();
  ResponsiveBreakpoint.autoScale(600);
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Colors.transparent,
      ),
      routes: {
        '/': (context) => SplashScreeen(),
        '/wrapper': (context) =>
            Constants.prefs.getBool("loggedin") == true ? Home() : Wrapper(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => Home(),
        '/profile': (context) => Profile(),
        '/add': (context) => Add()
      },
    ));
  });
}
