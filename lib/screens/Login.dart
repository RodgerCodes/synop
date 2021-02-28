import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:synop/utils/constants.dart';
import 'package:synop/utils/loader.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  var email, password, token;
  var visible = true;
  Dio dio = new Dio();
  var url = "https://blooming-earth-69373.herokuapp.com";
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  bool showProgressLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        enableSuggestions: true,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (val) {
                          email = val;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the requires info';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Email",
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.white),
                          hintStyle: TextStyle(color: Colors.white),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Password",
                          focusColor: Colors.white,
                          hintStyle: TextStyle(color: Colors.white),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                          ),
                          suffixIcon: FlatButton(
                            child: Icon(
                              Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              visible = !visible;
                              setState(() {});
                            },
                          ),
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          border: OutlineInputBorder(),
                        ),
                        obscureText: visible,
                        onChanged: (val) {
                          password = val;
                        },
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: size.width * 0.8,
                height: 50,
                child: RaisedButton(
                  disabledColor: Colors.red,
                  color: Colors.blue,
                  elevation: 10.5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Text('Sign In',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    // TOD0:Implement backend functionality
                    if (_formkey.currentState.validate()) {
                      _handleSubmit(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showLoadingDialog(context, _keyLoader); //invoking login
      try {
        await dio.post('$url/signin',
            data: {"email": email, "password": password},
            options: Options(contentType: Headers.formUrlEncodedContentType));
        Fluttertoast.showToast(
            msg: "Authenticated",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue[600],
            textColor: Colors.white,
            fontSize: 16.0);
        Constants.prefs.setBool("loggedin", true);
        Constants.prefs.setString("tk", token);
        Navigator.pushReplacementNamed(context, '/home');
      } on DioError catch (e) {
        Fluttertoast.showToast(
            msg: e.response.data['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue[600],
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      }
      // Navigator.of(_keyLoader.currentContext, rootNavigator: true)
      //     .pop(); //close the dialoge
    } catch (error) {
      print(error);
    }
  }
}
