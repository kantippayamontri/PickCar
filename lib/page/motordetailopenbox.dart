import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/boxslotrent.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:pickcar/page/addlocationowner.dart';

class MotorDetailOpenBox extends StatefulWidget {
  Boxslotrent boxslotrent;
Motorcycle motorcycle;
  MotorDetailOpenBox({@required this.boxslotrent , @required this.motorcycle});

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

  Future loaddata() async {}

  void starttimer() {
    print("start timer");

    Realtime.timekey = Timer.periodic(Duration(seconds: 5), (timer) async {
      if (!isloop) {
        return;
      }
      print("timenow is " + DateTime.now().second.toString());
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
        } else {
          await Datamanager.firestore
              .collection("BoxslotRent")
              .document(_boxslotrent.docid)
              .updateData({'iskey': false, 'ownerdropkey': false});
        }

        setstate();
      }

      preboxcheck = nowboxcheck;
    });
  }

  Future tapbox() async {
    print("boxslotrent docid : ${_boxslotrent.docid}");
    DocumentSnapshot doc = await Datamanager.firestore
        .collection("BoxslotRent")
        .document(_boxslotrent.docid)
        .get();
    if (doc['isopen'] == false) {
      await Datamanager.firestore
          .collection("BoxslotRent")
          .document(_boxslotrent.docid)
          .updateData({'isopen': true});
      this.currentcolor = Colors.green;
      this.statusbox = "Open";
      _boxslotrent.isopen = true;
      setstate();
    }
    /*else {
      await Datamanager.firestore
          .collection("BoxslotRent")
          .document(_boxslotrent.docid)
          .updateData({'isopen': false});
      this.currentcolor = Colors.red;
      this.statusbox = "Close";
      _boxslotrent.isopen = false;

      await showslertdropkey();
      print("pass tapbox");

      if (this._boxslotrent.iskey) {
        await Datamanager.firestore
            .collection("BoxslotRent")
            .document(_boxslotrent.docid)
            .updateData({'iskey': true,'ownerdropkey' : true});
      } else {
        await Datamanager.firestore
            .collection("BoxslotRent")
            .document(_boxslotrent.docid)
            .updateData({'iskey': false , 'ownerdropkey' : false});
      }

      setstate();
    }*/
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
    } else {
      currentcolor = Colors.green;
      this.statusbox = "Open";
    }

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
        width: MediaQuery.of(context).size.width,
        child: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: constraint.maxHeight * 0.2,
                  ),
                  InkWell(
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
                      : SizedBox(),

                      RaisedButton(child: Text("add map"),
                      onPressed: (){
                        print("add map");
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddLocationOwner(motorcycledocid: widget.motorcycle.firestoredocid,)));
                      },)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
