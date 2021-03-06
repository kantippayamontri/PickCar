import 'package:flutter/cupertino.dart';

class Boxslotrent {
  String type;
  String docid;
  String boxdocid;
  String boxslotdocid;
  String ownerdocid;
  String renterdocid;
  String boxplacedocid;
  int day;
  int month;
  int year;
  String time;
  bool iskey;
  bool isopen;
  bool ownerdropkey;
  DateTime startdate;
  DateTime enddate;
  String motorplaceloc;
  String motorcycledocid;

  Boxslotrent(
      {@required this.type,
      @required this.month,
      @required this.year,
      @required this.time,
      @required this.day,
      @required this.boxslotdocid,
      @required this.iskey,
      @required this.isopen,
      @required this.ownerdocid,
      @required this.renterdocid,
      @required this.boxdocid,
      @required this.boxplacedocid,
      @required this.ownerdropkey,
      @required this.startdate,
      @required this.enddate,
      @required this.motorplaceloc,
      @required this.motorcycledocid}) {}

  Map<String, dynamic> toJson() {
    return {
      'docid': docid,
      'month': month,
      'year': year,
      'time': time,
      'day': day,
      'boxslotdocid': boxslotdocid,
      'iskey': iskey,
      'isopen': isopen,
      'isopen': isopen,
      'renterdocid': renterdocid,
      'boxdocid': boxdocid,
      'ownerdocid': ownerdocid,
      'boxplacedocid': boxplacedocid,
      'ownerdropkey': ownerdropkey,
      'startdate': startdate,
      'motorplaceloc': motorplaceloc,
      'motorcycledocid': this.motorcycledocid,
      'type': this.type,
      'enddate': this.enddate,
    };
  }
}
