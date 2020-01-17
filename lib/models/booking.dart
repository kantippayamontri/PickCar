import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Booking {
  String tiems;
  int day;
  int month;
  int year;
  double price;
  String motorcycledocid;
  String motorforrentdocid;
  String ownerid;
  String myid;
  String bookingdocid;

 
  Booking({
    @required this.tiems,
    @required this.day,
    @required this.month,
    @required this.year,
    @required this.price,
    @required this.motorcycledocid,
    @required this.motorforrentdocid,
    @required this.ownerid,
    @required this.myid,
    @required this.bookingdocid,
  }) {}

   Map<String , Object> toJson(){
    return {
      'motorforrentdocid' : this.motorforrentdocid,
      'motorcycledocid' : this.motorcycledocid,
      'bookingdocid' : this.bookingdocid,
      'price' : this.price,
      'ownerid' : this.ownerid,
      'myid' : this.myid,
      'day' : this.day,
      'month' : this.month,
      'year' : this.year,
      'time' : this.tiems,
    };
  }
}
