import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/tag.dart';
import 'package:pickcar/bloc/motorrentalform/motorrentalformevent.dart';
import 'package:pickcar/bloc/motorrentalform/motorrentalformstate.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:pickcar/datamanager.dart';
import 'package:pickcar/models/motorforrent.dart';

class MotorRentalFormBloc
    extends Bloc<MotorRentalFormEvent, MotorRentalFormState> {
  BuildContext context;
  var formkey = GlobalKey<FormState>();
  Motorcycle motorcycle;
  TextEditingController pricecontroller = TextEditingController();
  DateTime dateTime;
  DateTime datenow;
  List<String> timeslotlist = List<String>();

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
        timeslotlist: timeslotlist);
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
