import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/bloc/motorwaitinglist/motorwaitinglistevent.dart';
import 'package:pickcar/bloc/motorwaitinglist/motorwaitingliststate.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:pickcar/models/motorcycletimeslot.dart';
import 'package:pickcar/models/singleforrent.dart';
import 'package:pickcar/widget/motorwaitingitem/motorwaitingedit.dart';

import '../../datamanager.dart';

class MotorWaitingListBloc
    extends Bloc<MotorWaitingListEvent, MotorWaitingListState> {
  BuildContext context;
  Motorcycle motorcycle;
  Function setstate;
  //List<MotorcycleTimeSlot> motorcycletimeslotlist;
  List<SingleForrent> singleforrentlist;

  MotorWaitingListBloc(
      {@required this.context,
      @required this.motorcycle,
      @required this.setstate}) {
    //motorcycletimeslotlist = List<MotorcycleTimeSlot>();
    singleforrentlist = List<SingleForrent>();
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
      //await loaddata();
      await loadalldata();
      yield MotorWaitingShowDataState();
    }
  }

  Future<Null> loadalldata() async {
    QuerySnapshot querySnapshot = await Datamanager.firestore
        .collection("Singleforrent")
        //.where('motorcycledocid' , isEqualTo: this.motorcycle.firestoredocid)
        .orderBy('startdate')
        .getDocuments();
    var singlelist = querySnapshot.documents.where((doc) =>
        doc['ownerdocid'] ==
        Datamanager.user
            .documentid); //querySnapshot.documents.where((doc) => doc['motorcycledocid'] == this.motorcycle);
    print("in load all data function " + singlelist.length.toString());
    print("motor docid :" + this.motorcycle.firestoredocid);
    for (var doc in singlelist) {
      print(doc['day'].toString() + " " + doc['time']);

      SingleForrent sgfr = SingleForrent(
          boxdocid: doc['boxdocid'],
          boxplacedocid: doc['boxplacedocid'],
          boxslotdocid: doc['boxslotdocid'],
          day: doc['day'],
          month: doc['month'],
          motorcycledocid: doc['motorcycledocid'],
          motorplacelocdocid: doc['motorplacelocdocid'],
          ownerdocid: doc['ownerdocid'],
          price: doc['price'],
          startdate: (doc['startdate'] as Timestamp).toDate(),
          time: doc['time'],
          university: doc['university'],
          year: doc['year'],
          status: doc['status'],
          iscancle: doc['iscancle'],
          ownercanclealert: doc['ownercanclealert'],
          rentercanclealert: doc['rentercanclealert'],
          enddate: doc['enddate']);

      sgfr.boxslotrentdocid = doc['boxslotrentdocid'];
      sgfr.docid = doc['docid'];

      if (sgfr.startdate.isAfter(DateTime.now())) {
        print("in add singleforrentlist naja");
        print("startdate : " + sgfr.startdate.toString());
        print("Time now : " + DateTime.now().toString());
        this.singleforrentlist.add(sgfr);
      }
    }
  }

  void showbottomsheet(SingleForrent singleForrent, Function editslot) {
    print("in showbottomsheet function ");
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return MotorWaitingEdit(
            editslot: editslot,
            singleforrent: singleForrent,
          );
        });
  }

  Future<Null> editslot(String docid, String pricestring) async {
    if (pricestring == "") {
      Navigator.pop(context);
    } else {
      print("HAVE CONDITION");
      final double value = double.parse(pricestring);
      await Datamanager.firestore
          .collection("Singleforrent")
          .document(docid)
          .updateData({'price': value});

      for (int i = 0; i < singleforrentlist.length; i++) {
        if (singleforrentlist[i].docid == docid) {
          singleforrentlist[i].price = value;
          setstate();
          Navigator.pop(context);
          return;
        }
      }

      /*final double value = double.parse(pricestring);
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
      }*/
    }
  }

  /*Future<Null> deleteslot(MotorcycleTimeSlot motorslot) async {
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
  }*/

  /*Future<Null> loaddata() async {
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
          docid: doc['docid'],
          boxslotrentdocid: doc['boxslotrentdocid'],
          keyboxplacelocdocid: doc['keyboxplacelocdocid'],
          motorplacelocdocid: doc['motorplacelocdocid'],
          );
 
      motorcycletimeslotlist.add(motorcycleTimeSlot);
    }
 
  }*/
}
