import 'package:flutter/cupertino.dart';

class MotorcycleBook {
  String bookingdocid;
  String motorcycledocid;
  String motorforrentdocid;
  String myid;
  String ownerid;
  String time;
  int day;
  int month;
  int year;
  double price;

  MotorcycleBook(
      {@required this.year,
      @required this.month,
      @required this.day,
      @required this.price,
      @required this.motorforrentdocid,
      @required this.motorcycledocid,
      @required this.time,
      @required this.bookingdocid,
      @required this.myid,
      @required this.ownerid});

  Map<String, dynamic> toJson() {
    return {
      'bookingdocid': this.bookingdocid,
      'motorcycledocid': this.motorcycledocid,
      'motorforrentdocid': this.motorforrentdocid,
      'myid': this.myid,
      'ownerid': this.ownerid,
      'time': this.time,
      'day': this.day,
      'month': this.month,
      'year': this.year,
      'price': this.price,
    };
  }
}
