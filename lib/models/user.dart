
import 'dart:io';

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
      'money' : 500
    };
  }
}