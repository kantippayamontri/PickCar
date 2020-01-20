import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Boxslot {
  bool isopen;
  bool iskey;
  int slotnumber;
  String rentorbook;
  String docslot;

  Boxslot({
    @required this.isopen,
    @required this.rentorbook,
    @required this.slotnumber,
    @required this.iskey,
  }) {}

   Map<String , Object> toJson(){
    return {
      'isopen' : this.isopen,
      'rentorbook' : this.rentorbook,
      'slotnumber' : this.slotnumber,
      'docslot' : this.docslot,
      'iskey' : this.iskey,
    };
  }
}

