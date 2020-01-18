import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/bloc/motorwaitinglist/motorwaitinglistevent.dart';
import 'package:pickcar/bloc/motorwaitinglist/motorwaitingliststate.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:pickcar/models/motorcycletimeslot.dart';
import 'package:pickcar/widget/motorwaitingitem/motorwaitingedit.dart';

import '../../datamanager.dart';

class MotorWaitingListBloc
    extends Bloc<MotorWaitingListEvent, MotorWaitingListState> {
  BuildContext context;
  Motorcycle motorcycle;
  Function setstate;
  List<MotorcycleTimeSlot> motorcycletimeslotlist;
  MotorWaitingListBloc(
      {@required this.context,
      @required this.motorcycle,
      @required this.setstate}) {
    motorcycletimeslotlist = List<MotorcycleTimeSlot>();
  }

  @override
  // TODO: implement initialState
  MotorWaitingListState get initialState => MotorWaitingListStartState();

  @override
  Stream<MotorWaitingListState> mapEventToState(
      MotorWaitingListEvent event) async* {
    // TODO: implement mapEventToState
    if (event is MotorWaitingListLoadDataEvent) {
      yield MotorWaitingLoadingState();
      await loaddata();
      yield MotorWaitingShowDataState();
    }
  }

  void showbottomsheet(MotorcycleTimeSlot motorslot){
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return MotorWaitingEdit(editslot: editslot,motorslot: motorslot,);
        });
  }

  Future<Null> editslot(String docid , String pricestring) async{
    if(pricestring == ""){
      Navigator.pop(context);
    }else{
      print("HAVE CONDITION");
      final double value = double.parse(pricestring);
      await Datamanager.firestore.collection("MotorcycleforrentSlot").document(docid).updateData(
        {
          'prize' : value
        }
      );
      for(int i=0 ; i<motorcycletimeslotlist.length ; i++){
        if(motorcycletimeslotlist[i].docid == docid){
          motorcycletimeslotlist[i].prize = value;
          setstate();
          Navigator.pop(context);
          return;
        }
      }
    }
  }

  Future<Null> deleteslot(MotorcycleTimeSlot motorslot) async {
    print("delete slot : " + motorslot.timeslot);
    print("delete docid : " + motorslot.docid);

    await Datamanager.firestore
        .collection("MotorcycleforrentSlot")
        .document(motorslot.docid)
        .delete(); //delete in motorslot

    var doc = await Datamanager.firestore
        .collection("Motorcycleforrent")
        .document(motorslot.motorforrentdocid)
        .get();
    print("motorforrentdocid : ${motorslot.motorforrentdocid}");
    List<dynamic> slot = List<String>.from(doc['timeslotlist']);
    if (slot.length == 1) {
      await Datamanager.firestore
          .collection("Motorcycleforrent")
          .document(motorslot.motorforrentdocid)
          .delete();
      await Datamanager.firestore
          .collection("Motorcycle")
          .document(motorcycle.firestoredocid)
          .updateData({'iswaiting': false});
      
      Navigator.pop(context , 'reset');
    } else {
      slot.remove(motorslot.timeslot);
      await Datamanager.firestore
          .collection("Motorcycleforrent")
          .document(motorslot.motorforrentdocid)
          .updateData({
        'timeslotlist': slot,
      });
    }

    print("before deletr : ${motorcycletimeslotlist.length}");
    motorcycletimeslotlist
        .removeWhere((slot) => motorslot.timeslot == slot.timeslot);
    print("after delete : ${motorcycletimeslotlist.length}");

    setstate();
  }

  

  Future<Null> loaddata() async {
    QuerySnapshot querySnapshot = await Datamanager.firestore
        .collection("MotorcycleforrentSlot")
        .orderBy('dateTime')
        .getDocuments();

    var list = querySnapshot.documents;
    list = list
        .where((motorforrentslot) =>
            (motorforrentslot['ownerdocid'] == Datamanager.user.documentid) &&
            (this.motorcycle.firestoredocid ==
                motorforrentslot['motorcycledocid']))
        .toList();

    for (var doc in list) {
      // print("//Timeslot//");
      // print(doc['timeslot']);
      MotorcycleTimeSlot motorcycleTimeSlot = MotorcycleTimeSlot(
          dateTime: (doc['dateTime'] as Timestamp).toDate(),
          day: doc['day'],
          month: doc['month'],
          year: doc['year'],
          motorcycledocid: doc['motorcycledocid'],
          motorforrentdocid: doc['motorforrentdocid'],
          ownerdocid: doc['ownerdocid'],
          prize: double.parse(doc['prize'].toString()),
          timeslot: doc['timeslot'],
          university: doc['university'],
          docid: doc['docid']);

      motorcycletimeslotlist.add(motorcycleTimeSlot);
    }

    // QuerySnapshot querySnapshot = await Datamanager.firestore
    //     .collection("Motorcycleforrent")
    //     .orderBy('dateTime')
    //     .getDocuments();
    // var list = querySnapshot.documents;
    // list = list
    //     .where((motorforrent) =>
    //         motorforrent['motorcycledocid'] == motorcycle.firestoredocid)
    //     .toList();

    // for (var doc in list) {
    //   List<String> slotlist = List<String>();
    //   slotlist = List.from(doc['timeslotlist']);
    //   for (var timeslot in slotlist) {
    //     MotorcycleTimeSlot motorcycleTimeSlot = MotorcycleTimeSlot(
    //         dateTime: (doc['dateTime'] as Timestamp).toDate(),
    //         day: doc['day'],
    //         month: doc['month'],
    //         year: doc['year'],
    //         motorcycledocid: doc['motorcycledocid'],
    //         motorforrentdocid: doc['motorforrentdocid'],
    //         prize:  double.parse(doc['price'].toString()) ,
    //         timeslot: timeslot);

    //         //print("Prize is ${doc['prize']}");
    //         //print("Timeslot is ${timeslot}");

    //     motorcycletimeslotlist.add(motorcycleTimeSlot);
    //   }
    // }
  }
}
