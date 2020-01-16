import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:pickcar/bloc/profile/changpassword/changpasswordbloc.dart';
import 'dart:typed_data';

import '../../datamanager.dart';

// import 'package:intl/intl.dart';
// import 'package:intl/date_symbol_data_local.dart';
// int i =0;
class Detailsearch extends StatefulWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  _DetailsearchState createState() => _DetailsearchState();
}
class _DetailsearchState extends State<Detailsearch> {
  File _image;
  Uint8List imagefile;
  var _changepassword;
CarouselSlider carouselSlider;
  int _current = 0;
  List imgList = [
    'https://images.unsplash.com/photo-1502117859338-fd9daa518a9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1554321586-92083ba0a115?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1536679545597-c2e5e1946495?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1543922596-b3bbaba80649?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60'
  ];
 
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
  @override
  Widget build(BuildContext context) {
    widget.formkey = GlobalKey<FormState>();
    final data = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.white,
       flexibleSpace: Image(
          image: AssetImage('assets/images/imagesprofile/appbar/background.png'),
          fit: BoxFit.cover,
        ),
       centerTitle: true,
       title: Text(UseString.changepass,
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
      body: SingleChildScrollView(
        child:Stack(
          children: <Widget>[
            Container(
              width: data.size.width,
              height: data.size.height,
              color: Colors.grey[400],
            ),
            Container(
              margin: EdgeInsets.only(top: data.size.height),
              width: data.size.width,
              height: data.size.height,
              color: Colors.grey[400],
            ),
            Container(
              width: data.size.width,
              height: 350,
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10,left: 10),
                    child: Text("name",
                        style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*25,color: PickCarColor.colorFont1), 
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      width: 370,
                      height: 280,
                      // color: Colors.black,
                      child: Container(
                        child: Stack(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            carouselSlider = CarouselSlider(
                              height: 230.0,
                              initialPage: 0,
                              enlargeCenterPage: true,
                              // autoPlay: true,
                              // reverse: false,
                              // enableInfiniteScroll: true,
                              // autoPlayInterval: Duration(seconds: 2),
                              // autoPlayAnimationDuration: Duration(milliseconds: 2000),
                              // pauseAutoPlayOnTouch: Duration(seconds: 10),
                              // scrollDirection: Axis.horizontal,
                              onPageChanged: (index) {
                                setState(() {
                                  _current = index;
                                });
                              },
                              items: imgList.map((imgUrl) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                      ),
                                      child: Image.network(
                                        imgUrl,
                                        fit: BoxFit.fill,
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 200),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: map<Widget>(imgList, (index, url) {
                                  return Container(
                                    width: 10.0,
                                    height: 10.0,
                                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _current == index ? PickCarColor.colormain : Colors.grey,
                                    ),
                                  );
                                }),
                              ),
                            ),
                            // SizedBox(
                            //   height: 20.0,
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: <Widget>[
                            //     OutlineButton(
                            //       onPressed: goToPrevious,
                            //       child: Text("<"),
                            //     ),
                            //     OutlineButton(
                            //       onPressed: goToNext,
                            //       child: Text(">"),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 290,left: 10),
              child: Text(Currency.thb+" 2000.0",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*30,color: PickCarColor.colorFont1), 
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 290,left: 243),
              child: Text(UseString.forrent,
                  style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: PickCarColor.colorFont1), 
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 280,left: 340),
              width: 45,
              height: 45,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
                )
            ),
            Container(
              width: 100,
              height: 20,
              margin: EdgeInsets.only(top: 325,left: 310),
              // color: Colors.black,
              child: Center(
                child: Text(UseString.name,
                    style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: PickCarColor.colorFont1), 
                ),
              ),
            ),

            Container(
              width: 195,
              height: 250,
              margin: EdgeInsets.only(top: 355),
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10,left: 20),
                    child: Text(UseString.detail,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*18,color: PickCarColor.colormain),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40,left: 40),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              height: 30,
                              width: 30,
                              child: Image.asset('assets/images/imagesearch/gears.png',fit: BoxFit.fill,),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 2),
                              child: Text("autometic"+' ',
                                style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: PickCarColor.colorFont2),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              height: 30,
                              width: 30,
                              child: Image.asset('assets/images/imagesearch/cc.png',fit: BoxFit.fill,),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 2,top: 5),
                              child: Text("123"+' '+UseString.cc,
                                style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: PickCarColor.colorFont2),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              height: 30,
                              width: 30,
                              child: Image.asset('assets/images/imagesearch/gas.png',fit: BoxFit.fill,),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 2,top: 5),
                              child: Text("123"+' '+UseString.cc,
                                style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: PickCarColor.colorFont2),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              height: 30,
                              width: 30,
                              child: Image.asset('assets/images/imagesearch/color.png',fit: BoxFit.fill,),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 2,top: 5),
                              child: Text("red",
                                style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: PickCarColor.colorFont2),
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
            Container(
              width: 215,
              height: 250,
              margin: EdgeInsets.only(top: 355,left: 201),
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10,left: 20),
                    child: Text(UseString.included,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colormain),
                    ),
                  ),
                  Container(
                     margin: EdgeInsets.only(top: 47,left: 17),
                     child: Icon(Icons.done,color: PickCarColor.colormain,),
                  ),
                  Container(
                     margin: EdgeInsets.only(top: 93,left: 17),
                     child: Icon(Icons.done,color: PickCarColor.colormain,),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 47,left: 40),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(UseString.freecancle,
                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: PickCarColor.colorFont2),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 5),
                          child: Text(UseString.insurancemotorcycle,
                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: PickCarColor.colorFont2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: data.size.width,
              height: 200,
              margin: EdgeInsets.only(top: 610),
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20,top: 20),
                    child: Text(UseString.precautions,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: PickCarColor.colormain),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20,top: 50),
                    child: Text(UseString.precautionsdetail,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont2),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20,top: 150),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 3),
                          height: 20,
                          width: 20,
                          child: Image.asset('assets/images/imagesearch/warning.png',fit: BoxFit.fill,),
                        ),
                        Text(UseString.warnning,
                          style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*15,color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: data.size.width,
              height: 200,
              margin: EdgeInsets.only(top: 815),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}