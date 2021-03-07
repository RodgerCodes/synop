import 'dart:async';

import 'package:flutter/material.dart';
import 'package:synop/utils/constants.dart';

class Logout extends StatelessWidget {
  const Logout({
    Key key,
    @required this.timer,
  }) : super(key: key);

  final Timer timer;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.logout,
          color: Colors.white,
        ),
        onPressed: () {
          Constants.prefs.setBool("loggedin", false);
          Constants.prefs.setString("tk", null);
          // timer.cancel();
          Navigator.pushReplacementNamed(context, '/wrapper');
        });
  }
}
