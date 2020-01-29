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
  String boxplacedocid;
  String boxslotrentdocid;
  String motorplacelocdocid;

 
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
    };
  }
}
