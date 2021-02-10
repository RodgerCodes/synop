import 'package:flutter/material.dart';
import 'package:synop/services/Auth.dart';
import 'package:synop/utils/constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var tok = Constants.prefs.getString("tk");
  var code;
  void fetchUser() {
    AuthService().getCode(tok).then((val) {
      code = val.data;
      setState(() {});
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[600],
          title: Text('SYNOP'),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () {
                  Constants.prefs.setBool("loggedin", false);
                  Navigator.pushReplacementNamed(context, '/login');
                })
          ],
        ),
        body: code != null
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 2),
                    child: Container(
                      height: size.height * 0.14,
                      child: Card(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        elevation: 20.5,
                        child: ListTile(
                          title: Text(
                            code[index]['creator']['name'],
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Text(
                              code[index]['code'],
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: code.length,
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
        drawer: Drawer(
          child: ListView(
            children: [UserAccountsDrawerHeader()],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          backgroundColor: Colors.blue[600],
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
