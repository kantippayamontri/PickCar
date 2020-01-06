import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:path/src/context.dart';
import 'package:pickcar/bloc/profile/editdetail/editdetailstate.dart';
import 'package:pickcar/datamanager.dart';


import 'editdetailevent.dart';

class Editdetailbloc extends Bloc<EditdetailEvent, EditdetailState> {
  Context context;
  var formkey = GlobalKey<FormState>();
  var namecontroller = TextEditingController();
  var telcontroller = TextEditingController();
  String university;
  String faculty;

  Editdetailbloc(this.context);

  @override
  EditdetailState get initialState => StartState();

  @override
  Stream<EditdetailState> mapEventToState(EditdetailEvent event) async* {

  }


  void edtidetail() async {
    var ref = await Datamanager.firestore
            .collection('User')
            .document(Datamanager.user.documentid);
    if(namecontroller.text.isNotEmpty){
      await ref.updateData({'name': namecontroller.text});
    }
    if(university.isNotEmpty){
    await ref.updateData({'university': university});
    }
    if(faculty.isNotEmpty){
    await ref.updateData({'faculty': faculty});
    }
    if(telcontroller.text.isNotEmpty){
    await ref.updateData({'telepphonenumnber': telcontroller.text});
    print('edit success');
    }
  }
}