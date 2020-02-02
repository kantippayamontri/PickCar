
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Boxslotrentshow {
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
  final DocumentReference reference;

Boxslotrentshow.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['time'] != null),
       assert(map['day'] != null),
       assert(map['month'] != null),
       assert(map['year'] != null),
       assert(map['docid'] != null),
       assert(map['boxslotdocid'] != null),
       assert(map['ownerdocid'] != null),
      //  assert(map['renterdocid'] != null),
       assert(map['iskey'] != null),
       assert(map['boxdocid'] != null),
       assert(map['boxplacedocid'] != null),
       assert(map['isopen'] != null),
       assert(map['ownerdropkey'] != null),
       time = map['time'],
       day = map['day'],
       month = map['month'],
       year = map['year'],
       docid = map['docid'],
       boxslotdocid = map['boxslotdocid'],
       ownerdocid = map['ownerdocid'],
       renterdocid = map['renterdocid'],
       iskey = map['iskey'],
       boxdocid = map['boxdocid'],
       boxplacedocid = map['boxplacedocid'],
       isopen = map['isopen'],
       ownerdropkey = map['ownerdropkey'];

  Boxslotrentshow.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

  
}
