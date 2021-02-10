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
  void fetchData() {
    AuthService().getCode(tok).then((val) {
      code = val.data;
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          elevation: 20.6,
          title: Text('SYNOP'),
          centerTitle: true,
          actions: [Logout()],
        ),
        body: code != null
            ? Container(
                color: Colors.grey[800],
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 2),
                      child: Container(
                        height: size.height * 0.14,
                        child: Card(
                          color: Colors.grey[900],
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          elevation: 20.5,
                          child: ListTile(
                            title: Text(
                              code[index]['creator']['name'],
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text(
                                code[index]['code'],
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: code.length,
                ),
              )
            : Container(
                color: Colors.grey[800],
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
        drawer: drawercomponent(),
        floatingActionButton: Btn(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
