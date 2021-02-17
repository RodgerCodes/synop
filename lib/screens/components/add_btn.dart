import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:synop/services/Auth.dart';
import 'package:synop/utils/constants.dart';
import 'package:synop/utils/loader.dart';

class Btn extends StatefulWidget {
  @override
  _BtnState createState() => _BtnState();
}

class _BtnState extends State<Btn> {
  var code_field, date;
  bool showProgressLoading = false;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  var tok = Constants.prefs.getString("tk");
  final _key = GlobalKey<FormState>();
  Future<String> createAlertBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.blueGrey[900],
            title: Text(
              'Add New code',
              style: TextStyle(color: Colors.white),
            ),
            content: Form(
              key: _key,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Fill in the form";
                  }

                  if (value.contains('AAXX')) {
                    return 'Please just enter the number';
                  }

                  return null;
                },
                onChanged: (val) {
                  code_field = val;
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: "Code",
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: "Enter the code here",
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 1.0)),
                    border: OutlineInputBorder()),
              ),
            ),
            actions: [
              MaterialButton(
                elevation: 30.5,
                onPressed: () {
                  if (_key.currentState.validate()) {
                    // backend function
                    // _handleSubmit(context);
                    Dialogs.showLoadingDialog(
                        context, _keyLoader); //invoking login

                    AuthService().addCode(tok, 'AAXX$code_field').then((val) {
                      Fluttertoast.showToast(
                          msg: "Code Submitted",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.blue,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Navigator.pop(context);
                      Navigator.of(_keyLoader.currentContext,
                              rootNavigator: true)
                          .pop();
                    });
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 30.5,
      child: Icon(
        Icons.add,
      ),
      backgroundColor: Colors.blue[600],
      onPressed: () {
        createAlertBox(context);
      },
    );
  }

  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showLoadingDialog(context, _keyLoader); //invoking login

      Navigator.of(_keyLoader.currentContext, rootNavigator: true)
          .pop(); //close the dialoge

    } catch (error) {
      print(error);
    }
  }
}

mixin _keyLoader {}
