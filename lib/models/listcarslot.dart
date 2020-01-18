import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../datamanager.dart';

class Listcarslot {
  List<String> timeslotlist;
  DateTime dateTime;
  int day;
  int month;
  int year;
  double price;
  String motorcycledocid;
  String ownerdocid;
  String motorforrentdocid;
  String university;
  final DocumentReference reference;

  Listcarslot.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['timeslotlist'] != null),
       assert(map['dateTime'] != null),
       assert(map['day'] != null),
       assert(map['month'] != null),
       assert(map['year'] != null),
       assert(map['price'] != null),
       assert(map['motorcycledocid'] != null),
       assert(map['ownerdocid'] != null),
       assert(map['motorforrentdocid'] != null),
       assert(map['university'] != null),
       timeslotlist = List.from(map['timeslotlist']),
       dateTime = (map['dateTime'] as Timestamp).toDate(),
       day = map['day'],
       month = map['month'],
       year = map['year'],
       price = map['price'].toDouble(),
       motorcycledocid = map['motorcycledocid'],
       ownerdocid = map['ownerdocid'],
       university = map['university'],
       
       motorforrentdocid = map['motorforrentdocid'];

  Listcarslot.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);
}

class MotorcycleShow{

  String brand;
  String generation;
  int cc;
  String gear;
  String color;
  String storagedocid;
  String firestoredocid;
  String owneruid;
  String motorprofilelink;
  String motorownerliscenselink;
  String motorfrontlink;
  String motorbacklink;
  String motorleftlink;
  String motorrightlink;
  String carstatus;
  bool isbook;
  bool iswaiting;
  bool isworking;
  final DocumentReference reference;

  
   MotorcycleShow.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['brand'] != null),
       assert(map['generation'] != null),
       assert(map['cc'] != null),
       assert(map['gear'] != null),
       assert(map['color'] != null),
       assert(map['storagedocid'] != null),
       assert(map['firestoredocid'] != null),
       assert(map['owneruid'] != null),
       assert(map['motorprofilelink'] != null),
       assert(map['motorownerliscenselink'] != null),
       assert(map['motorfrontlink'] != null),
       assert(map['motorbacklink'] != null),
       assert(map['motorleftlink'] != null),
       assert(map['motorrightlink'] != null),
       assert(map['carstatus'] != null),
       assert(map['isbook'] != null),
       assert(map['iswaiting'] != null),
       assert(map['isworking'] != null),
       brand = map['brand'],
       generation = map['generation'],
       cc = map['cc'],
       gear = map['gear'],
       color = map['color'],
       storagedocid = map['storagedocid'],
       firestoredocid = map['firestoredocid'],
       owneruid = map['owneruid'],
       motorprofilelink = map['motorprofilelink'],
       motorownerliscenselink = map['motorownerliscenselink'],
       motorfrontlink = map['motorfrontlink'],
       motorbacklink = map['motorbacklink'],
       motorleftlink = map['motorleftlink'],
       motorrightlink = map['motorrightlink'],
       carstatus = map['carstatus'],
       isbook = map['isbook'],
       iswaiting = map['iswaiting'],
       isworking = map['isworking'];

  MotorcycleShow.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);
  
}

class Usershow{

  String name;
  String uid;
  String profilepicpath;
  String profilepictype;
  String documentid;
  String documentchat;
  var imageurl;
  final DocumentReference reference;

  
   Usershow.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['name'] != null),
       assert(map['uid'] != null),
       assert(map['profilepicpath'] != null),
       assert(map['profilepictype'] != null),
       assert(map['documentid'] != null),
       assert(map['documentchat'] != null),
       name = map['name'],
       uid = map['uid'],
       profilepicpath = map['profilepicpath'],
       profilepictype = map['profilepictype'],
       documentid = map['documentid'],
       documentchat = map['documentchat'];
      

  Usershow.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);
  
}
class Slottime{

  int day;
  int month;
  double price;
  String timeslot;
  String university;
  int year;
  String motorcycledocid;
  String motorforrentdocid;
  String ownerdocid;
  String docid;
  final DocumentReference reference;

  
   Slottime.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['day'] != null),
       assert(map['month'] != null),
       assert(map['prize'] != null),
       assert(map['timeslot'] != null),
       assert(map['university'] != null),
       assert(map['year'] != null),
       assert(map['motorcycledocid'] != null),
       assert(map['motorforrentdocid'] != null),
       assert(map['ownerdocid'] != null),
       assert(map['docid'] != null),
       day = map['day'],
       month = map['month'],
       price = map['prize'].toDouble(),
       timeslot = map['timeslot'],
       university = map['university'],
       motorcycledocid = map['motorcycledocid'],
       motorforrentdocid = map['motorforrentdocid'],
       ownerdocid = map['ownerdocid'],
       docid = map['docid'],
       year = map['year'];

  Slottime.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);
  
}

