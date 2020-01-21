import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Boxlocation {
  double latitude;
  double longitude;
  String name;
  String docboxid;

  Boxlocation({
    @required this.latitude,
    @required this.longitude,
    @required this.name,
  }) {}

   Map<String , Object> toJson(){
    return {
      'latitude' : this.latitude,
      'longitude' : this.longitude,
      'name' : this.name,
      'docboxid' : this.docboxid,
    };
  }
}

class BoxlocationShow {
  double latitude;
  double longitude;
  int maxslot;
  String name;
  String docboxid;
  final DocumentReference reference;

  BoxlocationShow.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['latitude'] != null),
       assert(map['longitude'] != null),
       assert(map['name'] != null),
       assert(map['docboxid'] != null),
       latitude = map['latitude'],
       longitude = map['longitude'],
       name = map['name'],
       docboxid = map['docboxid'];

  BoxlocationShow.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);
  
}
