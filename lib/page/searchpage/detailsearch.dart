import 'package:carousel_slider/carousel_slider.dart';
import 'package:flat_icons_flutter/flat_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:pickcar/bloc/profile/changpassword/changpasswordbloc.dart';
import 'package:pickcar/ui/uisize.dart';
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
    Datamanager.motorcycleShow.motorfrontlink,
    Datamanager.motorcycleShow.motorleftlink,
    Datamanager.motorcycleShow.motorbacklink,
    Datamanager.motorcycleShow.motorrightlink,
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
    SizeConfig().init(context);
    // var fontsize = SizeConfig.blockSizeHorizontal+SizeConfig.blockSizeVertical;
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
       title: Text(UseString.detail,
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
              height: SizeConfig.blockSizeVertical*40,
              color: Colors.grey[400],
            ),
            Container(
              width: data.size.width,
              height: SizeConfig.blockSizeVertical*51,
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical,left: SizeConfig.blockSizeHorizontal),
                    child: Text(Datamanager.motorcycleShow.brand+' '+Datamanager.motorcycleShow.generation,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*30,color: PickCarColor.colorFont1), 
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*8),
                      width: SizeConfig.blockSizeHorizontal*90,
                      height: SizeConfig.blockSizeVertical*50,
                      // color: Colors.black,
                      child: Container(
                        child: Stack(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            carouselSlider = CarouselSlider(
                              height: SizeConfig.blockSizeVertical*30,
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
                                      margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
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
                              height: SizeConfig.blockSizeVertical,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: map<Widget>(imgList, (index, url) {
                                  return Container(
                                    width: SizeConfig.blockSizeVertical*1.5,
                                    height: SizeConfig.blockSizeVertical*1.5,
                                    margin: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical, horizontal: SizeConfig.blockSizeHorizontal/2),
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
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*42,left: SizeConfig.blockSizeHorizontal),
              child: Text(Currency.thb+' '+Datamanager.listcarslot.price.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*30,color: PickCarColor.colorFont1), 
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*42,left: SizeConfig.blockSizeHorizontal*60),
              child: Text(UseString.forrent,
                  style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: PickCarColor.colorFont1), 
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*41,left: SizeConfig.blockSizeHorizontal*82),
              width: SizeConfig.blockSizeHorizontal*11,
              height: SizeConfig.blockSizeHorizontal*11,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new NetworkImage(
                        Datamanager.usershow.imageurl)
                )
              )
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal*24,
              height: SizeConfig.blockSizeVertical*3,
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*47,left: SizeConfig.blockSizeHorizontal*75),
              // color: Colors.black,
              child: Center(
                child: Text(Datamanager.usershow.name,
                    style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: PickCarColor.colorFont1), 
                ),
              ),
            ),

            Container(
              width: SizeConfig.blockSizeHorizontal*47.5,
              height: SizeConfig.blockSizeVertical*36.5,
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*52),
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical,left: SizeConfig.blockSizeHorizontal*4),
                    child: Text(UseString.detail,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*18,color: PickCarColor.colormain),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*5,left: SizeConfig.blockSizeHorizontal*8),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              height: SizeConfig.blockSizeHorizontal*7,
                              width: SizeConfig.blockSizeHorizontal*7,
                              child: Image.asset('assets/images/imagesearch/gears.png',fit: BoxFit.fill,),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal),
                              child: Text(Datamanager.motorcycleShow.gear,
                                style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: PickCarColor.colorFont2),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
                              height: SizeConfig.blockSizeHorizontal*7,
                              width: SizeConfig.blockSizeHorizontal*7,
                              child: Image.asset('assets/images/imagesearch/cc.png',fit: BoxFit.fill,),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal,top: SizeConfig.blockSizeVertical),
                              child: Text(Datamanager.motorcycleShow.cc.toString()+' '+UseString.cc,
                                style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: PickCarColor.colorFont2),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
                              height: SizeConfig.blockSizeHorizontal*7,
                              width: SizeConfig.blockSizeHorizontal*7,
                              child: Image.asset('assets/images/imagesearch/gas.png',fit: BoxFit.fill,),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal,top: SizeConfig.blockSizeVertical),
                              child: Text(Datamanager.motorcycleShow.motorgas,
                                style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: PickCarColor.colorFont2),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
                              height: SizeConfig.blockSizeHorizontal*7,
                              width: SizeConfig.blockSizeHorizontal*7,
                              child: Image.asset('assets/images/imagesearch/color.png',fit: BoxFit.fill,),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal,top: SizeConfig.blockSizeVertical),
                              child: Text(Datamanager.motorcycleShow.color,
                                style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: PickCarColor.colorFont2),
                              ),
                            ),
                          ],
                        ),
                        // Row(
                        //   children: <Widget>[
                        //     Container(
                        //       margin: EdgeInsets.only(top: 5),
                        //       height: 30,
                        //       width: 30,
                        //       child: Image.asset('assets/images/imagesearch/color.png',fit: BoxFit.fill,),
                        //     ),
                        //     Container(
                        //       margin: EdgeInsets.only(left: 2,top: 5),
                        //       child: Text(Datamanager.motorcycleShow.color,
                        //         style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*18,color: PickCarColor.colorFont2),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal*51.5,
              height: SizeConfig.blockSizeVertical*36.5,
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*52,left: SizeConfig.blockSizeHorizontal*49),
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical,left: SizeConfig.blockSizeHorizontal*4),
                    child: Text(UseString.included,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colormain),
                    ),
                  ),
                  Container(
                     margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*5,left: SizeConfig.blockSizeHorizontal*4),
                     child: Icon(Icons.done,color: PickCarColor.colormain,),
                  ),
                  Container(
                     margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*12,left: SizeConfig.blockSizeHorizontal*4),
                     child: Icon(Icons.done,color: PickCarColor.colormain,),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*5,left: SizeConfig.blockSizeHorizontal*10),
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
                          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
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
              height: SizeConfig.blockSizeVertical*29,
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*89.5),
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*4,top: SizeConfig.blockSizeVertical*2),
                    child: Text(UseString.precautions,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: PickCarColor.colormain),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*4,top: SizeConfig.blockSizeVertical*6),
                    child: Text(UseString.precautionsdetail,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont2),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*4,top: SizeConfig.blockSizeVertical*22),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal),
                          height: SizeConfig.blockSizeVertical*2,
                          width: SizeConfig.blockSizeHorizontal*4,
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
              height: SizeConfig.blockSizeVertical*30,
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*119.5),
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*4,top: SizeConfig.blockSizeVertical*2),
                    child: Text(UseString.location,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: PickCarColor.colormain),
                          ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*4,top: SizeConfig.blockSizeVertical*7),
                    child: Text(UseString.locationdetail,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont2),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushNamed(Datamanager.maplocation);
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*43,top: SizeConfig.blockSizeVertical*12),
                          width: 50,
                          height: 55,
                          child: Image.asset('assets/images/imagesearch/pin.png',fit: BoxFit.fill,),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*42,top: SizeConfig.blockSizeVertical*20),
                          width: 60,
                          height: 55,
                          child: Text(UseString.location,
                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*15,color: PickCarColor.colormain),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: SizeConfig.blockSizeVertical*10,
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*142),
              width: data.size.width,
              // color: Colors.black,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Image.asset('assets/images/imagesearch/buttom.png',fit: BoxFit.fill,),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushNamed(Datamanager.confirmpage);
                    },
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical*1.1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          // color: Colors.black,
                        ),
                        width: SizeConfig.blockSizeHorizontal*35,
                        height: SizeConfig.blockSizeVertical*6,
                        child: Center(
                          child: Text(UseString.next,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: Colors.white),
                          ),
                      ),
                    ),
                  ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}