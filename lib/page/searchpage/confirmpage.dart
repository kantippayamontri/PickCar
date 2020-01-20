import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/booking.dart';

class ConfirmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(Datamanager.listcarslot.motorforrentdocid);
    booking(BuildContext context) async {
      // print(Datamanager.listcarslot.timeslotlist);
      print(Datamanager.slottime.timeslot);
      List<String> slotw = Datamanager.listcarslot.timeslotlist;
      print(slotw);
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
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Slotpage"),
            RaisedButton(
              onPressed: (){
                booking(context);
                if(Datamanager.listcarslot.timeslotlist.length ==0){
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                }else{
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
                // Navigator.of(context).pushNamed(Datamanager.detailsearch);
              },
              child: Text("Confirm"),
            ),
          ],
        ),
      ),
    );
  }
}