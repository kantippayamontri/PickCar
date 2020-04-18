import 'package:flutter/cupertino.dart';

class Forrent {
  String docid;
  String type;
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

  Forrent(
      {@required this.boxslotrentdocid,
      @required this.docid,
      @required this.boxdocid,
      @required this.boxplacedocid,
      @required this.boxslotdocid,
      @required this.day,
      @required this.enddate,
      @required this.iscancle,
      @required this.month,
      @required this.motorcycledocid,
      @required this.motorplacelocdocid,
      @required this.ownercanclealert,
      @required this.ownerdocid,
      @required this.price,
      @required this.rentercanclealert,
      @required this.startdate,
      @required this.status,
      @required this.time,
      @required this.university,
      @required this.year,
      @required this.type});
}
