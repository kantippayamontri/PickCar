import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class History {
  String times;
  double price;
  String motorcycledocid;
  String university;
  String boxname;
  String plancename;
  double priceaddtax;
  DateTime startdate;
  String ownername;
  String brand;
  String generation;
  String imagelink;
  bool iscancel;
  bool ishistory = false;

 
  History({
    @required this.times,
    @required this.price,
    @required this.motorcycledocid,
    // @required this.boxname,
    // @required this.plancename,
    @required this.university,
    @required this.priceaddtax,
    @required this.startdate,
    @required this.ownername,
    @required this.brand,
    @required this.generation,
    @required this.imagelink,
    @required this.iscancel,
    @required this.ishistory,
  }) {}

   Map<String , Object> toJson(){
    return {
      'motorcycledocid' : this.motorcycledocid,
      'price' : this.price,
      'time' : this.times,
      // 'boxplacedocid' : this.boxname,
      // 'boxslotrentdocid' : this.plancename,
      'university' : this.university,
      'priceaddtax' : this.priceaddtax,
      'startdate' : this.startdate,
      'ownername' : this.ownername,
      'brand' : this.brand,
      'generation' : this.generation,
      'imagelink' : this.imagelink,
      'iscancel' : this.iscancel,
      'ishistory' : false,
    };
  }
}
class HistoryShow {
  String time;
  int day;
  int month;
  int year;
  double price;
  double priceaddtax;
  String motorcycledocid;
  String ownerid;
  String myid;
  String bookingdocid;
  String boxdocid;
  String boxplacedocid;
  String boxslotrentdocid;
  String motorplacelocdocid;
  String university;
  String status;
  bool iscancle;
  bool ownercanclealert;
  bool rentercanclealert;
  DateTime startdate;
  final DocumentReference reference;

  HistoryShow.fromMap(Map<String, dynamic> map, {this.reference})
    //  : assert(map['time'] != null),
    //    assert(map['day'] != null),
    //    assert(map['month'] != null),
    //    assert(map['year'] != null),
    //    assert(map['price'] != null),
    //    assert(map['motorcycledocid'] != null),
    //    assert(map['ownerid'] != null),
    //    assert(map['myid'] != null),
    //    assert(map['bookingdocid'] != null),
    //    assert(map['boxdocid'] != null),
    //    assert(map['boxplacedocid'] != null),
    //    assert(map['boxslotrentdocid'] != null),
    //    assert(map['motorplacelocdocid'] != null),
    //    assert(map['university'] != null),
    //   //  assert(map['priceaddtax'] != null),
    //    assert(map['startdate'] != null),
       : startdate = (map['startdate'] as Timestamp).toDate(),
       time = map['time'],
       priceaddtax = map['priceaddtax'],
       day = map['day'],
       month = map['month'],
       year = map['year'],
       price = map['price'],
       motorcycledocid = map['motorcycledocid'],
       ownerid = map['ownerid'],
       myid = map['myid'],
       bookingdocid = map['bookingdocid'],
       boxdocid = map['boxdocid'],
       boxplacedocid = map['boxplacedocid'],
       boxslotrentdocid = map['boxslotrentdocid'],
       university = map['university'],
       status = map['status'],
       motorplacelocdocid = map['motorplacelocdocid'],
       iscancle = map['iscancle'],
       ownercanclealert = map['ownercanclealert'],
       rentercanclealert = map['rentercanclealert'];

  HistoryShow.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);
}