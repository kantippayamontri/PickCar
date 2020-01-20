import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Box {
  double latitude;
  double longitude;
  int maxslot;
  String placename;
  String docboxid;

  Box({
    @required this.latitude,
    @required this.longitude,
    @required this.maxslot,
    @required this.placename,
  }) {}

   Map<String , Object> toJson(){
    return {
      'latitude' : this.latitude,
      'longitude' : this.longitude,
      'maxslot' : this.maxslot,
      'placename' : this.placename,
      'docboxid' : this.docboxid,
    };
  }
}

class BoxShow {
  double latitude;
  double longitude;
  int maxslot;
  String placename;
  String docboxid;
  final DocumentReference reference;

  BoxShow.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['latitude'] != null),
       assert(map['longitude'] != null),
       assert(map['maxslot'] != null),
       assert(map['placename'] != null),
       assert(map['docboxid'] != null),
       latitude = map['latitude'],
       longitude = map['longitude'],
       maxslot = map['maxslot'],
       placename = map['placename'],
       docboxid = map['docboxid'];

  BoxShow.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);
  
}
