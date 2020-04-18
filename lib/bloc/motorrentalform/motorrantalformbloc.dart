import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/tag.dart';
import 'package:pickcar/bloc/motorrentalform/motorrentalformevent.dart';
import 'package:pickcar/bloc/motorrentalform/motorrentalformstate.dart';
import 'package:pickcar/bloc/registermotor/motorregisterstate.dart';
import 'package:pickcar/models/boxslotrent.dart';
import 'package:pickcar/models/doubleforrent.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/motorcycletimeslot.dart';
import 'package:pickcar/models/motorforrent.dart';
import 'package:pickcar/models/singleforrent.dart';
import 'package:pickcar/models/slotbox.dart';

class MotorRentalFormBloc
    extends Bloc<MotorRentalFormEvent, MotorRentalFormState> {
  BuildContext context;
  var formkey = GlobalKey<FormState>();
  Motorcycle motorcycle;
  TextEditingController pricecontroller = TextEditingController();
  DateTime dateTime;

  //todo type
  bool ischoosedate = false;
  String type;
  List<String> timeslot;
  String choosetimeslot;
  List<Map<String, String>> datasourcefordrop;
  Function setstate;

  MotorRentalFormBloc(
      {@required this.context,
      @required this.motorcycle,
      @required this.setstate}) {
    pricecontroller.text = CarPrice.motorminprice.toString();
    //datenow = DateTime.now();
    DateTime now = DateTime.now();
    //dateTime = DateTime(now.year , now.month , now.day);
    dateTime = DateTime.now();
    if (dateTime.isAfter(DateTime(now.year, now.month, now.day, 16, 0))) {
      dateTime = now.add(Duration(days: 1));
    }

    datasourcefordrop = List<Map<String, String>>();
  }

  @override
  // TODO: implement initialState
  MotorRentalFormState get initialState => MotorRentalFormStartState();

  @override
  Stream<MotorRentalFormState> mapEventToState(
      MotorRentalFormEvent event) async* {
    // TODO: implement mapEventToState
    if (event is MotorRentalFormSubmitFormEvent) {
      print("in MotorRentalFormSubmitFormEvent");
      await submitform();
      //await adddatamotorforrent();
      await resetstatusmotor();
      print("rental success");

      Navigator.of(context).pushNamedAndRemoveUntil(
        Datamanager.listcarpage,
        ModalRoute.withName('/'),
      );
    }

    if (event is MotorRentalFormLoadDataEvent) {}
  }

  Future<Null> submitform() async {
    final form = formkey.currentState;
    if (form.validate()) {
      print("form validate naja");
      //await changstatusmotorFirsestore();
      if (this.type == TypeRental.singleslot) {
        await rentalsingle();
      } else if (this.type == TypeRental.doubleslot) {
        print('goto rental double function');
        await rentaldouble();
      }

      await Datamanager.firestore.collection("Motorcycle")
      .document(motorcycle.firestoredocid)
      .updateData({'isbook' : true});
    } else {
      print("form is not validate");
    }
  }

  Future<Null> rentaldouble() async {
    print('in rental double function');
    bool isfull = true;
    QuerySnapshot boxlist = await Datamanager.firestore
        .collection("box")
        .where("boxlocationid", isEqualTo: Datamanager.boxlocationshow.docboxid)
        .getDocuments();
    //todo fix this loop
    OUTERLOOP:
    for (var box in boxlist.documents) {
      QuerySnapshot boxslotlist = await Datamanager.firestore
          .collection('box')
          .document(box['docboxid'])
          .collection('boxslot') //todo add where boxlocation
          .getDocuments();
      for (var boxslot in boxslotlist.documents) {
        QuerySnapshot boxslotrentlist = await Datamanager.firestore
            .collection('BoxslotRent')
            .where('boxdocid', isEqualTo: box['docid'])
            .where('boxslotdocid', isEqualTo: boxslot['docid'])
            .getDocuments();

        if (boxslotrentlist.documents.isEmpty) {
          print('this slot is empty');
          //todo add doubleforrent
          adddoubleforrent(
              box.documentID, boxslot.documentID, box['boxlocationid']);
          isfull = false;
          break OUTERLOOP;
        } else {
          print('this slot is not empty');
          bool alreadyslot = false;
          for (var boxslotrent in boxslotrentlist.documents) {
            DateTime boxslrstarttime =
                (boxslotrent['startdate'] as Timestamp).toDate();
            DateTime boxslrendtime =
                (boxslotrent['enddate'] as Timestamp).toDate();

            if (boxslotrent['type'] == TypeRental.singleslot) {
              print('this type is single');
              DateTime timecheck = boxslrstarttime.add(Duration(minutes: 1));
              DateTime choosetime =
                  makestartdatetimedouble(this.dateTime, this.choosetimeslot);
              print('-----------------------rrr---------------------');
              print(timecheck);
              print(choosetime);
              print('-----------------------rrr---------------------');
              if (timecheck.isAfter(choosetime) &&
                  timecheck.isBefore(
                      choosetime.add(Duration(hours: 2, minutes: 45)))) {
                print('-- already slot --');
                alreadyslot = true;
                break;
              }
            } else {
              print('this type is double');
              DateTime timecheck1 =
                  makestartdatetimedouble(this.dateTime, this.choosetimeslot);
              DateTime timecheck2 =
                  timecheck1.add(Duration(hours: 2, minutes: 45));
              timecheck1 = timecheck1.add(Duration(minutes: 1));

              if ((timecheck1.isAfter(boxslrstarttime) &&
                      (timecheck1.isBefore(boxslrendtime))) ||
                  (timecheck2.isAfter(boxslrstarttime) &&
                      (timecheck2.isBefore(boxslrendtime)))) {
                alreadyslot = true;
                break;
              }
            }
          }

          if (alreadyslot) {
            print("this slot is already have!!");
            continue;
          } else {
            adddoubleforrent(
                box.documentID, boxslot.documentID, box['boxlocationid']);
            isfull = false;
            break OUTERLOOP;
          }
        }
      }
    }

    if (isfull) {
      showDialog(
          context: this.context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(UseString.carownercancle),
              content: Text(UseString.fullslot),
              actions: <Widget>[
                FlatButton(
                  child: Text("ok"),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  Future<Null> rentalsingle() async {
    print("in rentalsingle function");
    bool isfull = true;
    QuerySnapshot boxlist = await Datamanager.firestore
        .collection("box")
        .where("boxlocationid", isEqualTo: Datamanager.boxlocationshow.docboxid)
        .getDocuments();

    OUTERLOOP:
    for (var box in boxlist.documents) {
      QuerySnapshot boxslotlist = await Datamanager.firestore
          .collection('box')
          .document(box['docboxid'])
          .collection('boxslot') //todo add where boxlocation
          .getDocuments();
      for (var boxslot in boxslotlist.documents) {
        QuerySnapshot boxslotrentlist = await Datamanager.firestore
            .collection('BoxslotRent')
            .where('boxdocid', isEqualTo: box['docid'])
            .where('boxslotdocid', isEqualTo: boxslot['docid'])
            .getDocuments();

        if (boxslotrentlist.documents.isEmpty) {
          print('this slot is empty');
          addsingleforrent(
              box.documentID, boxslot.documentID, box['boxlocationid']);
          isfull = false;
          break OUTERLOOP;
        } else {
          print("this slot is not empty");
          bool alreadyslot = false;
          for (var boxslotrent in boxslotrentlist.documents) {
            DateTime boxslrstarttime =
                (boxslotrent['startdate'] as Timestamp).toDate();
            DateTime boxslrendtime =
                (boxslotrent['enddate'] as Timestamp).toDate();
            DateTime timechoose =
                makestartdatetimesingle(dateTime, choosetimeslot);
            if (boxslotrent['type'] == TypeRental.singleslot) {
              print('type is singleslot');

              if ((timechoose.day == boxslrstarttime.day) &&
                  (timechoose.month == boxslrstarttime.month) &&
                  (timechoose.year == boxslrstarttime.year) &&
                  (timechoose.hour == boxslrstarttime.hour) &&
                  (timechoose.minute == boxslrstarttime.minute)) {
                alreadyslot = true;
                break;
              }
            } else {
              print('type is doubleslot');
              if ((timechoose.day == boxslrstarttime.day) &&
                  (timechoose.month == boxslrstarttime.month) &&
                  (timechoose.year == boxslrstarttime.year)) {
                //print('99999999999999');

                DateTime timecheck =
                    makestartdatetimesingle(dateTime, choosetimeslot)
                        .add(Duration(minutes: 1));

                print(timecheck);
                print(boxslrstarttime);
                print(boxslrendtime);
                if (timecheck.isAfter(boxslrstarttime) &&
                    timecheck.isBefore(boxslrendtime)) {
                  // print('8888888888888888888888');
                  // print('--------------------');
                  // print(boxslrstarttime);
                  // print(boxslrendtime);
                  // print(timecheck);
                  // print('--------------------');
                  alreadyslot = true;
                  break;
                }
              }
            }
          }

          if (alreadyslot) {
            print("this slot is already have!!");
            continue;
          } else {
            addsingleforrent(
                box.documentID, boxslot.documentID, box['boxlocationid']);
            isfull = false;
            break OUTERLOOP;
          }
          // var alreadyslot = boxslotrentlist.documents
          //     .where((doc) => doc['time'] == this.choosetimeslot);
          // if (alreadyslot.isNotEmpty) {
          //   print("this slot is already have!!");
          //   continue;
          // } else {
          //   addsingleforrent(
          //       box.documentID, boxslot.documentID, box['boxlocationid']);
          //   isfull = true;
          // }
          // break OUTERLOOP;
        }
      }
    }

    if (isfull) {
      showDialog(
          context: this.context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(UseString.carownercancle),
              content: Text(UseString.fullslot),
              actions: <Widget>[
                FlatButton(
                  child: Text("ok"),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  DateTime makestartdatetimedouble(DateTime date, String timeslot) {
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    print('in function makestartdatetimedouble');
    print(date);
    print(date.year);
    print(date.month);
    print(date.day);
    print(timeslot);
    DateTime startdate = DateTime(date.year, date.month, date.day);
    if (timeslot == TimeslotDouble.sub1) {
      startdate = DateTime(date.year, date.month, date.day, 8, 0);
    }
    if (timeslot == TimeslotDouble.sub2) {
      startdate = DateTime(date.year, date.month, date.day, 9, 30);
    }
    if (timeslot == TimeslotDouble.sub3) {
      startdate = DateTime(date.year, date.month, date.day, 13, 0);
    }
    if (timeslot == TimeslotDouble.sub4) {
      print('ininin');
      startdate = DateTime(date.year, date.month, date.day, 14, 30);
    }
    print(startdate);
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    return startdate;
  }

  DateTime makestartdatetimesingle(DateTime date, String timeslot) {
    DateTime startdate;
    if (timeslot == TimeSlotSingle.sub1) {
      startdate = DateTime(date.year, date.month, date.day, 8, 0);
    }
    if (timeslot == TimeSlotSingle.sub2) {
      startdate = DateTime(date.year, date.month, date.day, 9, 30);
    }
    if (timeslot == TimeSlotSingle.sub3) {
      startdate = DateTime(date.year, date.month, date.day, 11, 0);
    }
    if (timeslot == TimeSlotSingle.sub4) {
      startdate = DateTime(date.year, date.month, date.day, 13, 0);
    }
    if (timeslot == TimeSlotSingle.sub5) {
      startdate = DateTime(date.year, date.month, date.day, 14, 30);
    }
    if (timeslot == TimeSlotSingle.sub6) {
      startdate = DateTime(date.year, date.month, date.day, 16, 0);
    }

    return startdate;
  }

  Future<Null> adddoubleforrent(
      String boxdocid, String boxslotdocid, String boxlocid) async {
    print("in function adddoubleforrent");
    print("boxdocid " + boxdocid);
    print("boxslotdocid " + boxslotdocid);
    print(dateTime);
    print(makestartdatetimedouble(dateTime, this.choosetimeslot));
    print(makestartdatetimedouble(dateTime, this.choosetimeslot)
        .add(Duration(hours: 2, minutes: 45)));
    Boxslotrent bslr = Boxslotrent(
      boxdocid: boxdocid,
      boxplacedocid: boxlocid,
      boxslotdocid: boxslotdocid,
      day: this.dateTime.day,
      month: this.dateTime.month,
      year: this.dateTime.year,
      startdate: makestartdatetimedouble(dateTime, this.choosetimeslot),
      enddate: makestartdatetimedouble(dateTime, this.choosetimeslot)
          .add(Duration(hours: 2, minutes: 45)),
      iskey: false,
      isopen: false,
      motorcycledocid: this.motorcycle.firestoredocid,
      motorplaceloc: Datamanager.placelocationshow.docplaceid,
      ownerdocid: Datamanager.user.documentid,
      ownerdropkey: false,
      renterdocid: null,
      time: this.choosetimeslot,
      type: TypeRental.doubleslot,
    );

    var bslrdocref = await Datamanager.firestore
        .collection("BoxslotRent")
        .add(bslr.toJson());
    await Datamanager.firestore
        .collection('BoxslotRent')
        .document(bslrdocref.documentID)
        .updateData({
      'docid': bslrdocref.documentID,
    });

    DoubleForrent _doubleforrent = DoubleForrent(
      boxdocid: boxdocid,
      boxplacedocid: boxlocid,
      boxslotdocid: boxslotdocid,
      day: dateTime.day,
      month: dateTime.month,
      year: dateTime.year,
      iscancle: false,
      motorcycledocid: this.motorcycle.firestoredocid,
      motorplacelocdocid: Datamanager.placelocationshow.docplaceid,
      ownercanclealert: false,
      rentercanclealert: false,
      ownerdocid: Datamanager.user.documentid,
      price: double.parse(this.pricecontroller.text),
      startdate: makestartdatetimedouble(this.dateTime, this.choosetimeslot),
      status: null,
      time: this.choosetimeslot,
      university: Datamanager.user.university,
    );

    //todo add doubleforrent

    var dbfrdocref = await Datamanager.firestore
        .collection("Doubleforrent")
        .add(_doubleforrent.toJson());

    await Datamanager.firestore
        .collection("Doubleforrent")
        .document(dbfrdocref.documentID)
        .updateData({
      'boxslotrentdocid': bslrdocref.documentID,
      'docid': dbfrdocref.documentID,
    });
  }

  Future<Null> addsingleforrent(
      String boxdocid, String boxslotdocid, String boxlocid) async {
    print("in function addsingleforrent");
    print("boxdocid " + boxdocid);
    print("boxslotdocid " + boxslotdocid);

    Boxslotrent bslr = Boxslotrent(
        boxdocid: boxdocid,
        boxplacedocid: boxlocid,
        boxslotdocid: boxslotdocid,
        day: this.dateTime.day,
        month: this.dateTime.month,
        year: this.dateTime.year,
        iskey: false,
        isopen: false,
        ownerdocid: Datamanager.user.documentid,
        ownerdropkey: false,
        renterdocid: null,
        time: this.choosetimeslot,
        startdate: makestartdatetimesingle(this.dateTime, this.choosetimeslot),
        motorplaceloc: Datamanager.placelocationshow.docplaceid,
        motorcycledocid: this.motorcycle.firestoredocid,
        type: TypeRental.singleslot,
        enddate: makestartdatetimesingle(this.dateTime, this.choosetimeslot)
            .add(Duration(hours: 1, minutes: 15)));

    var bslrdocref = await Datamanager.firestore
        .collection("BoxslotRent")
        .add(bslr.toJson());
    await Datamanager.firestore
        .collection('BoxslotRent')
        .document(bslrdocref.documentID)
        .updateData({
      'docid': bslrdocref.documentID,
    });

    SingleForrent _singleforrent = SingleForrent(
      boxdocid: boxdocid,
      boxslotdocid: boxslotdocid,
      boxplacedocid: boxlocid,
      day: dateTime.day,
      month: dateTime.month,
      year: dateTime.year,
      motorcycledocid: this.motorcycle.firestoredocid,
      ownerdocid: Datamanager.user.documentid,
      price: double.parse(this.pricecontroller.text),
      time: this.choosetimeslot,
      university: Datamanager.user.university,
      motorplacelocdocid: Datamanager.placelocationshow.docplaceid,
      startdate: makestartdatetimesingle(this.dateTime, this.choosetimeslot),
      enddate: makestartdatetimesingle(this.dateTime, this.choosetimeslot)
          .add(Duration(hours: 1, minutes: 15)),
      status: null,
      iscancle: false,
      ownercanclealert: false,
      rentercanclealert: false,
    );

    var sgfrdocref = await Datamanager.firestore
        .collection("Singleforrent")
        .add(_singleforrent.toJson());

    await Datamanager.firestore
        .collection("Singleforrent")
        .document(sgfrdocref.documentID)
        .updateData({
      'boxslotrentdocid': bslrdocref.documentID,
      'docid': sgfrdocref.documentID,
    });
  }

  Future<List<String>> makeslottimelistdouble(DateTime date) async {
    print('in function makeslottimelistdouble');
    List<String> timeslotlist = TimeslotDouble.tolist();
    //print('timeslotlist double slot is ');
    //print(timeslotlist);
    DateTime now = DateTime.now();
    if ((date.year == now.year) &&
        (date.month == now.month) &&
        (date.day == now.day)) {
      print('datetime is today');
      if (dateTime.isAfter(DateTime(now.year, now.month, now.day, 8, 0))) {
        timeslotlist.remove(TimeslotDouble.sub1);
      }
      if (dateTime.isAfter(DateTime(now.year, now.month, now.day, 9, 30))) {
        timeslotlist.remove(TimeslotDouble.sub2);
      }
      if (dateTime.isAfter(DateTime(now.year, now.month, now.day, 13, 0))) {
        timeslotlist.remove(TimeslotDouble.sub3);
      }
      if (dateTime.isAfter(DateTime(now.year, now.month, now.day, 14, 30))) {
        timeslotlist.remove(TimeslotDouble.sub4);
      }
    }

    //todo delete in double
    QuerySnapshot _doubleforrentlist =
        await Datamanager.firestore.collection("Doubleforrent").getDocuments();
    List<DocumentSnapshot> dbfr = _doubleforrentlist.documents
        .where((doc) =>
            (doc['motorcycledocid'] == this.motorcycle.firestoredocid) &&
            (doc['year'] == this.dateTime.year) &&
            (doc['month'] == this.dateTime.month) &&
            (doc['day'] == this.dateTime.day))
        .toList();
    for (var doc in dbfr) {
      timeslotlist.remove(doc['time']);
    }
    //todo delete in single
    QuerySnapshot _singleforrentlist =
        await Datamanager.firestore.collection("Singleforrent").getDocuments();

    List<DocumentSnapshot> sgfr = _singleforrentlist.documents
        .where((doc) =>
            (doc['motorcycledocid'] == this.motorcycle.firestoredocid) &&
            (doc['year'] == this.dateTime.year) &&
            (doc['month'] == this.dateTime.month) &&
            (doc['day'] == this.dateTime.day))
        .toList();
    for (var doc in sgfr) {
      //print(doc['time']);
      timeslotlist.remove(singletodouble(doc['time']));
    }
    return timeslotlist;
  }

  Future<List<String>> makeslottimelist(DateTime date) async {
    print("in function");
    List<String> timeslotlist = TimeSlotSingle.tolist();
    DateTime now = DateTime.now();

    if ((date.year == now.year) &&
        (date.month == now.month) &&
        (date.day == now.day)) {
      print("in function in if date is today");
      if (date.isAfter(DateTime(now.year, now.month, now.day, 8, 0))) {
        timeslotlist.remove(TimeSlotSingle.sub1);
        print("remove " + TimeSlotSingle.sub1);
      }
      if (date.isAfter(DateTime(now.year, now.month, now.day, 9, 30))) {
        timeslotlist.remove(TimeSlotSingle.sub2);
        print("remove " + TimeSlotSingle.sub2);
      }
      if (date.isAfter(DateTime(now.year, now.month, now.day, 11, 0))) {
        timeslotlist.remove(TimeSlotSingle.sub3);
        print("remove " + TimeSlotSingle.sub3);
      }
      if (date.isAfter(DateTime(now.year, now.month, now.day, 13, 0))) {
        timeslotlist.remove(TimeSlotSingle.sub4);
        print("remove " + TimeSlotSingle.sub4);
      }
      if (date.isAfter(DateTime(now.year, now.month, now.day, 14, 30))) {
        timeslotlist.remove(TimeSlotSingle.sub5);
        print("remove " + TimeSlotSingle.sub5);
      }
      if (date.isAfter(DateTime(now.year, now.month, now.day, 16, 0))) {
        timeslotlist.remove(TimeSlotSingle.sub6);
        print("remove " + TimeSlotSingle.sub6);
      }
    } else {
      print("date is not today");
    }

    //todo delete in single

    QuerySnapshot _singleforrentlist =
        await Datamanager.firestore.collection("Singleforrent").getDocuments();

    List<DocumentSnapshot> sgfr = _singleforrentlist.documents
        .where((doc) =>
            (doc['motorcycledocid'] == this.motorcycle.firestoredocid) &&
            (doc['year'] == this.dateTime.year) &&
            (doc['month'] == this.dateTime.month) &&
            (doc['day'] == this.dateTime.day))
        .toList();
    for (var doc in sgfr) {
      //print(doc['time']);
      timeslotlist.remove(doc['time']);
    }

    QuerySnapshot booking = await Datamanager.firestore
        .collection("Booking")
        .where('motorcycledocid', isEqualTo: this.motorcycle.firestoredocid)
        .where('day', isEqualTo: this.dateTime.day)
        .where('month', isEqualTo: this.dateTime.month)
        .where('year', isEqualTo: this.dateTime.year)
        .getDocuments();

    List<DocumentSnapshot> bookinglist = booking.documents;
    for (var doc in bookinglist) {
      timeslotlist.remove(doc['time']);
    }
    // print('timeslotlist is ');
    // print(timeslotlist);

    //todo delete in double
    QuerySnapshot _doubleforrentlist =
        await Datamanager.firestore.collection("Doubleforrent").getDocuments();
    List<DocumentSnapshot> dbfr = _doubleforrentlist.documents
        .where((doc) =>
            (doc['motorcycledocid'] == this.motorcycle.firestoredocid) &&
            (doc['year'] == this.dateTime.year) &&
            (doc['month'] == this.dateTime.month) &&
            (doc['day'] == this.dateTime.day))
        .toList();
    for (var doc in dbfr) {
      //print(doc['time']);
      for (String time in doubletosingle(doc['time']))
        timeslotlist.remove(time);
    }

    return timeslotlist;
  }

  Future<Null> settimeslot() async {
    if (this.type == TypeRental.singleslot) {
      this.timeslot = await makeslottimelist(dateTime);
      this.datasourcefordrop = datasourcefordropdown();
      setstate();
    } else if (this.type == TypeRental.doubleslot) {
      this.timeslot = await makeslottimelistdouble(dateTime);
      this.datasourcefordrop = datasourcefordropdown();
      setstate();
      print("settimeslot double");
    }
  }

  String singletodouble(String _single) {
    if ((_single == TimeSlotSingle.sub1) || (_single == TimeSlotSingle.sub2))
      return TimeslotDouble.sub1;
    if ((_single == TimeSlotSingle.sub2) || (_single == TimeSlotSingle.sub3))
      return TimeslotDouble.sub2;
    if ((_single == TimeSlotSingle.sub4) || (_single == TimeSlotSingle.sub5))
      return TimeslotDouble.sub3;
    if ((_single == TimeSlotSingle.sub5) || (_single == TimeSlotSingle.sub6))
      return TimeslotDouble.sub4;
  }

  List<String> doubletosingle(String _double) {
    if (_double == TimeslotDouble.sub1) {
      return [TimeSlotSingle.sub1, TimeSlotSingle.sub2];
    }
    if (_double == TimeslotDouble.sub2) {
      return [TimeSlotSingle.sub2, TimeSlotSingle.sub3];
    }
    if (_double == TimeslotDouble.sub3) {
      return [TimeSlotSingle.sub4, TimeSlotSingle.sub5];
    }
    if (_double == TimeslotDouble.sub4) {
      return [TimeSlotSingle.sub5, TimeSlotSingle.sub6];
    }
  }

  Future<Null> resetstatusmotor() async {
    this.motorcycle.iswaiting = true;
    this.motorcycle.carstatus = CarStatus.checkcarstatus(this.motorcycle);
    await Datamanager.firestore
        .collection("Motorcycle")
        .document(this.motorcycle.firestoredocid)
        .updateData({
      'iswaiting': true,
      'carstatus': this.motorcycle.carstatus,
    });
  }

  Future<Null> changstatusmotorFirsestore() async {
    await Datamanager.firestore
        .collection("Motorcycle")
        .document(this.motorcycle.firestoredocid)
        .updateData({'carstatus': CarStatus.waiting});
  }

  //todo re tr picture1inches idcardcopy

  Future<Null> datepicker(Function changetime) async {
    DateTime now = DateTime.now();

    DateTime firstdate = DateTime(now.year, now.month, now.day);
    /*if (now.isAfter(DateTime(now.year, now.month, now.day, 16, 0))) {
      firstdate = now.add(Duration(days: 1));
    }*/
    DateTime lastdate = firstdate.add(Duration(days: 30));

    DateTime picked = await showDatePicker(
        context: this.context,
        firstDate: firstdate,
        lastDate: lastdate,
        initialDate: this.dateTime);

    if (picked != null /*&& picked != firstdate*/) {
      if (!((picked.year == dateTime.year) &&
          (picked.month == dateTime.month) &&
          (picked.day == dateTime.day))) {
        print("change day");
        this.choosetimeslot = null;
      }

      dateTime = picked;
      if ((dateTime.year == now.year) &&
          (dateTime.month == now.month) &&
          (dateTime.day == now.day)) {
        dateTime = now;
      }
      print("date picked : ${firstdate.toString()}");
      if (this.type == TypeRental.singleslot) {
        this.timeslot = await makeslottimelist(dateTime);
        this.datasourcefordrop = datasourcefordropdown();
      } else {
        this.timeslot = await makeslottimelistdouble(dateTime);
        this.datasourcefordrop = datasourcefordropdown();
      }

      changetime();
    }
  }

  List<Map<String, String>> datasourcefordropdown() {
    List<Map<String, String>> datasource = List<Map<String, String>>();
    for (String slot in this.timeslot) {
      datasource.add({"display": slot, "value": slot});
    }
    print('datasource is ');
    print(datasource);

    return datasource;
  }
}
