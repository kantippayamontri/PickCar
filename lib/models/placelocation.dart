import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Placelocation {
  double latitude;
  double longitude;
  String name;
  String docplaceid;
  String universityname;

  Placelocation({
    @required this.latitude,
    @required this.longitude,
    @required this.name,
    @required this.universityname,
  }) {}

   Map<String , Object> toJson(){
    return {
      'latitude' : this.latitude,
      'longitude' : this.longitude,
      'name' : this.name,
      'docplaceid' : this.docplaceid,
      'Universityname' : this.universityname,
    };
  }
}

class PlacelocationShow {
  double latitude;
  double longitude;
  String name;
  String docplaceid;
  String universityname;
  final DocumentReference reference;

  PlacelocationShow.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['latitude'] != null),
       assert(map['longitude'] != null),
       assert(map['name'] != null),
       assert(map['docplaceid'] != null),
       assert(map['Universityname'] != null),
       latitude = map['latitude'],
       longitude = map['longitude'],
       name = map['name'],
       universityname = map['universityname'],
       docplaceid = map['docplaceid'];

  PlacelocationShow.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);
  
}
