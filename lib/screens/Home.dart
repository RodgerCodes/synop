import 'dart:async';
import 'dart:io';
import 'package:calendar_strip/calendar_strip.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:synop/screens/components/Indicator.dart';
import 'package:synop/screens/components/add_btn.dart';
import 'package:synop/screens/components/drawer.dart';
import 'package:synop/screens/components/popmenu.dart';
import 'package:synop/services/Auth.dart';
import 'package:synop/services/Connectivity.dart';
import 'package:synop/utils/constants.dart';
import 'package:synop/utils/loader.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var tok = Constants.prefs.getString("tk");
  var del, user, rebuild;
  bool networkError = false;
  String date, tk;
  Timer timer;
  List code;
  Dio dio = new Dio();
  var url = "https://whispering-shelf-45463.herokuapp.com/code";
  // var url = "http://10.0.2.2:5000/code";

  Future fetchData() async {
    try {
      // dio.options.headers['authorization'] = 'Bearer $tok';
      // AuthService().getCode(tok).then((val) async {
      //   code = val.data;
      //   setState(() {});
      //   await Future.delayed(Duration(seconds: 4), () {
      //     setState(() {
      //       allCodes = [];
      //     });
      //   });
      //   for (int i = 0; i < code.length; i++) {
      //     var info = code[i]['createdAt'];
      //     DateTime tday = DateTime.parse(info);
      //     var formatedDate = DateFormat('yyyy-MM-dd').format(tday);
      //     if (DateFormat('yyyy-MM-dd').format(DateTime.now()) == formatedDate) {
      //       setState(() {
      //         allCodes.add(code[i]);
      //       });
      //     }
      //   }
      // });
      var data = await dio.get(url);
      setState(() {
        code = data.data;
      });

      setState(() {
        allCodes = [];
      });
      for (int i = 0; i < code.length; i++) {
        var info = code[i]['createdAt'];
        DateTime tday = DateTime.parse(info);
        var formatedDate = DateFormat('yyyy-MM-dd').format(tday);
        if (DateFormat('yyyy-MM-dd').format(DateTime.now()) == formatedDate) {
          setState(() {
            allCodes.add(code[i]);
          });
        }
      }
      AuthService().getinfo(tok).then((val) {
        user = val.data;
        setState(() {});
      });
    } on DioError catch (e) {
      setState(() {
        networkError = true;
      });
    }
  }

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  DateTime startDate = DateTime.now().subtract(Duration(days: 100));
  DateTime endDate = DateTime.now().add(Duration(days: 100));
  DateTime selectedDate = DateTime.now();
  List<DateTime> markedDates = [];
  List allCodes;
  ScrollController _controller;

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
  }

  @override
  void initState() {
    // CheckInternet().CheckConnection(context);
    fetchData();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
    if (formatDate(DateTime.now(), [HH, ':', nn]) == '08:10') {
      timer = Timer.periodic(Duration(seconds: 5), (Timer t) => fetchData());
    }
  }

  @override
  void dispose() {
    // CheckInternet().listener.cancel();
    super.dispose();
  }

  onSelect(data) {
    try {
      setState(() {
        selectedDate = data;
      });
      setState(() {
        allCodes.clear();
      });
      for (int i = 0; i < code.length; i++) {
        date = code[i]['createdAt'];
        DateTime tday = DateTime.parse(date);
        var formatedDate = DateFormat('yyyy-MM-dd').format(tday);
        if (DateFormat('yyyy-MM-dd').format(data) == formatedDate) {
          setState(() {
            allCodes.add(code[i]);
          });
        }
      }
    } on SocketException {
      setState(() {
        networkError = true;
      });
    }
  }

  onWeekSelect(data) {
    // print("Selected week starting at -> $data");
  }

  _monthNameWidget(monthName) {
    return Container(
      child: Text(monthName,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontStyle: FontStyle.italic)),
      padding: EdgeInsets.only(top: 8, bottom: 4),
    );
  }

  getMarkedIndicatorWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.only(left: 1, right: 1),
        width: 7,
        height: 7,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
      ),
      Container(
        width: 7,
        height: 7,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: bgColorSecondary),
      )
    ]);
  }

  dateTileBuilder(
      date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    Color fontColor = isDateOutOfRange ? Colors.white10 : Colors.white;
    TextStyle normalStyle =
        TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: fontColor);
    TextStyle selectedStyle = TextStyle(
        fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87);
    TextStyle dayNameStyle = TextStyle(fontSize: 13.5, color: fontColor);
    List<Widget> _children = [
      Text(dayName, style: dayNameStyle),
      Text(date.day.toString(),
          style: !isSelectedDate ? normalStyle : selectedStyle),
    ];

    if (isDateMarked == true) {
      _children.add(getMarkedIndicatorWidget());
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        color: !isSelectedDate ? Colors.transparent : bgColorSecondary,
        borderRadius: BorderRadius.all(Radius.circular(60)),
      ),
      child: Column(
        children: _children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey<Object>(rebuild),
      appBar: AppBar(
        backgroundColor: bgPrimary,
        elevation: 20.6,
        title: Text(
          'SYNOP',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          Popmenubtn(),
        ],
        toolbarHeight: 70,
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
                child: CalendarStrip(
              startDate: startDate,
              endDate: endDate,
              selectedDate: selectedDate,
              onDateSelected: onSelect,
              onWeekSelected: onWeekSelect,
              dateTileBuilder: dateTileBuilder,
              iconColor: Colors.blue[300],
              monthNameWidget: _monthNameWidget,
              containerDecoration: BoxDecoration(color: bgPrimary),
              addSwipeGesture: true,
            )),
            Container(
              child: allCodes != null
                  ? allCodes.isNotEmpty
                      ? ListView.builder(
                          controller: _controller, //new line
                          itemCount: allCodes.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var tday = allCodes[index]['createdAt'];
                            var dd = DateTime.parse(tday);
                            var formateddate = DateFormat.jms().format(dd);
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 2),
                              child: Container(
                                height: 210,
                                width: double.infinity,
                                child: Card(
                                  color: Colors.blueGrey[800],
                                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  elevation: 0.5,
                                  child: ListTile(
                                      key: Key(allCodes[index]['_id']),
                                      title: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 0),
                                        child: Text(
                                          allCodes[index]['creator']['name'],
                                          style: TextStyle(
                                              fontSize: 20, color: Colors.blue),
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Text(
                                              allCodes[index]['code'],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  letterSpacing: 1.3),
                                            ),
                                          ),
                                          Text(
                                            allCodes[index]['creator']
                                                ['district'],
                                            style: TextStyle(
                                                color: Colors.blue[600]),
                                          ),
                                          Text(formateddate,
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                      trailing: allCodes[index]['creator']
                                                  ['_id'] ==
                                              user['msg']['_id']
                                          ? IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  del = allCodes[index]['_id'];
                                                  // isSelected = true;
                                                });
                                                Dialogs.showLoadingDialog(
                                                    context, _keyLoader);
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
                                                  fetchData();
                                                  Future.delayed(
                                                      Duration(seconds: 3), () {
                                                    Navigator.of(
                                                            _keyLoader
                                                                .currentContext,
                                                            rootNavigator: true)
                                                        .pop();
                                                  });
                                                });

                                                //
                                              },
                                            )
                                          : Text('')),
                                ),
                              ),
                            );
                          })
                      : Container(
                          height: 200,
                          child: Center(
                            child: Text(
                              "No Codes available",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        )
                  : networkError == true
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.wifi_off,
                                  size: MediaQuery.of(context).size.width * 0.6,
                                  color: textColor,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Check your internet connection',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                RaisedButton(
                                  onPressed: () {
                                    fetchData();
                                    setState(() {
                                      rebuild = Object();
                                    });
                                  },
                                  child: Text('Refresh'),
                                )
                              ],
                            ),
                          ),
                        )
                      : Indicator(),
            ),
          ],
        ),
      ),
      drawer: drawercomponent(),
      floatingActionButton: Btn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
