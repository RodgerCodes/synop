import 'package:flutter/material.dart';

class SplashScreeen extends StatefulWidget {
  @override
  _SplashScreeenState createState() => _SplashScreeenState();
}

class _SplashScreeenState extends State<SplashScreeen> {
  void fetchData() async {
    await Future.delayed(Duration(seconds: 5),
        () => {Navigator.pushReplacementNamed(context, '/login')});
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
        child: Center(
          child: Image.asset(
            'assets/logo.png',
          ),
        ),
      ),
    );
  }
}
