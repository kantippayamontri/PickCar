import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:path/src/context.dart';
import 'package:pickcar/bloc/profile/newpassword/newpasswordevent.dart';
import 'package:pickcar/bloc/profile/newpassword/newpasswordstate.dart';
import 'package:pickcar/datamanager.dart';

class Newpasswordbloc extends Bloc<NewpasswordEvent, NewpasswordState> {
  Context context;
  var formkey = GlobalKey<FormState>();
  var newpassword = TextEditingController();
  var repeatpassword = TextEditingController();
  Newpasswordbloc(this.context);

  @override
  NewpasswordState get initialState => StartState();

  @override
  Stream<NewpasswordState> mapEventToState(NewpasswordEvent event) async* {

  }


  void matchpassword() async {
    print("ssssssss");
    print(Datamanager.user.password);
    await Datamanager.firebaseauth.signInWithEmailAndPassword(
            email: Datamanager.user.email, password: Datamanager.user.password);

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    //Pass in the password to updatePassword.
    user.updatePassword(newpassword.text).then((_){
      print("Succesfull changed password");
    }).catchError((error){
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
    var ref = await Datamanager.firestore
            .collection('User')
            .document(Datamanager.user.documentid);
    if(newpassword.text.isNotEmpty){
      Datamanager.user.password = newpassword.text;
      await ref.updateData({'password': newpassword.text});
      print("update password success");
    }
  }
}