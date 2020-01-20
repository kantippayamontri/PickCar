import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:typed_data';

import 'package:pickcar/datamanager.dart';

// import 'package:intl/intl.dart';
// import 'package:intl/date_symbol_data_local.dart';
// int i =0;
class SettingPage extends StatefulWidget {
  int i=0;
  @override
  _SettingPage createState() => _SettingPage();
}
class _SettingPage extends State<SettingPage> {
  File _image;
  Uint8List imagefile;
  List<DropdownMenuItem<String>> listDrop = [];
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
       centerTitle: true,
       flexibleSpace: Image(
          image: AssetImage('assets/images/imagesprofile/appbar/background.png'),
          fit: BoxFit.cover,
        ),
       title: Text('Setting',
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: Colors.white), 
       ),
       leading: Icon(Icons.keyboard_arrow_left,
          color: Colors.transparent,
        ),
      ),
      body: SingleChildScrollView(
        child:Stack(
          children: <Widget>[
            Container(
              width: data.size.width,
              height: data.size.height,
              color: Colors.white,
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 12,left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Setting',
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*16,color: Color.fromRGBO(112,112,112,1)),
                    ),
                  ),
                ),
                Container(padding: EdgeInsets.only(top: 9),),
                Container(
                  width: data.size.width,
                  height: 1,
                  color: Colors.grey[300],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Colors.grey[300]),
                      bottom: BorderSide(width: 1.0, color: Colors.grey[300]),
                    ),
                  ),
                  child: FlatButton(
                    onPressed: (){},
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Change Account Setting',
                              style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: Color.fromRGBO(112,112,112,1)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 335),
                            child: Icon(Icons.keyboard_arrow_right,
                            color: Color.fromRGBO(112,112,112,1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
               Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Colors.grey[300]),
                      bottom: BorderSide(width: 1.0, color: Colors.grey[300]),
                    ),
                  ),
                  child: FlatButton(
                    onPressed: (){},
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Language',
                              style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: Color.fromRGBO(112,112,112,1)),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 230),
                            child: Text('English',
                              style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: Colors.grey[400]),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 335),
                            child: Icon(Icons.keyboard_arrow_right,
                            color: Color.fromRGBO(112,112,112,1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Colors.grey[300]),
                      bottom: BorderSide(width: 1.0, color: Colors.grey[300]),
                    ),
                  ),
                  child: FlatButton(
                    onPressed: (){},
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Version',
                              style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: Color.fromRGBO(112,112,112,1)),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 230),
                            child: Text('1.0.0',
                              style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: Colors.grey[400]),
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 335),
                          //   child: Icon(Icons.keyboard_arrow_right,
                          //   color: Color.fromRGBO(112,112,112,1),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Colors.grey[300]),
                      bottom: BorderSide(width: 1.0, color: Colors.grey[300]),
                    ),
                  ),
                  child: FlatButton(
                    onPressed: (){},
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Currency',
                              style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: Color.fromRGBO(112,112,112,1)),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 230),
                            child: Text('THB',
                              style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: Colors.grey[400]),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 335),
                            child: Icon(Icons.keyboard_arrow_right,
                            color: Color.fromRGBO(112,112,112,1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: data.size.width,
                  height: 40,
                  color: Colors.grey[300],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Colors.grey[300]),
                      bottom: BorderSide(width: 1.0, color: Colors.grey[300]),
                    ),
                  ),
                  child: FlatButton(
                    onPressed: (){},
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Privacy Policy',
                              style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: Color.fromRGBO(112,112,112,1)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 335),
                            child: Icon(Icons.keyboard_arrow_right,
                            color: Color.fromRGBO(112,112,112,1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Colors.grey[300]),
                      bottom: BorderSide(width: 1.0, color: Colors.grey[300]),
                    ),
                  ),
                  child: FlatButton(
                    onPressed: (){},
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Notifications',
                              style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: Color.fromRGBO(112,112,112,1)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 335),
                            child: Icon(Icons.keyboard_arrow_right,
                            color: Color.fromRGBO(112,112,112,1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Colors.grey[300]),
                      bottom: BorderSide(width: 1.0, color: Colors.grey[300]),
                    ),
                  ),
                  child: FlatButton(
                    onPressed: (){},
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Terms & condigions',
                              style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: Color.fromRGBO(112,112,112,1)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 335),
                            child: Icon(Icons.keyboard_arrow_right,
                            color: Color.fromRGBO(112,112,112,1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: data.size.width,
                  height: 40,
                  color: Colors.grey[300],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Colors.grey[300]),
                      bottom: BorderSide(width: 1.0, color: Colors.grey[300]),
                    ),
                  ),
                  child: FlatButton(
                    onPressed: (){},
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('About & Suggestion',
                              style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: Color.fromRGBO(112,112,112,1)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 335),
                            child: Icon(Icons.keyboard_arrow_right,
                            color: Color.fromRGBO(112,112,112,1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Colors.grey[300]),
                      bottom: BorderSide(width: 1.0, color: Colors.grey[300]),
                    ),
                  ),
                  child: FlatButton(
                    onPressed: (){},
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('FAQS',
                              style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: Color.fromRGBO(112,112,112,1)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 335),
                            child: Icon(Icons.keyboard_arrow_right,
                            color: Color.fromRGBO(112,112,112,1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: data.size.width,
                  height: 40,
                  color: Colors.grey[300],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Colors.grey[300]),
                      bottom: BorderSide(width: 1.0, color: Colors.grey[300]),
                    ),
                  ),
                  child: FlatButton(
                    onPressed: (){
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(UseString.logout,
                              style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: Colors.red),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 335),
                            child: Icon(Icons.keyboard_arrow_right,
                            color: Color.fromRGBO(112,112,112,1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: data.size.width,
                  height: 60,
                  color: Colors.grey[300],
                ),
              ],
            ), 
          ],
        ),
      ),
    );
  }
}
