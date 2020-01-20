import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Pincar {
  double latitude;
  double longitude;
  String ownerid;
  String docpinid;
  String rentorbookid;

  Pincar({
    @required this.latitude,
    @required this.longitude,
    @required this.ownerid,
    @required this.rentorbookid,
  }) {}

  Map<String , Object> toJson(){
    return {
      'latitude' : this.latitude,
      'longitude' : this.longitude,
      'ownerid' : this.ownerid,
      'rentorbookid' : this.rentorbookid,
      'docboxid' : this.docpinid,
    };
  }
}

class PincarShow {
  double latitude;
  double longitude;
  String ownerid;
  String docpinid;
  String rentorbookid;
  final DocumentReference reference;

  PincarShow.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['latitude'] != null),
       assert(map['longitude'] != null),
       assert(map['rentorbookid'] != null),
       assert(map['ownerid'] != null),
       assert(map['docpinid'] != null),
       latitude = map['latitude'],
       longitude = map['longitude'],
       rentorbookid = map['rentorbookid'],
       ownerid = map['ownerid'],
       docpinid = map['docpinid'];

  PincarShow.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);
  
}
