import 'package:flutter/material.dart';
import 'package:synop/utils/constants.dart';

class Popmenubtn extends StatelessWidget {
  const Popmenubtn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (context) {
        return options.map((String value) {
          return PopupMenuItem(
            value: value,
            child: Text(value),
          );
        }).toList();
      },
      onSelected: (String choice) {
        if (choice == "About App") {
          showAboutDialog(
              context: context,
              applicationName: "Synop",
              applicationVersion: "1.2.2",
              children: [
                Text(
                  'This app was designed and built by Rodger Kumwanje',
                ),
              ]);
        } else {
          Constants.prefs.setBool("loggedin", false);
          Constants.prefs.setString("tk", null);
          Navigator.pushReplacementNamed(context, '/wrapper');
        }
      },
    );
  }
}
