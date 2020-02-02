import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


class Boxslotnumbershow {
  String boxid;
  String docid;
  int name;
  final DocumentReference reference;

  Boxslotnumbershow.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['boxid'] != null),
       assert(map['docid'] != null),
       assert(map['name'] != null),
       boxid = map['boxid'],
       docid = map['docid'],
       name = map['name'];

  Boxslotnumbershow.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);
}