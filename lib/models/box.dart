import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Box {
  double latitude;
  double longitude;
  String boxlocationid;
  String docboxid;
  int maxslot;

  Box({
    @required this.latitude,
    @required this.longitude,
    @required this.boxlocationid,
    @required this.maxslot,
  }) {}

   Map<String , Object> toJson(){
    return {
      'latitude' : this.latitude,
      'longitude' : this.longitude,
      'boxlocationid' : this.boxlocationid,
      'docid' : this.docboxid,
      'maxslot' : this.maxslot,
    };
  }
}

class BoxShow {
  double latitude;
  double longitude;
  String boxlocationid;
  String docboxid;
  int maxslot;
  final DocumentReference reference;

  BoxShow.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['latitude'] != null),
       assert(map['longitude'] != null),
       assert(map['boxlocationid'] != null),
       assert(map['docboxid'] != null),
       assert(map['maxslot'] != null),
       latitude = map['latitude'],
       longitude = map['longitude'],
       docboxid = map['docboxid'],
       maxslot = map['maxslot'],
       boxlocationid = map['boxlocationid'];

  BoxShow.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);
  
}
