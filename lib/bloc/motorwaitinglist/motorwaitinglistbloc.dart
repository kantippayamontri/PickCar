import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pickcar/bloc/motorwaitinglist/motorwaitinglistevent.dart';
import 'package:pickcar/bloc/motorwaitinglist/motorwaitingliststate.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:pickcar/models/motorcycletimeslot.dart';

import '../../datamanager.dart';

class MotorWaitingListBloc
    extends Bloc<MotorWaitingListEvent, MotorWaitingListState> {
  BuildContext context;
  Motorcycle motorcycle;
  List<MotorcycleTimeSlot> motorcycletimeslotlist;
  MotorWaitingListBloc({@required this.context, @required this.motorcycle}) {
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

  Future<Null> loaddata() async {
    QuerySnapshot querySnapshot = await Datamanager.firestore
        .collection("Motorcycleforrent")
        .orderBy('dateTime')
        .getDocuments();
    var list = querySnapshot.documents;
    list = list
        .where((motorforrent) =>
            motorforrent['motorcycledocid'] == motorcycle.firestoredocid)
        .toList();

    for (var doc in list) {
      List<String> slotlist = List<String>();
      slotlist = List.from(doc['timeslotlist']);
      for (var timeslot in slotlist) {
        MotorcycleTimeSlot motorcycleTimeSlot = MotorcycleTimeSlot(
            dateTime: (doc['dateTime'] as Timestamp).toDate(),
            day: doc['day'],
            month: doc['month'],
            year: doc['year'],
            motorcycledocid: doc['motorcycledocid'],
            motorforrentdocid: doc['motorforrentdocid'],
            prize: doc['prize'],
            tiemslot: timeslot);

        motorcycletimeslotlist.add(motorcycleTimeSlot);
      }
    }

    

  }
}
