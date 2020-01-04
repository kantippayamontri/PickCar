import 'package:flutter/cupertino.dart';

class Motorcycle{

  String profilepath;
  String ownerliscensepath;
  String motorfrontpath;
  String motorbackpath;
  String motorleftpath;
  String motorrightpath;
  String profiletype;
  String ownerliscensetype;
  String motorfronttype;
  String motorbacktype;
  String motorlefttype;
  String motorrighttype;
  String brand;
  String generation;
  int cc;
  String gear;
  String color;
  String storagedocid;
  String firestoredocid;
  String owneruid;

  Motorcycle({
    @required this.profilepath,
    @required this.profiletype,
    @required this.ownerliscensepath,
    @required this.ownerliscensetype,
    @required this.motorfrontpath,
    @required this.motorfronttype,
    @required this.motorbackpath,
    @required this.motorbacktype,
    @required this.motorleftpath,
    @required this.motorlefttype,
    @required this.motorrightpath,
    @required this.motorrighttype,
    @required this.brand,
    @required this.generation,
    @required this.cc,
    @required this.color,
    @required this.gear,
    @required this.owneruid,
    @required this.storagedocid
  });

  Map<String , dynamic> toJson(){
    return {
      'firestoredocid' : null,
      'storagedocid' : this.storagedocid,
      'owneruid' : this.owneruid,
      'gear' : this.gear,
      'color' : this.color,
      'cc' : this.cc,
      'generation' : this.generation,
      'brand' : this.brand,
      'profilepath' : this.profilepath,
      'profiletype' : this.profiletype,
      'ownerliscensepath' : this.ownerliscensepath,
      'ownerliscensetype' : this.ownerliscensetype,
      'motorfrontpath' : this.motorfrontpath,
      'motorfronttype' : this.motorfronttype,
      'motorbackpath' : this.motorbackpath,
      'motorbacktype' : this.motorbacktype,
      'motorleftpath' : this.motorleftpath,
      'motorlefttype' : this.motorlefttype,
      'motorrightpath' : this.motorrightpath,
      'motorrighttype' : this.motorrighttype
    };
  }
}