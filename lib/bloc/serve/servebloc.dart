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
      //DateTime timenow = DateTime(2020, 3, 25, 9, 31);
      bool istimeinslot = checkintimeslot(timenow);
      String timeslotin = timeslotmatch(timenow);
      await checkownerdontdropkey(timenow);
      print(
          "--------------------------------------------------------------------");
      await checkownerdontreceivekey(timenow, istimeinslot, timeslotin);
      print(
          "--------------------------------------------------------------------");
      await checkrenterdontdropkey(timenow, istimeinslot, timeslotin);
      print(
          "--------------------------------------------------------------------");
      await checkbookingandnotusing(timenow);
      print(
          "--------------------------------------------------------------------");
      await checkcanclesingleanddoublehavekey();
      //await deleteallcancle();
    });

    //print("xxxxxxxxxxxxxxxxxxxxxxxxxx");
  }

  Future<Null> checkcanclesingleanddoublehavekey() async {
    
  }

  Future<Null> deleteallcancle() async {
    //todo delete in singleforrent
    QuerySnapshot singledoc = await Datamanager.firestore
        .collection("Singleforrent")
        .where('iscancle', isEqualTo: true)
        .where('ownercanclealert', isEqualTo: true)
        .where('rentercanclealert', isEqualTo: true)
        .getDocuments();
    for (var singleforrent in singledoc.documents) {
      await Datamanager.firestore
          .collection("Singleforrent")
          .document(singleforrent['docid'])
          .delete();
    }
    print('delete all singleforrent success');

    QuerySnapshot bookingdoc = await Datamanager.firestore
        .collection("Booking")
        .where('iscancle', isEqualTo: true)
        .where('ownercanclealert', isEqualTo: true)
        .where('rentercanclealert', isEqualTo: true)
        .getDocuments();
    for (var booking in bookingdoc.documents) {
      await Datamanager.firestore
          .collection("Booking")
          .document(booking['bookingdocid'])
          .delete();
    }
    print('delete all booking success');
  }

  Future<Null> delete_boxslotrent_booking(String bookingdocid) async {
    DocumentSnapshot bookingdoc = await Datamanager.firestore
        .collection("Booking")
        .document(bookingdocid)
        .get();
    //todo delete in boxslotrent
    await Datamanager.firestore
        .collection("BoxslotRent")
        .document(bookingdoc['boxslotrentdocid'])
        .delete();
  }

  Future<Null> delete_boxslotrent_doubleforrent(
      String doubleforrentdocid) async {
    DocumentSnapshot doubleforrentdoc = await Datamanager.firestore
        .collection("Doubleforrent")
        .document(doubleforrentdocid)
        .get();

    //todo delete in boxslotrent
    DocumentSnapshot boxslotrentdoc = await Datamanager.firestore
        .collection("BoxslotRent")
        .document(doubleforrentdoc['boxslotrentdocid'])
        .get();
    if ((boxslotrentdoc['ownerdropkey'] == true) ||
        (boxslotrentdoc['iskey'] == true)) {
      return;
    }
    await Datamanager.firestore
        .collection("BoxslotRent")
        .document(doubleforrentdoc['boxslotrentdocid'])
        .delete();
  }

  Future<Null> delete_boxslotrent_singleforrent(
      String singleforrentdocid) async {
    DocumentSnapshot singleforrentdoc = await Datamanager.firestore
        .collection("Singleforrent")
        .document(singleforrentdocid)
        .get();
    //todo delete in boxslotrent
    DocumentSnapshot boxslotrentdoc = await Datamanager.firestore
        .collection("BoxslotRent")
        .document(singleforrentdoc['boxslotrentdocid'])
        .get();
    if ((boxslotrentdoc['ownerdropkey'] == true) ||
        (boxslotrentdoc['iskey'] == true)) {
      return;
    }
    await Datamanager.firestore
        .collection("BoxslotRent")
        .document(singleforrentdoc['boxslotrentdocid'])
        .delete();
  }

  Future<Null> checkbookingandnotusing(DateTime dateTime) async {
    var bookingdoc = await Datamanager.firestore
        .collection("Booking")
        .where('iscancle', isEqualTo: false)
        .where('status', isEqualTo: 'booking')
        .getDocuments();
    for (var booking in bookingdoc.documents) {
      var boxslotrentDoc = await Datamanager.firestore
          .collection("BoxslotRent")
          .document(booking['boxslotrentdocid'])
          .get();
      if (boxslotrentDoc['ownerdropkey'] == true &&
          (booking['enddate'] as Timestamp)
              .toDate()
              .isBefore(dateTime)) {
        await Datamanager.firestore
            .collection("Booking")
            .document(booking['bookingdocid'])
            .updateData({'status': 'end'});
      }
    }
  }

  Future<Null> checkrenterdontdropkey(
      DateTime dateTime, bool isintimeslot, String slotmatch) async {
    var bookingDoc = await Datamanager.firestore
        .collection("Booking")
        .where('status', isEqualTo: 'working')
        .where('iscancle', isEqualTo: false)
        .getDocuments();
    List<DocumentSnapshot> bookinglist = bookingDoc.documents;
    // if (bookinglist.isEmpty) {
    //   print("booklist empty");
    // } else {
    //   print("booklst not empty : ${bookinglist.length}");
    // }

    for (var booking in bookinglist) {
      if (dateTime.isAfter((booking['startdate'] as Timestamp).toDate()) &&
          dateTime.isBefore((booking['enddate'] as Timestamp)
              .toDate()
              )) {
        print("working in time");
        continue;
      } else {
        if (dateTime.isAfter((booking['enddate'] as Timestamp)
            .toDate()
            )) {
          print("working overtime");
          //todo cancle next slot
          var bookingslotrent = await Datamanager.firestore
              .collection("BoxslotRent")
              .document(booking['boxslotrentdocid'])
              .get();
          String bookingslotdocid =
              bookingslotrent['boxslotdocid']; //todo docid of boxslot
          print("bookingslotrentdocid : ${bookingslotdocid}");
          //todo check this boxslotrent book in this time
          QuerySnapshot boxslotrentDoc = await Datamanager.firestore
              .collection("BoxslotRent")
              .where('boxslotdocid', isEqualTo: bookingslotdocid)
              .getDocuments();
          List<DocumentSnapshot> boxslotrenttarget = boxslotrentDoc.documents;
          for (var boxslotrent in boxslotrenttarget) {
            if (boxslotrent['docid'] == bookingslotrent['docid']) {
              continue;
            }
            print("boxslotrenttarget");
            print("boxslotrentdocid : ${boxslotrent['docid']}");
            //todo check next slot
            if (dateTime.isAfter(
                    (boxslotrent['startdate'] as Timestamp).toDate()) &&
                dateTime.isBefore((boxslotrent['enddate'] as Timestamp)
                    .toDate()
                    )) {
              print("this boxslotrent is should cancle");
              //todo find booking from boxsltrent
              var canclebookDoc = await Datamanager.firestore
                  .collection("Booking")
                  .where('boxslotrentdocid', isEqualTo: boxslotrent['docid'])
                  .getDocuments();

              DocumentSnapshot canclebook = canclebookDoc.documents.first;
              print("bookingcancle docid : ${canclebook['bookingdocid']}");
              await Datamanager.firestore
                  .collection("Booking")
                  .document(canclebook['bookingdocid'])
                  .updateData({
                'iscancle': true,
              }).whenComplete(() {
                print("cancle ${canclebook['bookingdocid']} complete");
                delete_boxslotrent_booking(canclebook['bookingdocid']);
              });
              return;
            }
          }
        }
      }
    }
  }

  Future<Null> checkownerdontreceivekey(
      DateTime dateTime, bool isintimeslot, String slotmatch) async {
    // if (!isintimeslot) {
    //   print("return because not in slot");
    //   return;
    // }

    var bookingDoc = await Datamanager.firestore
        .collection("Booking")
        .where('status', isEqualTo: 'end')
        .where('iscancle', isEqualTo: false)
        .getDocuments();
    List<DocumentSnapshot> bookinglist = bookingDoc.documents;
    // if (bookinglist.isEmpty) {
    //   print("booklist empty");
    // } else {
    //   print("booklst not empty : ${bookinglist.length}");
    // }

    for (var booking in bookinglist) {
      print("${booking['bookingdocid']}");
      if (dateTime.isAfter((booking['startdate'] as Timestamp).toDate()) &&
          dateTime.isBefore((booking['enddate'] as Timestamp)
              .toDate()
              )) {
        print("end in time");
        continue;
      } else {
        print("end not in time");
        var bookingslotrent = await Datamanager.firestore
            .collection("BoxslotRent")
            .document(booking['boxslotrentdocid'])
            .get();
        String bookingslotdocid =
            bookingslotrent['boxslotdocid']; //todo docid of boxslot
        //print("bookingslotrentdocid : ${bookingslotrentdocid}");
        //todo check this boxslotrent book in this time
        QuerySnapshot boxslotrentDoc = await Datamanager.firestore
            .collection("BoxslotRent")
            .where('boxslotdocid', isEqualTo: bookingslotdocid)
            .getDocuments();
        List<DocumentSnapshot> boxslotrenttarget = boxslotrentDoc.documents;
        for (var boxslotrent in boxslotrenttarget) {
          if (boxslotrent['docid'] == bookingslotrent['docid']) {
            continue;
          }
          print("boxslotrenttarget");
          print("boxslotrentdocid : ${boxslotrent['docid']}");
          //todo check next slot
          if (dateTime
                  .isAfter((boxslotrent['startdate'] as Timestamp).toDate()) &&
              dateTime.isBefore((boxslotrent['enddate'] as Timestamp)
                  .toDate()
                  )) {
            print("this boxslotrent is should cancle");
            //todo find booking from boxsltrent
            var canclebookDoc = await Datamanager.firestore
                .collection("Booking")
                .where('boxslotrentdocid', isEqualTo: boxslotrent['docid'])
                .getDocuments();

            DocumentSnapshot canclebook = canclebookDoc.documents.first;
            print("bookingcancle docid : ${canclebook['bookingdocid']}");
            await Datamanager.firestore
                .collection("Booking")
                .document(canclebook['bookingdocid'])
                .updateData({
              'iscancle': true,
            }).whenComplete(() {
              print("cancle ${canclebook['bookingdocid']} complete");
              delete_boxslotrent_booking(canclebook['bookingdocid']);
            });
            return;
          }
        }
      }
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
        print("singleforrent docid : ${singleforrent['docid']}");
        await Datamanager.firestore
            .collection('Singleforrent')
            .document(singleforrent['docid'])
            .updateData({
          'iscancle': true,
          'rentercanclealert': true,
        }).whenComplete(() async {
          //print("update success");
          await delete_boxslotrent_singleforrent(singleforrent['docid']);
          print("---delete doubleforrent");
        });
      } else {
        //print("should not delete");
      }
    }
    //todo check in doubleforrent
    var doubleforrentDoc = await Datamanager.firestore
        .collection("Doubleforrent")
        .where('iscancle', isEqualTo: false)
        .getDocuments();
    List<DocumentSnapshot> doubleforrentlist = doubleforrentDoc.documents;
    for (DocumentSnapshot doubleforrent in doubleforrentlist) {
      //print("---double doc : ${doubleforrent['docid']}");
      //print(dateTime);
      //print('---double startdate : ${doubleforrent['startdate']}');
      if ((doubleforrent['startdate'] as Timestamp)
          .toDate()
          .isBefore(dateTime)) {
        print("doubleforrent doc is : ${doubleforrent['docid']}");
        await Datamanager.firestore
            .collection('Doubleforrent')
            .document(doubleforrent['docid'])
            .updateData({
          'iscancle': true,
          'rentercanclealert': true,
        }).whenComplete(() {
          //print("update success");
          delete_boxslotrent_doubleforrent(doubleforrent['docid']);
          //
        });
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
          //print("cancle ${booking['bookingdocid']} complete");
          delete_boxslotrent_booking(booking['bookingdocid']);
        });
      }
    }
  }

  String timeslotmatch(DateTime dateTime) {
    if (dateTime.isAfter(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 8, 0)) &&
        dateTime.isBefore(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 9, 15))) {
      print("this time is in timeslot");
      return TimeSlotSingle.sub1;
    }

    if (dateTime.isAfter(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 9, 30)) &&
        dateTime.isBefore(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 10, 45))) {
      print("this time is in timeslot");
      return TimeSlotSingle.sub2;
    }

    if (dateTime.isAfter(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 11, 00)) &&
        dateTime.isBefore(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 12, 15))) {
      print("this time is in timeslot");
      return TimeSlotSingle.sub3;
    }

    if (dateTime.isAfter(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 13, 0)) &&
        dateTime.isBefore(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 14, 15))) {
      print("this time is in timeslot");
      return TimeSlotSingle.sub4;
    }

    if (dateTime.isAfter(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 14, 30)) &&
        dateTime.isBefore(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 15, 45))) {
      print("this time is in timeslot");
      return TimeSlotSingle.sub5;
    }

    if (dateTime.isAfter(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 16, 00)) &&
        dateTime.isBefore(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 17, 30))) {
      print("this time is in timeslot");
      return TimeSlotSingle.sub6;
    }

    print("this time is not in timeslot");
    return null;
  }

  bool checkintimeslot(DateTime dateTime) {
    print(
        "checkintimeslot : ${dateTime.year} ${dateTime.month} ${dateTime.day} ${dateTime.hour} ${dateTime.minute} ");
    //DateTime timenow = DateTime.now();
    if (dateTime.isAfter(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 8, 0)) &&
        dateTime.isBefore(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 9, 15))) {
      print("this time is in timeslot");
      return true;
    }

    if (dateTime.isAfter(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 9, 30)) &&
        dateTime.isBefore(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 10, 45))) {
      print("this time is in timeslot");
      return true;
    }

    if (dateTime.isAfter(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 11, 00)) &&
        dateTime.isBefore(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 12, 15))) {
      print("this time is in timeslot");
      return true;
    }

    if (dateTime.isAfter(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 13, 0)) &&
        dateTime.isBefore(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 14, 15))) {
      print("this time is in timeslot");
      return true;
    }

    if (dateTime.isAfter(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 14, 30)) &&
        dateTime.isBefore(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 15, 45))) {
      print("this time is in timeslot");
      return true;
    }

    if (dateTime.isAfter(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 16, 00)) &&
        dateTime.isBefore(
            DateTime(dateTime.year, dateTime.month, dateTime.day, 17, 30))) {
      print("this time is in timeslot");
      return true;
    }

    print("this time is not in timeslot");
    return false;
  }
}
