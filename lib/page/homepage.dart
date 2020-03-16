import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/booking.dart';
import 'package:pickcar/models/listcarslot.dart';
import 'package:pickcar/page/tabscreen.dart';
import 'package:pickcar/ui/uisize.dart';
import 'package:pickcar/widget/cancel.dart';
import 'package:pickcar/widget/home/cardrental.dart';

int i = 0;

class HomePage extends StatefulWidget {
  Function gotosearchinHome;

  HomePage({@required this.gotosearchinHome});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppBar appbar;

  @override
  void initState() {
    // TODO: implement initState
    appbar = AppBar();
    super.initState();
  }

  void dispose() {
    // Realtime.checkalert.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // cancelshow(context);
    SizeConfig().init(context);
    showwarningWait(BuildContext context) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(UseString.pleasewaittitle),
            content: Text(UseString.pleasewaitbody),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    showwarningreject(BuildContext context) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              UseString.rejectalert,
              style: TextStyle(color: Colors.red),
            ),
            content: Text(
              UseString.rejectalertbody,
              style: TextStyle(color: Colors.red),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Send license'),
                onPressed: () {
                  // Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(Datamanager.sendlicensepage);
                },
              ),
              FlatButton(
                child: Text(UseString.cancel),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void _gotorental() {
      Firestore.instance
          .collection('User')
          .document(Datamanager.user.documentid)
          .get()
          .then((data) {
        Usershow usershow = Usershow.fromSnapshot(data);
        if (usershow.isapprove == 'wait') {
          showwarningWait(context);
        } else if (usershow.isapprove == 'Approve') {
          Navigator.of(context).pushNamed(Datamanager.search);
          // Navigator.of(context).pushNamed(Datamanager.adminmenu);
        } else {
          showwarningreject(context);
        }
      });
      // Navigator.of(context).pushNamed(Datamanager.search);
      // TabScreenPage(index: 1);
    }

    void _gotoregister() {
      Navigator.of(context).pushNamed(Datamanager.registerpage);
    }

    var data = MediaQuery.of(context);
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
              width: SizeConfig.blockSizeHorizontal * 20,
              child: Image.asset(
                'assets/images/imagelogin/logo.png',
                fit: BoxFit.fill,
              )),
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.transparent,
            ),
            onPressed: () {
              // Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          // margin: EdgeInsets.fromLTRB(0, appbar.preferredSize.height + MediaQuery.of(context).padding.top, 0, 0),
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CardRental(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      title: UseString.rentaltitle,
                      buttontext: UseString.rentalbutton,
                      tap: /*widget.gotosearchinHome,*/ _gotorental,
                      imageurl: 'assets/images/imagemain/forrent.png',
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.1,
                    ),
                    CardRental(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      title: UseString.registertitle,
                      buttontext: UseString.registerbutton,
                      tap: _gotoregister,
                      imageurl: 'assets/images/imagemain/forregister.png',
                    ),

                    // RaisedButton(
                    //   child: Text("Server"),
                    //   onPressed: (){
                    //     Navigator.of(context).pushNamed(Datamanager.serverpage);
                    //   },
                    // ),
                    // Container(
                    //     alignment: Alignment.centerLeft,
                    //     margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical,left:  SizeConfig.blockSizeHorizontal*3),
                    //     child: RaisedButton(
                    //       onPressed: (){
                    //         Navigator.of(context).pushNamed(Datamanager.selectUniversity);
                    //       },
                    //     ),
                    //   ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
