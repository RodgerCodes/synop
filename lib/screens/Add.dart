import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final _formkey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String dropdownvalue = '1';
  TextEditingController stationnumber = TextEditingController();
  var data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              Positioned(
                  child: IconButton(
                icon: Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {},
              ))
            ],
          ),
          Text('Add Code',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              )),
          Form(
            key: _formkey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // FlatButton(
                    //   onPressed: () {
                    //     print(DateFormat('dd').format(selectedDate));
                    //   },
                    //   child: Text('Select Date'),
                    // )
                    FlatButton(
                      onPressed: () {
                        showTimePicker(
                            context: context,
                            builder: (BuildContext context, Widget child) {
                              return MediaQuery(
                                  data: MediaQuery.of(context)
                                      .copyWith(alwaysUse24HourFormat: true),
                                  child: child);
                            },
                            initialTime: TimeOfDay(hour: 06, minute: 00));
                      },
                      child: Text(
                        'Select Time',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                    DropdownButton(
                      value: dropdownvalue,
                      onChanged: (val) {
                        setState(() {
                          data = val;
                          print(data);
                        });
                      },
                      items: <String>['0', '1', '3', '4', '/']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ],
                ),
                TextFormField(
                    enableSuggestions: true,
                    controller: stationnumber,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the requires info';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Station number",
                      labelText: "Station number",
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      border: OutlineInputBorder(),
                    )),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Rainfall',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
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
}
