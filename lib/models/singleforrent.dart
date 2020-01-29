

import 'package:flutter/cupertino.dart';

class SingleForrent{
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

  SingleForrent({
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
    @required this.startdate
    
  });

  Map<String , dynamic> toJson(){
    return {
      'day' : this.day ,
      'month' : this.month ,
      'year' : this.year ,
      'time' : this.time ,
      'motorcycledocid' : this.motorcycledocid ,
      'price' : this.price ,
      'ownerdocid' : this.ownerdocid ,
      'university' : this.university,
      'boxplacedocid' : this.boxplacedocid ,
      'boxdocid' : this.boxdocid ,
      'boxslotrentdocid' : this.boxslotrentdocid,
      'docid' : this.docid,
      'motorplacelocdocid' : this.motorplacelocdocid,
      'startdate' : this.startdate
      
    };
  }

}