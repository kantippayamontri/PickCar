import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/universityplace.dart';
import 'package:pickcar/ui/uisize.dart';

class SearchPage extends StatefulWidget {
  int indicatorpage = 0;
  int havebuttom = 0;
  int havebuttom2 = 0;
  int havebuttom3 = 0;
  var timeselect = [
    '08.00 - 09.15',
    '09.30 - 10.45',
    '11.00 - 12.15',
    '13.00 - 14.15',
    '14.30 - 15.45',
    '16.00 - 17.15'
  ];
  var timeselect2 = [
    '08.00 - 10.45',
    '09.30 - 12.15',
    '11.00 - 14.15',
    '13.00 - 15.45',
    '14.30 - 17.15'
  ];
  var timeselect3 = [
    '08.00 - 12.30',
    '09.30 - 14.30',
    '11.00 - 16.00',
    '13.00 - 17.30',
  ];
  int i = 0;
  DateTime now = DateTime.now();
  var colorselect1 = Colors.white;
  var colorselect2 = Colors.white;
  var colorselect3 = Colors.white;
  var colorselect4 = Colors.white;
  var colorselect5 = Colors.white;
  var colorselect6 = Colors.white;
  String dropdown = UseString.rent1;
  bool slottime1 = true;
  bool slottime2 = true;
  bool slottime3 = true;
  bool slottime4 = true;
  bool slottime5 = true;
  bool slottime6 = true;
  bool late1 = true;
  bool late2 = true;
  bool late3 = true;
  bool late4 = true;
  bool late5 = true;
  bool late6 = true;
  bool notimetoselect = true;
  bool noselect = true;
  double heightofalert = 340;
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  void initState() {
    TimeSearch.time1 = false;
    TimeSearch.time2 = false;
    TimeSearch.time3 = false;
    TimeSearch.time4 = false;
    TimeSearch.time5 = false;
    TimeSearch.time6 = false;
    widget.colorselect1 = Colors.white;
    widget.colorselect2 = Colors.white;
    widget.colorselect3 = Colors.white;
    widget.colorselect4 = Colors.white;
    widget.colorselect5 = Colors.white;
    widget.colorselect6 = Colors.white;
    widget.dropdown = UseString.rent1;
    SearchString.type = widget.dropdown;
    SearchString.university = UseString.universityhint;
    SearchString.location = UseString.locationhint;
    TimeSearch.today = DateTime.now();
    widget.slottime1 = true;
    widget.slottime2 = true;
    widget.slottime3 = true;
    widget.slottime4 = true;
    widget.slottime5 = true;
    widget.slottime6 = true;
    widget.noselect = true;
    widget.late1 = true;
    widget.late2 = true;
    widget.late3 = true;
    widget.late4 = true;
    widget.late5 = true;
    widget.late6 = true;
    widget.notimetoselect = true;
    widget.heightofalert = 340;
    super.initState();
  }

  String monthy(int month) {
    switch (month) {
      case 1:
        return 'Jan';
        break;
      case 2:
        return 'Feb';
        break;
      case 3:
        return 'Mar';
        break;
      case 4:
        return 'Apr';
        break;
      case 5:
        return 'May';
        break;
      case 6:
        return 'Jun';
        break;
      case 7:
        return 'Jul';
        break;
      case 8:
        return 'Aug';
        break;
      case 9:
        return 'Sep';
        break;
      case 10:
        return 'Oct';
        break;
      case 11:
        return 'Nov';
        break;
      default:
        return 'Dec';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var data = MediaQuery.of(context);
    showalertuni(BuildContext context) {
      var data = MediaQuery.of(context);
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20),
              ),
              // title: Text('place have same name.'),
              content: Text(
                UseString.chooseuni,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: data.textScaleFactor * 25,
                    color: PickCarColor.colorFont1),
              ),
            );
          });
    }

    showalertlo(BuildContext context) {
      var data = MediaQuery.of(context);
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20),
              ),
              // title: Text('place have same name.'),
              content: Text(
                UseString.chooselo,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: data.textScaleFactor * 25,
                    color: PickCarColor.colorFont1),
              ),
            );
          });
    }

    showalertall(BuildContext context) {
      var data = MediaQuery.of(context);
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20),
              ),
              // title: Text('place have same name.'),
              content: Text(
                UseString.chooseuniandlo,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: data.textScaleFactor * 25,
                    color: PickCarColor.colorFont1),
              ),
            );
          });
    }
    showalerttimeselect(BuildContext context) {
      var data = MediaQuery.of(context);
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20),
              ),
              // title: Text('place have same name.'),
              content: Text(
                UseString.choosetimeslot,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: data.textScaleFactor * 25,
                    color: PickCarColor.colorFont1),
              ),
            );
          });
    }

    // slottime1(BuildContext context) {
    //   return StatefulBuilder(builder: (context, setState) {
    //     return Column(
    //       children: <Widget>[
            
    //       ],
    //     );
    //   });
    // }

    selecttime(BuildContext context) {
      SizeConfig().init(context);
      var data = MediaQuery.of(context);
      // print(TimeSearch.time1);
      return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  // side: BorderSide(color: Colors.red)
                ),
                title: Text(
                  UseString.selecttime,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: data.textScaleFactor * 25,
                      color: PickCarColor.colormain),
                ),
                content: Container(
                  height: widget.heightofalert,
                  // width: 300,
                  // decoration: new BoxDecoration(
                  //   borderRadius: BorderRadius.circular(12),
                  //   color: Colors.black,
                  // ),
                  child: Column(
                    children: <Widget>[
                      Visibility(
                        visible: widget.late1,
                        child: Visibility(
                          visible: widget.slottime1,
                          child: Container(
                            width: 200,
                            child: RaisedButton(
                              color: widget.colorselect1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: PickCarColor.colormain)),
                              onPressed: () {
                                print(TimeSearch.time1);
                                setState(() {
                                  TimeSearch.time1 = !TimeSearch.time1;
                                  if(SearchString.type == UseString.rent1){
                                    if(TimeSearch.time1){
                                      widget.slottime2 = false;
                                      widget.slottime3 = false;
                                      widget.slottime4 = false;
                                      widget.slottime5 = false;
                                      widget.slottime6 = false;
                                      widget.heightofalert = 110;
                                    }else{
                                      widget.slottime2 = true;
                                      widget.slottime3 = true;
                                      widget.slottime4 = true;
                                      widget.slottime5 = true;
                                      widget.slottime6 = true;
                                      if(widget.havebuttom ==6){
                                        widget.heightofalert = 100;
                                      }else if(widget.havebuttom ==5){
                                        widget.heightofalert = 140;
                                      }else if(widget.havebuttom ==4){
                                        widget.heightofalert = 180;
                                      }else if(widget.havebuttom ==3){
                                        widget.heightofalert = 220;
                                      }else if(widget.havebuttom ==2){
                                        widget.heightofalert = 260;
                                      }else if(widget.havebuttom ==1){
                                        widget.heightofalert = 300;
                                      }else if(widget.havebuttom ==0){
                                        widget.heightofalert = 340;
                                      }
                                    }
                                    widget.noselect = !widget.noselect;
                                  }
                                  if (TimeSearch.time1) {
                                    widget.colorselect1 = Colors.green[400];
                                  } else {
                                    widget.colorselect1 = Colors.white;
                                  }
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.alarm),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.timeselect[0],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: data.textScaleFactor * 22,
                                        color: PickCarColor.colorFont1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.late2,
                        child: Visibility(
                          visible: widget.slottime2,
                          child: Container(
                            width: 200,
                            child: RaisedButton(
                              color: widget.colorselect2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: PickCarColor.colormain)),
                              onPressed: () {
                                setState(() {
                                  TimeSearch.time2 = !TimeSearch.time2;
                                  if(SearchString.type == UseString.rent1){
                                    if(TimeSearch.time2){
                                      widget.slottime1 = false;
                                      widget.slottime3 = false;
                                      widget.slottime4 = false;
                                      widget.slottime5 = false;
                                      widget.slottime6 = false;
                                      widget.heightofalert = 110;
                                      widget.noselect = !widget.noselect;
                                    }else{
                                      widget.slottime1 = true;
                                      widget.slottime3 = true;
                                      widget.slottime4 = true;
                                      widget.slottime5 = true;
                                      widget.slottime6 = true;
                                      if(widget.havebuttom ==6){
                                        widget.heightofalert = 100;
                                      }else if(widget.havebuttom ==5){
                                        widget.heightofalert = 140;
                                      }else if(widget.havebuttom ==4){
                                        widget.heightofalert = 180;
                                      }else if(widget.havebuttom ==3){
                                        widget.heightofalert = 220;
                                      }else if(widget.havebuttom ==2){
                                        widget.heightofalert = 260;
                                      }else if(widget.havebuttom ==1){
                                        widget.heightofalert = 300;
                                      }else if(widget.havebuttom ==0){
                                        widget.heightofalert = 340;
                                      }
                                      widget.noselect = !widget.noselect;
                                    }
                                  }
                                  if (TimeSearch.time2) {
                                    widget.colorselect2 = Colors.green[400];
                                  } else {
                                    widget.colorselect2 = Colors.white;
                                  }
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.alarm),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.timeselect[1],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: data.textScaleFactor * 22,
                                        color: PickCarColor.colorFont1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.late3,
                        child: Visibility(
                          visible: widget.slottime3,
                          child: Container(
                            width: 200,
                            child: RaisedButton(
                              color: widget.colorselect3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: PickCarColor.colormain)),
                              onPressed: () {
                                setState(() {
                                  TimeSearch.time3 = !TimeSearch.time3;
                                  if(SearchString.type == UseString.rent1){
                                    if(TimeSearch.time3){
                                      widget.slottime2 = false;
                                      widget.slottime1 = false;
                                      widget.slottime4 = false;
                                      widget.slottime5 = false;
                                      widget.slottime6 = false;
                                      widget.heightofalert = 110;
                                      widget.noselect = !widget.noselect;
                                    }else{
                                      widget.slottime2 = true;
                                      widget.slottime1 = true;
                                      widget.slottime4 = true;
                                      widget.slottime5 = true;
                                      widget.slottime6 = true;
                                      if(widget.havebuttom ==6){
                                        widget.heightofalert = 100;
                                      }else if(widget.havebuttom ==5){
                                        widget.heightofalert = 140;
                                      }else if(widget.havebuttom ==4){
                                        widget.heightofalert = 180;
                                      }else if(widget.havebuttom ==3){
                                        widget.heightofalert = 220;
                                      }else if(widget.havebuttom ==2){
                                        widget.heightofalert = 260;
                                      }else if(widget.havebuttom ==1){
                                        widget.heightofalert = 300;
                                      }else if(widget.havebuttom ==0){
                                        widget.heightofalert = 340;
                                      }
                                      widget.noselect = !widget.noselect;
                                    }
                                  }
                                  if (TimeSearch.time3) {
                                    widget.colorselect3 = Colors.green[400];
                                  } else {
                                    widget.colorselect3 = Colors.white;
                                  }
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.alarm),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.timeselect[2],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: data.textScaleFactor * 22,
                                        color: PickCarColor.colorFont1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.late4,
                        child: Visibility(
                          visible: widget.slottime4,
                          child: Container(
                            width: 200,
                            child: RaisedButton(
                              color: widget.colorselect4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: PickCarColor.colormain)),
                              onPressed: () {
                                setState(() {
                                  TimeSearch.time4 = !TimeSearch.time4;
                                  if(SearchString.type == UseString.rent1){
                                    if(TimeSearch.time4){
                                      widget.slottime2 = false;
                                      widget.slottime3 = false;
                                      widget.slottime1 = false;
                                      widget.slottime5 = false;
                                      widget.slottime6 = false;
                                      widget.heightofalert = 110;
                                      widget.noselect = !widget.noselect;
                                    }else{
                                      widget.slottime2 = true;
                                      widget.slottime3 = true;
                                      widget.slottime1 = true;
                                      widget.slottime5 = true;
                                      widget.slottime6 = true;
                                      if(widget.havebuttom ==6){
                                        widget.heightofalert = 100;
                                      }else if(widget.havebuttom ==5){
                                        widget.heightofalert = 140;
                                      }else if(widget.havebuttom ==4){
                                        widget.heightofalert = 180;
                                      }else if(widget.havebuttom ==3){
                                        widget.heightofalert = 220;
                                      }else if(widget.havebuttom ==2){
                                        widget.heightofalert = 260;
                                      }else if(widget.havebuttom ==1){
                                        widget.heightofalert = 300;
                                      }else if(widget.havebuttom ==0){
                                        widget.heightofalert = 340;
                                      }
                                      widget.noselect = !widget.noselect;
                                    }
                                  }
                                  if (TimeSearch.time4) {
                                    widget.colorselect4 = Colors.green[400];
                                  } else {
                                    widget.colorselect4 = Colors.white;
                                  }
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.alarm),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.timeselect[3],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: data.textScaleFactor * 22,
                                        color: PickCarColor.colorFont1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.late5,
                        child: Visibility(
                          visible: widget.slottime5,
                          child: Container(
                            width: 200,
                            child: RaisedButton(
                              color: widget.colorselect5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: PickCarColor.colormain)),
                              onPressed: () {
                                setState(() {
                                  TimeSearch.time5 = !TimeSearch.time5;
                                  if(SearchString.type == UseString.rent1){
                                    if(TimeSearch.time5){
                                      widget.slottime2 = false;
                                      widget.slottime3 = false;
                                      widget.slottime4 = false;
                                      widget.slottime1 = false;
                                      widget.slottime6 = false;
                                      widget.heightofalert = 110;
                                      widget.noselect = !widget.noselect;
                                    }else{
                                      widget.slottime2 = true;
                                      widget.slottime3 = true;
                                      widget.slottime4 = true;
                                      widget.slottime1 = true;
                                      widget.slottime6 = true;
                                      if(widget.havebuttom ==6){
                                        widget.heightofalert = 100;
                                      }else if(widget.havebuttom ==5){
                                        widget.heightofalert = 140;
                                      }else if(widget.havebuttom ==4){
                                        widget.heightofalert = 180;
                                      }else if(widget.havebuttom ==3){
                                        widget.heightofalert = 220;
                                      }else if(widget.havebuttom ==2){
                                        widget.heightofalert = 260;
                                      }else if(widget.havebuttom ==1){
                                        widget.heightofalert = 300;
                                      }else if(widget.havebuttom ==0){
                                        widget.heightofalert = 340;
                                      }
                                      widget.noselect = !widget.noselect;
                                    }
                                  }
                                  if (TimeSearch.time5) {
                                    widget.colorselect5 = Colors.green[400];
                                  } else {
                                    widget.colorselect5 = Colors.white;
                                  }
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.alarm),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.timeselect[4],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: data.textScaleFactor * 22,
                                        color: PickCarColor.colorFont1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.late6,
                        child: Visibility(
                          visible: widget.slottime6,
                          child: Container(
                            width: 200,
                            child: RaisedButton(
                              color: widget.colorselect6,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: PickCarColor.colormain)),
                              onPressed: () {
                                setState(() {
                                  TimeSearch.time6 = !TimeSearch.time6;
                                  if(SearchString.type == UseString.rent1){
                                    if(TimeSearch.time6){
                                      widget.slottime2 = false;
                                      widget.slottime3 = false;
                                      widget.slottime4 = false;
                                      widget.slottime5 = false;
                                      widget.slottime1 = false;
                                      widget.heightofalert = 110;
                                      widget.noselect = !widget.noselect;
                                    }else{
                                      widget.slottime2 = true;
                                      widget.slottime3 = true;
                                      widget.slottime4 = true;
                                      widget.slottime5 = true;
                                      widget.slottime1 = true;
                                      if(widget.havebuttom ==6){
                                        widget.heightofalert = 100;
                                      }else if(widget.havebuttom ==5){
                                        widget.heightofalert = 140;
                                      }else if(widget.havebuttom ==4){
                                        widget.heightofalert = 180;
                                      }else if(widget.havebuttom ==3){
                                        widget.heightofalert = 220;
                                      }else if(widget.havebuttom ==2){
                                        widget.heightofalert = 260;
                                      }else if(widget.havebuttom ==1){
                                        widget.heightofalert = 300;
                                      }else if(widget.havebuttom ==0){
                                        widget.heightofalert = 340;
                                      }
                                      widget.noselect = !widget.noselect;
                                    }
                                  }
                                  if (TimeSearch.time6) {
                                    widget.colorselect6 = Colors.green[400];
                                  } else {
                                    widget.colorselect6 = Colors.white;
                                  }
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.alarm),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.timeselect[5],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: data.textScaleFactor * 22,
                                        color: PickCarColor.colorFont1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Visibility(
                      //   visible: false,
                      //   child: Text("Gone"),
                        
                      // ),
                      Visibility(
                        visible: !widget.notimetoselect,
                        child: Container(
                          child: Text(
                            UseString.notimeforrent,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: data.textScaleFactor * 25,
                                color: PickCarColor.colorFont1),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.notimetoselect,
                        child: Container(
                          width: 120,
                          alignment: Alignment.center,
                          child: RaisedButton(
                            color: PickCarColor.colorbuttom,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(color: PickCarColor.colormain)),
                            onPressed: () {
                              setState(() {
                                widget.colorselect1 = Colors.white;
                                widget.colorselect2 = Colors.white;
                                widget.colorselect3 = Colors.white;
                                widget.colorselect4 = Colors.white;
                                widget.colorselect5 = Colors.white;
                                widget.colorselect6 = Colors.white;
                                TimeSearch.time1 = false;
                                TimeSearch.time2 = false;
                                TimeSearch.time3 = false;
                                TimeSearch.time4 = false;
                                TimeSearch.time5 = false;
                                TimeSearch.time6 = false;
                                widget.slottime1 = true;
                                widget.slottime2 = true;
                                widget.slottime3 = true;
                                widget.slottime4 = true;
                                widget.slottime5 = true;
                                widget.slottime6 = true;
                                widget.noselect = true;
                                if(widget.havebuttom ==6){
                                  widget.heightofalert = 100;
                                }else if(widget.havebuttom ==5){
                                  widget.heightofalert = 140;
                                }else if(widget.havebuttom ==4){
                                  widget.heightofalert = 180;
                                }else if(widget.havebuttom ==3){
                                  widget.heightofalert = 220;
                                }else if(widget.havebuttom ==2){
                                  widget.heightofalert = 260;
                                }else if(widget.havebuttom ==1){
                                  widget.heightofalert = 300;
                                }else if(widget.havebuttom ==0){
                                  widget.heightofalert = 340;
                                }
                              });
                            },
                            child: Text(
                              UseString.reset,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: data.textScaleFactor * 22,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // actions: <Widget>[
                //   FlatButton(
                //     onPressed: () => Navigator.pop(context),
                //     child: Text(UseString.confirm),
                //   ),
                //   FlatButton(
                //     onPressed: () => Navigator.pop(context),
                //     child: Text(UseString.cancel),
                //   ),
                // ],
              );
            },
          );
        },
      );
    }
    selecttime2(BuildContext context) {
      var data = MediaQuery.of(context);
      // print(TimeSearch.time1);
      return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  // side: BorderSide(color: Colors.red)
                ),
                title: Text(
                  UseString.selecttime,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: data.textScaleFactor * 25,
                      color: PickCarColor.colormain),
                ),
                content: Container(
                  height: widget.heightofalert,
                  // width: 300,
                  // decoration: new BoxDecoration(
                  //   borderRadius: BorderRadius.circular(12),
                  //   color: Colors.black,
                  // ),
                  child: Column(
                    children: <Widget>[
                      Visibility(
                        visible: widget.late1,
                        child: Visibility(
                          visible: widget.slottime1,
                          child: Container(
                            width: 200,
                            child: RaisedButton(
                              color: widget.colorselect1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: PickCarColor.colormain)),
                              onPressed: () {
                                print(TimeSearch.time1);
                                setState(() {
                                  TimeSearch.time1 = !TimeSearch.time1;
                                    if(TimeSearch.time1){
                                      widget.slottime2 = false;
                                      widget.slottime3 = false;
                                      widget.slottime4 = false;
                                      widget.slottime5 = false;
                                      widget.heightofalert = 110;
                                    }else{
                                      widget.slottime2 = true;
                                      widget.slottime3 = true;
                                      widget.slottime4 = true;
                                      widget.slottime5 = true;
                                      widget.heightofalert = 340;
                                    }
                                    widget.noselect = !widget.noselect;
                                  if (TimeSearch.time1) {
                                    widget.colorselect1 = Colors.green[400];
                                  } else {
                                    widget.colorselect1 = Colors.white;
                                  }
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.alarm),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.timeselect2[0],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: data.textScaleFactor * 22,
                                        color: PickCarColor.colorFont1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.late2,
                        child: Visibility(
                          visible: widget.slottime2,
                          child: Container(
                            width: 200,
                            child: RaisedButton(
                              color: widget.colorselect2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: PickCarColor.colormain)),
                              onPressed: () {
                                setState(() {
                                  TimeSearch.time2 = !TimeSearch.time2;
                                    if(TimeSearch.time2){
                                      widget.slottime1 = false;
                                      widget.slottime3 = false;
                                      widget.slottime4 = false;
                                      widget.slottime5 = false;
                                      widget.heightofalert = 110;
                                      widget.noselect = !widget.noselect;
                                    }else{
                                      widget.slottime1 = true;
                                      widget.slottime3 = true;
                                      widget.slottime4 = true;
                                      widget.slottime5 = true;
                                      widget.heightofalert = 340;
                                      widget.noselect = !widget.noselect;
                                  }
                                  if (TimeSearch.time2) {
                                    widget.colorselect2 = Colors.green[400];
                                  } else {
                                    widget.colorselect2 = Colors.white;
                                  }
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.alarm),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.timeselect2[1],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: data.textScaleFactor * 22,
                                        color: PickCarColor.colorFont1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.late3,
                        child: Visibility(
                          visible: widget.slottime3,
                          child: Container(
                            width: 200,
                            child: RaisedButton(
                              color: widget.colorselect3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: PickCarColor.colormain)),
                              onPressed: () {
                                setState(() {
                                  TimeSearch.time3 = !TimeSearch.time3;
                                    if(TimeSearch.time3){
                                      widget.slottime2 = false;
                                      widget.slottime1 = false;
                                      widget.slottime4 = false;
                                      widget.slottime5 = false;
                                      widget.heightofalert = 110;
                                      widget.noselect = !widget.noselect;
                                    }else{
                                      widget.slottime2 = true;
                                      widget.slottime1 = true;
                                      widget.slottime4 = true;
                                      widget.slottime5 = true;
                                      widget.heightofalert = 340;
                                      widget.noselect = !widget.noselect;
                                    }
                                  if (TimeSearch.time3) {
                                    widget.colorselect3 = Colors.green[400];
                                  } else {
                                    widget.colorselect3 = Colors.white;
                                  }
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.alarm),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.timeselect2[2],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: data.textScaleFactor * 22,
                                        color: PickCarColor.colorFont1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.late4,
                        child: Visibility(
                          visible: widget.slottime4,
                          child: Container(
                            width: 200,
                            child: RaisedButton(
                              color: widget.colorselect4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: PickCarColor.colormain)),
                              onPressed: () {
                                setState(() {
                                  TimeSearch.time4 = !TimeSearch.time4;
                                    if(TimeSearch.time4){
                                      widget.slottime2 = false;
                                      widget.slottime3 = false;
                                      widget.slottime1 = false;
                                      widget.slottime5 = false;
                                      widget.heightofalert = 110;
                                      widget.noselect = !widget.noselect;
                                    }else{
                                      widget.slottime2 = true;
                                      widget.slottime3 = true;
                                      widget.slottime1 = true;
                                      widget.slottime5 = true;
                                      widget.heightofalert = 340;
                                      widget.noselect = !widget.noselect;
                                    }
                                  if (TimeSearch.time4) {
                                    widget.colorselect4 = Colors.green[400];
                                  } else {
                                    widget.colorselect4 = Colors.white;
                                  }
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.alarm),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.timeselect2[3],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: data.textScaleFactor * 22,
                                        color: PickCarColor.colorFont1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.late5,
                        child: Visibility(
                          visible: widget.slottime5,
                          child: Container(
                            width: 200,
                            child: RaisedButton(
                              color: widget.colorselect5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: PickCarColor.colormain)),
                              onPressed: () {
                                setState(() {
                                  TimeSearch.time5 = !TimeSearch.time5;
                                    if(TimeSearch.time5){
                                      widget.slottime2 = false;
                                      widget.slottime3 = false;
                                      widget.slottime4 = false;
                                      widget.slottime1 = false;
                                      widget.heightofalert = 110;
                                      widget.noselect = !widget.noselect;
                                    }else{
                                      widget.slottime2 = true;
                                      widget.slottime3 = true;
                                      widget.slottime4 = true;
                                      widget.slottime1 = true;
                                      widget.heightofalert = 340;
                                      widget.noselect = !widget.noselect;
                                    }
                                  if (TimeSearch.time5) {
                                    widget.colorselect5 = Colors.green[400];
                                  } else {
                                    widget.colorselect5 = Colors.white;
                                  }
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.alarm),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.timeselect2[4],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: data.textScaleFactor * 22,
                                        color: PickCarColor.colorFont1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Visibility(
                      //   visible: false,
                      //   child: Text("Gone"),
                        
                      // ),
                      Visibility(
                        visible: !widget.notimetoselect,
                        child: Container(
                          child: Text(
                            UseString.notimeforrent,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: data.textScaleFactor * 25,
                                color: PickCarColor.colorFont1),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.notimetoselect,
                        child: Container(
                          width: 120,
                          alignment: Alignment.center,
                          child: RaisedButton(
                            color: PickCarColor.colorbuttom,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(color: PickCarColor.colormain)),
                            onPressed: () {
                              setState(() {
                                widget.colorselect1 = Colors.white;
                                widget.colorselect2 = Colors.white;
                                widget.colorselect3 = Colors.white;
                                widget.colorselect4 = Colors.white;
                                widget.colorselect5 = Colors.white;
                                widget.colorselect6 = Colors.white;
                                TimeSearch.time1 = false;
                                TimeSearch.time2 = false;
                                TimeSearch.time3 = false;
                                TimeSearch.time4 = false;
                                TimeSearch.time5 = false;
                                TimeSearch.time6 = false;
                                widget.slottime1 = true;
                                widget.slottime2 = true;
                                widget.slottime3 = true;
                                widget.slottime4 = true;
                                widget.slottime5 = true;
                                widget.slottime6 = true;
                                widget.noselect = true;
                                if(widget.havebuttom2 ==5){
                                  widget.heightofalert = 100;
                                }else if(widget.havebuttom2 ==4){
                                  widget.heightofalert = 140;
                                }else if(widget.havebuttom2 ==3){
                                  widget.heightofalert = 180;
                                }else if(widget.havebuttom2 ==2){
                                  widget.heightofalert = 220;
                                }else if(widget.havebuttom2 ==1){
                                  widget.heightofalert = 260;
                                }else if(widget.havebuttom2 ==0){
                                  widget.heightofalert = 300;
                                }
                              });
                            },
                            child: Text(
                              UseString.reset,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: data.textScaleFactor * 22,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // actions: <Widget>[
                //   FlatButton(
                //     onPressed: () => Navigator.pop(context),
                //     child: Text(UseString.confirm),
                //   ),
                //   FlatButton(
                //     onPressed: () => Navigator.pop(context),
                //     child: Text(UseString.cancel),
                //   ),
                // ],
              );
            },
          );
        },
      );
    }
    selecttime3(BuildContext context) {
      var data = MediaQuery.of(context);
      // print(TimeSearch.time1);
      return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  // side: BorderSide(color: Colors.red)
                ),
                title: Text(
                  UseString.selecttime,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: data.textScaleFactor * 25,
                      color: PickCarColor.colormain),
                ),
                content: Container(
                  height: widget.heightofalert,
                  // width: 300,
                  // decoration: new BoxDecoration(
                  //   borderRadius: BorderRadius.circular(12),
                  //   color: Colors.black,
                  // ),
                  child: Column(
                    children: <Widget>[
                      Visibility(
                        visible: widget.late1,
                        child: Visibility(
                          visible: widget.slottime1,
                          child: Container(
                            width: 200,
                            child: RaisedButton(
                              color: widget.colorselect1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: PickCarColor.colormain)),
                              onPressed: () {
                                print(TimeSearch.time1);
                                setState(() {
                                  TimeSearch.time1 = !TimeSearch.time1;
                                    if(TimeSearch.time1){
                                      widget.slottime2 = false;
                                      widget.slottime3 = false;
                                      widget.slottime4 = false;
                                      widget.heightofalert = 110;
                                    }else{
                                      widget.slottime2 = true;
                                      widget.slottime3 = true;
                                      widget.slottime4 = true;
                                      widget.heightofalert = 340;
                                    }
                                    widget.noselect = !widget.noselect;
                                  if (TimeSearch.time1) {
                                    widget.colorselect1 = Colors.green[400];
                                  } else {
                                    widget.colorselect1 = Colors.white;
                                  }
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.alarm),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.timeselect3[0],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: data.textScaleFactor * 22,
                                        color: PickCarColor.colorFont1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.late2,
                        child: Visibility(
                          visible: widget.slottime2,
                          child: Container(
                            width: 200,
                            child: RaisedButton(
                              color: widget.colorselect2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: PickCarColor.colormain)),
                              onPressed: () {
                                setState(() {
                                  TimeSearch.time2 = !TimeSearch.time2;
                                    if(TimeSearch.time2){
                                      widget.slottime1 = false;
                                      widget.slottime3 = false;
                                      widget.slottime4 = false;
                                      widget.heightofalert = 110;
                                      widget.noselect = !widget.noselect;
                                    }else{
                                      widget.slottime1 = true;
                                      widget.slottime3 = true;
                                      widget.slottime4 = true;
                                      widget.heightofalert = 280;
                                      widget.noselect = !widget.noselect;
                                  }
                                  if (TimeSearch.time2) {
                                    widget.colorselect2 = Colors.green[400];
                                  } else {
                                    widget.colorselect2 = Colors.white;
                                  }
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.alarm),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.timeselect3[1],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: data.textScaleFactor * 22,
                                        color: PickCarColor.colorFont1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.late3,
                        child: Visibility(
                          visible: widget.slottime3,
                          child: Container(
                            width: 200,
                            child: RaisedButton(
                              color: widget.colorselect3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: PickCarColor.colormain)),
                              onPressed: () {
                                setState(() {
                                  TimeSearch.time3 = !TimeSearch.time3;
                                    if(TimeSearch.time3){
                                      widget.slottime2 = false;
                                      widget.slottime1 = false;
                                      widget.slottime4 = false;
                                      widget.heightofalert = 110;
                                      widget.noselect = !widget.noselect;
                                    }else{
                                      widget.slottime2 = true;
                                      widget.slottime1 = true;
                                      widget.slottime4 = true;
                                      widget.heightofalert = 280;
                                      widget.noselect = !widget.noselect;
                                    }
                                  if (TimeSearch.time3) {
                                    widget.colorselect3 = Colors.green[400];
                                  } else {
                                    widget.colorselect3 = Colors.white;
                                  }
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.alarm),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.timeselect3[2],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: data.textScaleFactor * 22,
                                        color: PickCarColor.colorFont1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.late4,
                        child: Visibility(
                          visible: widget.slottime4,
                          child: Container(
                            width: 200,
                            child: RaisedButton(
                              color: widget.colorselect4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: PickCarColor.colormain)),
                              onPressed: () {
                                setState(() {
                                  TimeSearch.time4 = !TimeSearch.time4;
                                    if(TimeSearch.time4){
                                      widget.slottime2 = false;
                                      widget.slottime3 = false;
                                      widget.slottime1 = false;
                                      widget.heightofalert = 110;
                                      widget.noselect = !widget.noselect;
                                    }else{
                                      widget.slottime2 = true;
                                      widget.slottime3 = true;
                                      widget.slottime1 = true;
                                      widget.heightofalert = 280;
                                      widget.noselect = !widget.noselect;
                                    }
                                  if (TimeSearch.time4) {
                                    widget.colorselect4 = Colors.green[400];
                                  } else {
                                    widget.colorselect4 = Colors.white;
                                  }
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.alarm),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.timeselect3[3],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: data.textScaleFactor * 22,
                                        color: PickCarColor.colorFont1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !widget.notimetoselect,
                        child: Container(
                          child: Text(
                            UseString.notimeforrent,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: data.textScaleFactor * 25,
                                color: PickCarColor.colorFont1),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.notimetoselect,
                        child: Container(
                          width: 120,
                          alignment: Alignment.center,
                          child: RaisedButton(
                            color: PickCarColor.colorbuttom,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(color: PickCarColor.colormain)),
                            onPressed: () {
                              print(widget.havebuttom3);
                              setState(() {
                                widget.colorselect1 = Colors.white;
                                widget.colorselect2 = Colors.white;
                                widget.colorselect3 = Colors.white;
                                widget.colorselect4 = Colors.white;
                                widget.colorselect5 = Colors.white;
                                widget.colorselect6 = Colors.white;
                                TimeSearch.time1 = false;
                                TimeSearch.time2 = false;
                                TimeSearch.time3 = false;
                                TimeSearch.time4 = false;
                                TimeSearch.time5 = false;
                                TimeSearch.time6 = false;
                                widget.slottime1 = true;
                                widget.slottime2 = true;
                                widget.slottime3 = true;
                                widget.slottime4 = true;
                                widget.slottime5 = true;
                                widget.slottime6 = true;
                                widget.noselect = true;
                                if(widget.havebuttom3 ==4){
                                  widget.heightofalert = 100;
                                }else if(widget.havebuttom3 ==3){
                                  widget.heightofalert = 140;
                                }else if(widget.havebuttom3 ==2){
                                  widget.heightofalert = 180;
                                }else if(widget.havebuttom3 ==1){
                                  widget.heightofalert = 220;
                                }else if(widget.havebuttom3 ==0){
                                  widget.heightofalert = 260;
                                }
                              });
                            },
                            child: Text(
                              UseString.reset,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: data.textScaleFactor * 22,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // actions: <Widget>[
                //   FlatButton(
                //     onPressed: () => Navigator.pop(context),
                //     child: Text(UseString.confirm),
                //   ),
                //   FlatButton(
                //     onPressed: () => Navigator.pop(context),
                //     child: Text(UseString.cancel),
                //   ),
                // ],
              );
            },
          );
        },
      );
    }

    final List<Tab> myTabs = <Tab>[
      new Tab(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            UseString.search,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: data.textScaleFactor * 20,
                color: PickCarColor.colormain),
          ),
        ),
      ),
      new Tab(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            UseString.nearby,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: data.textScaleFactor * 20,
                color: PickCarColor.colormain),
          ),
        ),
      ),
    ];
    TabController _tabController;
    _tabController = new TabController(
        vsync: this, length: myTabs.length, initialIndex: widget.indicatorpage);
    body(BuildContext context) {
      if (widget.indicatorpage == 0) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                width: data.size.width,
                child: Stack(
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        child: Image.asset(
                          "assets/images/imagesearch/cardselect.png",
                          fit: BoxFit.fill,
                        )),
                    GestureDetector(
                      onTap: () {
                        showSearch(
                            context: context, delegate: SearcUniversity());
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                          width: double.infinity,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                child: Image.asset(
                                  "assets/images/imagesearch/search.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(left: 25, top: 15),
                                child: Text(
                                  SearchString.university,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: data.textScaleFactor * 22,
                                      color: Colors.grey[700]),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(left: 270, top: 15),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, left: 20),
                      width: double.infinity,
                      child: Text(
                        UseString.selectuniversity,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: data.textScaleFactor * 22,
                            color: PickCarColor.colorFont1),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                width: data.size.width,
                child: Stack(
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        child: Image.asset(
                          "assets/images/imagesearch/cardselect.png",
                          fit: BoxFit.fill,
                        )),
                    GestureDetector(
                      onTap: () {
                        if (SearchString.university !=
                            UseString.universityhint) {
                          showSearch(
                              context: context, delegate: SearcLocation());
                        } else {
                          showalertuni(context);
                        }
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                          width: double.infinity,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                child: Image.asset(
                                  "assets/images/imagesearch/search.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(left: 25, top: 15),
                                child: Text(
                                  SearchString.location,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: data.textScaleFactor * 22,
                                      color: Colors.grey[700]),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(left: 270, top: 15),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, left: 20),
                      width: double.infinity,
                      child: Text(
                        UseString.selectlocation,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: data.textScaleFactor * 22,
                            color: PickCarColor.colorFont1),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                width: data.size.width,
                child: Stack(
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        child: Image.asset(
                          "assets/images/imagesearch/cardselect.png",
                          fit: BoxFit.fill,
                        )),
                    GestureDetector(
                      onTap: () {
                        if (SearchString.university !=
                            UseString.universityhint) {
                          showSearch(
                              context: context, delegate: SearcLocation());
                        } else {
                          showalertuni(context);
                        }
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 40, left: 40, right: 40),
                          width: double.infinity,
                          child: Stack(
                            children: <Widget>[
                              DropdownButton<String>(
                                focusColor: Colors.grey,
                                hint: Text(
                                  widget.dropdown,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: data.textScaleFactor * 22,
                                      color: PickCarColor.colorFont1),
                                ),
                                isExpanded: true,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: data.textScaleFactor * 22,
                                    color: PickCarColor.colorFont1),
                                items: <String>[
                                  UseString.rent1,
                                  UseString.rent2,
                                  // UseString.rent3
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    TimeSearch.time1 = false;
                                    TimeSearch.time2 = false;
                                    TimeSearch.time3 = false;
                                    TimeSearch.time4 = false;
                                    TimeSearch.time5 = false;
                                    TimeSearch.time6 = false;
                                    widget.colorselect1 = Colors.white;
                                    widget.colorselect2 = Colors.white;
                                    widget.colorselect3 = Colors.white;
                                    widget.colorselect4 = Colors.white;
                                    widget.colorselect5 = Colors.white;
                                    widget.colorselect6 = Colors.white;
                                    widget.dropdown = UseString.rent1;
                                    widget.slottime1 = true;
                                    widget.slottime2 = true;
                                    widget.slottime3 = true;
                                    widget.slottime4 = true;
                                    widget.slottime5 = true;
                                    widget.slottime6 = true;
                                    widget.noselect = true;
                                    widget.late1 = true;
                                    widget.late2 = true;
                                    widget.late3 = true;
                                    widget.late4 = true;
                                    widget.late5 = true;
                                    widget.late6 = true;
                                    widget.notimetoselect = true;

                                    widget.dropdown = value;
                                    SearchString.type = value;
                                  });
                                },
                              )
                            ],
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, left: 20),
                      width: double.infinity,
                      child: Text(
                        UseString.typeforrent,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: data.textScaleFactor * 22,
                            color: PickCarColor.colorFont1),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                width: data.size.width,
                height: 265,
                child: Stack(
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Image.asset(
                          "assets/images/imagesearch/backdate.png",
                          fit: BoxFit.fill,
                        )),
                    GestureDetector(
                      onTap: () {
                        // selectday(context);
                        showDatePicker(
                          context: context,
                          initialDate: TimeSearch.today,
                          firstDate: TimeSearch.yesterday,
                          lastDate: TimeSearch.nextmonth,
                        ).then((data) {
                          setState(() {
                            if (data != null) {
                              TimeSearch.today = data;
                              TimeSearch.time1 = false;
                                    TimeSearch.time2 = false;
                                    TimeSearch.time3 = false;
                                    TimeSearch.time4 = false;
                                    TimeSearch.time5 = false;
                                    TimeSearch.time6 = false;
                                    widget.colorselect1 = Colors.white;
                                    widget.colorselect2 = Colors.white;
                                    widget.colorselect3 = Colors.white;
                                    widget.colorselect4 = Colors.white;
                                    widget.colorselect5 = Colors.white;
                                    widget.colorselect6 = Colors.white;
                                    widget.dropdown = UseString.rent1;
                                    widget.slottime1 = true;
                                    widget.slottime2 = true;
                                    widget.slottime3 = true;
                                    widget.slottime4 = true;
                                    widget.slottime5 = true;
                                    widget.slottime6 = true;
                                    widget.noselect = true;
                                    widget.late1 = true;
                                    widget.late2 = true;
                                    widget.late3 = true;
                                    widget.late4 = true;
                                    widget.late5 = true;
                                    widget.late6 = true;
                                    widget.notimetoselect = true;
                              
                            }
                          });
                        });
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 45, left: SizeConfig.blockSizeHorizontal*29),
                          // color: Colors.black,
                          width: 150,
                          height: 130,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: Image.asset(
                                  "assets/images/imagesearch/calender.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 34,
                                // color: Colors.black,
                                alignment: Alignment.center,
                                child: Text(
                                  monthy(TimeSearch.today.month) +
                                      ' | ' +
                                      TimeSearch.today.year.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: data.textScaleFactor * 22,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                // color: Colors.black,
                                margin: EdgeInsets.only(top: 30),
                                alignment: Alignment.center,
                                child: Text(
                                  TimeSearch.today.day.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: data.textScaleFactor * 80,
                                      color: PickCarColor.colorFont1),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 180, left: SizeConfig.blockSizeHorizontal*29.5),
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            // borderRadius: new BorderRadius.circular(12.0),
                            side: BorderSide(color: Colors.black)),
                        onPressed: () {
                          var count =0;
                          widget.now = DateTime.now();
                          widget.havebuttom = count;
                          widget.havebuttom2 = count;
                          widget.havebuttom3 = count;
                          if(TimeSearch.today.day == widget.now.day){
                            print((widget.now.hour+(widget.now.minute/100)));
                            if(widget.now.hour>8 ){
                              widget.late1 = false;
                              if(SearchString.type == UseString.rent3){
                                widget.heightofalert = 220;
                              }else if(SearchString.type == UseString.rent2){
                                widget.heightofalert = 260;
                              }else{
                                widget.heightofalert = 300;
                              }
                              count++;
                            }else{
                              widget.late1 = true;
                            }
                            if((widget.now.hour+(widget.now.minute/100))>9.30){
                              widget.late2 = false;
                              if(SearchString.type == UseString.rent3){
                                widget.heightofalert = 180;
                              }else if(SearchString.type == UseString.rent2){
                                widget.heightofalert = 220;
                              }else{
                                widget.heightofalert = 260;
                              }
                              count++;
                            }else{
                              widget.late2 = true;
                            }
                            if(widget.now.hour>11 ){
                              widget.late3 = false;
                              if(SearchString.type == UseString.rent3){
                                widget.heightofalert = 140;
                              }else if(SearchString.type == UseString.rent2){
                                widget.heightofalert = 180;
                              }else{
                                widget.heightofalert = 220;
                              }
                              count++;
                            }else{
                              widget.late3 = true;
                            }
                            if(widget.now.hour>13 ){
                              widget.late4 = false;
                              if(SearchString.type == UseString.rent3){
                                widget.heightofalert = 100;
                              }else if(SearchString.type == UseString.rent2){
                                widget.heightofalert = 140;
                              }else{
                                widget.heightofalert = 180;
                              }
                              count++;
                            }else{
                              widget.late4 = true;
                            }
                            if((widget.now.hour+(widget.now.minute/100))>14.30){
                              widget.late5 = false;
                              if(SearchString.type == UseString.rent2){
                                widget.heightofalert = 100;
                              }else{
                                widget.heightofalert = 140;
                              }
                              count++;
                              widget.havebuttom3--;
                            }else{
                              widget.late5 = true;
                            }
                            if(widget.now.hour>16 ){
                              widget.late6 = false;
                              widget.heightofalert = 100;
                              count++;
                              widget.havebuttom2--;
                              widget.havebuttom3--;
                            }else{
                              widget.late6 = true;
                            }
                          }else{
                            widget.late1 = true;
                            widget.late2 = true;
                            widget.late3 = true;
                            widget.late4 = true;
                            widget.late5 = true;
                            widget.late6 = true;
                             if(SearchString.type == UseString.rent3){
                                widget.heightofalert = 260;
                              }else if(SearchString.type == UseString.rent2){
                                widget.heightofalert = 300;
                              }else{
                                widget.heightofalert = 340;
                              }
                          }
                          if(TimeSearch.today.day == widget.now.day){
                            widget.havebuttom = count;
                            widget.havebuttom2 = widget.havebuttom2 + count;
                            widget.havebuttom3 = widget.havebuttom3 + count;
                          }else{
                            widget.havebuttom = 0;
                            widget.havebuttom2 = 0;
                            widget.havebuttom3 = 0;
                          }
                          // print(widget.havebuttom);
                          // print(widget.havebuttom2);
                          // print(widget.havebuttom3);
                          if(widget.havebuttom2<0){
                            widget.havebuttom2 =0;
                          }
                          if(widget.havebuttom3<0){
                            widget.havebuttom3 =0;
                          }
                          if(count == 6){
                            widget.notimetoselect = false;
                            widget.heightofalert = 50;
                          }else{
                            widget.notimetoselect = true; 
                          }
                          if(TimeSearch.time1|| TimeSearch.time2 || TimeSearch.time3|| TimeSearch.time4||TimeSearch.time5||TimeSearch.time6){
                            widget.heightofalert = 100;
                          }
                          if(SearchString.type == UseString.rent1){
                            selecttime(context);
                          }else if(SearchString.type == UseString.rent2){
                            selecttime2(context);
                          }else{
                            selecttime3(context);
                          }
                          
                        },
                        child: Text(
                          UseString.selecttime,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: data.textScaleFactor * 22,
                              color: PickCarColor.colorFont1),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, left: 20),
                      width: double.infinity,
                      child: Text(
                        UseString.selectlocation,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: data.textScaleFactor * 22,
                            color: PickCarColor.colorFont1),
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                color: PickCarColor.colorbuttom,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(13.0),
                  // side: BorderSide(color: PickCarColor.colormain)
                ),
                onPressed: () {
                  if(TimeSearch.time1 || TimeSearch.time2 ||TimeSearch.time3 ||TimeSearch.time4 ||TimeSearch.time5 || TimeSearch.time6){
                    if (SearchString.location != UseString.locationhint &&
                      SearchString.university != UseString.universityhint) {
                      Navigator.of(context).pushNamed(Datamanager.listcar);
                    } else if (SearchString.location == UseString.locationhint &&
                      SearchString.university != UseString.universityhint) {
                      showalertlo(context);
                    } else {
                      showalertall(context);
                    }
                  }else{
                    showalerttimeselect(context);
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    UseString.find,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: data.textScaleFactor * 25,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        );
      } else {
        return Container();
      }
    }
    // print(Datamanager.universityshow.listplacebox);
    // print(Datamanager.listUniversity);
    // print(Datamanager.universityshow);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: Image(
          image:
              AssetImage('assets/images/imagesprofile/appbar/background.png'),
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        title: Container(
          width: SizeConfig.blockSizeHorizontal*20,
          child: Image.asset('assets/images/imagelogin/logo.png',fit: BoxFit.fill,)
        ),
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: body(context),
    );
  }
}

class SearcUniversity extends SearchDelegate<String> {
  // final data = ["asssssd","b"];
  // final suggest = ["cadad","d"];
  final data = Datamanager.listUniversity;
  final suggest = Datamanager.listUniversity;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // SearchString.university = UseString.universityhint;
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        SearchString.university = UseString.universityhint;
        SearchString.location = UseString.locationhint;
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var data = MediaQuery.of(context);
    var index = Datamanager.listUniversity.indexOf(query);
    if (index != -1) {
      SearchString.university = Datamanager.listUniversity[index];
      close(context, null);
      return Container();
    } else {
      query = "";
      return Center(
        child: Text(
          UseString.notfound,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: data.textScaleFactor * 30,
              color: PickCarColor.colorFont1),
        ),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? suggest
        : data.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            // showResults(context);
            SearchString.university = Datamanager.listUniversity[index];
            close(context, null);
            // print(index);
          },
          leading: Icon(Icons.location_city),
          title: RichText(
            text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: suggestionList.length,
    );
  }
}

class SearcLocation extends SearchDelegate<String> {
  // final data = ["asssssd","b"];
  // final suggest = ["cadad","d"];
  List<dynamic> data = [];
  List<dynamic> suggest = [];
  fetchdata() {
    for (var i in Datamanager.universityshow) {
      if (i.universityname == SearchString.university) {
        data = i.listplacelocation;
        suggest = i.listplacelocation;
      }
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    fetchdata();
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        SearchString.location = UseString.locationhint;
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var data = MediaQuery.of(context);
    var index = suggest.indexOf(query);
    if (index != -1) {
      SearchString.university = suggest[index];
      close(context, null);
      return Container();
    } else {
      return Center(
        child: Text(
          UseString.notfound,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: data.textScaleFactor * 30,
              color: PickCarColor.colorFont1),
        ),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? suggest
        : data.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            // showResults(context);
            SearchString.location = suggest[index];
            close(context, null);
            // print(index);
          },
          leading: Icon(Icons.location_city),
          title: RichText(
            text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: suggestionList.length,
    );
  }
}