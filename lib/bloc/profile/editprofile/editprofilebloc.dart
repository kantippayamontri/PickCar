import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mime_type/mime_type.dart';

import 'package:path/src/context.dart';
import 'package:pickcar/datamanager.dart';

import 'editprofileevent.dart';
import 'editprofilestate.dart';



class EditProfilebloc extends Bloc<EditProfileEvent, EditProfileState> {
  Context context;
  var formkey = GlobalKey<FormState>();
  var namecontroller = TextEditingController();
  var telcontroller = TextEditingController();
  String university;
  String faculty;
  EditProfilebloc(this.context);

  @override
  EditProfileState get initialState => StartState();

  @override
  Stream<EditProfileState> mapEventToState(EditProfileEvent event) async* {
    if (event is ChangeProfileImage) {
      print("change profile images event naja");
      uploadPic(event.context,"profile","profilepictype",event.changeimg);
    }

    if (event is ChangeIDCardImage) {
      print("change id card images event naja");
      uploadPic(event.context,"idcard","idcardpictype",event.changeimg);
    }

    if (event is ChangeUniversityCardImage) {
      print("change university id card images event naja");
      uploadPic(event.context,"universitycard","universitycardtype",event.changeimg);
    }

    if (event is ChangeDriMotor) {
      print("change driver motorcycle card images event naja");
      uploadPic(event.context,"drimotorcard","driveliscensemotorpictype",event.changeimg);
    }

    // if (event is ChangeDriCar) {
    //   print("change driver car card images event naja");
    //   uploadPic(event.context,"profile","idcardpictype",event.changeimg);
    // }
  }
  Future uploadPic(BuildContext context,String name,String type,File _image) async{
    String contenttype;
    String ext;
    StorageReference ref =
        Datamanager.firebasestorage.ref().child("User").child(Datamanager.user.uid);
    StorageUploadTask uploadtask;
    contenttype = mime(_image.path);
    ext = contenttype.split('/').last;
    uploadtask = ref
        .child(name+".${ext}")
        .putFile(_image, StorageMetadata(contentType: contenttype));
    await uploadtask.onComplete;
    Uint8List image = _image.readAsBytesSync();
    if (uploadtask.isComplete) {
      print("upload profile success");
      if(name == "profile"){
        ImageProfiles.profileUrl = image;
      }else if(name == "idcard"){
        ImageProfiles.idcard = image;
      }else if(name == "universitycard"){
        ImageProfiles.universitycard = image;
      }else if(name == "drimotorcard"){
        ImageProfiles.drimotorcard = image;
      }
      Datamanager.user.profileimgtype = ext;
      await Datamanager.firestore
            .collection('User')
            .document(Datamanager.user.documentid)
            .updateData({type: ext});
    } 
  }
}