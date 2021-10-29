import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:synop/services/Auth.dart';
import 'package:synop/utils/constants.dart';
import 'package:synop/utils/loader.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var user;
  var info;
  var token = Constants.prefs.getString('tk');
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  Future<Response> sendForm(
      String url, Map<String, dynamic> data, Map<String, File> files) async {
    Map<String, MultipartFile> fileMap = {};
    for (MapEntry fileEntry in files.entries) {
      File file = fileEntry.value;
      String fileName = basename(file.path);
      fileMap[fileEntry.key] = MultipartFile(
          file.openRead(), await file.length(),
          filename: fileName);
    }
    data.addAll(fileMap);
    var formData = FormData.fromMap(data);
    Dio dio = new Dio();
    return await dio.post(url,
        data: formData,
        options: Options(
            contentType: 'multipart/form-data',
            headers: {'authorization': 'Bearer $token'}));
  }

  var tok = Constants.prefs.getString("tk");
  File _image;
  final picker = ImagePicker();

  void fetchUser() {
    AuthService().getinfo(tok).then((val) {
      user = val.data;
      setState(() {});
    });
  }

  Future getImage(BuildContext context) async {
    final pickedImage =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    Dialogs.showLoadingDialog(context, _keyLoader);
    try {
      await sendForm('https://whispering-shelf-45463.herokuapp.com/upload',
          {"image": pickedImage}, {"image": pickedImage});
      Fluttertoast.showToast(
          msg: "Image updated successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue[600],
          textColor: Colors.white,
          fontSize: 16.0);
      fetchUser();
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      setState(() {
        if (pickedImage != null) {
          print('successfully updated your profile picture');
        } else {
          print('NO image selected');
        }
      });
    } on HttpException {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      Fluttertoast.showToast(
          msg: "HTTP ERROR",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue[600],
          textColor: Colors.white,
          fontSize: 16.0);
    } on SocketException {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      Fluttertoast.showToast(
          msg: "Check your network connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue[600],
          textColor: Colors.white,
          fontSize: 16.0);
    } on DioError catch (e) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      Fluttertoast.showToast(
          msg: "Oops! something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue[600],
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
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
                                child: GestureDetector(
                                  onTap: () {
                                    getImage(context);
                                  },
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.width * 0.15,
                                backgroundImage: AssetImage('assets/user.png'),
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
