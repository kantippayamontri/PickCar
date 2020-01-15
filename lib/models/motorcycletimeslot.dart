import 'package:flutter/cupertino.dart';

class MotorcycleTimeSlot {
  String tiemslot;
  DateTime dateTime;
  int day;
  int month;
  int year;
  double prize;
  String motorcycledocid;
  String motorforrentdocid;

  MotorcycleTimeSlot({
    @required this.tiemslot,
    @required this.dateTime,
    @required this.day,
    @required this.month,
    @required this.year,
    @required this.prize,
    @required this.motorcycledocid,
    @required this.motorforrentdocid,
  }) {}
}
