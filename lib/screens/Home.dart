import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:synop/screens/components/add_btn.dart';
import 'package:synop/screens/components/drawer.dart';
import 'package:synop/screens/components/logout_btn.dart';
import 'package:synop/services/Auth.dart';
import 'package:synop/utils/constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var tok = Constants.prefs.getString("tk");
  var code, del, user;
  String date;
  // ignore: non_constant_identifier_names
  Timer timer;
  bool isSelected = false;
  Future fetchData() async {
    AuthService().getCode(tok).then((val) {
      code = val.data;
      setState(() {});
      // print(code);
    });
    AuthService().getinfo(tok).then((val) {
      user = val.data;
      setState(() {});
      // print(user);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => fetchData());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          elevation: 20.6,
          title: Text(
            'SYNOP',
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
          actions: [Logout()],
          toolbarHeight: 70,
        ),
        body: code != null
            ? code != []
                ? RefreshIndicator(
                    onRefresh: fetchData,
                    child: Container(
                      color: Colors.blueGrey[800],
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 2),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.23,
                              width: double.infinity,
                              child: Card(
                                color: Colors.blueGrey[900],
                                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                elevation: 30.5,
                                child: ListTile(
                                    key: Key(code[index]['_id']),
                                    title: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Text(
                                        code[index]['creator']['name'],
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.blue),
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 5),
                                      child: Text(
                                        code[index]['code'],
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            letterSpacing: 1.3),
                                      ),
                                    ),
                                    trailing: code[index]['creator']['_id'] ==
                                            user['msg']['_id']
                                        ? IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                del = code[index]['_id'];
                                                // isSelected = true;
                                              });
                                              AuthService()
                                                  .deleteCode(tok, del)
                                                  .then((val) {
                                                Fluttertoast.showToast(
                                                    msg: val.data['msg'],
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.TOP,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.blue,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              });
                                              fetchData();
                                              setState(() {
                                                isSelected = false;
                                              });
                                            },
                                          )
                                        : Text('')),
                              ),
                            ),
                          );
                        },
                        itemCount: code.length,
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      'There is nothing inside',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  )
            : Container(
                color: Colors.blueGrey[800],
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
        drawer: drawercomponent(),
        floatingActionButton: Btn(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
