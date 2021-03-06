import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../datamanager.dart';

class Listcarslot {
  String time;
  DateTime startdate;
  DateTime enddate;
  int day;
  int month;
  int year;
  double price;
  String motorcycledocid;
  String ownerdocid;
  String docid;
  String university;
  String boxdocid;
  String boxplacedocid;
  String boxslotrentdocid;
  String motorplacelocdocid;
  bool iscancle;
  bool ownercanclealert;
  bool rentercanclealert;
  final DocumentReference reference;

  Listcarslot.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['time'] != null),
       assert(map['startdate'] != null),
       assert(map['day'] != null),
       assert(map['month'] != null),
       assert(map['year'] != null),
       assert(map['price'] != null),
       assert(map['motorcycledocid'] != null),
       assert(map['ownerdocid'] != null),
       assert(map['docid'] != null),
       assert(map['university'] != null),
       assert(map['boxdocid'] != null),
       assert(map['boxplacedocid'] != null),
       assert(map['boxslotrentdocid'] != null),
       assert(map['motorplacelocdocid'] != null),
       assert(map['iscancle'] != null),
       assert(map['ownercanclealert'] != null),
       assert(map['rentercanclealert'] != null),
       assert(map['enddate'] != null),
       enddate = (map['enddate'] as Timestamp).toDate(),
       iscancle = map['iscancle'],
       ownercanclealert = map['ownercanclealert'],
       rentercanclealert = map['rentercanclealert'],
       time = map['time'],
       startdate = (map['startdate'] as Timestamp).toDate(),
       day = map['day'],
       month = map['month'],
       year = map['year'],
       price = map['price'].toDouble(),
       motorcycledocid = map['motorcycledocid'],
       ownerdocid = map['ownerdocid'],
       university = map['university'],
       docid = map['docid'],
       boxdocid = map['boxdocid'],
       boxplacedocid = map['boxplacedocid'],
       motorplacelocdocid = map['motorplacelocdocid'],
       boxslotrentdocid = map['boxslotrentdocid'];

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
  String motorreg;
  String motorgas;
  bool isbook;
  bool iswaiting;
  bool isworking;
  double currentlatitude;
  double currentlongitude;
  String isapprove;
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
       assert(map['motorreg'] != null),
       assert(map['motorgas'] != null),
       assert(map['isapprove'] != null),
      //  assert(map['currentlatitude'] != null),
      //  assert(map['currentlongitude'] != null),
      isapprove = map['isapprove'],
       currentlatitude = map['currentlatitude'],
       currentlongitude = map['currentlongitude'],
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
       motorreg = map['motorreg'],
       motorgas = map['motorgas'],
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
  String email;
  String driveliscensecarpath;
  String driveliscensecarpictype;
  String isapprove;
  double money;
  var imageurl;
  final DocumentReference reference;

  
   Usershow.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['name'] != null),
       assert(map['uid'] != null),
       assert(map['email'] != null),
       assert(map['profilepicpath'] != null),
       assert(map['profilepictype'] != null),
       assert(map['documentid'] != null),
      //  assert(map['documentchat'] != null),
       assert(map['money'] != null),
      //  assert(map['driveliscensecarpath'] != null),
      //  assert(map['driveliscensecarpictype'] != null),
       driveliscensecarpath = map['driveliscensecarpath'],
       driveliscensecarpictype = map['driveliscensecarpictype'],
       email = map['email'],
       name = map['name'],
       uid = map['uid'],
       profilepicpath = map['profilepicpath'],
       profilepictype = map['profilepictype'],
       documentid = map['documentid'],
       money = map['money'].toDouble(),
       isapprove = map['isapprove'],
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

