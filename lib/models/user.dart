
import 'dart:io';
// import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class User{
  String uid;
  String email;
  String password;
  String name;
  String university;
  String faculty;
  String tel;
  String address;
  bool confirm;
  File profileimg;
  File idcardimg;
  File universityimg;
  File drivemotorimg;
  File drivecarimg;
  String profileimgtype;
  String idcardimgtype;
  String universityimgtype;
  String drivemotorimgtype;
  String drivecarimgtype; 
  double money;
  String documentid;
  String documentchat;

  User({
  @required this.uid,  
  @required this.email , 
  @required this.password , 
  @required this.name , 
  @required this.university , 
  @required this.faculty , 
  @required this.tel , 
  @required this.address,
  @required this.profileimg,
  @required this.idcardimg,
  @required this.universityimg,
  @required this.drivemotorimg,
  @required this.drivecarimg,
  @required this.profileimgtype,
  @required this.idcardimgtype,
  @required this.universityimgtype,
  @required this.drivemotorimgtype,
  @required this.drivecarimgtype,
  @required this.money,
  @required this.documentchat,
  });

  Map<String , dynamic> toJson(){
    return {
      'uid' : uid,
      'email' : email,
      'password' : password,
      'address' : address,
      'telepphonenumnber' : tel,
      'driveliscensemotorpath' : 'drimotorcard',
      'driveliscensemotorpictype' : drivemotorimgtype,
      'driveliscensecarpath' : 'dricarcard',
      'driveliscensecarpictype' : drivecarimgtype,
      'idcardpath' : 'idcard',
      'idcardpictype' : idcardimgtype,
      'universitycadrpath' : 'universitycard',
      'universitycardtype' : universityimgtype,
      'university' : university,
      'faculty' : faculty,
      'name' : name,
      'profilepicpath' : 'profile',
      'profilepictype' : profileimgtype,
      'money' : money,
      'documentid' : documentid
    };
  }
}
// class Usershow{
//   String uid;
//   String email;
//   String password;
//   String name;
//   String university;
//   String faculty;
//   String tel;
//   String address;
//   bool confirm;
//   File profileimg;
//   File idcardimg;
//   File universityimg;
//   File drivemotorimg;
//   File drivecarimg;
//   String profileimgtype;
//   String idcardimgtype;
//   String universityimgtype;
//   String drivemotorimgtype;
//   String drivecarimgtype; 
//   double money;
//   String documentid;
//   String documentchat;
//   final DocumentReference reference;

//   Usershow.fromMap(Map<String, dynamic> map, {this.reference})
//      : assert(map['uid'] != null),
//        assert(map['email'] != null),
//        assert(map['password'] != null),
//        assert(map['name'] != null),
//        assert(map['university'] != null),
//        assert(map['faculty'] != null),
//        assert(map['tel'] != null),
//        assert(map['address'] != null),
//        assert(map['confirm'] != null),
//        assert(map['profileimg'] != null),
//        assert(map['idcardimg'] != null),
//        assert(map['universityimg'] != null),
//        assert(map['drivemotorimg'] != null),
//        assert(map['drivecarimg'] != null),
//       //  assert(map['priceaddtax'] != null),
//        assert(map['idcardimgtype'] != null),
//        assert(map['universityimgtype'] != null),
//        assert(map['drivemotorimgtype'] != null),
//        assert(map['drivecarimgtype'] != null),
//        assert(map['money'] != null),
//        assert(map['documentid'] != null),
//        assert(map['documentchat'] != null),
//        uid = map['uid'],
//        email = map['email'],
//        password = map['password'],
//        name = map['name'],
//        university = map['university'],
//        faculty = map['faculty'],
//        tel = map['tel'],
//        address = map['address'],
//        confirm = map['confirm'],
//        profileimg = map['profileimg'],
//        idcardimg = map['idcardimg'],
//        universityimg = map['universityimg'],
//        drivemotorimg = map['drivemotorimg'],
//        drivecarimg = map['drivecarimg'],
//        profileimgtype = map['profileimgtype'],
//        idcardimgtype = map['idcardimgtype'],
//        universityimgtype = map['universityimgtype'],
//        drivemotorimgtype = map['drivemotorimgtype'],
//        drivecarimgtype = map['drivecarimgtype'],
//        documentid = map['documentid'],
//        documentchat = map['documentchat'],
//        money = map['money'];

//   Usershow.fromSnapshot(DocumentSnapshot snapshot)
//      : this.fromMap(snapshot.data, reference: snapshot.reference);
// }