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
import 'package:pickcar/models/slotbox.dart';

class MotorRentalFormBloc
    extends Bloc<MotorRentalFormEvent, MotorRentalFormState> {
  BuildContext context;
  var formkey = GlobalKey<FormState>();
  Motorcycle motorcycle;
  TextEditingController pricecontroller = TextEditingController();
  DateTime dateTime;
  DateTime datenow;
  List<String> timeslotlist = List<String>();
  List<Map<String, dynamic>> realts = List<Map<String, dynamic>>();
  List<Boxslotrent> boxslotrentreal = List<Boxslotrent>();
  List<String> errortimeslot = List<String>();
  List<String> boxslotrentrealdocid = List<String>();

  MotorRentalFormBloc({@required this.context, @required this.motorcycle}) {
    pricecontroller.text = CarPrice.motorminprice.toString();
    datenow = DateTime.now();
    dateTime = DateTime.now();
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
      await adddatamotorforrent();
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
    }
  }

  Future<Null> adddatamotorforrent() async {
    //todo check box avaiable
    String boxdocidforrent;

    print("before timeslotlist : ${timeslotlist.length}");
    //this.errortimeslot = this.timeslotlist;

    for (var slot in timeslotlist) {
      this.errortimeslot.add(slot);
    }

    QuerySnapshot boxlist = await Datamanager.firestore
        .collection("box")
        .where("boxlocationid", isEqualTo: Datamanager.boxlocationshow.docboxid)
        .getDocuments();

    OUTERLOOP:
    for (var box in boxlist.documents) {
      //print("box docid : " + box['docid']);
      boxdocidforrent = box.documentID;

      QuerySnapshot boxslotlist = await Datamanager.firestore
          .collection('box')
          .document(box['docboxid'])
          .collection('boxslot') //todo add where boxlocation
          .getDocuments();
      for (var boxslot in boxslotlist.documents) {
        //print('boxslot doc id : ${boxslot['docid']}');

        QuerySnapshot boxslotrentlist = await Datamanager.firestore
            .collection('BoxslotRent')
            .where('boxdocid', isEqualTo: box['docid'])
            .where('boxslotdocid', isEqualTo: boxslot['docid'])
            .getDocuments();

        // print("BoxslotRent : ${boxslotrentlist.documents.length}");

        if (this.errortimeslot.length == this.boxslotrentreal.length) {
          print("errortimeselot is empty");
          break OUTERLOOP;
        }

        bool chekcboxslotavilabel = true;
        for (String timeslot in this.errortimeslot) {
          var alreadyhaveslotrent = boxslotrentlist.documents.where(
              (boxslotrent) => ((boxslotrent['day'] == this.dateTime.day) &&
                  (boxslotrent['month'] == this.dateTime.month) &&
                  (boxslotrent['year'] == this.dateTime.year) &&
                  (boxslotrent['time'] == timeslot)));

          if (alreadyhaveslotrent.isNotEmpty) {
            chekcboxslotavilabel = false;
            break;
          } else {
            Boxslotrent bslr = Boxslotrent(
                boxdocid: box['docid'],
                boxslotdocid: boxslot['docid'],
                boxplacedocid: box['boxlocationid'],
                day: this.dateTime.day,
                month: this.dateTime.month,
                year: this.dateTime.year,
                ownerdocid: Datamanager.user.documentid,
                renterdocid: null,
                iskey: false,
                isopen: false,
                time: timeslot,
                ownerdropkey: false
                );
            this.boxslotrentreal.add(bslr);
          }

          /*var alreadyhaveslotrent = boxslotrentlist.documents.where((boxslotrent) => (
            (boxslotrent['day'] == this.dateTime.day) &&
            (boxslotrent['month'] == this.dateTime.month) &&
            (boxslotrent['year'] == this.dateTime.year) &&
            (boxslotrent['time'] == timeslot)
          ));

          if(alreadyhaveslotrent.isEmpty){
            print("slot is avaliable");
            //this.errortimeslot.removeWhere((errortime) => errortime == timeslot);
            Boxslotrent bslr = Boxslotrent(
              boxdocid: box['docid'],
              boxslotdocid: boxslot['docid'],
              boxplacedocid: box['boxlocationid'],
              day: this.dateTime.day,
              month: this.dateTime.month,
              year: this.dateTime.year,
              ownerdocid: Datamanager.user.documentid,
              renterdocid: null,
              iskey: false,
              isopen: false,
              time: timeslot
            );
            this.boxslotrentreal.add(bslr);
          }else{
            print("this slot is full");
          }
        }*/

        }

        if (chekcboxslotavilabel) {
          break OUTERLOOP;
        } else {
          this.boxslotrentreal.clear();
        }
      }
    }

      //todo add boxslotrentrel to firebase
      for (Boxslotrent bslr in boxslotrentreal) {
        this.errortimeslot.remove(bslr.time);
        var docref = await Datamanager.firestore
            .collection("BoxslotRent")
            .add(bslr.toJson());
        await Datamanager.firestore
            .collection('BoxslotRent')
            .document(docref.documentID)
            .updateData({
          'docid': docref.documentID,
        });

        boxslotrentrealdocid.add(docref.documentID);
        //print("88888888888888888888888 : ${docref.documentID}");
      }
      // print("middle timeslotlist is ${timeslotlist.length}");

      //print("9999999999999999999 : ${boxslotrentrealdocid.length}");
      //todo------------------------

      MotorForRent motorForRent = MotorForRent(
          dateTime: this.dateTime,
          motorcycledocid: this.motorcycle.firestoredocid,
          price: double.parse(this.pricecontroller.text),
          status: CarStatus.waiting,
          timeslotlist: timeslotlist,
          ownerdocid: Datamanager.user.documentid,
          university: Datamanager.user.university,
          boxdocid: boxdocidforrent,
          boxplacedocid: Datamanager.boxlocationshow.docboxid
          );
      final docref = await Datamanager.firestore
          .collection("Motorcycleforrent")
          .add(motorForRent.toJson());
      String docid = docref.documentID;
      await Datamanager.firestore
          .collection("Motorcycleforrent")
          .document(docid)
          .updateData({'motorforrentdocid': docid});
      //todo update motorforrent in motorcycle
      await Datamanager.firestore
          .collection("Motorcycle")
          .document(this.motorcycle.firestoredocid)
          .updateData({'motorforrentdocid': docid});

      //todo add motorforrentslot
      //List<MotorcycleTimeSlot> motortimeslotlist = List<MotorcycleTimeSlot>();
      //print("out loop timesoltlist 555555555");
      //print("size of  timesoltlist ${timeslotlist.length}");
      int count = 0;
      for (String timeslot in timeslotlist) {
        print("in loop timesoltlist 555555555");
        //todo add box carplace boxslotrent
        MotorcycleTimeSlot motorslot = MotorcycleTimeSlot(
          dateTime: this.dateTime,
          day: this.dateTime.day,
          month: this.dateTime.month,
          year: this.dateTime.year,
          motorcycledocid: this.motorcycle.firestoredocid,
          motorforrentdocid: docid,
          ownerdocid: Datamanager.user.documentid,
          prize: double.parse(this.pricecontroller.text),
          timeslot: timeslot,
          university: Datamanager.user.university,
          docid: null,
          boxslotrentdocid: boxslotrentrealdocid[count],
          keyboxplacelocdocid: Datamanager.boxlocationshow.docboxid,
          motorplacelocdocid: Datamanager.placelocationshow.docplaceid,
        );

        final docref = await Datamanager.firestore
            .collection("MotorcycleforrentSlot")
            .add(motorslot.toJson());

        Datamanager.firestore
            .collection("MotorcycleforrentSlot")
            .document(docref.documentID)
            .updateData({'docid': docref.documentID});
        //todo ------------------------------------------------------------------------------
        count++;
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

  void checkitemtimeslot(Item ts) {
    if (ts.active) {
      timeslotlist.add(ts.title);
    } else {
      if (timeslotlist.contains(ts.title)) {
        timeslotlist.remove(ts.title);
      }
    }
  }

  //todo re tr picture1inches idcardcopy

  Future<Null> datepicker(Function changetime) async {
    DateTime picked = await showDatePicker(
        context: this.context,
        firstDate: this.datenow,
        lastDate: this.datenow.add(Duration(days: 30)),
        initialDate: dateTime);

    if (picked != null && picked != dateTime) {
      dateTime = picked;
      print("date picked : ${dateTime.toString()}");
      changetime();
    }
  }
}
