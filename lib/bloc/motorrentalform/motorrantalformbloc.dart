import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/tag.dart';
import 'package:pickcar/bloc/motorrentalform/motorrentalformevent.dart';
import 'package:pickcar/bloc/motorrentalform/motorrentalformstate.dart';
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
  List<Map<String , dynamic>> realts = List<Map<String , dynamic>>();

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

    if(event is MotorRentalFormLoadDataEvent){

    }


  }

  Future<Null> submitform() async {
    final form = formkey.currentState;
    if (form.validate()) {
      print("form validate naja");
      //await changstatusmotorFirsestore();
    }
  }

  Future<Null> adddatamotorforrent() async {
    MotorForRent motorForRent = MotorForRent(
        dateTime: this.dateTime,
        motorcycledocid: this.motorcycle.firestoredocid,
        price: double.parse(this.pricecontroller.text),
        status: CarStatus.waiting,
        timeslotlist: timeslotlist,
        ownerdocid: Datamanager.user.documentid,
        university: Datamanager.user.university);
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
    List<MotorcycleTimeSlot> motortimeslotlist = List<MotorcycleTimeSlot>();
    for (String timeslot in timeslotlist) {
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
          docid: null
          );

      final docref = await Datamanager.firestore
          .collection("MotorcycleforrentSlot")
          .add(motorslot.toJson());

      Datamanager.firestore.collection("MotorcycleforrentSlot").document(docref.documentID).updateData({
        'docid' : docref.documentID
      });

      // Datamanager.pincar.rentorbookid = docref.documentID;
      // Datamanager.pincar.docboxid = Datamanager.boxselect.docboxid;
      // Datamanager.pincar.rentorbookid = docref.documentID;
      // Datamanager.pincar.docboxid = Datamanager.boxlocationshow.docboxid;
      // final docpinref = await Datamanager.firestore
      //   .collection("pincar")
      //   .add(Datamanager.pincar.toJson());
      // Datamanager.pincar.docpinid = docpinref.documentID;
      // Datamanager.firestore.collection("pincar").document(Datamanager.pincar.docpinid).updateData({
      //   'docpinid' : docpinref.documentID
      // });
      // Datamanager.firestore.collection("MotorcycleforrentSlot").document(docref.documentID).updateData({
      //   'pindocid' : docpinref.documentID
      // });
      
    }
    // Boxslot boxslot = Boxslot(
    //     isopen: false,
    //     rentorbook: docref.documentID,
    //     slotnumber: ,
    //   );
    //   final docboxslotref = await Datamanager.firestore
    //     .collection("box")
    //     .document(Datamanager.boxselect.docboxid)
    //     .collection('boxslot')
    //     .add(boxslot.toJson());
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
