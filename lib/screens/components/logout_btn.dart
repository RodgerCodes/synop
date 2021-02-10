import 'package:flutter/material.dart';
import 'package:synop/utils/constants.dart';

class Logout extends StatelessWidget {
  const Logout({
    Key key,
  }) : super(key: key);

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
          Navigator.pushReplacementNamed(context, '/login');
        });
  }
}
