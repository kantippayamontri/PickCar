import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/page/tabscreen.dart';
import 'package:pickcar/ui/uisize.dart';
import 'package:pickcar/widget/home/cardrental.dart';
int i=0;
class Adminmenu extends StatefulWidget {

  Function gotosearchinHome;

  @override
  _AdminmenuState createState() => _AdminmenuState();
}

class _AdminmenuState extends State<Adminmenu> {
  AppBar appbar;
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var data = MediaQuery.of(context);
    AppBar appbar = AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: Image(
            image: AssetImage('assets/images/imagesprofile/appbar/background.png'),
            fit: BoxFit.cover,
          ),
        centerTitle: true,
        title: Text(UseString.menu,
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: Colors.white), 
        ),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left,
          color: Colors.transparent,
          ),
          onPressed: () {
          },
        ),
      );
      var sizeappbar = AppBar().preferredSize.height;
      double sizetapbar = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appbar,
      body: Column(
        children: <Widget>[
          Container(
            width: SizeConfig.screenWidth,
            height: (SizeConfig.screenHeight/2) - ((sizeappbar+sizetapbar)/2),
            // color: Colors.black,
            child: RaisedButton(
              onPressed: (){
                Navigator.of(context).pushNamed(Datamanager.adminlicense);
              },
              color: PickCarColor.colormain,
              child: Container(
                margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*7,),
                child: Column(
                  children: <Widget>[
                    Icon(Icons.assignment_ind,color: Colors.white,size: SizeConfig.blockSizeVertical*15,),
                    Text(UseString.checkdetail,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*40,color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: SizeConfig.screenWidth,
             height: (SizeConfig.screenHeight/2) - ((sizeappbar+sizetapbar)/2),
            // color: Colors.black,
            child: RaisedButton(
              onPressed: (){
                Navigator.of(context).pushNamed(Datamanager.selectUniversity);
              },
              color: PickCarColor.colorbuttom,
              child: Container(
                margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical*7,),
                child: Column(
                  children: <Widget>[
                    Icon(Icons.location_city,color: Colors.white,size: SizeConfig.blockSizeVertical*15,),
                    Text(UseString.placebox,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*40,color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
