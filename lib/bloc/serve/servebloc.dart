import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:pickcar/bloc/serve/serveevent.dart';
import 'package:pickcar/bloc/serve/servestate.dart';
import 'package:pickcar/datamanager.dart';

class ServeBloc extends Bloc<ServeEvent, ServeState> {
  BuildContext context;
  int count = 0;

  ServeBloc({@required this.context});

  @override
  // TODO: implement initialState
  ServeState get initialState => ServeStartState();

  @override
  Stream<ServeState> mapEventToState(ServeEvent event) {}

  Future<Null> looptime() async {
    Timer.periodic(Duration(seconds: 5), (timer) async {
      print("count : ${count++}");
      //todo init var

      //todo -----------
      DateTime timenow = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, DateTime.now().hour, DateTime.now().minute);
      // DateTime timenow = DateTime(DateTime.now().year, DateTime.now().month,
      //     DateTime.now().day, 8, 15);
      bool istimeinslot = checkintimeslot(timenow);
      await checkownerdontdropkey(timenow);
      await checkownerdontreceivekey(timenow);
      await checkrenterdontdropkey(timenow);
    });

    print("xxxxxxxxxxxxxxxxxxxxxxxxxx");
  }

  Future<Null> checkrenterdontdropkey(DateTime dateTime) async {}

  Future<Null> checkownerdontreceivekey(DateTime dateTime) async {
    var bookingDoc = await Datamanager.firestore
        .collection("Booking")
        .where('status', isEqualTo: 'end')
        .where('iscancle', isEqualTo: false)
        .getDocuments();
    List<DocumentSnapshot> bookinglist = bookingDoc.documents;
    if(bookinglist.isEmpty){
      //print()
    }
  }

  Future<Null> checkownerdontdropkey(DateTime dateTime) async {
    var singleforrentDoc = await Datamanager.firestore
        .collection("Singleforrent")
        .where('iscancle', isEqualTo: false)
        .getDocuments();
    List<DocumentSnapshot> singleforrentlist = singleforrentDoc.documents;
    //todo  check in singleforrent
    if (singleforrentlist.isEmpty) {
      //print("list is empty");
    }
    for (DocumentSnapshot singleforrent in singleforrentlist) {
      //print("Single Forrent");
      // print(
      //     "${singleforrent['docid']} ${(singleforrent['startdate'] as Timestamp).toDate()}");
      if ((singleforrent['startdate'] as Timestamp)
          .toDate()
          .isBefore(dateTime)) {
        //print("should delete");

        await Datamanager.firestore
            .collection('Singleforrent')
            .document(singleforrent['docid'])
            .updateData({
          'iscancle': true,
          'rentercanclealert': true,
        }).whenComplete(() {
          //print("update success");
        });
      } else {
        //print("should not delete");
      }
    }

    //todo check in Booking
    var bookingDoc = await Datamanager.firestore
        .collection("Booking")
        .where('status', isEqualTo: 'booking')
        .where('iscancle', isEqualTo: false)
        .getDocuments();
    List<DocumentSnapshot> bookinglist = bookingDoc.documents;
    //print("list booking length : ${bookinglist.length}");
    for (DocumentSnapshot booking in bookinglist) {
      //check ownerdropkey in boxslotrent
      var boxslotrentDoc = await Datamanager.firestore
          .collection("BoxslotRent")
          .document(booking['boxslotrentdocid'])
          .get();
      //print("boxslotrentdocid : ${boxslotrentDoc['docid']}");
      //print("ownerdropkey : ${boxslotrentDoc['ownerdropkey']}");
      if (((booking['startdate'] as Timestamp).toDate().isBefore(dateTime)) &&
          (boxslotrentDoc['ownerdropkey'] == false)) {
        await Datamanager.firestore
            .collection("Booking")
            .document(booking['bookingdocid'])
            .updateData({
          'iscancle': true,
        }).whenComplete(() {
          print("cancle ${booking['bookingdocid']} complete");
        });
      }
    }
  }

  bool checkintimeslot(DateTime dateTime) {
    print(
        "checkintimeslot : ${dateTime.year} ${dateTime.month} ${dateTime.day} ${dateTime.hour} ${dateTime.minute} ");
    DateTime timenow = DateTime.now();
    if (dateTime.isAfter(
            DateTime(timenow.year, timenow.month, timenow.day, 8, 0)) &&
        dateTime.isBefore(
            DateTime(timenow.year, timenow.month, timenow.day, 9, 15))) {
      print("this time is in timeslot");
      return true;
    }

    if (dateTime.isAfter(
            DateTime(timenow.year, timenow.month, timenow.day, 9, 30)) &&
        dateTime.isBefore(
            DateTime(timenow.year, timenow.month, timenow.day, 10, 45))) {
      print("this time is in timeslot");
      return true;
    }

    if (dateTime.isAfter(
            DateTime(timenow.year, timenow.month, timenow.day, 11, 00)) &&
        dateTime.isBefore(
            DateTime(timenow.year, timenow.month, timenow.day, 12, 15))) {
      print("this time is in timeslot");
      return true;
    }

    if (dateTime.isAfter(
            DateTime(timenow.year, timenow.month, timenow.day, 13, 0)) &&
        dateTime.isBefore(
            DateTime(timenow.year, timenow.month, timenow.day, 14, 15))) {
      print("this time is in timeslot");
      return true;
    }

    if (dateTime.isAfter(
            DateTime(timenow.year, timenow.month, timenow.day, 14, 30)) &&
        dateTime.isBefore(
            DateTime(timenow.year, timenow.month, timenow.day, 15, 45))) {
      print("this time is in timeslot");
      return true;
    }

    if (dateTime.isAfter(
            DateTime(timenow.year, timenow.month, timenow.day, 16, 00)) &&
        dateTime.isBefore(
            DateTime(timenow.year, timenow.month, timenow.day, 17, 30))) {
      print("this time is in timeslot");
      return true;
    }

    print("this time is not in timeslot");
    return false;
  }
}
