import 'package:flutter/cupertino.dart';
import 'package:pickcar/models/motorcycle.dart';

class MotorcycleTimeSlot {
  String timeslot;
  DateTime dateTime;
  int day;
  int month;
  int year;
  double prize;
  String motorcycledocid;
  String motorforrentdocid;
  String ownerdocid;

  MotorcycleTimeSlot({
    @required this.timeslot,
    @required this.dateTime,
    @required this.day,
    @required this.month,
    @required this.year,
    @required this.prize,
    @required this.motorcycledocid,
    @required this.motorforrentdocid,
    @required this.ownerdocid,
  }) {}

  Map<String , dynamic> toJson(){
    return {
      'timeslot' : this.timeslot,
      'dateTime' : this.dateTime,
      'day' : this.day,
      'month' : this.month,
      'year' : this.year,
      'prize' : this.prize,
      'motorcycledocid' : this.motorcycledocid,
      'motorforrentdocid' : this.motorforrentdocid,
      'ownerdocid' : this.ownerdocid
    };
  }
}
