import 'package:flutter/cupertino.dart';

class DoubleForrent {
  String docid;
  int day;
  int month;
  int year;
  String time;
  String motorcycledocid;
  double price;
  String ownerdocid;
  String university;
  String boxplacedocid;
  String boxdocid;
  String boxslotdocid;
  String boxslotrentdocid;
  String motorplacelocdocid;
  DateTime startdate;
  DateTime enddate;
  String status;
  bool iscancle;
  bool ownercanclealert;
  bool rentercanclealert;

  DoubleForrent({
    @required this.boxdocid,
    @required this.boxplacedocid,
    @required this.motorcycledocid,
    @required this.ownerdocid,
    @required this.price,
    @required this.time,
    @required this.day,
    @required this.month,
    @required this.university,
    @required this.year,
    @required this.boxslotdocid,
    @required this.motorplacelocdocid,
    @required this.startdate,
    @required this.status,
    @required this.iscancle,
    @required this.ownercanclealert,
    @required this.rentercanclealert,
  }) {
    this.enddate = this.startdate.add(Duration(hours: 2, minutes: 45));
  }

  Map<String, dynamic> toJson() {
    return {
      'day': this.day,
      'month': this.month,
      'year': this.year,
      'time': this.time,
      'motorcycledocid': this.motorcycledocid,
      'price': this.price,
      'ownerdocid': this.ownerdocid,
      'university': this.university,
      'boxplacedocid': this.boxplacedocid,
      'boxdocid': this.boxdocid,
      'boxslotrentdocid': this.boxslotrentdocid,
      'docid': this.docid,
      'motorplacelocdocid': this.motorplacelocdocid,
      'startdate': this.startdate,
      'status': this.status,
      'iscancle': this.iscancle,
      'ownercanclealert': this.ownercanclealert,
      'rentercanclealert': this.rentercanclealert,
      'enddate': this.enddate
    };
  }
}
