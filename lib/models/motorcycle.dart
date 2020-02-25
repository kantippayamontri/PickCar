import 'package:flutter/foundation.dart';
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
  String firestoredocid=null;
  String owneruid;
  String motorprofilelink;
  String motorownerliscenselink;
  String motorfrontlink;
  String motorbacklink;
  String motorleftlink;
  String motorrightlink;
  String carstatus;
  bool isbook = false;
  bool iswaiting = false;
  bool isworking = false;
  double currentlongitude;
  double currentlatitude;
  String motorreg;
  String motorgas;
  String isapprove;


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
    @required this.storagedocid,
    @required this.motorprofilelink,
    @required this.motorownerliscenselink,
    @required this.motorfrontlink,
    @required this.motorbacklink,
    @required this.motorleftlink,
    @required this.motorrightlink,
    @required this.carstatus,
    @required this.currentlatitude,
    @required this.currentlongitude,

    @required this.isbook,
    @required this.iswaiting,
    @required this.isworking,
    @required this.motorreg,
    @required this.motorgas,
    @required this.isapprove
    
  });

  Map<String , dynamic> toJson(){
    return {
      'firestoredocid' : this.firestoredocid,
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
      'motorrighttype' : this.motorrighttype,
      'motorprofilelink' : this.motorprofilelink,
      'motorownerliscenselink' : this.motorownerliscenselink,
      'motorfrontlink' : this.motorfrontlink,
      'motorbacklink' : this.motorbacklink,
      'motorleftlink' : this.motorleftlink,
      'motorrightlink' : this.motorrightlink,
      'carstatus' : this.carstatus,
      'isbook' : this.isbook,
      'iswaiting' : this.iswaiting,
      'isworking' : this.isworking,
      'currentlatitude' : this.currentlatitude,
      'currentlongitude' : this.currentlongitude,
      'motorreg' : this.motorreg,
      'motorgas' : this.motorgas,
      'isapprove' : this.isapprove,
      
    };
  }
}