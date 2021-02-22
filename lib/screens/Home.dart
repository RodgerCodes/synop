import 'dart:async';
import 'package:calendar_strip/calendar_strip.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:synop/screens/components/add_btn.dart';
import 'package:synop/screens/components/drawer.dart';
import 'package:synop/screens/components/logout_btn.dart';
import 'package:synop/services/Auth.dart';
import 'package:synop/utils/constants.dart';
import 'package:synop/utils/loader.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var tok = Constants.prefs.getString("tk");
  var code, del, user;
  String date, tk;
  Timer timer;

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

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  DateTime startDate = DateTime.now().subtract(Duration(days: 15));
  DateTime endDate = DateTime.now().add(Duration(days: 15));
  DateTime selectedDate = DateTime.now();
  List<DateTime> markedDates = [];
  List allCodes = [];
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
    fetchData();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    // TODO: implement initState
    super.initState();
    // get synoptic codes
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => fetchData());
  }

  onSelect(data) {
    fetchData();
    setState(() {
      allCodes.clear();
    });
    // String tii = data;
    // DateTime gg = DateTime.parse(data);
    var foo = DateFormat('yyyy-MM-dd').format(data);

    // print(foo);

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

    print(allCodes);
  }

  onWeekSelect(data) {
    print("Selected week starting at -> $data");
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
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
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
    TextStyle dayNameStyle = TextStyle(fontSize: 14.5, color: fontColor);
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
        color: !isSelectedDate ? Colors.transparent : Colors.white70,
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
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
        elevation: 20.6,
        title: Text(
          'SYNOP',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
        actions: [Logout()],
        toolbarHeight: 70,
      ),
      body: Container(
        color: Colors.blueGrey[700],
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
              iconColor: Colors.white,
              monthNameWidget: _monthNameWidget,
              containerDecoration: BoxDecoration(color: Colors.blueGrey[700]),
              addSwipeGesture: true,
            )),
            Container(
                child: allCodes != null
                    ? allCodes != []
                        ? ListView.builder(
                            controller: _controller, //new line
                            itemCount: allCodes.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 2),
                                child: Container(
                                  height: 210,
                                  width: double.infinity,
                                  child: Card(
                                    color: Colors.blueGrey[800],
                                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    elevation: 0.5,
                                    child: ListTile(
                                        // isThreeLine: true,
                                        key: Key(code[index]['_id']),
                                        title: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 0),
                                          child: Text(
                                            code[index]['creator']['name'],
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.blue),
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
                                        trailing: code[index]['creator']
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
                                                    del = code[index]['_id'];
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
                                                        gravity:
                                                            ToastGravity.TOP,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor:
                                                            Colors.blue,
                                                        textColor: Colors.white,
                                                        fontSize: 16.0);
                                                    fetchData();
                                                    Future.delayed(
                                                        Duration(seconds: 3),
                                                        () {
                                                      Navigator.of(
                                                              _keyLoader
                                                                  .currentContext,
                                                              rootNavigator:
                                                                  true)
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
                            height: MediaQuery.of(context).size.height,
                            child: Center(
                              child: Text(
                                "NO Codes available",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                    : Container(
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )),
          ],
        ),
      ),
      drawer: drawercomponent(),
      floatingActionButton: Btn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
