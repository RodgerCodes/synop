import 'package:flutter/material.dart';
import 'package:synop/screens/components/drawer.dart';
import 'package:synop/screens/components/logout_btn.dart';

class AddCode extends StatefulWidget {
  @override
  _AddCodeState createState() => _AddCodeState();
}

class _AddCodeState extends State<AddCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text('SYNOP'),
        centerTitle: true,
        actions: [Logout()],
      ),
      body: Center(
        child: Text(
          "Will implement Later",
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: drawercomponent(),
    );
  }
}
