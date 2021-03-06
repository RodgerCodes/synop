import 'dart:async';
// import 'dart:html';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CheckInternet {
  // ignore: cancel_subscriptions
  StreamSubscription<DataConnectionStatus> listener;
  // ignore: non_constant_identifier_names
  var InternetStatus = "Unknown";
  var contentmessage = "Unknown";

  void _showDialog(String title, String content, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'))
            ],
          );
        });
  }

  // ignore: non_constant_identifier_names
  CheckConnection(BuildContext context) async {
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          InternetStatus = "Connected to the internet";
          contentmessage = "Connected to the internet";
          // _showDialog(InternetStatus, contentmessage, context);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(contentmessage),
          ));

          break;
        case DataConnectionStatus.disconnected:
          InternetStatus = "You are disconnected to the internet";
          contentmessage = "Please check your internet connection";
          // _showDialog(InternetStatus, contentmessage, context);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(contentmessage),
          ));
          break;
      }
    });
    return await DataConnectionChecker().connectionStatus;
  }
}
