import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:synop/services/Auth.dart';
import 'package:synop/utils/constants.dart';
import 'package:synop/utils/functions.dart';
import 'package:synop/utils/loader.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  var tok = Constants.prefs.getString('tk');
  Future<void> _showDialog(
      String title, String content, BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content, style: TextStyle(fontSize: 18)),
            actions: [
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        if (_formkey.currentState.validate()) {
                          try {
                            Dialogs.showLoadingDialog(context, _keyLoader);
                            AuthService().addCode(tok, content).then((val) {
                              Fluttertoast.showToast(
                                msg: "Synop added",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.blue[600],
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              Navigator.of(_keyLoader.currentContext,
                                      rootNavigator: true)
                                  .pop();
                              Navigator.pushReplacementNamed(context, '/home');
                            });
                          } on SocketException {
                            Navigator.of(_keyLoader.currentContext,
                                    rootNavigator: true)
                                .pop();
                            Fluttertoast.showToast(
                              msg: "No internet connection",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.blue[600],
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          } on HttpException {
                            Navigator.of(
                              _keyLoader.currentContext,
                              rootNavigator: true,
                            ).pop();
                            Fluttertoast.showToast(
                              msg: "Internal server error",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.blue[600],
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          } catch (e) {
                            Navigator.of(
                              _keyLoader.currentContext,
                              rootNavigator: true,
                            ).pop();
                            Fluttertoast.showToast(
                              msg: "Oops! something went wrong",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.blue[600],
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                        }
                      },
                      child: Text('Submit')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Go Back'))
                ],
              )
            ],
          );
        });
  }

  final _formkey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String dropdownvalue = 'm/s(est)';
  String ir = "Data included", ix = 'Data included';
  String rainfallDuration = '6 hours preceding observation';
  String low = 'No clouds', medium = 'No clouds', high = 'No clouds';
  String pastweather = 'Cloud cover 4 oktas or less';
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
  TextEditingController stationPressure = TextEditingController();
  TextEditingController seaPressure = TextEditingController();
  TextEditingController precipitation = TextEditingController();
  TextEditingController presentWeather = TextEditingController();
  TextEditingController isobaric = TextEditingController();
  TextEditingController extraWind = TextEditingController();

  var data = "m/s(est)", date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
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
                  color: textColor,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ))
            ],
          ),
          Text('Add Code',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 20,
              )),
          SizedBox(
            height: 20,
          ),
          Form(
            key: _formkey,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 22,
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(20),
                        color: bgColorSecondary,
                        onPressed: () {
                          showTimePicker(
                                  context: context,
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          alwaysUse24HourFormat: true),
                                      child: child,
                                    );
                                  },
                                  initialTime: TimeOfDay(hour: 06, minute: 00))
                              .then((value) {
                            setState(() {
                              if (value.hour < 10) {
                                date = "0${value.hour}";
                              } else {
                                date = value.hour;
                              }
                            });
                          });
                        },
                        child: Text(
                          'Select Time',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Wind speed units',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: bgColorSecondary,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: data,
                              dropdownColor: bgColorSecondary,
                              onChanged: (val) {
                                setState(() {
                                  data = val;
                                });
                              },
                              items: <String>[
                                'm/s(est)',
                                'm/s(anemometer)',
                                'knots(est)',
                                'knots(anemometer)',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      color: textColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Station number',
                style: TextStyle(color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 5),
                child: TextFormField(
                    enableSuggestions: true,
                    controller: stationnumber,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: "Station number",
                      labelText: "Station number",
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
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
              Text(
                'Rainfall data Availability',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: bgColorSecondary,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 6,
                      bottom: 6,
                    ),
                    child: Center(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          dropdownColor: bgColorSecondary,
                          value: ir,
                          onChanged: (val) {
                            setState(() {
                              ir = val;
                            });
                          },
                          items: rain_data_availability
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: textColor,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Present/past weather Inclusion',
                style: TextStyle(
                  color: textColor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: bgColorSecondary,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Center(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          dropdownColor: bgColorSecondary,
                          style: TextStyle(
                            color: textColor,
                          ),
                          value: ix,
                          onChanged: (val) {
                            setState(() {
                              ix = val;
                            });
                          },
                          items: present_past_data
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Height',
                style: TextStyle(color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 5),
                child: TextFormField(
                    enableSuggestions: true,
                    controller: cloud_height,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Cloud height (m)",
                      labelText: "Cloud height (m)",
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
                padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 5),
                child: TextFormField(
                    enableSuggestions: true,
                    controller: visibility,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please fill in this form';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Visibility (in Meters)",
                      labelText: "Visibility (Meters)",
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
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Cloud amount',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 5),
                child: TextFormField(
                    enableSuggestions: true,
                    controller: cloud_amount,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please fill this form';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Cloud amount (Oktas or eigths) e.g.. 1, /, 0",
                      labelText: "cloud amount (Oktas or eights)",
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
                'Wind direction',
                style: TextStyle(color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 5),
                child: TextFormField(
                  enableSuggestions: true,
                  controller: wind_direction,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Wind Direction (in degrees)",
                    labelText: "Wind Direction (in degrees)",
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.blue[600]),
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 1.0)),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Wind Speed',
                style: TextStyle(color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 5),
                child: TextFormField(
                    enableSuggestions: true,
                    controller: windSpeed,
                    keyboardType: TextInputType.number,
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
                padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 5),
                child: TextFormField(
                  enableSuggestions: true,
                  controller: temperature,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Air temperature ",
                    labelText: "Air temperature",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.blue[600],
                    ),
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 1.0)),
                    border: OutlineInputBorder(),
                  ),
                ),
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
                padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 5),
                child: TextFormField(
                    enableSuggestions: true,
                    controller: dewpoint,
                    keyboardType: TextInputType.number,
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
              SizedBox(
                height: 30,
              ),
              Text('Pressure',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30)),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 5),
                child: TextFormField(
                    enableSuggestions: true,
                    controller: stationPressure,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Station Pressure (hectopascals)",
                      labelText: "Station pressure (hectopascals)",
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(
                        color: Colors.blue[600],
                      ),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      border: OutlineInputBorder(),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Text('Isobaric pressure', style: TextStyle(color: Colors.white)),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 5),
                child: TextFormField(
                  enableSuggestions: true,
                  controller: isobaric,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "isobaric (hectopascals)",
                    labelText: "Isobaric standard (hectopascals)",
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.blue[600]),
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 1.0)),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text('Geopotential height',
                  style: TextStyle(
                    color: Colors.white,
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 5),
                child: TextFormField(
                    enableSuggestions: true,
                    controller: seaPressure,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Geopotential height",
                      labelText: "Geopotential height",
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
                'Precipitation',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 5),
                child: TextFormField(
                  enableSuggestions: true,
                  controller: precipitation,
                  enabled: ir == 'Data included' ? true : false,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Precipitation amount (Code figure)",
                    labelText: "Precipitation amount",
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: bgColorSecondary),
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 1.0)),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Rainfall duration',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              IgnorePointer(
                ignoring: ir == 'Data included' ? false : true,
                child: Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 2, 20.0, 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorChanger(ir, bgColorSecondary, disabledBtn),
                    ),
                    child: Center(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          dropdownColor: bgColorSecondary,
                          style: TextStyle(color: textColor),
                          value: rainfallDuration,
                          onChanged: (val) {
                            setState(() {
                              rainfallDuration = val;
                            });
                          },
                          items: rainDuration
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Present and Past Weather',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 5),
                  child: TextFormField(
                      enableSuggestions: true,
                      controller: presentWeather,
                      enabled: ix == 'Data included' ? true : false,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Present Weather (Code figure)",
                        labelText: "Present Weather (Code figure)",
                        labelStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.blue[600]),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        border: OutlineInputBorder(),
                      ))),
              SizedBox(
                height: 20,
              ),
              Text(
                'Past weather',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              IgnorePointer(
                ignoring: ix == 'Data included' ? false : true,
                child: Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorChanger(ix, bgColorSecondary, disabledBtn),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            dropdownColor: bgColorSecondary,
                            style: TextStyle(
                              color: textColor,
                            ),
                            value: pastweather,
                            onChanged: (val) {
                              setState(() {
                                pastweather = val;
                              });
                            },
                            items: pastWeather
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text('Cloud groups',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              Text(
                'Low clouds',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: bgColorSecondary,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Center(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: low,
                              dropdownColor: bgColorSecondary,
                              style: TextStyle(color: textColor),
                              onChanged: (val) {
                                setState(() {
                                  low = val;
                                });
                              },
                              items: lowCloudsOptions
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
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
              Text(
                'Middle clouds',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: bgColorSecondary,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: medium,
                            dropdownColor: bgColorSecondary,
                            style: TextStyle(color: textColor),
                            onChanged: (val) {
                              setState(() {
                                medium = val;
                              });
                              // print(data);
                            },
                            items: middleclouds
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
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
              Text(
                'High Clouds',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 5),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 2, 20.0, 2),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: bgColorSecondary,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: Center(
                      child: DropdownButton(
                        dropdownColor: bgColorSecondary,
                        style: TextStyle(
                          color: textColor,
                        ),
                        value: high,
                        onChanged: (val) {
                          setState(() {
                            high = val;
                          });
                          // print(data);
                        },
                        items: highclouds
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                child: RaisedButton(
                  disabledColor: Colors.red,
                  color: bgColorSecondary,
                  elevation: 10.5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    if (_formkey.currentState.validate()) {
                      var info = DateFormat('dd').format(selectedDate);
                      var station = stationnumber.text;
                      var cloudheight,
                          visible = visibility.text,
                          amount = cloud_amount.text,
                          direction = wind_direction.text,
                          speed = windSpeed.text;
                      var sign, dewSign, isobaricValue;
                      var geoHeight = seaPressure.text;
                      // var p_station = double.parse(stationPressure.text);
                      // var newPressure =
                      //     (((p_station * 100) / 100) * 10).round();
                      // var iso = int.parse(isobaric.text);
                      // var numtemp = double.parse(temperature.text),
                      //     rainfall = precipitation.text;
                      // var dewPoint = double.parse(dewpoint.text),
                      //     present = presentWeather.text,
                      //     past = pastWeather.text;
                      // var newTemp = (numtemp * 10).round().toString();
                      // var newDewPoint = (dewPoint * 10).round().toString();

                      // var windData = double.parse(speed).round();

                      // wind units
                      // if (data == "m/s(est)") {
                      //   setState(() {
                      //     data = "0";
                      //   });
                      // } else if (data == "m/s(anemometer)") {
                      //   setState(() {
                      //     data = "1";
                      //   });
                      // } else if (data == "knots(est)") {
                      //   setState(() {
                      //     data = "3";
                      //   });
                      // } else if (data == "knots(anemometer)") {
                      //   setState(() {
                      //     data = "4";
                      //   });
                      // }

                      // //windspeed units
                      // if (data == "3" || data == "4" && windData > 99) {
                      //   setState(() {
                      //     speed = "99";
                      //   });
                      // }

                      // //  rainfall data availability
                      // if (ir == 'Data included') {
                      //   setState(() {
                      //     ir = '1';
                      //   });
                      // } else if (ir == 'Precipitation equals 0') {
                      //   setState(() {
                      //     ir = '3';
                      //   });
                      // } else {
                      //   setState(() {
                      //     ir = "4";
                      //   });
                      // }

                      // // present and past weather data inclusion
                      // if (ix == 'Data included') {
                      //   setState(() {
                      //     ix = '1';
                      //   });
                      // } else if (ix == 'No significant Phenomena') {
                      //   setState(() {
                      //     ix = '2';
                      //   });
                      // } else {
                      //   setState(() {
                      //     ix = '3';
                      //   });
                      // }

                      // // cloud height
                      // if (int.parse(cloud_height.text) >= 0 &&
                      //     double.parse(cloud_height.text) < 50) {
                      //   setState(() {
                      //     cloudheight = 0;
                      //   });
                      // } else if (int.parse(cloud_height.text) >= 50 &&
                      //     double.parse(cloud_height.text) < 100) {
                      //   setState(() {
                      //     cloudheight = 1;
                      //   });
                      // } else if (int.parse(cloud_height.text) >= 100 &&
                      //     int.parse(cloud_height.text) < 200) {
                      //   setState(() {
                      //     cloudheight = 2;
                      //   });
                      // } else if (int.parse(cloud_height.text) >= 200 &&
                      //     int.parse(cloud_height.text) < 300) {
                      //   setState(() {
                      //     cloudheight = 3;
                      //   });
                      // } else if (int.parse(cloud_height.text) >= 300 &&
                      //     double.parse(cloud_height.text) < 600) {
                      //   setState(() {
                      //     cloudheight = 4;
                      //   });
                      // } else if (int.parse(cloud_height.text) >= 600 &&
                      //     double.parse(cloud_height.text) < 1000) {
                      //   setState(() {
                      //     cloudheight = 5;
                      //   });
                      // } else if (int.parse(cloud_height.text) >= 1000 &&
                      //     int.parse(cloud_height.text) < 1500) {
                      //   setState(() {
                      //     cloudheight = 6;
                      //   });
                      // } else if (int.parse(cloud_height.text) >= 1500 &&
                      //     double.parse(cloud_height.text) < 2000) {
                      //   setState(() {
                      //     cloudheight = 7;
                      //   });
                      // } else if (int.parse(cloud_height.text) >= 2000 &&
                      //     double.parse(cloud_height.text) < 2500) {
                      //   setState(() {
                      //     cloudheight = 8;
                      //   });
                      // } else if (int.parse(cloud_height.text) >= 2500 ||
                      //     cloud_height.text == "no clouds") {
                      //   setState(() {
                      //     cloudheight = 9;
                      //   });
                      // } else {
                      //   setState(() {
                      //     cloudheight = '/';
                      //   });
                      // }

                      // // temperature sign
                      // if (numtemp > 0 || numtemp == 0) {
                      //   setState(() {
                      //     sign = 0;
                      //   });
                      // } else {
                      //   setState(() {
                      //     sign = 1;
                      //   });
                      // }

                      // // isobaric standard surface
                      // if (iso == 1000) {
                      //   setState(() {
                      //     isobaricValue = 1;
                      //   });
                      // } else if (iso == 925) {
                      //   setState(() {
                      //     isobaricValue = 2;
                      //   });
                      // } else if (iso == 500) {
                      //   setState(() {
                      //     isobaricValue = 5;
                      //   });
                      // } else if (iso == 700) {
                      //   setState(() {
                      //     isobaricValue = 7;
                      //   });
                      // } else if (iso == 850) {
                      //   setState(() {
                      //     isobaricValue = 8;
                      //   });
                      // } else {
                      //   setState(() {
                      //     isobaricValue = '/';
                      //   });
                      //   Fluttertoast.showToast(msg: "Value does not exit");
                      // }

                      // // dew point temperature sign
                      // if (dewPoint > 0 || dewPoint == 0) {
                      //   setState(() {
                      //     dewSign = 0;
                      //   });
                      // } else {
                      //   setState(() {
                      //     dewSign = 1;
                      //   });
                      // }

                      // if (dewPoint > 0 && dewPoint < 10) {
                      //   setState(() {
                      //     newDewPoint = '0$newDewPoint';
                      //   });
                      // }

                      var visibility_data =
                          visibilityinfo.visibilityData(int.parse(visible));
                      print(visibility_data);

                      // wind direction data
                      var windDirection = WindData.windDirection(direction);

                      // rainfall duration
                      var duration = RainDuration.rain(rainfallDuration);

                      var past_weather_data =
                          PastweatherData.PastWeatherChecker(pastweather);

                      var lowClouds = LowClouds.Low(low);
                      var middleClouds = MiddleClouds.Middle(medium);
                      var highClouds = HighClouds.High(high);

//                       var finalSting = 'AAXX ' +
//                           info +
//                           '$date' +
//                           '$data ' +
//                           '67$station ' +
//                           ir +
//                           ix +
//                           '$cloudheight' +
//                           visibility_data +
//                           ' $amount' +
//                           windDirection +
//                           '$speed 1$sign' +
//                           newTemp +
//                           ' 2$dewSign' +
//                           newDewPoint +
//                           ' 3$newPressure 4$isobaricValue' +
//                           geoHeight +
//                           ' 6$rainfall' +
//                           duration +
//                           ' 8$amount' +
//                           lowClouds +
//                           middleClouds +
//                           highClouds;

//                       var noraindata1 = 'AAXX ' +
//                           info +
//                           '$date' +
//                           '$data ' +
//                           '67$station ' +
//                           ir +
//                           ix +
//                           '$cloudheight' +
//                           visibility_data +
//                           ' $amount' +
//                           windDirection +
//                           '$speed 1$sign' +
//                           newTemp +
//                           ' 2$dewSign' +
//                           newDewPoint +
//                           ' 3$newPressure 4$isobaricValue' +
//                           geoHeight +
//                           ' 8$amount' +
//                           lowClouds +
//                           middleClouds +
//                           highClouds;

//                       var thirdString = 'AAXX ' +
//                           info +
//                           '$date' +
//                           '$data ' +
//                           '67$station ' +
//                           ir +
//                           ix +
//                           '$cloudheight' +
//                           visibility_data +
//                           ' $amount' +
//                           windDirection +
//                           '$speed 00$windData 1$sign' +
//                           newTemp +
//                           ' 2$dewSign' +
//                           newDewPoint +
//                           ' 3$newPressure 4$isobaricValue' +
//                           geoHeight +
//                           ' 6$rainfall' +
//                           duration +
//                           ' 8$amount' +
//                           low +
//                           medium +
//                           high;

//                       var noraindata2 = 'AAXX ' +
//                           info +
//                           '$date' +
//                           '$data ' +
//                           '67$station ' +
//                           ir +
//                           ix +
//                           '$cloudheight' +
//                           visibility_data +
//                           ' $amount' +
//                           windDirection +
//                           '$speed 00$windData 1$sign' +
//                           newTemp +
//                           ' 2$dewSign' +
//                           newDewPoint +
//                           ' 3$newPressure 4$isobaricValue' +
//                           geoHeight +
//                           ' 8$amount' +
//                           low +
//                           medium +
//                           high;

// // second string
//                       var secondString = 'AAXX ' +
//                           info +
//                           '$date' +
//                           '$data ' +
//                           '67$station ' +
//                           ir +
//                           ix +
//                           '$cloudheight' +
//                           visibility_data +
//                           ' $amount' +
//                           windDirection +
//                           '$speed 1$sign' +
//                           newTemp +
//                           ' 2$dewSign' +
//                           newDewPoint +
//                           ' 3$newPressure 4$isobaricValue' +
//                           geoHeight +
//                           ' 6$rainfall' +
//                           duration +
//                           '7$present' +
//                           past +
//                           ' 8$amount' +
//                           low +
//                           medium +
//                           high;

//                       var noraindata3 = 'AAXX ' +
//                           info +
//                           '$date' +
//                           '$data ' +
//                           '67$station ' +
//                           ir +
//                           ix +
//                           '$cloudheight' +
//                           visibility_data +
//                           ' $amount' +
//                           windDirection +
//                           '$speed 1$sign' +
//                           newTemp +
//                           ' 2$dewSign' +
//                           newDewPoint +
//                           ' 3$newPressure 4$isobaricValue' +
//                           geoHeight +
//                           '7$present' +
//                           past_weather_data +
//                           ' 8$amount' +
//                           low +
//                           medium +
//                           high;

//                       var FourthString = 'AAXX ' +
//                           info +
//                           '$date' +
//                           '$data ' +
//                           '67$station ' +
//                           ir +
//                           ix +
//                           '$cloudheight' +
//                           visibility_data +
//                           ' $amount' +
//                           windDirection +
//                           '$speed 00$windData 1$sign' +
//                           newTemp +
//                           ' 2$dewSign' +
//                           newDewPoint +
//                           ' 3$newPressure 4$isobaricValue' +
//                           geoHeight +
//                           ' 6$rainfall' +
//                           duration +
//                           '7$present' +
//                           past_weather_data +
//                           ' 8$amount' +
//                           low +
//                           medium +
//                           high;

//                       var noraindata4 = 'AAXX ' +
//                           info +
//                           '$date' +
//                           '$data ' +
//                           '67$station ' +
//                           ir +
//                           ix +
//                           '$cloudheight' +
//                           visibility_data +
//                           ' $amount' +
//                           windDirection +
//                           '$speed 00$windData 1$sign' +
//                           newTemp +
//                           ' 2$dewSign' +
//                           newDewPoint +
//                           ' 3$newPressure 4$isobaricValue' +
//                           geoHeight +
//                           ' 7$present' +
//                           past_weather_data +
//                           ' 8$amount' +
//                           low +
//                           medium +
//                           high;

//                       // show dialog
//                       if (ix == '1') {
//                         if (data == "3" || data == "4" && windData > 99) {
//                           if (ir == '3' || ir == '4') {
//                             _showDialog("Verify Synop", noraindata4, context);
//                           } else {
//                             _showDialog("Verify Synop", FourthString, context);
//                           }
//                         } else {
//                           if (ir == '3' || ir == '4') {
//                             _showDialog("Verify Synop", noraindata3, context);
//                           } else {
//                             _showDialog("Verify Synop", secondString, context);
//                           }
//                         }
//                       } else {
//                         if (data == "3" || data == "4" && windData > 99) {
//                           if (ir == '3' || ir == '4') {
//                             _showDialog('Verify Synop', noraindata2, context);
//                           } else {
//                             _showDialog('Verify Synop', thirdString, context);
//                           }
//                         } else {
//                           if (ir == '3' || ir == '4') {
//                             _showDialog('Verify Synop', noraindata1, context);
//                           } else {
//                             _showDialog('Verify Synop', finalSting, context);
//                           }
//                         }
//                       }
                    }
                  },
                ),
              ),
              SizedBox(
                height: 30,
              )
            ]),
          )
        ],
      ),
    );
  }
}
