import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/page/tabscreen.dart';
import 'package:pickcar/ui/uisize.dart';
import 'package:pickcar/widget/home/cardrental.dart';
int i=0;
class Adminlicense extends StatefulWidget {

  Function gotosearchinHome;

  @override
  _AdminlicenseState createState() => _AdminlicenseState();
}

class _AdminlicenseState extends State<Adminlicense> {
  AppBar appbar;
  

  @override
  void initState() {
    super.initState();
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
        title: Text(UseString.license,
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
      body: Column(
        children: <Widget>[
          Container(
            height: SizeConfig.blockSizeVertical*58.2,
            width: SizeConfig.screenWidth,
            color: Colors.black,
          ),
          Row(
            children: <Widget>[
              Container(
                height: SizeConfig.blockSizeVertical*6,
                width: SizeConfig.screenWidth,
                // color: Colors.blue,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: SizeConfig.blockSizeVertical*6,
                      width: SizeConfig.screenWidth/2,
                      color: PickCarColor.colormain,
                      child: Center(
                        child: Text('Driver License',
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*22,color: Colors.white), 
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      height: SizeConfig.blockSizeVertical*6,
                      width: SizeConfig.screenWidth/2,
                      color: PickCarColor.colorbuttom,
                      child: Center(
                        child: Text('Vehicle registration',
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*22,color: Colors.white), 
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: SizeConfig.blockSizeVertical*24,
            width: SizeConfig.screenWidth,
            color: Colors.yellow,
            child: ListView(
              
            ),
          ),
        ],
      ),
    );
  }
}
