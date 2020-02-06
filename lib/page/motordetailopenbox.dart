import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/boxlocation.dart';
import 'package:pickcar/models/boxslotrent.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:pickcar/models/placelocation.dart';
import 'package:pickcar/page/addlocationowner.dart';

class MotorDetailOpenBox extends StatefulWidget {
  Boxslotrent boxslotrent;
  Motorcycle motorcycle;
  Placelocation placelocation;
  Boxlocation boxlocation;
  MotorDetailOpenBox(
      {@required this.boxslotrent,
      @required this.motorcycle,
      @required this.placelocation,
      @required this.boxlocation});

  @override
  _MotorDetailOpenBoxState createState() => _MotorDetailOpenBoxState();
}

class _MotorDetailOpenBoxState extends State<MotorDetailOpenBox> {
  Color currentcolor = Colors.yellow;
  String statusbox = "Waiting";
  Boxslotrent _boxslotrent;
  //bool isdropkey;
  bool nowboxcheck;
  bool preboxcheck;
  bool isloop = true;
  bool isaddlocation = false;

  Placelocation placeloc;
  Boxlocation boxloc;

  bool isrealboxopen = false;

  Future loaddata() async {}

  void starttimer() {
    print("start timer");

    Realtime.timekey = Timer.periodic(Duration(seconds: 5), (timer) async {
      if (!isloop) {
        return;
      }
      bool checkrealbox;
      var doc = await Datamanager.realtimedatabase
          .reference()
          .child(this._boxslotrent.boxdocid)
          .child(this._boxslotrent.boxslotdocid)
          .once()
          .then((DataSnapshot doc) {
            Map<dynamic , dynamic> result = doc.value;
            checkrealbox = result['isopen'] as bool;
            print("checkrealbox is ${checkrealbox}");
          });

      if (this.isrealboxopen && !checkrealbox) {
        this.currentcolor = Colors.red;
        this.statusbox = "Close";
        _boxslotrent.isopen = false;
        setstate();
        //
        isloop = false;
        await showslertdropkey();
        print("pass tapbox");

        if (this._boxslotrent.iskey) {
          await Datamanager.firestore
              .collection("BoxslotRent")
              .document(_boxslotrent.docid)
              .updateData({'iskey': true, 'ownerdropkey': true , 'isopen' : false});
          Navigator.of(context).pop();
        } else {
          await Datamanager.firestore
              .collection("BoxslotRent")
              .document(_boxslotrent.docid)
              .updateData({'iskey': false, 'ownerdropkey': false , 'isopen' : false});
          this.isrealboxopen = false;
        }

        setstate();
      }
      /*print("timenow is " + DateTime.now().second.toString());
      var doc = await Datamanager.firestore
          .collection("BoxslotRent")
          .document(_boxslotrent.docid)
          .get();
      nowboxcheck = doc['isopen'];

      if ((preboxcheck == true) && (nowboxcheck == false)) {
        //
        this.currentcolor = Colors.red;
        this.statusbox = "Close";
        _boxslotrent.isopen = false;
        setstate();
        //
        isloop = false;
        await showslertdropkey();
        print("pass tapbox");

        if (this._boxslotrent.iskey) {
          await Datamanager.firestore
              .collection("BoxslotRent")
              .document(_boxslotrent.docid)
              .updateData({'iskey': true, 'ownerdropkey': true});
          Navigator.of(context).pop();
        } else {
          await Datamanager.firestore
              .collection("BoxslotRent")
              .document(_boxslotrent.docid)
              .updateData({'iskey': false, 'ownerdropkey': false});
        }

        setstate();
      }

      preboxcheck = nowboxcheck;*/
    });
  }

  Future tapbox() async {
    print("boxslotrent docid : ${_boxslotrent.docid}");

    if (this.isrealboxopen == false) {
      if (!this.isaddlocation) {
        await showalertaddlocation();
      }

      Datamanager.realtimedatabase
          .reference()
          .child(this._boxslotrent.boxdocid)
          .child(this._boxslotrent.boxslotdocid)
          .update({
        'isopen': true,
      });

      await Datamanager.firestore
          .collection("BoxslotRent")
          .document(_boxslotrent.docid)
          .updateData({'isopen': true});

      this.currentcolor = Colors.green;
      this.statusbox = "Open";
      _boxslotrent.isopen = true;

      this.isrealboxopen = true;
      //todo realtimedatabase
      setstate();
    }

    // DocumentSnapshot doc = await Datamanager.firestore
    //     .collection("BoxslotRent")
    //     .document(_boxslotrent.docid)
    //     .get();
    // if (doc['isopen'] == false) {
    //   //todo check add location
    //   if (!this.isaddlocation) {
    //     await showalertaddlocation();
    //   }

    //   if (!this.isaddlocation) {
    //     print("dont add location");
    //     return;
    //   } else {
    //     print("add location success");
    //   }

    //   await Datamanager.firestore
    //       .collection("BoxslotRent")
    //       .document(_boxslotrent.docid)
    //       .updateData({'isopen': true});
    //   this.currentcolor = Colors.green;
    //   this.statusbox = "Open";
    //   _boxslotrent.isopen = true;

    //   //todo realtimedatabase
    //   setstate();
    // }
  }

  Future<Null> showalertaddlocation() {
    print('show alert add location');
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Please add your motorcycle location"),
            content:
                Text("You must add your motorycle location before open keybox"),
            actions: <Widget>[
              FlatButton(
                child: Text("Yes"),
                onPressed: () async {
                  print("YES");
                  var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddLocationOwner(
                                motorcycledocid:
                                    widget.motorcycle.firestoredocid,
                              )));
                  print('resutl is ${result as bool}');
                  this.isaddlocation = result as bool;
                  if (this.isaddlocation == null) {
                    this.isaddlocation = false;
                  }
                  setstate();

                  // await Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => AddLocationOwner(
                  //                   motorcycledocid:
                  //                       widget.motorcycle.firestoredocid,
                  //                 )));
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  print("No");
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<void> showslertdropkey() async {
    print("showslertdropkey 111111111111111111111");
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are you drop your key?"),
            content: Text("Are you drop your key?"),
            actions: <Widget>[
              FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  print("YES");
                  this._boxslotrent.iskey = true;
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  print("No");
                  this._boxslotrent.iskey = false;
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this._boxslotrent = widget.boxslotrent;

    if (_boxslotrent.isopen == false) {
      currentcolor = Colors.red;
      this.statusbox = "Close";
      //todo realtime
    } else {
      //todo realtime
      currentcolor = Colors.green;
      this.statusbox = "Open";
    }

    this.placeloc = widget.placelocation;
    this.boxloc = widget.boxlocation;

    print("place loc : ${this.placeloc.name}");
    print("box loc : ${this.boxloc.name}");

    preboxcheck = this._boxslotrent.isopen;
  }

  void setstate() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isloop) {
      starttimer();
    }
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top,
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        width: MediaQuery.of(context).size.width,
        child: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 10,
                    child: Container(
                      width: constraint.maxWidth * 0.9,
                      height: constraint.maxHeight * 0.3,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.timer),
                              Text(this._boxslotrent.time),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(Icons.vpn_key),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(this.boxloc.name),
                                ],
                              ),
                              RaisedButton(
                                child: Text(
                                  "See location",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Color.fromRGBO(229, 229, 0, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(Icons.motorcycle),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(this.placeloc.name),
                                ],
                              ),
                              RaisedButton(
                                child: Text(
                                  "See location",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Color.fromRGBO(229, 229, 0, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                onPressed: () {},
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constraint.maxHeight * 0.05,
                  ),
                  // InkWell(
                  //   child: Card(
                  //     elevation: 10,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(180),
                  //         side: BorderSide(color: this.currentcolor)),
                  //     child: Container(
                  //       height: constraint.maxWidth * 0.6,
                  //       width: constraint.maxWidth * 0.6,
                  //       decoration: BoxDecoration(
                  //           //color: this.currentcolor,
                  //           shape: BoxShape.circle,
                  //           gradient: LinearGradient(
                  //               begin: Alignment.topLeft,
                  //               end: Alignment.bottomRight,
                  //               colors: [this.currentcolor, Colors.yellow])),
                  //       child: Center(
                  //         child: Text(
                  //           this.statusbox,
                  //           style: TextStyle(fontSize: 56, color: Colors.white),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  //   onTap: () async {
                  //     await tapbox();
                  //   },
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  //todo step1
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      width: constraint.maxWidth * 0.9,
                      height: constraint.maxHeight * 0.3,
                      decoration: BoxDecoration(
                          color: this.isaddlocation
                              ? PickCarColor.colormain.withOpacity(0.3)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Step 1 : Share motorcycle location"),
                          SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: ButtonTheme(
                              minWidth: constraint.maxWidth * 0.7,
                              height: constraint.maxHeight * 0.1,
                              child: NiceButton(
                                width: constraint.maxWidth * 0.5,
                                radius: 25,
                                background: PickCarColor.colormain,
                                onPressed: () async {
                                  print("share motor location");
                                  var result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddLocationOwner(
                                                motorcycledocid: widget
                                                    .motorcycle.firestoredocid,
                                              )));
                                  print('resutl is ${result as bool}');
                                  this.isaddlocation = result as bool;
                                  if (this.isaddlocation == null) {
                                    this.isaddlocation = false;
                                  }
                                  setstate();
                                },
                                text: "Share location",
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  //todo step 2
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      width: constraint.maxWidth * 0.9,
                      height: constraint.maxHeight * 0.3,
                      decoration: BoxDecoration(
                          color: this._boxslotrent.isopen
                              ? PickCarColor.colormain.withOpacity(0.3)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Step 2 : Open key box"),
                          SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(180),
                                    side: BorderSide(color: this.currentcolor)),
                                child: Container(
                                  height: constraint.maxWidth * 0.3,
                                  width: constraint.maxWidth * 0.3,
                                  decoration: BoxDecoration(
                                      //color: this.currentcolor,
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            this.currentcolor,
                                            Colors.yellow
                                          ])),
                                  child: Center(
                                    child: Text(
                                      this.statusbox,
                                      style: TextStyle(
                                          fontSize: 28, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () async {
                                await tapbox();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _boxslotrent.iskey == true
                      ? Container(
                          height: constraint.maxHeight * 0.1,
                          width: constraint.maxWidth * 0.9,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(45),
                                  topRight: Radius.circular(45),
                                  bottomLeft: Radius.circular(45),
                                  bottomRight: Radius.circular(45))),
                          child: Center(
                              child: Text(
                            "Key is in the box",
                            style: TextStyle(color: Colors.white),
                          )),
                        )
                      : SizedBox(),
                  // RaisedButton(
                  //   child: Text("add map"),
                  //   onPressed: () {
                  //     print("add map");
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => AddLocationOwner(
                  //                   motorcycledocid:
                  //                       widget.motorcycle.firestoredocid,
                  //                 )));
                  //   },
                  // )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
