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
  String ownermotorcycle;
  String renterdocid;
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
    @required this.ownermotorcycle,
    @required this.renterdocid,
    // @required this.ishistory,
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
      'whocancel' : null,
      'ownermotorcycle':this.ownermotorcycle,
      'renterdocid':this.renterdocid,
    };
  }
}
class HistoryShow {
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
  String ownermotorcycle;
  String renterdocid;
  bool iscancel;
  bool ishistory;
  String whocancel;

  final DocumentReference reference;

  HistoryShow.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['time'] != null),
       assert(map['price'] != null),
       assert(map['motorcycledocid'] != null),
       assert(map['university'] != null),
      //  assert(map['boxname'] != null),
      //  assert(map['plancename'] != null),
       assert(map['ownername'] != null),
       assert(map['brand'] != null),
       assert(map['ownername'] != null),
       assert(map['generation'] != null),
       assert(map['imagelink'] != null),
       assert(map['ownermotorcycle'] != null),
       assert(map['renterdocid'] != null),
      //  assert(map['priceaddtax'] != null),
       assert(map['startdate'] != null),
       startdate = (map['startdate'] as Timestamp).toDate(),
       times = map['time'],
       priceaddtax = map['priceaddtax'],
       price = map['price'],
       motorcycledocid = map['motorcycledocid'],
       university = map['university'],
      //  boxname = map['boxname'],
      //  plancename = map['plancename'],
       ownername = map['ownername'],
       brand = map['brand'],
       generation = map['generation'],
       imagelink = map['imagelink'],
       ownermotorcycle = map['ownermotorcycle'],
       renterdocid = map['renterdocid'],
       iscancel = map['iscancel'],
       whocancel = map['whocancel'],
       ishistory = map['ishistory'];

  HistoryShow.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);
}