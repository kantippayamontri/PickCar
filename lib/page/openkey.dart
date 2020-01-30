import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/boxlocation.dart';
import 'package:url_launcher/url_launcher.dart';

class Openkey extends StatefulWidget {
  double zoom = 14;
  int i=0;
  @override
  _OpenkeyState createState() => _OpenkeyState();
}

class _OpenkeyState extends State<Openkey> {
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        width: data.size.width,
        height: data.size.height,
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 50,),
              Container(
                child: Text(UseString.slotnumber,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*30,color: Colors.black), 
                ),
              ),
              Container(
                child: Text('1',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*180,color: Colors.black), 
                ),
              ),
              RaisedButton(
                onPressed: (){

                },
                child: Text('OPEN BOX',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*30,color: Colors.black), 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
