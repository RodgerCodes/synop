import 'dart:async';
import 'package:flutter/material.dart';
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
  var code;
  // ignore: non_constant_identifier_names
  Timer timer;
  Future fetchData() async {
    AuthService().getCode(tok).then((val) {
      code = val.data;
      setState(() {});
      // print(code);
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
                              height: 130,
                              decoration: BoxDecoration(),
                              child: Card(
                                color: Colors.blueGrey[900],
                                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                elevation: 30.5,
                                child: ListTile(
                                  title: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                    child: Text(
                                      code[index]['creator']['name'],
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.blue),
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 10, 0, 5),
                                    child: Text(
                                      code[index]['code'],
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          letterSpacing: 2),
                                    ),
                                  ),
                                ),
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
