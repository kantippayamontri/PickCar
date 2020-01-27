import 'package:flutter/cupertino.dart';
import 'package:pickcar/datamanager.dart';

class MotorForRent {
  String status; //
  DateTime dateTime; //
  int day;
  int month;
  int year;
  List<String> timeslotlist; //
  String motorcycledocid; //
  double price; //
  String motorforrentdocid;
  String ownerdocid;
  String university;
  String boxplacedocid;
  String boxdocid;
  

  MotorForRent({
    @required this.status,
    @required this.price,
    @required this.dateTime,
    @required this.motorcycledocid,
    @required this.timeslotlist,
    @required this.ownerdocid,
    @required this.university,
    @required this.boxplacedocid,
    @required this.boxdocid,
    
  }) {
    this.day = dateTime.day;
    this.month = dateTime.month;
    this.year = dateTime.year;
    this.motorforrentdocid = null;

    /*switch (this.timeslot) {
      case TimeSlot.sub1:
        {
          starttime =
              DateTime(dateTime.year, dateTime.month, dateTime.day, 8, 0);
          endtime =
              DateTime(dateTime.year, dateTime.month, dateTime.day, 9, 30);
        }
        break;

      case TimeSlot.sub2:
        {
          starttime =
              DateTime(dateTime.year, dateTime.month, dateTime.day, 9, 30);
          endtime =
              DateTime(dateTime.year, dateTime.month, dateTime.day, 11, 0);
        }
        break;

      case TimeSlot.sub3:
        {
          starttime =
              DateTime(dateTime.year, dateTime.month, dateTime.day, 11, 0);
          endtime =
              DateTime(dateTime.year, dateTime.month, dateTime.day, 12, 30);
        }
        break;

      case TimeSlot.sub4:
        {
          starttime =
              DateTime(dateTime.year, dateTime.month, dateTime.day, 13, 0);
          endtime =
              DateTime(dateTime.year, dateTime.month, dateTime.day, 14, 30);
        }
        break;

      case TimeSlot.sub5:
        {
          starttime =
              DateTime(dateTime.year, dateTime.month, dateTime.day, 14, 30);
          endtime =
              DateTime(dateTime.year, dateTime.month, dateTime.day, 16, 0);
        }
        break;

      case TimeSlot.sub6:
        {
          starttime =
              DateTime(dateTime.year, dateTime.month, dateTime.day, 16, 0);
          endtime =
              DateTime(dateTime.year, dateTime.month, dateTime.day, 17, 30);
        }
        break;
    }*/
  }

  Map<String , Object> toJson(){
    return {
      'motorforrentdocid' : this.motorforrentdocid,
      'status' : this.status,
      'price' : this.price,
      'dateTime' : this.dateTime,
      'day' : this.day,
      'month' : this.month,
      'year' : this.year,
      'timeslotlist' : this.timeslotlist.toList(),
      'motorcycledocid' : this.motorcycledocid,
      'ownerdocid' : this.ownerdocid,
      'university' : this.university,
      'boxplacedocid' : this.boxplacedocid,
      'boxdocid' : this.boxdocid
    };
  }
}
