import 'package:flutter/material.dart';
import 'package:synop/services/Auth.dart';
import 'package:synop/utils/constants.dart';

class drawercomponent extends StatefulWidget {
  @override
  _drawercomponentState createState() => _drawercomponentState();
}

class _drawercomponentState extends State<drawercomponent> {
  var user;
  var tok = Constants.prefs.getString("tk");
  var placeholder =
      'https://www.dovercourt.org/wp-content/uploads/2019/11/610-6104451_image-placeholder-png-user-profile-placeholder-image-png.jpg';
  void fetchUser() {
    AuthService().getinfo(tok).then((val) {
      user = val.data;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: user != null
            ? Container(
                color: Colors.blueGrey[900],
                child: ListView(
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: Colors.blue[600]),
                      accountName: Text(
                        user['msg']['name'],
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      accountEmail: Text(
                        user['msg']['email'],
                        style: TextStyle(fontSize: 17.0),
                      ),
                      currentAccountPicture: user['msg']['profile_img'] != null
                          ? CircleAvatar(
                              backgroundImage:
                                  NetworkImage(user['msg']['profile_img']),
                            )
                          : CircleAvatar(
                              backgroundImage: NetworkImage(placeholder),
                            ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        size: 30.7,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Profile',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      subtitle: Text(
                        user['msg']['name'],
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Container(
                      child: user['msg']['role'] == 'Admin'
                          ? ListTile(
                              leading: Icon(
                                Icons.admin_panel_settings,
                                size: 30,
                                color: Colors.white,
                              ),
                              title: Text(
                                "Create a User",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              onTap: () {},
                            )
                          : null,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 30,
                      ),
                      title: Text(
                        'Settings',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                        onTap: () {
                          Constants.prefs.setBool("loggedin", false);
                          Constants.prefs.setString("tk", null);
                          Navigator.pushReplacementNamed(context, '/wrapper');
                        },
                        leading: Icon(
                          Icons.logout,
                          size: 30,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ))
                  ],
                ),
              )
            : Container(
                color: Colors.blueGrey[900],
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ));
  }
}
