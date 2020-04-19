import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/bloc/listcar/listcarevent.dart';
import 'package:pickcar/bloc/listcar/listcarstate.dart';
import 'package:pickcar/models/motorcycle.dart';

import '../../datamanager.dart';

class ListCarBloc extends Bloc<ListCarEvent, ListCarState> {
  BuildContext context;
  List<Motorcycle> motorcyclelist;
  bool isshowalert = false;

  ListCarBloc({@required this.context}) {
    motorcyclelist = List<Motorcycle>();
  }

  @override
  ListCarState get initialState => ListCarStartState();

  @override
  Stream<ListCarState> mapEventToState(ListCarEvent event) async* {
    if (event is ListCarLoadingDataEvent) {
      yield ListCarStartState();
      print("Loading data list car naja");
      loadingmotordata();
      yield ListCarShowData(motorcyclelist: motorcyclelist);
    }
  }

  Future<Null> looptime() async {
    Timer.periodic(Duration(seconds: 5), (timer) async {
      if (isshowalert) return;
      List<String> singlefordelete = List<String>();
      List<String> doublefordelete = List<String>();
      String deletelist;
      List<String> bookingfordelete = List<String>();

      //todo find in singeforrent
      QuerySnapshot singleforrentquey = await Datamanager.firestore
          .collection("Singleforrent")
          .where('ownerdocid', isEqualTo: Datamanager.user.documentid)
          .where('iscancle', isEqualTo: true)
          .where('ownercanclealert', isEqualTo: false)
          .getDocuments();
      List<DocumentSnapshot> singleforrentdoc = singleforrentquey.documents;
      if (singleforrentdoc.isNotEmpty) {
        print('single forrent is not empty');
        deletelist = "singleforrent " + '\n';
        for (var singleforrent in singleforrentdoc) {
          deletelist = deletelist +
              singleforrent['day'].toString() +
              "/" +
              singleforrent['month'].toString() +
              "/" +
              singleforrent['year'].toString() +
              " : " +
              singleforrent['time'] +
              '\n';
          singlefordelete.add((singleforrent['docid'] as String));
        }
      }

      //todo find in doubleforrent
      QuerySnapshot doubleforrentquey = await Datamanager.firestore
          .collection("Doubleforrent")
          .where('ownerdocid', isEqualTo: Datamanager.user.documentid)
          .where('iscancle', isEqualTo: true)
          .where('ownercanclealert', isEqualTo: false)
          .getDocuments();
      List<DocumentSnapshot> doubleforrentdoc = doubleforrentquey.documents;
      if (doubleforrentdoc.isNotEmpty) {
        print('double forrent is not empty');
        deletelist = "doubleforrent" + '\n';;
        for (var doubleforrent in doubleforrentdoc) {
          deletelist = deletelist +
              doubleforrent['day'].toString() +
              "/" +
              doubleforrent['month'].toString() +
              "/" +
              doubleforrent['year'].toString() +
              " : " +
              doubleforrent['time'] +
              '\n';
          doublefordelete.add((doubleforrent['docid'] as String));
        }
      }

      //todo find in booking
      QuerySnapshot bookingquey = await Datamanager.firestore
          .collection("Booking")
          .where('ownerdocid', isEqualTo: Datamanager.user.documentid)
          .where('iscancle', isEqualTo: true)
          .where('ownercanclealert', isEqualTo: false)
          .getDocuments();
      if (bookingquey.documents.isNotEmpty) {
        print('booking not empty');
        deletelist += "booking" + '\n';
        for (var booking in bookingquey.documents) {
          deletelist = deletelist +
              booking['day'].toString() +
              "/" +
              booking['month'].toString() +
              "/" +
              booking['year'].toString() +
              " : " +
              booking['time'] +
              '\n';
          bookingfordelete.add((booking['bookingdocid'] as String));
        }
      }

      if (singlefordelete.isNotEmpty ||
          bookingfordelete.isNotEmpty ||
          doublefordelete.isNotEmpty) {
        this.isshowalert = true;
        showDialog(
            context: this.context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(UseString.carownercancle),
                content: Text(deletelist),
                actions: <Widget>[
                  FlatButton(
                    child: Text("ok"),
                    onPressed: () async {
                      this.isshowalert = false;
                      await confirmcancle(
                          singlefordelete, bookingfordelete, doublefordelete);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }

      //todo show dialog

      // for (var singleforrent in singleforrentdoc) {
      //   print("looptime singleforrent doc : ${singleforrent['docid']}");
      //   // await Datamanager.firestore.collection("Singleforrent").document(singleforrent['docid']).updateData({

      //   // });
      // }
      // QuerySnapshot bookingquey = await Datamanager.firestore
      //     .collection("Booking")
      //     .where('ownerid', isEqualTo: Datamanager.user.documentid)
      //     .where('iscancle', isEqualTo: true)
      //     .where('ownercanclealert', isEqualTo: false)
      //     .getDocuments();
      // List<DocumentSnapshot> bookingdoc = bookingquey.documents;
      // for (var booking in bookingdoc) {
      //   //print("looptime singleforrent doc : ${booking['docid']}");
      // }
    });
  }

  Future<Null> confirmcancle(List<String> singlelistdoc,
      List<String> bookinglistdoc, List<String> doublelistdoc) async {
    for (var singleforrentdoc in singlelistdoc) {
      await Datamanager.firestore
          .collection("Singleforrent")
          .document(singleforrentdoc)
          .updateData({
        'ownercanclealert': true,
      }).whenComplete(() {
        print('single complete');
      });
    }

    for (var bookingdocid in bookinglistdoc) {
      await Datamanager.firestore
          .collection("Booking")
          .document(bookingdocid)
          .updateData({
        'ownercanclealert': true,
      }).whenComplete(() {
        print('booking complete');
      });
    }

    for (var doubledocid in doublelistdoc) {
      await Datamanager.firestore
          .collection("Doubleforrent")
          .document(doubledocid)
          .updateData({
        'ownercanclealert': true,
      }).whenComplete(() {
        print('double complete');
      });
    }
  }

  void loadingmotordata() {
    Datamanager.firestore
        .collection('Motorcycle')
        .where("owneruid", isEqualTo: Datamanager.user.uid)
        .snapshots()
        .listen((data) {
      data.documents.forEach((doc) {
        // print("Motor doc id : ${doc['firestoredocid']}");

        Motorcycle motor = Motorcycle(
            carstatus: doc['carstatus'],
            brand: doc['brand'],
            cc: int.parse(doc['cc'].toString()),
            color: doc['color'],
            gear: doc['gear'],
            generation: doc['generation'],
            owneruid: doc['owneruid'],
            storagedocid: doc['storagedocid'],
            profilepath: doc['profilepath'],
            profiletype: doc['profiletype'],
            motorprofilelink: doc['motorprofilelink'],
            ownerliscensepath: doc['ownerliscensepath'],
            ownerliscensetype: doc['ownerliscensetype'],
            motorownerliscenselink: doc['motorownerliscenselink'],
            motorfrontpath: doc['motorfrontpath'],
            motorfronttype: doc['motorfronttype'],
            motorfrontlink: doc['motorfrontlink'],
            motorbackpath: doc['motorbackpath'],
            motorbacktype: doc['motorbacktype'],
            motorbacklink: doc['motorbacklink'],
            motorleftpath: doc['motorleftpath'],
            motorlefttype: doc['motorlefttype'],
            motorleftlink: doc['motorleftlink'],
            motorrightpath: doc['motorrightpath'],
            motorrighttype: doc['motorrighttype'],
            motorrightlink: doc['motorrightlink'],
            currentlatitude: doc['currentlatitude'],
            currentlongitude: doc['currentlatitude'],
            isworking: doc['isworking'],
            iswaiting: doc['iswaiting'],
            isbook: doc['isbook'],
            motorgas: doc['motorgas'],
            motorreg: doc['motorreg'],
            isapprove: doc['isapprove']);
        motor.firestoredocid = doc['firestoredocid'];
        motorcyclelist.add(motor);
      });
    });

    print("finish load datanaja");
  }
}
