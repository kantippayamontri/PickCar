// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:pickcar/datamanager.dart';
// import 'package:pickcar/models/booking.dart';
// class ConfirmPage extends StatefulWidget {
//   bool isExpand = false;
//   bool alertpolicy = false;
//   var pricefree;
//   var pricetotal;
//   double pricevat;
//   var iconchange = Icon(Icons.add,size: 32,color: PickCarColor.colormain,);
//   @override
//   _ConfirmPageState createState() => _ConfirmPageState();
// }

// class _ConfirmPageState extends State<ConfirmPage> {
//   void initState(){
//     Checkpolicy.checkpolicy = false;
//     super.initState();
//   }
//   String monthy(int month){
//     switch(month){
//       case 1:return 'January';break;
//       case 2:return 'February';break;
//       case 3:return 'March';break;
//       case 4:return 'April';break;
//       case 5:return 'May';break;
//       case 6:return 'June';break;
//       case 7:return 'July';break;
//       case 8:return 'August';break;
//       case 9:return 'September';break;
//       case 10:return 'October';break;
//       case 11:return 'November';break;
//       default:return 'December';break;
//     }
//   }
//   Widget alertpolicy(BuildContext context){
//     var data = MediaQuery.of(context);
//     if(widget.alertpolicy == true){
//       return Container(
//         margin: EdgeInsets.only(top: 5),
//         child: Text(UseString.notaccept,
//             style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*19,color: Colors.red[600]), 
//           ),
//       );
//     }else{
//       return Container();
//     }
//   }
//   calculateprice(){
//     var price = Datamanager.listcarslot.price;
//     widget.pricefree = price + 5;
//     widget.pricevat = widget.pricefree+(widget.pricefree * 7)/100;
//     String string = widget.pricevat.toString();
//     var dot = string.split('.');
//     print(dot);
//     double numberdot = double.parse(dot[1]);
//     double number = double.parse(dot[0]);
//     if(numberdot>0 && numberdot<25){
//       number += 0.25;
//     }else if(numberdot>25 && numberdot<50){
//       number += 0.50;
//     }else if(numberdot>50 && numberdot<75){
//       number += 0.75;
//     }else{
//       number += 1;
//     }
//     widget.pricetotal = number;
//     print(widget.pricetotal);
//   }
//   @override
//   Widget build(BuildContext context) {
//     var data = MediaQuery.of(context);
//     print(Datamanager.listcarslot.docid);
//     booking(BuildContext context) async {
//       // List<String> slotw = Datamanager.listcarslot.timeslotlist;
//       // // print(slotw);
//       // int indexs = Datamanager.listcarslot.timeslotlist.indexOf(Datamanager.slottime.timeslot);
//       // if(indexs != -1){
//       //   slotw.removeAt(indexs);
//       // }
//       // Datamanager.listcarslot.timeslotlist = slotw;
//       // List<String> slot = [];
//       // slot.add(Datamanager.slottime.timeslot);
//       // Booking booking = Booking(
//       //   tiems: Datamanager.slottime.timeslot,
//       //   day: Datamanager.slottime.day,
//       //   month: Datamanager.slottime.month,
//       //   price: Datamanager.slottime.price,
//       //   year: Datamanager.slottime.year,
//       //   motorcycledocid: Datamanager.slottime.motorcycledocid,
//       //   motorforrentdocid: Datamanager.slottime.motorforrentdocid,
//       //   ownerid: Datamanager.slottime.ownerdocid,
//       //   myid: Datamanager.user.documentid,
//       //   bookingdocid:null,
//       // );
//       // var ref = await Datamanager.firestore.collection('Booking').add(booking.toJson());
//       // var document = ref.documentID;
//       // Datamanager.firestore.collection("Booking").document(document).updateData(
//       //     {'bookingdocid' : document}
//       // );
//       // Datamanager.firestore.collection("Motorcycle")
//       //                       .document(Datamanager.listcarslot.motorcycledocid)
//       //                       .updateData({"isbook": true});
//       // Datamanager.firestore.collection("Motorcycleforrent")
//       //                       .document(Datamanager.listcarslot.docid)
//       //                       .updateData({"timeslotlist": FieldValue.arrayRemove(slot)});
//       // if(Datamanager.listcarslot.timeslotlist.length ==0){
//       //   Datamanager.firestore.collection("Motorcycleforrent")
//       //                       .document(Datamanager.listcarslot.docid)
//       //                       .delete();
//       //   Datamanager.firestore.collection("Motorcycle")
//       //                       .document(Datamanager.listcarslot.motorcycledocid)
//       //                       .updateData({"iswaiting": false});
//       // }
//       // Datamanager.firestore.collection('MotorcycleforrentSlot').document(Datamanager.slottime.docid).delete();
//     }
//     var time = Datamanager.slottime.timeslot.split('-');
//     calculateprice();
//     return Scaffold(
//       appBar: AppBar(
//        backgroundColor: Colors.white,
//        flexibleSpace: Image(
//           image: AssetImage('assets/images/imagesprofile/appbar/background.png'),
//           fit: BoxFit.cover,
//         ),
//        centerTitle: true,
//        title: Text(UseString.confirmrent,
//           style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: Colors.white), 
//        ),
//        leading: IconButton(
//           icon: Icon(Icons.keyboard_arrow_left,
//           color: Colors.white,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child:Column(
//           children: <Widget>[
//             Container(
//               alignment: Alignment.centerLeft,
//               margin: EdgeInsets.only(top: 5,left: 30),
//               child: Text(UseString.rentaldetail,
//                   style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: PickCarColor.colormain), 
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 5,left: 30),
//               child: Row(
//                 children: <Widget>[
//                   Text(UseString.selectedcar,
//                       style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont2), 
//                   ),
//                   SizedBox(width: 90,),
//                    Text(UseString.getkey,
//                       style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont2), 
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 5,left: 20),
//               child: Row(
//                 children: <Widget>[
//                   Container(
//                     width: 120,
//                     height: 65,
//                     // color: Colors.black,
//                     // alignment: Alignment.centerLeft,
//                     child: Column(
//                       children: <Widget>[
//                         Text(Datamanager.motorcycleShow.brand,
//                             style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
//                         ),
//                          Text(Datamanager.motorcycleShow.generation,
//                             style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(width: 75,),
//                   Container(
//                     width: 130,
//                     height: 65,
//                     // color: Colors.black,
//                     child: Text(UseString.getkey,
//                         style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(left: 30),
//               child: Row(
//                 children: <Widget>[
//                   Text(UseString.receivecar,
//                       style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont2), 
//                   ),
//                   SizedBox(width: 100,),
//                    Text(UseString.returncar,
//                       style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont2), 
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 5,left: 50),
//               child: Row(
//                 children: <Widget>[
//                   Container(
//                     // width: 180,
//                     // height: 30,
//                     // color: Colors.black,
//                     // alignment: Alignment.centerLeft,
//                     child: Column(
//                       children: <Widget>[
//                         Text(time[0].trim(),
//                             style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(width: 145,),
//                   Container(
//                     // width: 190,
//                     // height: 30,
//                     // color: Colors.black,
//                     child: Column(
//                       children: <Widget>[
//                         Text(time[1].trim(),
//                             style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//             margin: EdgeInsets.only(top:10,left: 150),
//             child: Row(
//               children: <Widget>[
//                 Text(UseString.day,
//                     style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont2), 
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(left: 110),
//             child: Row(
//               children: <Widget>[
//                 Text(Datamanager.listcarslot.day.toString()+' '+monthy(Datamanager.listcarslot.month)+' '+Datamanager.listcarslot.year.toString(),
//                     style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(top:5,left: 20,right: 20),
//             color: Colors.grey[200],
//             child: ExpansionTile(
//               initiallyExpanded: widget.isExpand,
//               backgroundColor: Colors.white,
//               // key: PageStorageKey(this.widget.headerTitle),
//               trailing: widget.iconchange,
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(top: 5),
//                   width: double.infinity,
//                   height: 1,
//                   color: Colors.grey[200],
//                 ),
//                 Container(
//                   alignment: Alignment.centerLeft,
//                   width: double.infinity,
//                   margin: EdgeInsets.only(left:15,top: 5),
//                   child: Stack(
//                     children: <Widget>[
//                       Container(
//                         alignment: Alignment.centerLeft,
//                         width: double.infinity,
//                         child: Text(UseString.pricebegin,
//                           style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorcmu), 
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(right: 15),
//                         alignment: Alignment.centerRight,
//                         width: double.infinity,
//                         child: Text(Datamanager.slottime.price.toString(),
//                           style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorcmu), 
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   alignment: Alignment.centerLeft,
//                   width: double.infinity,
//                   margin: EdgeInsets.only(left:15,top: 5,bottom: 5),
//                   child: Stack(
//                     children: <Widget>[
//                       Container(
//                         alignment: Alignment.centerLeft,
//                         width: double.infinity,
//                         child: Text(UseString.pricefee,
//                           style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorcmu), 
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(right: 15),
//                         alignment: Alignment.centerRight,
//                         width: double.infinity,
//                         child: Text(widget.pricefree.toString(),
//                           style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorcmu), 
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   alignment: Alignment.centerLeft,
//                   width: double.infinity,
//                   margin: EdgeInsets.only(left:15,top: 5,bottom: 5),
//                   child: Stack(
//                     children: <Widget>[
//                       Container(
//                         alignment: Alignment.centerLeft,
//                         width: double.infinity,
//                         child: Text(UseString.pricevat,
//                           style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorcmu), 
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(right: 15),
//                         alignment: Alignment.centerRight,
//                         width: double.infinity,
//                         child: Text(widget.pricevat.toString(),
//                           style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorcmu), 
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//               onExpansionChanged: (value){
//                 setState(() {
//                   if(value){
//                     widget.iconchange = Icon(Icons.arrow_drop_down,size: 32,color: PickCarColor.colormain,);
//                   }else{
//                     widget.iconchange = Icon(Icons.add,size: 32,color: PickCarColor.colormain,);
//                   }
//                   widget.isExpand = value;
//                 });
//               },
//               title: Container(
//                 // color: Colors.grey[200],
//                 width: double.infinity,
//                 child: Text(UseString.pricedetail,
//                   style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*20,color: PickCarColor.colormain), 
//                 ),
//               )
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(top:5),
//             width: data.size.width,
//             child: Stack(
//               children: <Widget>[
//                 Container(
//                   margin: EdgeInsets.only(left: 25),
//                   width: double.infinity,
//                   alignment: Alignment.centerLeft,
//                   child: Text(UseString.totalprice,
//                       style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
//                   ),
//                 ),
//                  Container(
//                    margin: EdgeInsets.only(right: 25),
//                   alignment: Alignment.centerRight,
//                   width: double.infinity,
//                   child: Text(widget.pricetotal.toString()+' '+Currency.thb,
//                       style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(top:5),
//             width: data.size.width-40,
//             height: 2,
//             color: Colors.grey[300],
//           ),
//           Container(
//             alignment: Alignment.centerLeft,
//             margin: EdgeInsets.only(top: 30,left: 30),
//             child: Text(UseString.userdetail,
//                 style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: PickCarColor.colormain), 
//             ),
//           ),
//           Container(
//             alignment: Alignment.centerLeft,
//             margin: EdgeInsets.only(top: 5,left: 30),
//             child: Row(
//               children: <Widget>[
//                 Icon(Icons.person,color: Colors.grey[500],),
//                 SizedBox(width: 5,),
//                 Text(Datamanager.user.name,
//                     style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             alignment: Alignment.centerLeft,
//             margin: EdgeInsets.only(top: 5,left: 30),
//             child: Row(
//               children: <Widget>[
//                 Icon(Icons.email,color: Colors.grey[500],),
//                 SizedBox(width: 5,),
//                 Text(Datamanager.user.email,
//                     style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             alignment: Alignment.centerLeft,
//             margin: EdgeInsets.only(top: 5,left: 30),
//             child: Row(
//               children: <Widget>[
//                 Icon(Icons.phone,color: Colors.grey[500],),
//                 SizedBox(width: 5,),
//                 Text(Datamanager.user.tel,
//                     style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             alignment: Alignment.centerLeft,
//             margin: EdgeInsets.only(top: 15,left: 30),
//             child: Column(
//               children: <Widget>[
//                 Row(
//                   children: <Widget>[
//                     SizedBox(
//                       height: 24.0,
//                       width: 24.0,
//                       child: Checkbox(
//                       value: Checkpolicy.checkpolicy,
//                         onChanged: (bool value) {
//                           setState(() {
//                             Checkpolicy.checkpolicy = value;
//                             widget.alertpolicy =false;
//                           });
//                         },
//                       ),
//                     ),
//                     Text(UseString.readandagree,
//                         style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*17,color: PickCarColor.colorcmu), 
//                     ),
//                     GestureDetector(
//                       onTap: (){},
//                       child: Row(
//                         children: <Widget>[
//                           Text(UseString.policy,
//                             style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*17,color: Colors.blue[600],decoration: TextDecoration.underline,), 
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(left: 23),
//                   alignment: Alignment.centerLeft,
//                   child: Text(UseString.forpolicy,
//                     style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*17,color: PickCarColor.colorcmu), 
//                   ),
//                 ),
//                 alertpolicy(context),
//                  Row(
//                    children: <Widget>[
//                      RaisedButton(
//                       color: Colors.grey[600],
//                       onPressed: (){
//                           Navigator.pop(context);
//                           Navigator.pop(context);
//                       },
//                       child: Text(UseString.cancel,
//                           style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*18,color: Colors.white), 
//                         ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(left: 5),
//                       width: 280,
//                       child: RaisedButton(
//                         color: PickCarColor.colormain,
//                         onPressed: (){
//                           if(Checkpolicy.checkpolicy == true){
//                             booking(context);
//                             if(Datamanager.listcarslot.time.length ==0){
//                               Navigator.pop(context);
//                               Navigator.pop(context);
//                               Navigator.pop(context);
//                               DataFetch.fetchpiority = 0;
//                               DataFetch.checkhavedata = 0;
//                               DataFetch.checknotsamenoresult = 0;
//                               DataFetch.checknothaveslottime = 0;
//                               Datamanager.motorcycleShow = null;
//                               Datamanager.usershow= null;
//                               Datamanager.listcarslot= null;
//                               Datamanager.slottime= null;
//                             }else{
//                               Navigator.pop(context);
//                               Navigator.pop(context);
//                             }
//                           }else{
//                             setState(() {
//                               widget.alertpolicy = true;
//                             });
//                           }
//                           // Navigator.of(context).pushNamed(Datamanager.detailsearch);
//                         },
//                         child: Text(UseString.confirm,
//                           style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*18,color: Colors.white), 
//                         ),
//                       ),
//                     ),
//                    ],
//                  ),
//               ],
//             ),
//           ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// // Text("Slotpage"),
//             // RaisedButton(
//             //   onPressed: (){
//             //     booking(context);
//             //     if(Datamanager.listcarslot.timeslotlist.length ==0){
//             //       Navigator.pop(context);
//             //       Navigator.pop(context);
//             //       Navigator.pop(context);
//             //     }else{
//             //       Navigator.pop(context);
//             //       Navigator.pop(context);
//             //     }
//             //     // Navigator.of(context).pushNamed(Datamanager.detailsearch);
//             //   },
//             //   child: Text("Confirm"),
//             // ),

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/booking.dart';
class ConfirmPage extends StatefulWidget {
  bool isExpand = false;
  bool alertpolicy = false;
  var pricefree;
  var pricetotal;
  double pricevat;
  var iconchange = Icon(Icons.add,size: 32,color: PickCarColor.colormain,);
  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  void initState(){
    Checkpolicy.checkpolicy = false;
    super.initState();
  }
  String monthy(int month){
    switch(month){
      case 1:return 'January';break;
      case 2:return 'February';break;
      case 3:return 'March';break;
      case 4:return 'April';break;
      case 5:return 'May';break;
      case 6:return 'June';break;
      case 7:return 'July';break;
      case 8:return 'August';break;
      case 9:return 'September';break;
      case 10:return 'October';break;
      case 11:return 'November';break;
      default:return 'December';break;
    }
  }
  Widget alertpolicy(BuildContext context){
    var data = MediaQuery.of(context);
    if(widget.alertpolicy == true){
      return Container(
        margin: EdgeInsets.only(top: 5),
        child: Text(UseString.notaccept,
            style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*19,color: Colors.red[600]), 
          ),
      );
    }else{
      return Container();
    }
  }
  calculateprice(){
    var price = Datamanager.listcarslot.price;
    widget.pricefree = price + 5;
    widget.pricevat = (widget.pricefree * 7)/100;
    var priceinclude = widget.pricefree+(widget.pricefree * 7)/100;
    String string = priceinclude.toString();
    var dot = string.split('.');
    print(dot);
    double numberdot = double.parse(dot[1]);
    double number = double.parse(dot[0]);
    if(numberdot>0 && numberdot<25){
      number += 0.25;
    }else if(numberdot>25 && numberdot<50){
      number += 0.50;
    }else if(numberdot>50 && numberdot<75){
      number += 0.75;
    }else{
      number += 1;
    }
    widget.pricetotal = number;
    print(widget.pricetotal);
  }
  booking(BuildContext context) async {
    Booking booking = Booking(
      university: Datamanager.listcarslot.university,
      times: Datamanager.listcarslot.time,
      day: Datamanager.listcarslot.day,
      month: Datamanager.listcarslot.month,
      price: Datamanager.listcarslot.price,
      year: Datamanager.listcarslot.year,
      motorcycledocid: Datamanager.listcarslot.motorcycledocid,
      ownerid: Datamanager.listcarslot.ownerdocid,
      myid: Datamanager.user.documentid,
      boxdocid: Datamanager.listcarslot.boxdocid,
      boxslotrentdocid:  Datamanager.listcarslot.boxslotrentdocid,
      boxplacedocid:  Datamanager.listcarslot.boxplacedocid,
      motorplacelocdocid: Datamanager.listcarslot.motorplacelocdocid,
      bookingdocid:null,
    );
    var ref = await Datamanager.firestore.collection('Booking').add(booking.toJson());
    var document = ref.documentID;
    Datamanager.firestore.collection("Booking").document(document).updateData(
        {'bookingdocid' : document}
    );
    Datamanager.firestore.collection("Motorcycle")
                          .document(Datamanager.listcarslot.motorcycledocid)
                          .updateData({"isbook": true});
    // if(Datamanager.listcarslot.timeslotlist.length ==0){
    //   Datamanager.firestore.collection("Motorcycleforrent")
    //                       .document(Datamanager.listcarslot.docid)
    //                       .delete();
    //   Datamanager.firestore.collection("Motorcycle")
    //                       .document(Datamanager.listcarslot.motorcycledocid)
    //                       .updateData({"iswaiting": false});
    // }
    Datamanager.firestore.collection('Singleforrent').document(Datamanager.listcarslot.docid).delete();
  }
  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))
          ),
          title: Text(UseString.areyousure),
          content: Text(UseString.rentthis),
          actions: <Widget>[
            FlatButton(
              child: Text(UseString.confirm),
              onPressed: () {
                booking(context);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text(UseString.cancel),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);
    var time = Datamanager.listcarslot.time.split('-');
    calculateprice();
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.white,
       flexibleSpace: Image(
          image: AssetImage('assets/images/imagesprofile/appbar/background.png'),
          fit: BoxFit.cover,
        ),
       centerTitle: true,
       title: Text(UseString.confirmrent,
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
        child:Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 5,left: 30),
              child: Text(UseString.rentaldetail,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: PickCarColor.colormain), 
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5,left: 30),
              child: Row(
                children: <Widget>[
                  Text(UseString.selectedcar,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont2), 
                  ),
                  SizedBox(width: 90,),
                   Text(UseString.getkey,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont2), 
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5,left: 20),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 120,
                    height: 65,
                    // color: Colors.black,
                    // alignment: Alignment.centerLeft,
                    child: Column(
                      children: <Widget>[
                        Text(Datamanager.motorcycleShow.brand,
                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
                        ),
                         Text(Datamanager.motorcycleShow.generation,
                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 75,),
                  Container(
                    width: 130,
                    height: 65,
                    // color: Colors.black,
                    child: Center(
                      child: Text(Datamanager.boxlocationshow.name,
                          style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30),
              child: Row(
                children: <Widget>[
                  Text(UseString.receivecar,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont2), 
                  ),
                  SizedBox(width: 100,),
                   Text(UseString.returncar,
                      style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont2), 
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5,left: 50),
              child: Row(
                children: <Widget>[
                  Container(
                    // width: 180,
                    // height: 30,
                    // color: Colors.black,
                    // alignment: Alignment.centerLeft,
                    child: Column(
                      children: <Widget>[
                        Text(time[0].trim(),
                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 145,),
                  Container(
                    // width: 190,
                    // height: 30,
                    // color: Colors.black,
                    child: Column(
                      children: <Widget>[
                        Text(time[1].trim(),
                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
            margin: EdgeInsets.only(top:10,left: 150),
            child: Row(
              children: <Widget>[
                Text(UseString.day,
                    style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*20,color: PickCarColor.colorFont2), 
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 110),
            child: Row(
              children: <Widget>[
                Text(Datamanager.listcarslot.day.toString()+' '+monthy(Datamanager.listcarslot.month)+' '+Datamanager.listcarslot.year.toString(),
                    style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top:5,left: 20,right: 20),
            color: Colors.grey[200],
            child: ExpansionTile(
              initiallyExpanded: widget.isExpand,
              backgroundColor: Colors.white,
              // key: PageStorageKey(this.widget.headerTitle),
              trailing: widget.iconchange,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5),
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[200],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  margin: EdgeInsets.only(left:15,top: 5),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        child: Text(UseString.pricebegin,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorcmu), 
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        alignment: Alignment.centerRight,
                        width: double.infinity,
                        child: Text(Datamanager.listcarslot.price.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorcmu), 
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  margin: EdgeInsets.only(left:15,top: 5,bottom: 5),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        child: Text(UseString.pricefee,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorcmu), 
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        alignment: Alignment.centerRight,
                        width: double.infinity,
                        child: Text(widget.pricefree.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorcmu), 
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  margin: EdgeInsets.only(left:15,top: 5,bottom: 5),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        child: Text(UseString.pricevat,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorcmu), 
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        alignment: Alignment.centerRight,
                        width: double.infinity,
                        child: Text(widget.pricevat.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*20,color: PickCarColor.colorcmu), 
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              onExpansionChanged: (value){
                setState(() {
                  if(value){
                    widget.iconchange = Icon(Icons.arrow_drop_down,size: 32,color: PickCarColor.colormain,);
                  }else{
                    widget.iconchange = Icon(Icons.add,size: 32,color: PickCarColor.colormain,);
                  }
                  widget.isExpand = value;
                });
              },
              title: Container(
                // color: Colors.grey[200],
                width: double.infinity,
                child: Text(UseString.pricedetail,
                  style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*20,color: PickCarColor.colormain), 
                ),
              )
            ),
          ),
          Container(
            margin: EdgeInsets.only(top:5),
            width: data.size.width,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 25),
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Text(UseString.totalprice,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
                  ),
                ),
                 Container(
                   margin: EdgeInsets.only(right: 25),
                  alignment: Alignment.centerRight,
                  width: double.infinity,
                  child: Text(widget.pricetotal.toString()+' '+Currency.thb,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top:5),
            width: data.size.width-40,
            height: 2,
            color: Colors.grey[300],
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 30,left: 30),
            child: Text(UseString.userdetail,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*25,color: PickCarColor.colormain), 
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 5,left: 30),
            child: Row(
              children: <Widget>[
                Icon(Icons.person,color: Colors.grey[500],),
                SizedBox(width: 5,),
                Text(Datamanager.user.name,
                    style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 5,left: 30),
            child: Row(
              children: <Widget>[
                Icon(Icons.email,color: Colors.grey[500],),
                SizedBox(width: 5,),
                Text(Datamanager.user.email,
                    style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 5,left: 30),
            child: Row(
              children: <Widget>[
                Icon(Icons.phone,color: Colors.grey[500],),
                SizedBox(width: 5,),
                Text(Datamanager.user.tel,
                    style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 15,left: 30),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      height: 24.0,
                      width: 24.0,
                      child: Checkbox(
                      value: Checkpolicy.checkpolicy,
                        onChanged: (bool value) {
                          setState(() {
                            Checkpolicy.checkpolicy = value;
                            widget.alertpolicy =false;
                          });
                        },
                      ),
                    ),
                    Text(UseString.readandagree,
                        style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*17,color: PickCarColor.colorcmu), 
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: Row(
                        children: <Widget>[
                          Text(UseString.policy,
                            style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*17,color: Colors.blue[600],decoration: TextDecoration.underline,), 
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 23),
                  alignment: Alignment.centerLeft,
                  child: Text(UseString.forpolicy,
                    style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*17,color: PickCarColor.colorcmu), 
                  ),
                ),
                alertpolicy(context),
                 Row(
                   children: <Widget>[
                     RaisedButton(
                      color: Colors.grey[600],
                      onPressed: (){
                          Navigator.pop(context);
                      },
                      child: Text(UseString.cancel,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*18,color: Colors.white), 
                        ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      width: 280,
                      child: RaisedButton(
                        color: PickCarColor.colormain,
                        onPressed: (){
                          if(Checkpolicy.checkpolicy == true){
                            _ackAlert(context);
                          }else{
                            setState(() {
                              widget.alertpolicy = true;
                            });
                          }
                          // Navigator.of(context).pushNamed(Datamanager.detailsearch);
                        },
                        child: Text(UseString.confirm,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: data.textScaleFactor*18,color: Colors.white), 
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
    );
  }
}



// Text("Slotpage"),
            // RaisedButton(
            //   onPressed: (){
            //     booking(context);
            //     if(Datamanager.listcarslot.timeslotlist.length ==0){
            //       Navigator.pop(context);
            //       Navigator.pop(context);
            //       Navigator.pop(context);
            //     }else{
            //       Navigator.pop(context);
            //       Navigator.pop(context);
            //     }
            //     // Navigator.of(context).pushNamed(Datamanager.detailsearch);
            //   },
            //   child: Text("Confirm"),
            // ),