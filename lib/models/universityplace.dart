import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Universityplaceshow {
  double latitude;
  double longitude;
  String universityname;
  String docid;
  var listplacebox;
  var listplacelocation;
  final DocumentReference reference;

  Universityplaceshow.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['latitude'] != null),
       assert(map['longitude'] != null),
       assert(map['Universityname'] != null),
      //  assert(map['docid'] != null),
      //  assert(map['listplace'] != null),
       latitude = map['latitude'],
       longitude = map['longitude'],
       universityname = map['Universityname'],
       listplacebox = map['listplacebox'],
       listplacelocation = map['listplacelocation'],
       docid = map['docid'];

  Universityplaceshow.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);
  
}
