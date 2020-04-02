import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Coupon {
  int percent;
  DateTime startdate;
  DateTime expireddate;
  String code;
  String coupondocid;
  bool use;

 
  Coupon({
    @required this.percent,
    @required this.startdate,
    @required this.expireddate,
    @required this.code,
    @required this.coupondocid,
    @required this.use,
  }) {}

   Map<String , Object> toJson(){
    return {
      'percent' : this.percent,
      'startdate' : this.startdate,
      'expireddate' : this.expireddate,
      'code' : this.code,
      'coupondocid' : this.coupondocid,
      'use' : this.use,
    };
  }
}
class Couponshow {
  int percent;
  DateTime startdate;
  DateTime expireddate;
  String code;
  String coupondocid;
  bool use;
  final DocumentReference reference;

  Couponshow.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['percent'] != null),
       assert(map['startdate'] != null),
       assert(map['expireddate'] != null),
       assert(map['code'] != null),
       assert(map['coupondocid'] != null),
       assert(map['use'] != null),
       startdate = (map['startdate'] as Timestamp).toDate(),
       expireddate = (map['expireddate']as Timestamp).toDate(),
       code = map['code'],
       percent = map['percent'],
       coupondocid = map['coupondocid'],
       use = map['use'];

  Couponshow.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);
}