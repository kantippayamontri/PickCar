import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/ui/uisize.dart';
import 'dart:io';
import 'dart:typed_data';

import 'package:pickcar/widget/profile/profileImage.dart';
class ProfilePage extends StatefulWidget {
  // int i=0;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {
  File _image;
  Uint8List imagefile;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final data = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Stack(
          children: <Widget>[
            SafeArea(
            bottom: false,
            top: false,
            child: Stack(
              children: <Widget>[
                Opacity(
                  opacity: 0.9,
                  child: Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight/2,
                    color: Colors.black,
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight/2,
                  child: Opacity(
                    opacity: 0.8,
                    child: imageProfile(ImageProfiles.profileUrl),
                  ),
                ),
              ],
            ),
          ),
            Container(
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              child: Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.blockSizeVertical*44,
                // margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical *6),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Image(
                        image: AssetImage('assets/images/imagesprofile/bg.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal *5),
                          alignment: Alignment.centerLeft,
                          child: Text(Datamanager.user.name,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*40,color: Color.fromRGBO(69,79,99,1)),
                            ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal *5),
                          alignment: Alignment.centerLeft,
                          child: Text(UseString.facultyof + " "+Datamanager.user.faculty,
                            // style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0x78849E)),
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: Color.fromRGBO(120,132,158,1)),
                            ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal *5),
                          alignment: Alignment.centerLeft,
                          child: Text(Datamanager.user.university +" "+ UseString.university,
                            // style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0x78849E)),
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: Color.fromRGBO(120,132,158,1)),
                            ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: (2*SizeConfig.screenWidth)/3,
                              height: SizeConfig.screenHeight/3.3,

                              // color: Colors.blue,
                              // margin: EdgeInsets.only(),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    // width: double.infinity,
                                    height: SizeConfig.blockSizeVertical *27,
                                    child: Image(
                                      image: AssetImage('assets/images/imagesprofile/bg1.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(top:data.size.width/20),
                                        alignment: Alignment.topCenter,
                                        child: Text("Wallet",
                                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*30,color: Color.fromRGBO(69,79,99,1)),
                                          ),
                                      ),
                                      Container(
                                        // margin: EdgeInsets.only(top:data.size.width/20),
                                        alignment: Alignment.topCenter,
                                        child: Text("Current money",
                                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*22,color: Color.fromRGBO(69,79,99,1)),
                                          ),
                                      ),
                                      Container(
                                        // margin: EdgeInsets.only(top:data.size.width/20),
                                        alignment: Alignment.topCenter,
                                        child: Text(Datamanager.user.money.toString()+"฿",
                                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*50,color: Color.fromRGBO(69,79,99,1)),
                                          ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  width: data.size.width/3.4,
                                  height: data.size.height/4.1,
                                  // color: Colors.blue,
                                  margin: EdgeInsets.only(bottom: data.size.height/24),
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        // color: Colors.blue,
                                        width: double.infinity,
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              width: double.infinity,
                                              child: Image(
                                                image: AssetImage('assets/images/imagesprofile/bg2.png'),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Column(
                                              children: <Widget>[
                                               GestureDetector(
                                                 onTap:(){
                                                   Navigator.of(context).pushNamed(Datamanager.historypage);
                                                 },
                                                 child: Container(
                                                  //  color: Colors.blue,
                                                   width: data.size.width/3.4,
                                                   height: data.size.height/8.2,
                                                   child: Container(
                                                     width:double.infinity,
                                                     margin: EdgeInsets.only(right:data.size.width/35),
                                                     child: IconButton(
                                                       onPressed: (){
                                                         Navigator.of(context).pushNamed(Datamanager.historypage);
                                                       },
                                                        icon:Icon(Icons.history,color: PickCarColor.colormain,),
                                                        iconSize: (data.size.width+data.size.height)/22,
                                                      ),
                                                    ),
                                                 ),
                                               ),
                                               GestureDetector(
                                                 onTap: (){
                                                  // Navigator.of(context).pushNamed(Datamanager.coupongpage);
                                                 },
                                                 child: Container(
                                                  //  color: Colors.blue,
                                                   width: data.size.width/3.4,
                                                   height: data.size.height/8.2,
                                                   child: Container(
                                                      width:double.infinity,
                                                      margin: EdgeInsets.only(right:data.size.width/35,bottom: data.size.height/45,),
                                                      child: IconButton(
                                                        onPressed: (){
                                                          // print("aaab");
                                                          Navigator.of(context).pushNamed(Datamanager.coupongpage);
                                                        },
                                                        icon:Icon(Icons.card_giftcard,color: PickCarColor.colormain,),
                                                        iconSize: (data.size.width+data.size.height)/22,
                                                      ),
                                                    ),
                                                 ),
                                               ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            Container(
              width: data.size.width/6,
              height: data.size.height/15,
              // color: Colors.blue,
              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*78,top:SizeConfig.blockSizeVertical*52),
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).pushNamed(Datamanager.editprofile);
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      // color: Colors.blue,
                      width: double.infinity,
                      child: Image(
                        image: AssetImage('assets/images/imagesprofile/Editbutton.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                     Container(
                       width: double.infinity,
                       alignment: Alignment.topCenter,
                       margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical *1.5),
                       child: Text(UseString.edit,
                         style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: Colors.white),
                       ),
                     ),
                  ],
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
