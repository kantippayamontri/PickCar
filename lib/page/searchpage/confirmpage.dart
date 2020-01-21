import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/booking.dart';

class ConfirmPage extends StatelessWidget {
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
  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);
    print(Datamanager.listcarslot.motorforrentdocid);
    booking(BuildContext context) async {
      // print(Datamanager.listcarslot.timeslotlist);
      // print(Datamanager.slottime.timeslot);
      List<String> slotw = Datamanager.listcarslot.timeslotlist;
      // print(slotw);
      int indexs = Datamanager.listcarslot.timeslotlist.indexOf(Datamanager.slottime.timeslot);
      if(indexs != -1){
        slotw.removeAt(indexs);
      }
      Datamanager.listcarslot.timeslotlist = slotw;
      List<String> slot = [];
      slot.add(Datamanager.slottime.timeslot);
      Booking booking = Booking(
        tiems: Datamanager.slottime.timeslot,
        day: Datamanager.slottime.day,
        month: Datamanager.slottime.month,
        price: Datamanager.slottime.price,
        year: Datamanager.slottime.year,
        motorcycledocid: Datamanager.slottime.motorcycledocid,
        motorforrentdocid: Datamanager.slottime.motorforrentdocid,
        ownerid: Datamanager.slottime.ownerdocid,
        myid: Datamanager.user.documentid,
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
      Datamanager.firestore.collection("Motorcycleforrent")
                            .document(Datamanager.listcarslot.motorforrentdocid)
                            .updateData({"timeslotlist": FieldValue.arrayRemove(slot)});
      if(Datamanager.listcarslot.timeslotlist.length ==0){
        Datamanager.firestore.collection("Motorcycleforrent")
                            .document(Datamanager.listcarslot.motorforrentdocid)
                            .delete();
        Datamanager.firestore.collection("Motorcycle")
                            .document(Datamanager.listcarslot.motorcycledocid)
                            .updateData({"iswaiting": false});
      }
      Datamanager.firestore.collection('MotorcycleforrentSlot').document(Datamanager.slottime.docid).delete();
    }
    var time = Datamanager.slottime.timeslot.split('-');
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
                    child: Text(UseString.getkey,
                        style: TextStyle(fontWeight: FontWeight.normal,fontSize: data.textScaleFactor*22,color: PickCarColor.colorcmu), 
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
          ],
        ),
      ),
    );
  }
}



// Text("Slotpage"),
//             RaisedButton(
//               onPressed: (){
//                 booking(context);
//                 if(Datamanager.listcarslot.timeslotlist.length ==0){
//                   Navigator.pop(context);
//                   Navigator.pop(context);
//                   Navigator.pop(context);
//                 }else{
//                   Navigator.pop(context);
//                   Navigator.pop(context);
//                 }
//                 // Navigator.of(context).pushNamed(Datamanager.detailsearch);
//               },
//               child: Text("Confirm"),
//             ),