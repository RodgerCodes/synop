import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:synop/utils/constants.dart';

class SplashScreeen extends StatefulWidget {
  @override
  _SplashScreeenState createState() => _SplashScreeenState();
}

class _SplashScreeenState extends State<SplashScreeen> {
  void fetchData() async {
    await Future.delayed(Duration(seconds: 5),
        () => {Navigator.pushReplacementNamed(context, '/wrapper')});
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        color: bgPrimary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SYNOP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                letterSpacing: 11.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SpinKitThreeBounce(
              size: 25.0,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
