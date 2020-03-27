import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Booking {
  String times;
  int day;
  int month;
  int year;
  double price;
  String motorcycledocid;
  String ownerid;
  String myid;
  String bookingdocid;
  String boxdocid;
  String university;
  String boxplacedocid;
  String boxslotrentdocid;
  String motorplacelocdocid;
  String status;
  double priceaddtax;
  DateTime startdate;
  DateTime enddate;
  bool isinhistory;
  bool iscancle;
  bool ownercanclealert;
  bool rentercanclealert;
  String docid;
  String type;

 
  Booking({
    @required this.times,
    @required this.day,
    @required this.month,
    @required this.year,
    @required this.price,
    @required this.motorcycledocid,
    @required this.ownerid,
    this.myid,
    @required this.bookingdocid,
    @required this.boxdocid,
    @required this.boxplacedocid,
    @required this.boxslotrentdocid,
    @required this.motorplacelocdocid,
    @required this.university,
    @required this.status,
    this.priceaddtax,
    @required this.startdate,
    this.isinhistory,
    @required this.iscancle,
    @required this.ownercanclealert,
    @required this.rentercanclealert,
    @required this.enddate,
    @required this.type,
    this.docid,
  }) {}

   Map<String , Object> toJson(){
    return {
      'motorcycledocid' : this.motorcycledocid,
      'bookingdocid' : this.bookingdocid,
      'price' : this.price,
      'ownerdocid' : this.ownerid,
      'myid' : this.myid,
      'day' : this.day,
      'month' : this.month,
      'year' : this.year,
      'time' : this.times,
      'boxdocid' : this.boxdocid,
      'boxplacedocid' : this.boxplacedocid,
      'boxslotrentdocid' : this.boxslotrentdocid,
      'motorplacelocdocid' : this.motorplacelocdocid,
      'university' : this.university,
      'status' : this.status,
      'priceaddtax' : this.priceaddtax,
      'startdate' : this.startdate,
      'isinhistory' : this.isinhistory,
      'iscancle' : this.iscancle,
      'ownercanclealert' : this.ownercanclealert,
      'rentercanclealert' : this.rentercanclealert,
      'alreadycheck' : null,
      'enddate' : this.enddate,
      'docid' : this.docid,
      'type' : this.type,
    };
  }
}
class Bookingshow {
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
  bool iscancle;
  bool ownercanclealert;
  bool rentercanclealert;
  DateTime startdate;
  DateTime enddate;
  String type;
  final DocumentReference reference;

  Bookingshow.fromMap(Map<String, dynamic> map, {this.reference})
    //  : assert(map['time'] != null),
    //    assert(map['day'] != null),
    //    assert(map['month'] != null),
    //    assert(map['year'] != null),
    //    assert(map['price'] != null),
    //    assert(map['motorcycledocid'] != null),
    //    assert(map['ownerid'] != null),
    //    assert(map['myid'] != null),
    //    assert(map['bookingdocid'] != null),
    //    assert(map['boxdocid'] != null),
    //    assert(map['boxplacedocid'] != null),
    //    assert(map['boxslotrentdocid'] != null),
    //    assert(map['motorplacelocdocid'] != null),
    //    assert(map['university'] != null),
    //   //  assert(map['priceaddtax'] != null),
    //    assert(map['startdate'] != null),
       : startdate = (map['startdate'] as Timestamp).toDate(),
       time = map['time'],
       priceaddtax = map['priceaddtax'],
       day = map['day'],
       month = map['month'],
       year = map['year'],
       price = map['price'],
       motorcycledocid = map['motorcycledocid'],
       ownerid = map['ownerdocid'],
       myid = map['myid'],
       bookingdocid = map['bookingdocid'],
       boxdocid = map['boxdocid'],
       boxplacedocid = map['boxplacedocid'],
       boxslotrentdocid = map['boxslotrentdocid'],
       university = map['university'],
       status = map['status'],
       motorplacelocdocid = map['motorplacelocdocid'],
       iscancle = map['iscancle'],
       type = map['type'],
       ownercanclealert = map['ownercanclealert'],
       enddate = (map['enddate']as Timestamp).toDate(),
       rentercanclealert = map['rentercanclealert'];

  Bookingshow.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);
}