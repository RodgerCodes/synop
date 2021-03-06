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
  String ir = '0', ix = '1';
  TextEditingController stationnumber = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController cloud_height = TextEditingController();
  TextEditingController visibility = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController cloud_amount = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController wind_direction = TextEditingController();
  TextEditingController windSpeed = TextEditingController();
  TextEditingController temperature = TextEditingController();
  TextEditingController dewpoint = TextEditingController();

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
            child: Column(children: [
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
                  Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.cyan),
                    child: DropdownButton(
                      value: dropdownvalue,
                      onChanged: (val) {
                        setState(() {
                          data = val;
                        });
                        print(data);
                      },
                      items: <String>['0', '1', '3', '4', '/']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50.0, 40, 50.0, 5),
                child: TextFormField(
                    enableSuggestions: true,
                    controller: stationnumber,
                    keyboardType: TextInputType.number,
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
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Rainfall Data',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.cyan),
                    child: DropdownButton(
                      value: ir,
                      onChanged: (val) {
                        setState(() {
                          ir = val;
                        });
                        print(ir);
                      },
                      items: <String>['0', '1', '2', '3', '4']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    // color: Colors.white,
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.cyan),
                    child: DropdownButton(
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      value: ix,
                      onChanged: (val) {
                        setState(() {
                          ix = val;
                        });
                        print(ix);
                      },
                      items: <String>['0', '1', '2', '3']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Height',
                style: TextStyle(color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50.0, 10, 50.0, 5),
                child: TextFormField(
                    enableSuggestions: true,
                    controller: cloud_height,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter th cloud height';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Cloud height",
                      labelText: "Cloud height",
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.blue[600]),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      border: OutlineInputBorder(),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Visibility',
                style: TextStyle(color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50.0, 10, 50.0, 5),
                child: TextFormField(
                    enableSuggestions: true,
                    controller: cloud_height,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the visibility';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Visibility (enter code figure)",
                      labelText: "Visibility (code figure)",
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.blue[600]),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      border: OutlineInputBorder(),
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Cloud Cover and wind',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Cloud amount(eigth)',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50.0, 10, 50.0, 5),
                child: TextFormField(
                    enableSuggestions: true,
                    controller: cloud_amount,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the cloud amount';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Cloud amount ",
                      labelText: "cloud amount",
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.blue[600]),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      border: OutlineInputBorder(),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Wind direction (code figure)',
                style: TextStyle(color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50.0, 10, 50.0, 5),
                child: TextFormField(
                    enableSuggestions: true,
                    controller: wind_direction,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the code figure for wind direction';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Wind Direction (enter code figure)",
                      labelText: "Wind Direction (code figure)",
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.blue[600]),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      border: OutlineInputBorder(),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Wind Speed',
                style: TextStyle(color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50.0, 10, 50.0, 5),
                child: TextFormField(
                    enableSuggestions: true,
                    controller: windSpeed,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the windspeed';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "WindSpeed",
                      labelText: "Windspeed",
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.blue[600]),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      border: OutlineInputBorder(),
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Temperature',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50.0, 10, 50.0, 5),
                child: TextFormField(
                    enableSuggestions: true,
                    controller: temperature,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the Temperature';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Air temperature",
                      labelText: "Air tempearature",
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.blue[600]),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      border: OutlineInputBorder(),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Dew point temperature',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50.0, 10, 50.0, 5),
                child: TextFormField(
                    enableSuggestions: true,
                    controller: dewpoint,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the Temperature';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Dew point temperature",
                      labelText: "Dew point tempearature",
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.blue[600]),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      border: OutlineInputBorder(),
                    )),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
