import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/icon/boxicon_icons.dart';
import 'package:pickcar/icon/keyiconna_icons.dart';
import 'package:pickcar/models/boxlocation.dart';
import 'package:pickcar/models/boxslotrent.dart';
import 'package:pickcar/models/motorcycle.dart';

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/boxslotrent.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:pickcar/models/placelocation.dart';

class MotorDetailReceiveBox extends StatefulWidget {
  final Boxslotrent boxslotrent;
  final Motorcycle motorcycle;
  final String bookingdocid;

  final Placelocation motorplaceloc;
  final Boxlocation motorboxplace;

  final int boxnumber;

  MotorDetailReceiveBox(
      {@required this.boxslotrent,
      @required this.motorcycle,
      @required this.bookingdocid,
      @required this.motorplaceloc,
      @required this.motorboxplace,
      @required this.boxnumber}) {
    print('boxslotrent eiei: ${boxslotrent.docid}');
    print('boxslotrent isopen eiei: ${boxslotrent.isopen}');
  }

  @override
  _MotorDetailReceiveBoxState createState() => _MotorDetailReceiveBoxState();
}

class _MotorDetailReceiveBoxState extends State<MotorDetailReceiveBox> {
  Color currentcolor = Colors.yellow;
  String statusbox = "Waiting";
  Boxslotrent _boxslotrent;
  //bool isdropkey;
  bool nowboxcheck;
  bool preboxcheck;
  bool isloop = true;
  bool isremoving = false;

  bool isrealboxopen = false;

  int _boxnumber;

  Future loaddata() async {}

  void starttimer() {
    print("start timer");

    Realtime.timekey = Timer.periodic(Duration(seconds: 5), (timer) async {
      if (isremoving) {
        return;
      }
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
        Map<dynamic, dynamic> result = doc.value;
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

        if (!this._boxslotrent.iskey) {
          this.isremoving = true;
          await Datamanager.firestore
              .collection("BoxslotRent")
              .document(_boxslotrent.docid)
              .updateData(
                  {'iskey': false, 'ownerdropkey': false, 'isopen': false});
          //todo goto delete
          print("delete book");
          await Datamanager.firestore
              .collection("Booking")
              .document(widget.bookingdocid)
              .delete();
          await Datamanager.firestore
              .collection("BoxslotRent")
              .document(widget.boxslotrent.docid)
              .delete();
          Navigator.of(context).pop();
        } else {
          await Datamanager.firestore
              .collection("BoxslotRent")
              .document(_boxslotrent.docid)
              .updateData(
                  {'iskey': true, 'ownerdropkey': true, 'isopen': false});
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

        if (!this._boxslotrent.iskey) {
          this.isremoving = true;
          await Datamanager.firestore
              .collection("BoxslotRent")
              .document(_boxslotrent.docid)
              .updateData({'iskey': false, 'ownerdropkey': false});

          print("delete book");
          await Datamanager.firestore
              .collection("Booking")
              .document(widget.bookingdocid)
              .delete();
          await Datamanager.firestore
              .collection("BoxslotRent")
              .document(widget.boxslotrent.docid)
              .delete();
          Navigator.of(context).pop();
        } else {
          await Datamanager.firestore
              .collection("BoxslotRent")
              .document(_boxslotrent.docid)
              .updateData({'iskey': true, 'ownerdropkey': true});
        }

        setstate();
      }

      preboxcheck = nowboxcheck;*/
    });
  }

  Future tapbox() async {
    if (isrealboxopen == false) {
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

    // print("boxslotrent docid : ${_boxslotrent.docid}");
    // DocumentSnapshot doc = await Datamanager.firestore
    //     .collection("BoxslotRent")
    //     .document(_boxslotrent.docid)
    //     .get();
    // if (doc['isopen'] == false) {
    //   //todo check add location

    //   await Datamanager.firestore
    //       .collection("BoxslotRent")
    //       .document(_boxslotrent.docid)
    //       .updateData({'isopen': true});
    //   this.currentcolor = Colors.green;
    //   this.statusbox = "Open";
    //   _boxslotrent.isopen = true;
    //   setstate();
    // }
  }

  Future<void> showslertdropkey() async {
    print("showslertdropkey 111111111111111111111");
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are you get your key?"),
            content: Text("Are you get your key?"),
            actions: <Widget>[
              FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  print("YES");
                  this._boxslotrent.iskey = false;
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  print("No");
                  this._boxslotrent.iskey = true;
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
    this._boxnumber = widget.boxnumber;
    this._boxslotrent = widget.boxslotrent;

    if (_boxslotrent.isopen == false) {
      currentcolor = Colors.red;
      this.statusbox = "Close";
    } else {
      currentcolor = Colors.green;
      this.statusbox = "Open";
    }

    preboxcheck = this._boxslotrent.isopen;

    print("start status box : ${this._boxslotrent.isopen}");
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
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: constraint.maxHeight * 0.05,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  width: (constraint.maxWidth * 0.9) * 0.1,
                                  child: Icon(Icons.timer)),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  width: (constraint.maxWidth * 0.9) * 0.5,
                                  child: Text(
                                    this._boxslotrent.time,
                                    style: TextStyle(fontSize: 24),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      width: (constraint.maxWidth * 0.9) * 0.1,
                                      child: Icon(Icons.vpn_key)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      width: (constraint.maxWidth * 0.9) * 0.5,
                                      child: Text(widget.motorboxplace.name)),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      width: (constraint.maxWidth * 0.9) * 0.1,
                                      child: Icon(Icons.motorcycle)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      width: (constraint.maxWidth * 0.9) * 0.5,
                                      child: Text(widget.motorplaceloc.name)),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  width: (constraint.maxWidth * 0.9) * 0.1,
                                  child: Icon(Boxicon.box)),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  width: (constraint.maxWidth * 0.9) * 0.5,
                                  child: Text(
                                    this._boxnumber.toString(),
                                    style: TextStyle(fontSize: 18),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                          color:
                              /*this.isaddlocation
                              ? PickCarColor.colormain.withOpacity(0.3)
                              :*/
                              Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
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
                                    color: this.currentcolor == Colors.red
                                        ? Colors.white
                                        : PickCarColor.colormain,
                                    shape: BoxShape.circle,
                                    /*gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            this.currentcolor,
                                            Colors.yellow
                                          ])*/
                                  ),
                                  child: Center(
                                    child: Center(
                                      child: Icon(
                                        Keyiconna.access,
                                        color: Colors.grey,
                                        size: 80,
                                      ),
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
                  /*InkWell(
                    child: Container(
                      height: constraint.maxWidth * 0.8,
                      width: constraint.maxWidth * 0.8,
                      decoration: BoxDecoration(
                          color: this.currentcolor, shape: BoxShape.circle),
                      child: Center(
                        child: Text(
                          this.statusbox,
                          style: TextStyle(fontSize: 56, color: Colors.white),
                        ),
                      ),
                    ),
                    onTap: () async {
                      await tapbox();
                    },
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
                      : SizedBox(),*/
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
