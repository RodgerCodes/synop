import 'package:flutter/material.dart';

class Forms extends StatelessWidget {
  const Forms({
    Key key,
    @required this.size,
    @required this.formkey,
    @required this.email,
    @required this.password,
    @required this.visible,
  }) : super(key: key);

  final Size size;
  final GlobalKey<FormState> formkey;
  final TextEditingController email;
  final TextEditingController password;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              'Welcome to Synop',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    TextField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
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
                    TextField(
                        controller: password,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.lock),
                            ),
                            suffixIcon: FlatButton(
                              child: Icon(Icons.visibility),
                              onPressed: () {},
                            ),
                            labelText: "Password",
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1.0)),
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(color: Colors.grey)),
                        obscureText: visible)
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
                },
              ),
            ),
            FlatButton(
                onPressed: null,
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
    );
  }
}
