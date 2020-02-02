import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/tag.dart';
import 'package:pickcar/bloc/motorrentalform/motorrentalformevent.dart';
import 'package:pickcar/bloc/motorrentalform/motorrentalformstate.dart';
import 'package:pickcar/bloc/registermotor/motorregisterstate.dart';
import 'package:pickcar/models/boxslotrent.dart';
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
  String type;
  List<String> timeslot;
  String choosetimeslot;
  List<Map<String, String>> datasourcefordrop;

  MotorRentalFormBloc({@required this.context, @required this.motorcycle}) {
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
      } else {}
    } else {
      print("form is not validate");
    }
  }

  Future<Null> rentalsingle() async {
    print("in rentalsingle function");
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
          break OUTERLOOP;
        } else {
          print("this slot is not empty");
          var alreadyslot = boxslotrentlist.documents
              .where((doc) => doc['time'] == this.choosetimeslot);
          if (alreadyslot.isNotEmpty) {
            print("this slot is already have!!");
            continue;
          } else {
            addsingleforrent(
                box.documentID, boxslot.documentID, box['boxlocationid']);
          }
          break OUTERLOOP;
        }
      }
    }
  }

  DateTime makestartdatetimesingle(DateTime date , String timeslot){
    DateTime startdate;
    if(timeslot == TimeSlotSingle.sub1){
      startdate = DateTime(date.year,date.month,date.day,8,0);
    }
    if(timeslot == TimeSlotSingle.sub2){
      startdate = DateTime(date.year,date.month,date.day,9,30);
    }
    if(timeslot == TimeSlotSingle.sub3){
      startdate = DateTime(date.year,date.month,date.day,11,0);
    }
    if(timeslot == TimeSlotSingle.sub4){
      startdate = DateTime(date.year,date.month,date.day,13,0);
    }
    if(timeslot == TimeSlotSingle.sub5){
      startdate = DateTime(date.year,date.month,date.day,14,30);
    }
    if(timeslot == TimeSlotSingle.sub6){
      startdate = DateTime(date.year,date.month,date.day,16,0);
    }

    return startdate;
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
        startdate: makestartdatetimesingle(this.dateTime,this.choosetimeslot),
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
      startdate: makestartdatetimesingle(this.dateTime,this.choosetimeslot),
      status: null
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

    QuerySnapshot _singleforrentlist =
        await Datamanager.firestore.collection("Singleforrent").getDocuments();
    
     List<DocumentSnapshot> sgfr = _singleforrentlist.documents.where((doc) => (doc['motorcycledocid'] == this.motorcycle.firestoredocid) && (doc['year'] == this.dateTime.year) && (doc['month'] == this.dateTime.month) && (doc['day'] == this.dateTime.day)).toList();
      for(var doc in sgfr){
        //print(doc['time']);
        timeslotlist.remove(doc['time']);
      }
    return timeslotlist;
  }

  Future<Null> settimeslot() async {
    if (this.type == TypeRental.singleslot) {
      this.timeslot = await makeslottimelist(dateTime);
      this.datasourcefordrop = datasourcefordropdown();
    } else if (this.type == TypeRental.doubleslot) {
      print("settimeslot double");
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
      this.timeslot = await makeslottimelist(dateTime);
      this.datasourcefordrop = datasourcefordropdown();
      changetime();
    }
  }

  List<Map<String, String>> datasourcefordropdown() {
    List<Map<String, String>> datasource = List<Map<String, String>>();
    for (String slot in this.timeslot) {
      datasource.add({"display": slot, "value": slot});
    }

    return datasource;
  }
}
