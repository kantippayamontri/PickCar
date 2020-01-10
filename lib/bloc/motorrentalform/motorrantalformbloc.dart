import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pickcar/bloc/motorrentalform/motorrentalformevent.dart';
import 'package:pickcar/bloc/motorrentalform/motorrentalformstate.dart';
import 'package:pickcar/models/motorcycle.dart';
import 'package:pickcar/datamanager.dart';

class MotorRentalFormBloc
    extends Bloc<MotorRentalFormEvent, MotorRentalFormState> {
  BuildContext context;
  var formkey = GlobalKey<FormState>();
  Motorcycle motorcycle;
  TextEditingController pricecontroller = TextEditingController();

  MotorRentalFormBloc({@required this.context, @required this.motorcycle}) {
    pricecontroller.text = CarPrice.motorminprice.toString();
  }

  @override
  // TODO: implement initialState
  MotorRentalFormState get initialState => MotorRentalFormStartState();

  @override
  Stream<MotorRentalFormState> mapEventToState(MotorRentalFormEvent event) {
    // TODO: implement mapEventToState
  }
}
