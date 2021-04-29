import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:synop/services/Auth.dart';
import 'package:synop/utils/constants.dart';
import 'package:synop/utils/loader.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  var name, email, password, district;

  final _formkey = GlobalKey<FormState>();

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/ty.jpg',
            alignment: Alignment.topCenter,
            fit: BoxFit.cover,
            color: Colors.blueGrey[900].withOpacity(0.8),
            colorBlendMode: BlendMode.darken,
          ),
          Container(
            margin: EdgeInsets.only(
              top: 100,
            ),
            child: Text(
              'SYNOP',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Sign in',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    color: Colors.blue[600],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    _Signup(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future _Signup(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.8),
                  offset: Offset(0.5, 0.5),
                  blurRadius: 20.9,
                )
              ],
              color: Colors.blueGrey[800],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  50,
                ),
                topRight: Radius.circular(
                  50,
                ),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Sign Up',
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
                              name = val;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please make sure to provide your name';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Name",
                              labelText: "Name",
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
                            enableSuggestions: true,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (val) {
                              email = val;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your email';
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
                                  Icons.email_outlined,
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
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: null,
                                border: Border.all(
                                  color: Colors.white,
                                )),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: 20,
                                    ),
                                    child: Icon(
                                      Icons.location_city,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Expanded(
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        icon: Icon(
                                          Icons.arrow_drop_down_sharp,
                                          color: Colors.white,
                                        ),
                                        isExpanded: true,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        dropdownColor: Colors.blueGrey[700],
                                        hint: Text(
                                          'Choose a district..',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        value: district,
                                        onChanged: (val) {
                                          setState(() {
                                            district = val;
                                          });
                                        },
                                        items: districts
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                              labelText: "Password",
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0)),
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                            onChanged: (val) {
                              password = val;
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
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
      },
    );
  }

  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showLoadingDialog(context, _keyLoader); //invoking login
      AuthService().createUser(name, email, district, password).then((val) {
        Fluttertoast.showToast(
            msg: "User successfully created",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue[600],
            textColor: Colors.white,
            fontSize: 16.0);
        Future.delayed(
          Duration(seconds: 3),
          () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        );
      });
      Navigator.of(_keyLoader.currentContext, rootNavigator: true)
          .pop(); //close the dialoge
    } catch (error) {
      print(error);
    }
  }
}
