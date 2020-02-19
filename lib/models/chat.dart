import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Chatprofile {
  String name;
  DateTime arrivaltime;
  // String documentchatid;
  // String documentmessage;
  String documentcontact;

 
  Chatprofile({
    @required this.name,
    @required this.arrivaltime,
    // @required this.documentchatid,
    // @required this.documentmessage,
    @required this.documentcontact,
  }) {}

   Map<String , Object> toJson(){
    return {
      'name' : this.name,
      'arrivaltime' : this.arrivaltime,
      // 'documentchatid' : this.documentchatid,
      // 'documentmessage' : this.documentmessage,
      'documentcontact' : this.documentcontact,
    };
  }
}
class Chatprofileshow {
  String time;
  int day;
  int month;
  int year;
  double price;
  double priceaddtax;
  String motorcycledocid;
  String ownerid;
  String myid;
  String bookingdocid;
  String boxdocid;
  String boxplacedocid;
  String boxslotrentdocid;
  String motorplacelocdocid;
  String university;
  String status;
  DateTime startdate;
  final DocumentReference reference;

  Chatprofileshow.fromMap(Map<String, dynamic> map, {this.reference})
       : startdate = (map['startdate'] as Timestamp).toDate(),
       time = map['time'],
       priceaddtax = map['priceaddtax'],
       day = map['day'],
       month = map['month'],
       year = map['year'],
       price = map['price'],
       motorcycledocid = map['motorcycledocid'],
       ownerid = map['ownerid'],
       myid = map['myid'],
       bookingdocid = map['bookingdocid'],
       boxdocid = map['boxdocid'],
       boxplacedocid = map['boxplacedocid'],
       boxslotrentdocid = map['boxslotrentdocid'],
       university = map['university'],
       status = map['status'],
       motorplacelocdocid = map['motorplacelocdocid'];

  Chatprofileshow.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);
}