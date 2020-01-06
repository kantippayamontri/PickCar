import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:path/src/context.dart';
import 'package:pickcar/bloc/profile/changpassword/changpasswordevent.dart';
import 'package:pickcar/bloc/profile/changpassword/changpasswordstate.dart';
import 'package:pickcar/datamanager.dart';

class Changpasswordbloc extends Bloc<ChangpasswordEvent, ChangpasswordState> {
  Context context;
  var formkey = GlobalKey<FormState>();
  var currentpass = TextEditingController();
  Changpasswordbloc(this.context);

  @override
  ChangpasswordState get initialState => StartState();

  @override
  Stream<ChangpasswordState> mapEventToState(ChangpasswordEvent event) async* {

  }
  void matchpassword(BuildContext context) async {
    Firestore.instance
              .collection("User")
              .where("documentid", isEqualTo: Datamanager.user.documentid)
              .snapshots()
              .listen((data) => data.documents.forEach((doc) async {
                print(doc['password']);
                print(currentpass.text);
                    if(doc['password'] == currentpass.text){
                      Navigator.of(context).pushNamed(Datamanager.newpassword);
                    }
                  }
                )
              );
  }
}