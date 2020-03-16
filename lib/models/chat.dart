import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Chatprofile {
  String name;
  DateTime arrivaltime;
  // String documentchatid;
  String documentmessage;
  String documentcontact;

 
  Chatprofile({
    @required this.name,
    @required this.arrivaltime,
    // @required this.documentchatid,
    this.documentmessage,
    @required this.documentcontact,
  }) {}

   Map<String , Object> toJson(){
    return {
      'name' : this.name,
      'arrivaltime' : this.arrivaltime,
      // 'documentchatid' : this.documentchatid,
      'documentmessage' : this.documentmessage,
      'documentcontact' : this.documentcontact,
    };
  }
}
class Message {
  String ownmessage;
  DateTime arrivaltime;
  // String documentchatid;
  String messagevalue;
  String image;

 
  Message({
    @required this.ownmessage,
    @required this.arrivaltime,
    // @required this.documentchatid,
    this.messagevalue,
    @required this.image,
  }) {}

   Map<String , Object> toJson(){
    return {
      'ownmessage' : this.ownmessage,
      'arrivaltime' : this.arrivaltime,
      // 'documentchatid' : this.documentchatid,
      'messagevalue' : this.messagevalue,
      'image' : this.image,
    };
  }
}
class Chatprofilehasmessage {
  String name;
  DateTime arrivaltime;
  // String documentchatid;
  String documentcontact;

 
  Chatprofilehasmessage({
    @required this.name,
    @required this.arrivaltime,
    // @required this.documentchatid,
    @required this.documentcontact,
  }) {}

   Map<String , Object> toJson(){
    return {
      'name' : this.name,
      'arrivaltime' : this.arrivaltime,
      // 'documentchatid' : this.documentchatid,
      'documentcontact' : this.documentcontact,
    };
  }
}
class Chatnoname {
  DateTime arrivaltime;
  // String documentchatid;
  String documentcontact;

 
  Chatnoname({
    @required this.arrivaltime,
    // @required this.documentchatid,
    @required this.documentcontact,
  }) {}

   Map<String , Object> toJson(){
    return {
      'arrivaltime' : this.arrivaltime,
      // 'documentchatid' : this.documentchatid,
      'documentcontact' : this.documentcontact,
    };
  }
}
class Chatprofileshow {
  String name;
  DateTime arrivaltime;
  // String documentchatid;
  String documentmessage;
  String documentcontact;
  final DocumentReference reference;

  Chatprofileshow.fromMap(Map<String, dynamic> map, {this.reference})
       : arrivaltime = (map['arrivaltime'] as Timestamp).toDate(),
       documentmessage = map['documentmessage'],
       documentcontact = map['documentcontact'],
       name = map['name'];

  Chatprofileshow.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);
}

class Messageshow {
  String ownmessage;
  DateTime arrivaltime;
  // String documentchatid;
  String messagevalue;
  String image;
  final DocumentReference reference;

  Messageshow.fromMap(Map<String, dynamic> map, {this.reference})
       : arrivaltime = (map['arrivaltime'] as Timestamp).toDate(),
       ownmessage = map['ownmessage'],
       messagevalue = map['messagevalue'],
       image = map['image'];

  Messageshow.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);
}