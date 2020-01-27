import 'package:cloud_firestore/cloud_firestore.dart';
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
  String university;
  String docid;

  String motorplacelocdocid;
  String keyboxplacelocdocid;
  String boxslotrentdocid;
  
 
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
    @required this.university,
    @required this.docid,
    @required this.motorplacelocdocid,
    @required this.keyboxplacelocdocid,
    @required this.boxslotrentdocid,
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
      'ownerdocid' : this.ownerdocid,
      'university' : this.university,
      'docid' : this.docid,
      'motorplacelocdocid' : this.motorplacelocdocid,
      'keyboxplacelocdocid' : this.keyboxplacelocdocid,
      'boxslotrentdocid' : this.boxslotrentdocid,
    };
  }
}
