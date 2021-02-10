import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:synop/services/Auth.dart';
import 'package:synop/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  var email, password, token;
  var visible = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: TextStyle(
                    color: Colors.black,
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
                        decoration: InputDecoration(
                            hintText: "Email",
                            labelText: "Email",
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.person),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1.0)),
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(color: Colors.grey)),
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
                        decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.lock),
                            ),
                            suffixIcon: FlatButton(
                              child: Icon(Icons.visibility),
                              onPressed: () {
                                visible = !visible;
                                setState(() {});
                              },
                            ),
                            labelText: "Password",
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1.0)),
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(color: Colors.grey)),
                        obscureText: visible,
                        onChanged: (val) {
                          password = val;
                        },
                      )
                    ],
                  ),
                ),
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
                        }
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
    );
  }
}
