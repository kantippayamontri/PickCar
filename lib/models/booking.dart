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

 
  Booking({
    @required this.times,
    @required this.day,
    @required this.month,
    @required this.year,
    @required this.price,
    @required this.motorcycledocid,
    @required this.ownerid,
    @required this.myid,
    @required this.bookingdocid,
    @required this.boxdocid,
    @required this.boxplacedocid,
    @required this.boxslotrentdocid,
    @required this.motorplacelocdocid,
    @required this.university,
    @required this.status,
    @required this.priceaddtax,
    @required this.startdate,
  }) {}

   Map<String , Object> toJson(){
    return {
      'motorcycledocid' : this.motorcycledocid,
      'bookingdocid' : this.bookingdocid,
      'price' : this.price,
      'ownerid' : this.ownerid,
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
  DateTime startdate;
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
       ownerid = map['ownerid'],
       myid = map['myid'],
       bookingdocid = map['bookingdocid'],
       boxdocid = map['boxdocid'],
       boxplacedocid = map['boxplacedocid'],
       boxslotrentdocid = map['boxslotrentdocid'],
       university = map['university'],
       status = map['status'],
       motorplacelocdocid = map['motorplacelocdocid'];

  Bookingshow.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);
}