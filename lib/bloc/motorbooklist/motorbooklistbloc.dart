import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:pickcar/bloc/motorbooklist/motorbooklistevent.dart';
import 'package:pickcar/bloc/motorbooklist/motorbookliststate.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:pickcar/models/motorcyclebook.dart';

class MotorBookListBloc extends Bloc<MotorBookListEvent, MotorBookListState> {
  Motorcycle motorcycle;
  List<MotorcycleBook> motorcyclebooklist;
  MotorBookListBloc({@required this.motorcycle}) {
    motorcyclebooklist = List<MotorcycleBook>();
  }

  @override
  // TODO: implement initialState
  MotorBookListState get initialState => MotorBookListStartState();

  @override
  Stream<MotorBookListState> mapEventToState(MotorBookListEvent event) async* {
    // TODO: implement mapEventToState

    if (event is MotorBookListLoadDataEvent) {
      yield MotorBookListStartState();
      print("in MotorBookListLoadDataEvent");
      await loaddata();
      yield MotorBookLisShowDatatState(motorbooklist: this.motorcyclebooklist);
    }
  }

  Future<Null> loaddata() async {
    QuerySnapshot queysnapshot =
        await Datamanager.firestore.collection("Booking").getDocuments();
    var list = queysnapshot.documents;
    list = list
        .where(
            (doc) => (doc['motorcycledocid'] == this.motorcycle.firestoredocid))
        .toList();

    for (var doc in list) {
      MotorcycleBook motorbook = MotorcycleBook(
        bookingdocid: doc['bookingdocid'],
        day: doc['day'],
        month: doc['month'],
        motorcycledocid: doc['motorcycledocid'],
        motorforrentdocid: doc['motorforrentdocid'],
        myid: doc['myid'],
        ownerid: doc['ownerid'],
        price: doc['price'],
        time: doc['time'],
        year: doc['year'],
      );
      

      DocumentSnapshot ownerdoc = await Datamanager.firestore.collection("User").document(doc['myid']).get();
      //motorbook.rentername = ownerdoc['name'];
      String renterprofilepaht = ownerdoc['profilepicpath'].toString();
      String renterprofiletype = ownerdoc['profilepictype'].toString();
      //motorbook.renterprofilelink = await FirebaseStorage.instance.ref().child("").getDownloadURL();
      motorcyclebooklist.add(motorbook);
    }
  }
}
