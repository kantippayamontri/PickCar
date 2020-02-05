// import 'package:flutter/material.dart';
// import 'package:pickcar/main.dart';
// import 'package:pickcar/models/motorcycle.dart';
// import 'package:pickcar/page/motordetailpage.dart';
// import 'package:transparent_image/transparent_image.dart';

// import '../../datamanager.dart';

// class ListCarItem extends StatefulWidget {
//   BoxConstraints constrant;
//   Color statuscolor;
//   Motorcycle motor;
//   ListCarItem({Key key, @required this.constrant, @required this.motor})
//       : super(key: key) {
//     switch (motor.carstatus) {
//       case CarStatus.nothing:
//         {
//           statuscolor = Colors.grey;
//         }
//         break;
//       case CarStatus.waiting:
//         {
//           statuscolor = Colors.yellow;
//         }
//         break;
//       case CarStatus.booked:
//         {
//           statuscolor = Colors.blue;
//         }
//         break;
//       case CarStatus.working:
//         {
//           statuscolor = PickCarColor.colormain;
//         }
//         break;
//     }
//   }

//   @override
//   _ListCarItemState createState() => _ListCarItemState();
// }

// class _ListCarItemState extends State<ListCarItem> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         //print("Inkwell firstore docid : ${widget.motor.motorprofilelink}");
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => MotorDetailPage(
//                     motordocid: widget.motor.firestoredocid,
//                   )),
//         );
//       },
//       child: Stack(
//         children: <Widget>[
//           Container(
//             height: widget.constrant.maxHeight * 0.2,
//             width: widget.constrant.maxWidth * 0.9,
//             decoration: BoxDecoration(
//                 color: widget.statuscolor,
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.black12,
//                       offset: Offset(0.0, 15.0),
//                       blurRadius: 15.0),
//                   BoxShadow(
//                       color: Colors.black12,
//                       offset: Offset(0.0, -10.0),
//                       blurRadius: 10.0),
//                 ],
//                 borderRadius: BorderRadius.circular(10)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: <Widget>[
//                 RotatedBox(
//                   quarterTurns: -1,
//                   child: FittedBox(
//                     fit: BoxFit.contain,
//                     child: Text(
//                       widget.motor.carstatus,
//                       style: TextStyle(color: Colors.white, fontSize: 18),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             height: widget.constrant.maxHeight * 0.18,
//             width: widget.constrant.maxWidth * 0.8,
//             decoration: BoxDecoration(
//                 color: Colors.white, borderRadius: BorderRadius.circular(10)),
//             padding: EdgeInsets.all(5),
//             child: Row(
//               children: <Widget>[
//                 Flexible(
//                   flex: 1,
//                   child: Padding(
//                     padding: const EdgeInsets.all(5),
//                     child: Stack(
//                       children: <Widget>[
//                         Center(child: CircularProgressIndicator()),
//                         Center(
//                           child: FadeInImage.memoryNetwork(
//                             placeholder: kTransparentImage,
//                             image: widget.motor.motorprofilelink,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Flexible(
//                   flex: 2,
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 5, right: 5),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         FittedBox(
//                             fit: BoxFit.contain,
//                             child: Text(
//                               widget.motor.brand +
//                                   " " +
//                                   widget.motor.generation,
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 25,
//                               ),
//                             )),
//                         SizedBox(
//                           height: 2,
//                         ),
//                         Divider(
//                           height: 1,
//                           color: Colors.grey,
//                         ),
//                         SizedBox(
//                           height: 2,
//                         ),
//                         FittedBox(
//                           fit: BoxFit.contain,
//                           child: Text(
//                             UseString.waitingforrent,
//                             style: TextStyle(fontSize: 20, color: Colors.grey),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:pickcar/main.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:pickcar/page/motordetailpage.dart';
import 'package:pickcar/ui/uisize.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../datamanager.dart';

class ListCarItem extends StatefulWidget {
  BoxConstraints constrant;
  Color statuscolor;
  Motorcycle motor;
  bool showwaiting = false;
  bool showbooking = false;
  bool showworking = false;
  double isbooking =0;
  double iswaiting =0;
  double isworking =0;
  ListCarItem({Key key, @required this.constrant, @required this.motor})
      : super(key: key) {
  }

  @override
  _ListCarItemState createState() => _ListCarItemState();
}

class _ListCarItemState extends State<ListCarItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.motor.iswaiting);
    print(widget.motor.isbook);
    print(widget.motor.isworking);
    if(widget.motor.iswaiting){
      widget.showwaiting = true;
    }
    if(widget.motor.isbook){
      widget.showbooking = true;
    }
    if(widget.motor.isworking){
      widget.showworking = true;
    }
    // if(!widget.motor.iswaiting && !widget.motor.isworking){
    //   widget.isbooking = SizeConfig.blockSizeHorizontal*26;
    // }
    if(!widget.motor.iswaiting){
      widget.isbooking = SizeConfig.blockSizeHorizontal*28;
    }
    if(!widget.motor.isbook){
      widget.iswaiting = SizeConfig.blockSizeHorizontal*28;
    }
    if(!widget.motor.iswaiting && !widget.motor.isworking){
      widget.isbooking = SizeConfig.blockSizeHorizontal*28;
    }
    if(!widget.motor.iswaiting && !widget.motor.isbook){
      widget.isworking = SizeConfig.blockSizeHorizontal*2;
    }
    SizeConfig().init(context);
    var datasize = MediaQuery.of(context);
    return InkWell(
      onTap: () {
        //print("Inkwell firstore docid : ${widget.motor.motorprofilelink}");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MotorDetailPage(
                    motordocid: widget.motor.firestoredocid,
                  )),
        );
      },
      child: Stack(
        children: <Widget>[
          Container(
            width: datasize.size.width,
            height: SizeConfig.blockSizeVertical*22,
            child: Image.asset('assets/images/imagesearch/card.png',fit: BoxFit.fill,),
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal*90,
            height: SizeConfig.blockSizeVertical*17,
            // color: Colors.blue,
            margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal*6,top:SizeConfig.blockSizeVertical*2, ),
            child: Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
                   Container(
                    width: SizeConfig.blockSizeHorizontal*33,
                    height: SizeConfig.blockSizeVertical*17,
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: CircularProgressIndicator()
                        ),
                        Center(
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: widget.motor.motorprofilelink,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        // alignment: Alignment.topLeft,
                        width: SizeConfig.blockSizeHorizontal*54,
                        // color: Colors.blue,
                        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
                        child: Text(widget.motor.brand +" "+widget.motor.generation,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*24,color: PickCarColor.colorFont1), 
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Visibility(
                            visible: widget.showwaiting,
                            child: Container(
                              margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal,right: widget.iswaiting),
                              width: SizeConfig.blockSizeHorizontal*27,
                              height: SizeConfig.blockSizeVertical*4,
                              decoration: BoxDecoration(
                                // color: Colors.green,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                border: Border.all(
                                  color: Colors.grey[400],
                                  width: 2,
                                ),
                              ),
                              child: 
                              Container(
                                width: double.infinity,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal,),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.local_offer,
                                      color: Colors.grey[400],
                                      size: SizeConfig.blockSizeHorizontal *5,
                                    ),
                                    Text(UseString.waitting ,
                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*18,color: Colors.grey[400]), 
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: widget.showbooking,
                            child: Container(
                               margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal,right: widget.isbooking),
                              width: SizeConfig.blockSizeHorizontal*27,
                              height: SizeConfig.blockSizeVertical*4,
                              decoration: BoxDecoration(
                                // color: Colors.green,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                border: Border.all(
                                  color: PickCarColor.colormain,
                                  width: 2,
                                ),
                              ),
                              child: 
                              Container(
                                width: double.infinity,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal,),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.local_offer,
                                      color: PickCarColor.colormain,
                                      size: SizeConfig.blockSizeHorizontal *5,
                                    ),
                                    Text(UseString.bookking ,
                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*18,color: PickCarColor.colormain), 
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                     Visibility(
                        visible: widget.showworking,
                        child: Container(
                          margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical,right: SizeConfig.blockSizeHorizontal*27,left:widget.isworking),
                          // alignment: Alignment.centerLeft,
                          width: SizeConfig.blockSizeHorizontal*27,
                          height: SizeConfig.blockSizeVertical*4,
                          decoration: BoxDecoration(
                            // color: Colors.green,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            border: Border.all(
                              color: Colors.blueAccent,
                              width: 2,
                            ),
                          ),
                          child: 
                          Container(
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left:SizeConfig.blockSizeHorizontal,),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.local_offer,
                                  color: Colors.blueAccent,
                                  size: SizeConfig.blockSizeHorizontal *5,
                                ),
                                Text(UseString.workking ,
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: datasize.textScaleFactor*18,color: Colors.blueAccent,), 
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          ),
        ],
      ),
    );
  }
}

