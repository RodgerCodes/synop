import 'package:flutter/material.dart';

class Btn extends StatefulWidget {
  @override
  _BtnState createState() => _BtnState();
}

class _BtnState extends State<Btn> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 50.5,
      child: Icon(
        Icons.add,
      ),
      backgroundColor: Colors.blue[600],
      onPressed: () {
        Navigator.pushNamed(context, '/add');
      },
    );
  }
}
