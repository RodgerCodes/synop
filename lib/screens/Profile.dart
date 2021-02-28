import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:synop/services/Auth.dart';
import 'package:http_parser/http_parser.dart';
import 'package:synop/utils/constants.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var user;
  var tok = Constants.prefs.getString("tk");
  File _image;
  final picker = ImagePicker();
  var placeholder =
      'https://www.dovercourt.org/wp-content/uploads/2019/11/610-6104451_image-placeholder-png-user-profile-placeholder-image-png.jpg';
  void fetchUser() {
    AuthService().getinfo(tok).then((val) {
      user = val.data;
      setState(() {});
      print(user);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[700],
        appBar: AppBar(backgroundColor: Colors.blueGrey[700]),
        body: user != null
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Center(
                        child: user['msg']['profile_img'] != null
                            ? CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.width * 0.15,
                                backgroundImage: NetworkImage(
                                    user['msg']['profile_img'],
                                    scale: 10),
                              )
                            : CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.width * 0.15,
                                backgroundImage: NetworkImage(placeholder),
                              )),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                        child: ListTile(
                          title: Text(
                            "Name:",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            user['msg']['name'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                letterSpacing: 2),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                        child: ListTile(
                          title: Text(
                            "Email:",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            user['msg']['email'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                letterSpacing: 2),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                        child: ListTile(
                          title: Text(
                            "Role:",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            user['msg']['role'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                letterSpacing: 2),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                        child: ListTile(
                          title: Text(
                            "District:",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            user['msg']['district'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                letterSpacing: 2),
                          ),
                        )),
                  ],
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ));
  }
}