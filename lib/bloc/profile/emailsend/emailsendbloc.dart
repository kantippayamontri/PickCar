import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:path/src/context.dart';
import 'package:pickcar/bloc/profile/emailsend/emailsendevent.dart';
import 'package:pickcar/datamanager.dart';

import 'emailsendstate.dart';

class Emailsendbloc extends Bloc<EmailsendEvent, EmailsendState> {
  Context context;
  var formkey = GlobalKey<FormState>();
  var currentemail = TextEditingController();
  Emailsendbloc(this.context);

  @override
  EmailsendState get initialState => StartState();

  @override
  Stream<EmailsendState> mapEventToState(EmailsendEvent event) async* {

  }
  void matchemail(BuildContext context) async {
    // Firestore.instance
    //           .collection("User")
    //           .where("documentid", isEqualTo: Datamanager.user.documentid)
    //           .snapshots()
    //           .listen((data) => data.documents.forEach((doc) async {
    //             print(doc['password']);
    //             print(currentpass.text);
    //                 if(doc['password'] == currentpass.text){
    //                   Navigator.of(context).pushNamed(Datamanager.newpassword);
    //                 }
    //               }
    //             )
    //           );
  }
}