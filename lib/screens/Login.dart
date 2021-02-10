import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:synop/services/Auth.dart';
import 'package:synop/utils/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  var email, password, token;
  var visible = true;
  bool showProgressLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: showProgressLoading,
      child: Scaffold(
        backgroundColor: Colors.grey[850],
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
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
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
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
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
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
                        setState(() {
                          showProgressLoading = true;
                        });
                        AuthService().login(email, password).then((val) {
                          if (val.data['success']) {
                            token = val.data['token'];
                            Fluttertoast.showToast(
                                msg: "Authenticated",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Constants.prefs.setBool("loggedin", true);
                            Constants.prefs.setString("tk", token);
                            Navigator.pushReplacementNamed(
                              context,
                              "/home",
                            );
                          } else {
                            Fluttertoast.showToast(
                                msg: "Password incorrect",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }

                          setState(() {
                            showProgressLoading = false;
                          });
                        });
                      }
                    },
                  ),
                ),
                FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.blue[400],
                        fontSize: 16,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
