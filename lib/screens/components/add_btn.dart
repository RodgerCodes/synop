import 'package:flutter/material.dart';
import 'package:synop/utils/constants.dart';

class Btn extends StatefulWidget {
  @override
  _BtnState createState() => _BtnState();
}

class _BtnState extends State<Btn> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return FloatingActionButton(
            elevation: 50.5,
            child: Icon(
              Icons.add,
              size: 40,
              color: textColor,
            ),
            backgroundColor: bgColorSecondary,
            onPressed: () {
              Navigator.pushNamed(context, '/add');
            },
          );
        } else {
          return FloatingActionButton(
            elevation: 50.5,
            child: Icon(
              Icons.add,
              color: textColor,
            ),
            backgroundColor: bgColorSecondary,
            onPressed: () {
              Navigator.pushNamed(context, '/add');
            },
          );
        }
      },
    );
  }
}
