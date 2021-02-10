import 'package:flutter/material.dart';

class Btn extends StatelessWidget {
  const Btn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
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
