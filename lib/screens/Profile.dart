import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:synop/services/Auth.dart';
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

  Future _imageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        // _image = await MultipartFile.fromFile(pickedFile.path);
        setState(() {});
        AuthService()
            .updatePic(tok, MultipartFile.fromFile(pickedFile.path))
            .then((val) {
          print(val);
        });
        print(_image);
      } else {
        print('No image selected.');
      }
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
        backgroundColor: Colors.blueGrey[800],
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
                                child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(80, 70, 0, 5),
                                    child: FloatingActionButton(
                                      child: Icon(Icons.add_a_photo_rounded),
                                      onPressed: () {
                                        _imageFromGallery();
                                      },
                                    )),
                              )),
                    RaisedButton(child: Text("Update"), onPressed: () {})
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
