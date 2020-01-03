import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pickcar/datamanager.dart';
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
    final data = MediaQuery.of(context);
    return Scaffold(
      body: SingleChildScrollView(
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
                    width: data.size.width,
                    height: data.size.height/2,
                    color: Colors.black,
                  ),
                ),
                Container(
                  width: data.size.width,
                  height: data.size.height/2,
                  child: Opacity(
                    opacity: 0.8,
                    child: imageProfile(ImageProfiles.profileUrl),
                  ),
                ),
              ],
            ),
          ),
          // Positioned(
          //     child: AppBar(
          //       // title: Text("Transparent AppBar"),
          //       backgroundColor: Colors.transparent,
          //       // elevation: 0,
          //       leading: IconButton(
          //           icon: Icon(FontAwesomeIcons.arrowLeft),
          //           onPressed: () {},
          //           // tooltip: 'Share',
          //         ),
          //     ),
          //   ),
            Container(
              width: data.size.width,
              height: data.size.height,
              margin: EdgeInsets.only(top: data.size.height/2.1),
              child: Image(
                image: AssetImage('assets/images/imagesprofile/bg.png'),
                fit: BoxFit.fill,
              ),
            ),
            Container(
              width: data.size.width,
              height: data.size.height/3,
              margin: EdgeInsets.only(top: data.size.height/1.5),
              child: Image(
                image: AssetImage('assets/images/imagesprofile/bg1.png'),
                fit: BoxFit.fill,
              ),
            ),
            
            Container(
              width: data.size.width/6,
              height: data.size.height/15,
              margin: EdgeInsets.only(left: data.size.width/1.3,top:data.size.height/1.9),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(Datamanager.editprofile);
                },
                child: Image(
                  image: AssetImage('assets/images/imagesprofile/Editbutton.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              width: data.size.width/6,
              height: data.size.height/15,
              margin: EdgeInsets.only(left: data.size.width/1.3,top:data.size.height/1.9),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(Datamanager.editprofile);
                },
                child: Text('Edit',
                  // style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0x78849E)),
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*15,color: Colors.white),
                ),
              ),
            ),
            Container(
              width: data.size.width,
              height: data.size.height/3,
              margin: EdgeInsets.only(top: data.size.height/1.5),
              child: Image(
                image: AssetImage('assets/images/imagesprofile/divider.png'),
                // fit: BoxFit.fill,
              ),
            ),
            Container(
              width: data.size.width,
              height: data.size.height/3,
              margin: EdgeInsets.only(top: data.size.height/1.5),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 70.0,top: 40.0),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            // Navigator.pushNamed(context, '/Chat');
                          },
                          child: Column(
                            children: <Widget>[
                              Image(
                                image: AssetImage('assets/images/imagesprofile/icon1.png'),
                                fit: BoxFit.fill,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text('Chat',
                                // style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0x78849E)),
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*15,color: Color.fromRGBO(120,132,158,1)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 40.0),
                          child: GestureDetector(
                          onTap: () {
                            print("onTap Discount.");
                          },
                          child: Column(
                            children: <Widget>[
                              Image(
                                image: AssetImage('assets/images/imagesprofile/icon5.png'),
                                fit: BoxFit.fill,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text('Discount',
                                // style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0x78849E)),
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*15,color: Color.fromRGBO(120,132,158,1)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        )
                      ],
                    ) 
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40.0,top: 40.0),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            print("onTap Booking.");
                          },
                          child: Column(
                            children: <Widget>[
                              Image(
                                image: AssetImage('assets/images/imagesprofile/icon2.png'),
                                fit: BoxFit.fill,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text('Booking',
                                // style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0x78849E)),
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*15,color: Color.fromRGBO(120,132,158,1)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 40.0),
                          child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/Notifications');
                          },
                          child: Column(
                            children: <Widget>[
                              Image(
                                image: AssetImage('assets/images/imagesprofile/Notifications.png'),
                                fit: BoxFit.fill,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text('Notification',
                                // style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0x78849E)),
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*15,color: Color.fromRGBO(120,132,158,1)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        )
                      ],
                    ) 
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40.0,top: 40.0),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            print("onTap Mycar.");
                          },
                          child: Column(
                            children: <Widget>[
                              Image(
                                image: AssetImage('assets/images/imagesprofile/icon3.png'),
                                fit: BoxFit.fill,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text('Mycar',
                                // style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0x78849E)),
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*15,color: Color.fromRGBO(120,132,158,1)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 40.0),
                          child: GestureDetector(
                          onTap: () {
                            print("onTap Setting.");
                          },
                          child: Column(
                            children: <Widget>[
                              Image(
                                image: AssetImage('assets/images/imagesprofile/icon4.png'),
                                fit: BoxFit.fill,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text('Setting',
                                // style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0x78849E)),
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*15,color: Color.fromRGBO(120,132,158,1)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        )
                      ],
                    ) 
                  ),
                ],
              ),
            ),
            Container(
              width: data.size.width,
              height: data.size.height,
              margin: EdgeInsets.only(top: data.size.height/2.1),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all( 20.0),
                    child: Text(Datamanager.user.name,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*40,color: Color.fromRGBO(69,79,99,1)),
                      ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0,top: 65.0),
                    child: Text(UseString.facultyof + " "+Datamanager.user.faculty,
                      // style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0x78849E)),
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: Color.fromRGBO(120,132,158,1)),
                      ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0,top: 95.0),
                    child: Text(Datamanager.user.university +" "+ UseString.university,
                      // style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0x78849E)),
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: Color.fromRGBO(120,132,158,1)),
                      ),
                  ),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}
