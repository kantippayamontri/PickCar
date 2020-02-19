import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/booking.dart';
import 'package:pickcar/models/boxlocation.dart';
import 'package:pickcar/models/boxslotrentshow.dart';
import 'package:pickcar/models/listcarslot.dart';
import 'package:pickcar/models/user.dart';
import 'package:pickcar/ui/uisize.dart';
import 'package:url_launcher/url_launcher.dart';

import '../datamanager.dart';

class Messagepage extends StatefulWidget {
  String url = 'assets/images/keyopen/gif.gif';
  double zoom = 14;
  int i=0;
  bool receivekey = false;
  double unlock = 20;
  @override
  _MessagepageState createState() => _MessagepageState();
}

class _MessagepageState extends State<Messagepage> {
  @override
  void initState(){
    super.initState();
  }
  
  dispose() {

  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var data = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: Image(
            image: AssetImage('assets/images/imagesprofile/appbar/background.png'),
            fit: BoxFit.cover,
          ),
        centerTitle: true,
        title: Text(Datamanager.usershow.name,
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: Colors.white), 
        ),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left,
          color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: data.size.width,
        height: data.size.height,
      ),
    );
  }
}
